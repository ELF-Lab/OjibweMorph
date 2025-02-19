# Set these variables to point to the location of these repos on your system
PARSER_TOOLS=~/Documents/ELF/OjibweTesting/ParserTools
OJIBWE_LEXICON=~/Documents/ELF/OjibweTesting/OjibweLexicon
# This path needs to be **relative to ParserTools/csv2fst**
# For example, if both OjibweMorph and ParserTools are in your root folder,
# set this to ../../OjibweMorph
OJIBWE_MORPH=../../OjibweMorph

cd $PARSER_TOOLS/csv2fst
make $1 MORPHOLOGYSRCDIR=$OJIBWE_MORPH LEMMAS_DIR=$OJIBWE_LEXICON/OPD SPREADSHEETS_FOR_YAML_DIR=$OJIBWE_LEXICON/OPD/for_yaml PARADIGM_MAPS_DIR=$OJIBWE_LEXICON/resources OUTPUT_DIR=$OJIBWE_MORPH/FST