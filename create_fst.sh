# Set these variables to point to the location of these repos on your system
PARSER_TOOLS=~/ParserTools
OJIBWE_LEXICON=~/OjibweLexicon
# This path needs to be **relative to ParserTools/csv2fst**
# For example, if both OjibweMorph and ParserTools are in your root folder,
# set this to ../../OjibweMorph
OJIBWE_MORPH=../../OjibweMorph

# Per ParserTools, you can also specify a comma-separated *list* of directories for LEMMAS_DIR
cd $PARSER_TOOLS/csv2fst
make $1 MORPHOLOGYSRCDIR=$OJIBWE_MORPH LEMMAS_DIR=$OJIBWE_LEXICON/OPD.$OJIBWE_LEXICON/HammerlyFieldwork SPREADSHEETS_FOR_YAML_DIR=$OJIBWE_LEXICON/OPD/for_yaml PARADIGM_MAPS_DIR=$OJIBWE_LEXICON/resources OUTPUT_DIR=$OJIBWE_MORPH/FST LANGUAGE_NAME=ojibwe
cd $OJIBWE_MORPH
if [ $1 = "check" ]; then
    python3 scripts/update_results.py
fi;