#!/bin/bash
DIR="../OjibweLexicon/OPD/example_sentences/by_speaker/"
FOMA=$1

for file_name in $DIR*_example_sentences.txt; do
    if [[ "$file_name" =~ $DIR([a-z_]+)_example_sentences.txt ]]; then
        speaker=${BASH_REMATCH[1]}
        echo "\nAnalyzing sentences from speaker: $speaker"
        sh scripts/analyze_text.sh $file_name $FOMA
    else
        echo "Unexpected filename in $DIR"
    fi
done