# Set these three variables to point to the location of these repositories on your system
PARSER_TOOLS=~/Documents/ParserTools
OJIBWE_LEXICON=~/Documents/OjibweLexicon
OJIBWE_MORPH=~/Documents/OjibweMorph

# Per ParserTools, you can also specify a comma-separated *list* of directories for LEMMAS_DIR
cd $PARSER_TOOLS/csv2fst
make $1 MORPHOLOGYSRCDIR=$OJIBWE_MORPH LEMMAS_DIR=$OJIBWE_LEXICON/OPD,$OJIBWE_LEXICON/HammerlyFieldwork LEXICAL_DATA_TO_EXCLUDE=$OJIBWE_LEXICON/other/lexical_data_to_exclude.csv SPREADSHEETS_FOR_YAML_DIR=$OJIBWE_LEXICON/OPD/for_yaml PARADIGM_MAPS_DIR=$OJIBWE_LEXICON/resources OUTPUT_DIR=$OJIBWE_MORPH/FST LANGUAGE_NAME=ojibwe
cd $OJIBWE_MORPH
if [ $1 = "check" ]; then
    python3 scripts/update_results.py
fi;