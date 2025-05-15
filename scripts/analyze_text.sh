#!/bin/bash
# Step 1: Tokenize .txt and save to _tok.txt
TEXT_FILE=$1
echo "Analyzing:" $TEXT_FILE
TOKENIZED_TEXT_FILE=$(echo $TEXT_FILE | sed 's/\/data/\/generated/; s/.txt/_tok.txt/')
ANALYZED_TEXT_FILE=$(echo $TEXT_FILE | sed 's/\/data/\/generated/; s/.txt/_analyzed.txt/')
ANALYZED_TEXT_FAILS_FILE=$(echo $ANALYZED_TEXT_FILE | sed 's/analyzed.txt/analyzed_fails.txt/')
ANALYZED_TEXT_FAILS_UNIQUE_FILE=$(echo $ANALYZED_TEXT_FILE | sed 's/analyzed.txt/analyzed_fails_unique.txt/')
FOMA=$2

bash ./scripts/tokenize.sh $TEXT_FILE > $TOKENIZED_TEXT_FILE

# Step 2: Analyze tokenized file with flookup and save to _analyzed.txt,
#         removing "words" analyzed as punctuation (and the following new line).
flookup $FOMA < $TOKENIZED_TEXT_FILE | sed '$!N;/PUNCT.*\n$/d;P;D' > $ANALYZED_TEXT_FILE

# Step 3: Count errors (= no analysis given by the FST) and total lines
errors=$(grep "[+][?]" $ANALYZED_TEXT_FILE | wc -l)
total=$(grep "^$" $ANALYZED_TEXT_FILE | wc -l)
unique_errors=$(sort -u $ANALYZED_TEXT_FILE | grep "[+][?]" | wc -l)
unique_total=$(grep "[a-zA-Z]" $TOKENIZED_TEXT_FILE | sort -u | wc -l)

# Step 4: Calculate error rate (handling division in bash)
if [ "$total" -gt 0 ]; then
    error_rate=$(echo "scale=4; $errors / $total" | bc)
else
    error_rate=0  # Avoid division by zero
fi
if [ "$unique_total" -gt 0 ]; then
    unique_error_rate=$(echo "scale=4; $unique_errors / $unique_total" | bc)
else
    unique_error_rate=0  # Avoid division by zero
fi
# Prepare these variables for printing
errors=$(echo $errors | bc)
total=$(echo $total | bc)
unique_errors=$(echo $unique_errors | bc)
unique_total=$(echo $unique_total | bc)

# Step 5: Output the error rate
echo "Error rate = $error_rate ($errors/$total words)"
echo "Unique error rate = $unique_error_rate ($unique_errors/$unique_total words)"

# Step 6: Find all error tokens
grep '.*\t[\+\?].*' $ANALYZED_TEXT_FILE > $ANALYZED_TEXT_FAILS_FILE

# Step 7: Find all error types
sort $ANALYZED_TEXT_FAILS_FILE | uniq -u > $ANALYZED_TEXT_FAILS_UNIQUE_FILE