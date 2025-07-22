#!/bin/bash
# Get the expected output, and generate the actual output
EXPECTED_OUTPUT_FILE="scripts/test_data/analyzed_test_expected_output.txt"
ACTUAL_OUTPUT_FILE="scripts/test_data/analyzed_test_actual_output.txt"
python3 scripts/ambiguity.py scripts/test_data/analyzed_test.txt scripts/test_data/ > $ACTUAL_OUTPUT_FILE

# Go line-by-line through each output file, checking for matching lines
LINE_MISMATCH_COUNT=0
while read -r expected_line && read -r actual_line <&3; do
    if [ "$expected_line" != "$actual_line" ] ; then
    let LINE_MISMATCH_COUNT+=1
        echo "\nDiscrepancy between expected output and actual output."
        echo "Expected output line:"
        echo $expected_line
        echo "Actual output line:"
        echo $actual_line
    fi
done < $EXPECTED_OUTPUT_FILE 3< $ACTUAL_OUTPUT_FILE

if [ -s $ACTUAL_OUTPUT_FILE ] ; then
    if [ $LINE_MISMATCH_COUNT = 0 ] ; then
        echo "\nTest passed!  The expected output exactly matched the actual output."
    else
        echo "\nTest failed! There were $LINE_MISMATCH_COUNT lines that did not match between the expected and actual output."
    fi
else
    echo "\nTest failed! No ambiguity analysis was generated."
fi