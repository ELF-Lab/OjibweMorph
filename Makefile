# *** Constants for generating the FST ***
# * Tools *
PYTHON=python3
FOMA=foma
# * Keyword (for naming output files, etc.) *
# Change this value to have a name relevant to your FST
LANGUAGE_NAME="ojibwe"
# * Source files *
# Change the below values to point to the relevant files on your system
MORPHOLOGYSRCDIR=~/OjibweMorph
LEMMAS_DIR=~/OjibweLexicon/OPD,~/OjibweLexicon/HammerlyFieldwork # Can be a list (separated by commas) e.g., LEMMAS_DIR=~/folder1,~/folder2
LEXICAL_DATA_TO_EXCLUDE=""
OUTPUT_DIR=$(MORPHOLOGYSRCDIR)/FST
# Do not change the below values; determined automatically
VERB_JSON = $(MORPHOLOGYSRCDIR)/config/verbs.json
NOUN_JSON = $(MORPHOLOGYSRCDIR)/config/nouns.json

# *** Constants for YAML tests ***
# * Tools *
CREATE_YAML=FSTmorph/tests/create_yaml.py
LOOKUP=flookup
RUN_YAML_TESTS=FSTmorph/tests/run_yaml_tests.py
SUMMARIZE_TESTS=FSTmorph/tests/summarize_tests.py
# * Keyword (for naming output files, etc.) *
# Change this value to have a name relevant to your set of tests
LABEL_FOR_TESTS="paradigm"
# * Source files *
# Change the below values to point to the relevant files on your system
PARADIGM_MAPS_DIR=~/OjibweLexicon/resources
VERB_DATA_FOR_TESTS_DIR=$(MORPHOLOGYSRCDIR)/VerbSpreadsheets
NOUN_DATA_FOR_TESTS_DIR=$(MORPHOLOGYSRCDIR)/NounSpreadsheets
FST_FOR_TESTS=$(OUTPUT_DIR)/check-generated/$(LANGUAGE_NAME).fomabin # This can be the regular FST, or some alternative versions created further below in the Tests section of this Makefile
# Do not change the below values; determined automatically
YAML_DIR=$(OUTPUT_DIR)/$(LABEL_FOR_TESTS)_yaml_output
REGULAR_TEST_LOG=$(OUTPUT_DIR)/$(LABEL_FOR_TESTS)-test.log
CORE_TEST_LOG=$(OUTPUT_DIR)/core-$(LABEL_FOR_TESTS)-test.log

# *** Constants for building the LEXC files ***
# Likely no need to change any of these values!
# POS are determined by the files in config/
CONFIG_FILES=$(shell find $(MORPHOLOGYSRCDIR)/config/ -name "*.json")
# Add escape chars to the file path so it can be used in the gsub below
MORPHOLOGYSRCDIR_REGEX=$(shell echo $(MORPHOLOGYSRCDIR) | sed 's/\./\\\./g' | sed 's/\//\\\//g')
# Strip each file path to only include the POS e.g., "../config/nouns.json" -> "nouns"
POS=$(shell awk '{ gsub(/$(MORPHOLOGYSRCDIR_REGEX)\/config\/+/, ""); gsub(/\.json/, ""); print }' <<< "$(CONFIG_FILES)")
LEXCTARGETS=$(POS:%=%.lexc)
TAG_CONFIGURATION_FILES=$(POS:%=$(OUTPUT_DIR)/generated/%_tags.json)
ALTTAG=False
DERIVATIONS=True

all:$(OUTPUT_DIR)/generated/all.lexc $(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).fomabin $(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).att $(TAG_CONFIGURATION_FILES)

release:all
	zip generated.zip $(OUTPUT_DIR)/generated/*

$(OUTPUT_DIR)/generated/all.lexc:$(CONFIG_FILES)
	mkdir -p $(OUTPUT_DIR)/generated
	$(PYTHON) FSTmorph/csv2lexc.py --config-files `echo $^ | tr ' ' ','` \
                              --source-path $(MORPHOLOGYSRCDIR) \
                              --database-paths $(LEMMAS_DIR) \
                              --alt-tag $(ALTTAG) \
                              --add-derivations $(DERIVATIONS) \
                              --lexc-path $(OUTPUT_DIR)/generated \
                              --lexical-data-to-exclude $(LEXICAL_DATA_TO_EXCLUDE)
	cd $(OUTPUT_DIR)/generated; \
        cat root.lexc `ls *lexc | grep -v root.lexc | tr '\n' ' '` > all.lexc

%/phonology.xfst:$(MORPHOLOGYSRCDIR)/xfst/phonology.xfst
	mkdir -p $*
	cp $^ $@

$(OUTPUT_DIR)/generated/compile_fst.xfst:FSTmorph/assets/compile_fst.xfst
	mkdir -p $(OUTPUT_DIR)/generated
	cp $^ $@
	cat $^ | sed 's/LANGUAGE_NAME/$(LANGUAGE_NAME)/g' > $@

$(OUTPUT_DIR)/check-generated/compile_fst.xfst:FSTmorph/assets/compile_fst.xfst
	mkdir -p $(OUTPUT_DIR)/check-generated
	cat $^ | sed 's/LANGUAGE_NAME/$(LANGUAGE_NAME)/g' > $@

$(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).fomabin:$(OUTPUT_DIR)/generated/all.lexc $(OUTPUT_DIR)/generated/phonology.xfst $(OUTPUT_DIR)/generated/compile_fst.xfst
	mkdir -p $(OUTPUT_DIR)/generated
	echo "Compiling FST using XFST script $(FSTSCRIPT) and LEXC targets $(LEXCTARGETS)"
	cd $(OUTPUT_DIR)/generated; $(FOMA) -f compile_fst.xfst

$(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).noAlt.fomabin:$(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).fomabin FSTmorph/assets/delete_alt_tag.xfst 
	cat FSTmorph/assets/delete_alt_tag.xfst | sed 's/LANGUAGE_NAME/$(LANGUAGE_NAME)/g' > $(OUTPUT_DIR)/generated/delete_alt_tag.xfst
	cd $(OUTPUT_DIR)/generated; $(FOMA) -f delete_alt_tag.xfst

# For building spell checkers etc. using Giellatekno infrastructure.
$(OUTPUT_DIR)/generated/lang-ciw:$(OUTPUT_DIR)/generated/all.lexc $(OUTPUT_DIR)/generated/phonology.xfst
	mkdir -p $(OUTPUT_DIR)/generated
	cd $(OUTPUT_DIR)/generated; \
        git clone https://github.com/giellalt/lang-ciw.git; \
	cp root.lexc lang-ciw/src/fst/morphology/ ; \
	cp phonology.xfst lang-ciw/src/fst/morphology/phonology.xfscript ; \
	cp $(addprefix ojibwe_,$(LEXCTARGETS)) lang-ciw/src/fst/morphology/stems/; \
	cp preverbs.lexc prenouns.lexc preadverbs.lexc lang-ciw/src/fst/morphology/stems/

# Tag specification file
$(OUTPUT_DIR)/generated/verbs_tags.json:$(MORPHOLOGYSRCDIR)/config/verbs.json
	mkdir -p $(OUTPUT_DIR)/generated
	$(PYTHON) FSTmorph/extract_tag_combinations.py \
             --config-file $< \
             --source-path $(MORPHOLOGYSRCDIR) \
             --pre-element=TensePreverbs \
             --pre-element-tags="PVTense/gii,0" \
             --post-element=Derivations \
             --post-element-tags="VII+Augment/magad,0" \
             --output-file $@

$(OUTPUT_DIR)/generated/%_tags.json:$(MORPHOLOGYSRCDIR)/config/%.json
	mkdir -p $(OUTPUT_DIR)/generated
	$(PYTHON) FSTmorph/extract_tag_combinations.py \
             --config-file $< \
             --source-path $(MORPHOLOGYSRCDIR) \
             --output-file $@


#####################################################################
#                                                                   #
#                             TESTS                                 #
#                                                                   #
#####################################################################

# We can build a separate FST which you can use for YAML tests because
# entries from the external lexical database will interfere with YAML
# testing due to morphological ambiguity.

check: check-core-tests check-tests

# A different version of the lexc files that *doesn't* use the external lexical database
$(OUTPUT_DIR)/check-generated/all.lexc:$(shell find $(MORPHOLOGYSRCDIR)/config/ -name "*.json")
	mkdir -p $(OUTPUT_DIR)/check-generated
	$(PYTHON) FSTmorph/csv2lexc.py --config-files `echo $^ | tr ' ' ','` \
                              --source-path $(MORPHOLOGYSRCDIR) \
                              --database-paths $(LEMMAS_DIR) \
                              --lexc-path $(OUTPUT_DIR)/check-generated \
                              --add-derivations $(DERIVATIONS) \
                              --read-lexical-database False \
                              --alt-tag False \
                              --lexical-data-to-exclude $(LEXICAL_DATA_TO_EXCLUDE)
	cd $(OUTPUT_DIR)/check-generated; \
        cat root.lexc `ls *lexc | grep -v root.lexc | tr '\n' ' '` > all.lexc

# A different version of the FST that *doesn't* use the external lexical database
$(OUTPUT_DIR)/check-generated/$(LANGUAGE_NAME).fomabin:$(OUTPUT_DIR)/check-generated/all.lexc $(OUTPUT_DIR)/check-generated/phonology.xfst $(OUTPUT_DIR)/check-generated/compile_fst.xfst
	mkdir -p $(OUTPUT_DIR)/check-generated
	echo "Compiling FST using XFST script $(FSTSCRIPT) and LEXC targets $(LEXCTARGETS)"
	cd $(OUTPUT_DIR)/check-generated; $(FOMA) -f compile_fst.xfst

# Generate the YAML files for testing
# Add non-core-tags if you want to run some "core" tests as well
$(YAML_DIR):
	rm -Rf $@
	mkdir $@
	$(PYTHON) $(CREATE_YAML) $(VERB_DATA_FOR_TESTS_DIR) $(VERB_JSON) ./ --pos=verb
	mv yaml_output/* $@
	$(PYTHON) $(CREATE_YAML) $(NOUN_DATA_FOR_TESTS_DIR) $(NOUN_JSON) ./ --pos=noun
	mv yaml_output/* $@
	rm -d yaml_output

# Create test .log files from the YAML files
check-tests:$(FST_FOR_TESTS) $(YAML_DIR)
	rm -f $(REGULAR_TEST_LOG)
	for f in `ls $(YAML_DIR)/*.yaml | grep -v core`; do \
                  echo "YAML test file $$f"; \
                  $(PYTHON) $(RUN_YAML_TESTS) --app $(LOOKUP) --surface --mor $(FST_FOR_TESTS) $$f; \
                  echo ; \
                  done > $(REGULAR_TEST_LOG)
	$(PYTHON) $(SUMMARIZE_TESTS) --input_file_name "$(REGULAR_TEST_LOG)" --yaml_source_csv_dir $(VERB_DATA_FOR_TESTS_DIR) --paradigm_map_path "$(PARADIGM_MAPS_DIR)/VERBS_paradigm_map.csv" --output_dir $(OUTPUT_DIR) --output_file_identifier $(LABEL_FOR_TESTS)
	$(PYTHON) $(SUMMARIZE_TESTS) --input_file_name "$(REGULAR_TEST_LOG)" --yaml_source_csv_dir $(NOUN_DATA_FOR_TESTS_DIR) --paradigm_map_path "$(PARADIGM_MAPS_DIR)/NOUNS_paradigm_map.csv" --output_dir $(OUTPUT_DIR) --output_file_identifier $(LABEL_FOR_TESTS) --for_nouns

# If there are no core YAML files, this will do nothing.
check-core-tests:$(FST_FOR_TESTS) $(YAML_DIR)
	rm -f $(CORE_TEST_LOG)
	for f in `ls $(YAML_DIR)/*core.yaml`; do \
                  echo "YAML test file $$f"; \
                  $(PYTHON) $(RUN_YAML_TESTS) --hide-passes --app $(LOOKUP) --surface --mor $(FST_FOR_TESTS) $$f; \
                  echo ; \
                  done > $(CORE_TEST_LOG)
	if [ ! -s "$(CORE_TEST_LOG)" ]; then \
		rm -f $(CORE_TEST_LOG); \
	fi

clean:
	rm -rf $(OUTPUT_DIR)/generated $(OUTPUT_DIR)/check-generated $(YAML_DIR) $(CORE_TEST_LOG) $(REGULAR_TEST_LOG) csv_output

#####################################################################
#                                                                   #
#                       DOCUMENTATION                               #
#                                                                   #
#####################################################################

# Generating documentation requires the python module pdoc
# Install it by `pip3 install pdoc3` if you need to build
# the docs

doc:*py
	pdoc --force -c syntax_highlighting=True --html .
	rm -r -f docs/html_docs
	mkdir docs/html_docs/
	mv html/FSTmorph/* docs/html_docs/
	rm -r html/

