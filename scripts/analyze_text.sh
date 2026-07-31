#!/bin/bash

set -euo pipefail

TEXT_FILE=${1:-}
FOMA=${2:-}

if [ -z "$TEXT_FILE" ] || [ -z "$FOMA" ]; then
    echo "Usage: $0 TEXT_FILE FOMA_FILE" >&2
    exit 2
fi

TOKENIZED_TEXT_FILE=$(echo "$TEXT_FILE" | sed 's/\/data/\/generated/; s/\.txt$/_tok.txt/')
ANALYZED_TEXT_FILE=$(echo "$TEXT_FILE" | sed 's/\/data/\/generated/; s/\.txt$/_analyzed.txt/')
ANALYZED_TEXT_FAILS_FILE=$(echo "$ANALYZED_TEXT_FILE" | sed 's/analyzed\.txt$/analyzed_fails.txt/')
ANALYZED_TEXT_FAILS_UNIQUE_FILE=$(echo "$ANALYZED_TEXT_FILE" | sed 's/analyzed\.txt$/analyzed_fails_unique.txt/')

if [ ! -s "$TEXT_FILE" ]; then
    echo "ERROR: Could not read from the text file input, $TEXT_FILE" >&2
    exit 1
fi

if [ ! -s "$FOMA" ]; then
    echo "ERROR: Could not access the specified FST, $FOMA" >&2
    exit 1
fi

mkdir -p "$(dirname "$TOKENIZED_TEXT_FILE")"
mkdir -p "$(dirname "$ANALYZED_TEXT_FILE")"

echo "Analyzing: $TEXT_FILE"

# Step 1: Tokenize without lowercasing. The original surface capitalization is
# retained in _tok.txt.
bash ./scripts/tokenize.sh "$TEXT_FILE" > "$TOKENIZED_TEXT_FILE"

# Step 2: Analyze each token as written. If the token contains uppercase
# letters, also analyze its lowercase form. All successful analyses are
# retained, but the first output column always contains the original corpus
# token. Lowercase tokens are never given an invented capitalized candidate.
python3 - "$TOKENIZED_TEXT_FILE" "$FOMA" "$ANALYZED_TEXT_FILE" <<'PY'
from __future__ import annotations

import subprocess
import sys
from pathlib import Path


token_file = Path(sys.argv[1])
foma_file = Path(sys.argv[2])
output_file = Path(sys.argv[3])

surface_tokens = [
    line.rstrip("\n")
    for line in token_file.read_text(encoding="utf-8").splitlines()
    if line.rstrip("\n")
]

# Each entry connects one flookup input block to its original corpus token.
requests: list[tuple[str, str]] = []
for surface in surface_tokens:
    requests.append((surface, surface))

    lowercase = surface.lower()
    if lowercase != surface:
        requests.append((surface, lowercase))

flookup_input = "\n".join(candidate for _, candidate in requests) + "\n"

result = subprocess.run(
    ["flookup", str(foma_file)],
    input=flookup_input,
    text=True,
    encoding="utf-8",
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    check=False,
)

if result.returncode != 0:
    sys.stderr.write(result.stderr)
    raise SystemExit(result.returncode)

# flookup separates the output for successive input strings with blank lines.
raw_blocks = result.stdout.rstrip("\n").split("\n\n") if result.stdout else []

if len(raw_blocks) != len(requests):
    raise RuntimeError(
        "Could not align flookup output with input candidates: "
        f"submitted {len(requests)} candidates but received "
        f"{len(raw_blocks)} output blocks."
    )

analyses_by_token: list[list[str]] = [[] for _ in surface_tokens]
request_index = 0

for token_index, surface in enumerate(surface_tokens):
    candidate_count = 2 if surface.lower() != surface else 1
    seen_analyses: set[str] = set()

    for _ in range(candidate_count):
        block = raw_blocks[request_index]
        request_surface, candidate = requests[request_index]
        request_index += 1

        if request_surface != surface:
            raise RuntimeError("Internal candidate alignment error.")

        for line in block.splitlines():
            if not line.strip():
                continue

            columns = line.split("\t", 1)
            if len(columns) != 2:
                continue

            _, analysis = columns

            # Ignore failed candidate analyses when another casing succeeds.
            if analysis.startswith("+?"):
                continue

            # Punctuation is omitted from the analyzed corpus, matching the
            # previous sed-based behavior.
            if "PUNCT" in analysis:
                continue

            if analysis not in seen_analyses:
                seen_analyses.add(analysis)
                analyses_by_token[token_index].append(analysis)

with output_file.open("w", encoding="utf-8") as output:
    for surface, analyses in zip(surface_tokens, analyses_by_token):
        # Punctuation tokens have no retained analyses and are not failures.
        if not any(character.isalpha() for character in surface):
            continue

        if analyses:
            for analysis in analyses:
                output.write(f"{surface}\t{analysis}\n")
        else:
            output.write(f"{surface}\t+?\n")

        # Keep all analyses of one token together, then separate the next
        # corpus token with exactly one blank line.
        output.write("\n")
PY

# Step 3: Count token failures. Multiple analyses for one token do not inflate
# the denominator. Unique totals are based on original surface forms.
errors=$(awk -F '\t' '$2 ~ /^\+\?/ {count++} END {print count+0}' "$ANALYZED_TEXT_FILE")
total=$(awk '/[[:alpha:]]/ {count++} END {print count+0}' "$TOKENIZED_TEXT_FILE")
unique_errors=$(awk -F '\t' '$2 ~ /^\+\?/ {failed[$1]=1} END {print length(failed)+0}' "$ANALYZED_TEXT_FILE")
unique_total=$(awk '/[[:alpha:]]/ {tokens[$0]=1} END {print length(tokens)+0}' "$TOKENIZED_TEXT_FILE")

if [ "$total" -gt 0 ]; then
    error_rate=$(awk -v errors="$errors" -v total="$total" 'BEGIN {printf "%.4f", errors / total}')
else
    error_rate=0
fi

if [ "$unique_total" -gt 0 ]; then
    unique_error_rate=$(awk -v errors="$unique_errors" -v total="$unique_total" 'BEGIN {printf "%.4f", errors / total}')
else
    unique_error_rate=0
fi

echo "Error rate = $error_rate ($errors/$total words)"
echo "Unique error rate = $unique_error_rate ($unique_errors/$unique_total words)"

# Step 4: Write failed tokens and failed token types.
awk -F '\t' '$2 ~ /^\+\?/' "$ANALYZED_TEXT_FILE" > "$ANALYZED_TEXT_FAILS_FILE"
sort -u "$ANALYZED_TEXT_FAILS_FILE" > "$ANALYZED_TEXT_FAILS_UNIQUE_FILE"
