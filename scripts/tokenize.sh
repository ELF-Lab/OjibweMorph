#!/bin/bash

# Tokenize text while preserving the capitalization found in the corpus.
# Capitalization alternatives are handled later by analyze_text.sh.
cat "$@" |
sed 's/[".,\!?:;–][".,\!?:;–]*/#&#/g' |
tr -s ' \n\r\t\#' '\n'
