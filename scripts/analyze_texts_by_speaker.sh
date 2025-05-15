#!/bin/bash
DIR=$1
FOMA=$2

for file_name in $DIR/*_example_sentences.txt; do
    if [[ "$file_name" =~ $DIR/([a-z_]+)_example_sentences.txt ]]; then
        speaker=${BASH_REMATCH[1]}
        echo "\nAnalyzing sentences from speaker: $speaker"
        sh scripts/analyze_text.sh $file_name $FOMA
    else
        echo "Unexpected filename in $DIR: $file_name"
    fi
done