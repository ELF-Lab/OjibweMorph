# Set these three variables to point to the location of these repositories on your system
PARSER_TOOLS=~/ParserTools
OJIBWE_LEXICON=~/OjibweLexicon
OJIBWE_MORPH=~/OjibweMorph

# No need to edit these variables
OUTPUT_DIR=$OJIBWE_MORPH/FST
LANGUAGE_NAME="ojibwe"
# For paradigm tests
LABEL_FOR_PARADIGM_TESTS="paradigm"
VERB_DATA_FOR_PARADIGM_TESTS_DIR=$OJIBWE_MORPH/VerbSpreadsheets
NOUN_DATA_FOR_PARADIGM_TESTS_DIR=$OJIBWE_MORPH/NounSpreadsheets
FST_FOR_PARADIGM_TESTS=$OUTPUT_DIR/check-generated/$LANGUAGE_NAME.fomabin
# For OPD tests
LABEL_FOR_OPD_TESTS="opd"
# TO DO: Make it so that this DIR can be used to print forms_with_no_analyses etc.
VERB_DATA_FOR_OPD_TESTS_DIR=$OJIBWE_LEXICON/OPD/for_yaml/verbs
NOUN_DATA_FOR_OPD_TESTS_DIR=$OJIBWE_LEXICON/OPD/for_yaml/nouns/
FST_FOR_OPD_TESTS=$OUTPUT_DIR/generated/$LANGUAGE_NAME.noAlt.fomabin
# For corpus tests
FST_FOR_CORPUS_TESTS=$OUTPUT_DIR/generated/$LANGUAGE_NAME.fomabin
EXAMPLE_SENTENCES_DIR=$OJIBWE_LEXICON/OPD/example_sentences
CORPUS_TEST_OUTPUT_FILE=$OUTPUT_DIR/corpus_test.txt


# Per ParserTools, you can also specify a comma-separated *list* of directories for LEMMAS_DIR
cd $PARSER_TOOLS/csv2fst
# Call once for each test (won't do anything for 'all', but ensures both tests get covered by 'check' and 'clean')
# Call first with the paradigm test info
make $1 MORPHOLOGYSRCDIR=$OJIBWE_MORPH LEMMAS_DIR=$OJIBWE_LEXICON/OPD,$OJIBWE_LEXICON/HammerlyFieldwork LEXICAL_DATA_TO_EXCLUDE=$OJIBWE_LEXICON/other/lexical_data_to_exclude.csv OUTPUT_DIR=$OUTPUT_DIR LANGUAGE_NAME=$LANGUAGE_NAME PARADIGM_MAPS_DIR=$OJIBWE_LEXICON/resources LABEL_FOR_TESTS=$LABEL_FOR_PARADIGM_TESTS VERB_DATA_FOR_TESTS_DIR=$VERB_DATA_FOR_PARADIGM_TESTS_DIR NOUN_DATA_FOR_TESTS_DIR=$NOUN_DATA_FOR_PARADIGM_TESTS_DIR FST_FOR_TESTS=$FST_FOR_PARADIGM_TESTS
# Call again with the OPD test info
make $1 MORPHOLOGYSRCDIR=$OJIBWE_MORPH LEMMAS_DIR=$OJIBWE_LEXICON/OPD,$OJIBWE_LEXICON/HammerlyFieldwork LEXICAL_DATA_TO_EXCLUDE=$OJIBWE_LEXICON/other/lexical_data_to_exclude.csv OUTPUT_DIR=$OUTPUT_DIR LANGUAGE_NAME=$LANGUAGE_NAME PARADIGM_MAPS_DIR=$OJIBWE_LEXICON/resources LABEL_FOR_TESTS=$LABEL_FOR_OPD_TESTS VERB_DATA_FOR_TESTS_DIR=$VERB_DATA_FOR_OPD_TESTS_DIR NOUN_DATA_FOR_TESTS_DIR=$NOUN_DATA_FOR_OPD_TESTS_DIR FST_FOR_TESTS=$FST_FOR_OPD_TESTS
if [ $1 = "check" ]; then
    cd $OJIBWE_MORPH
    sh scripts/analyze_text.sh $EXAMPLE_SENTENCES_DIR/example_sentences.txt $FST_FOR_CORPUS_TESTS > $CORPUS_TEST_OUTPUT_FILE
    sh scripts/analyze_texts_by_speaker.sh $EXAMPLE_SENTENCES_DIR/by_speaker $FST_FOR_CORPUS_TESTS >> $CORPUS_TEST_OUTPUT_FILE
    python3 scripts/summarize_corpus_tests.py --input_file_name $CORPUS_TEST_OUTPUT_FILE
    python3 scripts/update_results.py
    fi;
if [ $1 = "clean" ]; then
    rm -f $EXAMPLE_SENTENCES_DIR/example_sentences_*
    rm -f $EXAMPLE_SENTENCES_DIR/by_speaker/*_example_sentences_*
    fi;