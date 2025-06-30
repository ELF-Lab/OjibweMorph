# *** Constants for generating the FST ***
# * Tools *
PYTHON=python3
FOMA=foma
# * Keyword (for naming output files, etc.) *
# Change this value to have a name relevant to your FST
LANGUAGE_NAME=ojibwe
# * Source files *
# Change the below values to point to the relevant files on your system
OJIBWE_MORPH=.
OJIBWE_LEXICON=../OjibweLexicon
LEMMAS_DIR=$(OJIBWE_LEXICON)/OPD,$(OJIBWE_LEXICON)/HammerlyFieldwork # Can be a list (separated by commas) e.g., LEMMAS_DIR=~/folder1,~/folder2
LEXICAL_DATA_TO_EXCLUDE=$(OJIBWE_LEXICON)/other/lexical_data_to_exclude.csv
OUTPUT_DIR=$(OJIBWE_MORPH)/FST
# Do not change the below values; determined automatically
VERB_JSON = $(OJIBWE_MORPH)/config/verbs.json
NOUN_JSON = $(OJIBWE_MORPH)/config/nouns.json
REGULAR_FST=$(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).fomabin

# *** Constants for building the LEXC files ***
# Likely no need to change any of these values!
# POS are determined by the files in config/
CONFIG_FILES=$(shell find $(OJIBWE_MORPH)/config/ -name "*.json")
COMPILE_FST_XFST=$(shell python3 scripts/get_package_file.py "fstmorph" "assets/compile_fst.xfst")
# Add escape chars to the file path so it can be used in the gsub below
OJIBWE_MORPH_REGEX=$(shell echo $(OJIBWE_MORPH) | sed 's/\./\\\./g' | sed 's/\//\\\//g')
# Strip each file path to only include the POS e.g., "../config/nouns.json" -> "nouns"
POS=$(shell awk '{ gsub(/$(OJIBWE_MORPH_REGEX)\/config\/+/, ""); gsub(/\.json/, ""); print }' <<< "$(CONFIG_FILES)")
LEXCTARGETS=$(POS:%=%.lexc)
TAG_CONFIGURATION_FILES=$(POS:%=$(OUTPUT_DIR)/generated/%_tags.json)
ALTTAG=False
DERIVATIONS=True

all:$(OUTPUT_DIR)/generated/all.lexc $(REGULAR_FST) $(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).att $(TAG_CONFIGURATION_FILES)

release:all
	zip generated.zip $(OUTPUT_DIR)/generated/*

$(OUTPUT_DIR)/generated/all.lexc:$(CONFIG_FILES)
	mkdir -p $(OUTPUT_DIR)/generated
	$(PYTHON) -m fstmorph.csv2lexc --config-files `echo $^ | tr ' ' ','` \
                              --source-path $(OJIBWE_MORPH) \
                              --database-paths $(LEMMAS_DIR) \
                              --alt-tag $(ALTTAG) \
                              --add-derivations $(DERIVATIONS) \
                              --lexc-path $(OUTPUT_DIR)/generated \
                              --lexical-data-to-exclude $(LEXICAL_DATA_TO_EXCLUDE)
	cd $(OUTPUT_DIR)/generated; \
        cat root.lexc `ls *lexc | grep -v root.lexc | tr '\n' ' '` > all.lexc

%/phonology.xfst:$(OJIBWE_MORPH)/xfst/phonology.xfst
	mkdir -p $*
	cp $^ $@

$(OUTPUT_DIR)/generated/compile_fst.xfst:
	mkdir -p $(OUTPUT_DIR)/generated
	cp $(COMPILE_FST_XFST) $@
	cat $(COMPILE_FST_XFST) | sed 's/LANGUAGE_NAME/$(LANGUAGE_NAME)/g' > $@

$(OUTPUT_DIR)/check-generated/compile_fst.xfst:
	mkdir -p $(OUTPUT_DIR)/check-generated
	cat $(COMPILE_FST_XFST) | sed 's/LANGUAGE_NAME/$(LANGUAGE_NAME)/g' > $@

$(REGULAR_FST):$(OUTPUT_DIR)/generated/all.lexc $(OUTPUT_DIR)/generated/phonology.xfst $(OUTPUT_DIR)/generated/compile_fst.xfst
	mkdir -p $(OUTPUT_DIR)/generated
	echo "Compiling FST using XFST script $(FSTSCRIPT) and LEXC targets $(LEXCTARGETS)"
	cd $(OUTPUT_DIR)/generated; $(FOMA) -f compile_fst.xfst

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
$(OUTPUT_DIR)/generated/verbs_tags.json:$(OJIBWE_MORPH)/config/verbs.json
	mkdir -p $(OUTPUT_DIR)/generated
	$(PYTHON) -m fstmorph.extract_tag_combinations \
             --config-file $< \
             --source-path $(OJIBWE_MORPH) \
             --pre-element=TensePreverbs \
             --pre-element-tags="PVTense/gii,0" \
             --post-element=Derivations \
             --post-element-tags="VII+Augment/magad,0" \
             --output-file $@

$(OUTPUT_DIR)/generated/%_tags.json:$(OJIBWE_MORPH)/config/%.json
	mkdir -p $(OUTPUT_DIR)/generated
	$(PYTHON) -m fstmorph.extract_tag_combinations \
             --config-file $< \
             --source-path $(OJIBWE_MORPH) \
             --output-file $@


#####################################################################
#                                                                   #
#                             TESTS                                 #
#                                                                   #
#####################################################################
# *** Constants for YAML tests ***
# * Tools *
LOOKUP=flookup
# * Keyword (for naming output files, etc.) *
LABEL_FOR_PARADIGM_TESTS="paradigm"
# * Source files *
# Change the below values to point to the relevant files on your system
PARADIGM_MAPS_DIR=$(OJIBWE_LEXICON)/resources
VERB_DATA_FOR_PARADIGM_TESTS_DIR=$(OJIBWE_MORPH)/VerbSpreadsheets
NOUN_DATA_FOR_PARADIGM_TESTS_DIR=$(OJIBWE_MORPH)/NounSpreadsheets
# Do not change the below values; determined automatically
PARADIGM_YAML_DIR=$(OUTPUT_DIR)/$(LABEL_FOR_PARADIGM_TESTS)_yaml_output
PARADIGM_TEST_LOG=$(OUTPUT_DIR)/$(LABEL_FOR_PARADIGM_TESTS)-test.log
NO_ALT_FST=$(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).noAlt.fomabin
NO_LEX_DB_FST=$(OUTPUT_DIR)/check-generated/$(LANGUAGE_NAME).fomabin

check: check-paradigm-tests

$(OUTPUT_DIR)/generated/$(LANGUAGE_NAME).noAlt.fomabin:$(REGULAR_FST) FSTmorph/assets/delete_alt_tag.xfst 
	cat FSTmorph/assets/delete_alt_tag.xfst | sed 's/LANGUAGE_NAME/$(LANGUAGE_NAME)/g' > $(OUTPUT_DIR)/generated/delete_alt_tag.xfst
	cd $(OUTPUT_DIR)/generated; $(FOMA) -f delete_alt_tag.xfst

# A different version of the lexc files that *doesn't* use the external lexical database
# (because entries from the external lexical database will interfere with YAML
# testing due to morphological ambiguity).
$(OUTPUT_DIR)/check-generated/all.lexc:$(shell find $(OJIBWE_MORPH)/config/ -name "*.json")
	mkdir -p $(OUTPUT_DIR)/check-generated
	$(PYTHON) -m fstmorph.csv2lexc --config-files `echo $^ | tr ' ' ','` \
                              --source-path $(OJIBWE_MORPH) \
                              --database-paths $(LEMMAS_DIR) \
                              --lexc-path $(OUTPUT_DIR)/check-generated \
                              --add-derivations $(DERIVATIONS) \
                              --read-lexical-database False \
                              --alt-tag False \
                              --lexical-data-to-exclude $(LEXICAL_DATA_TO_EXCLUDE)
	cd $(OUTPUT_DIR)/check-generated; \
        cat root.lexc `ls *lexc | grep -v root.lexc | tr '\n' ' '` > all.lexc

# A different version of the FST that *doesn't* use the external lexical database
# (because entries from the external lexical database will interfere with YAML
# testing due to morphological ambiguity).
$(NO_LEX_DB_FST):$(OUTPUT_DIR)/check-generated/all.lexc $(OUTPUT_DIR)/check-generated/phonology.xfst $(OUTPUT_DIR)/check-generated/compile_fst.xfst
	mkdir -p $(OUTPUT_DIR)/check-generated
	echo "Compiling FST using XFST script $(FSTSCRIPT) and LEXC targets $(LEXCTARGETS)"
	cd $(OUTPUT_DIR)/check-generated; $(FOMA) -f compile_fst.xfst

# Generate the YAML files for testing
# Add non-core-tags if you want to run some "core" tests as well
$(PARADIGM_YAML_DIR):
	rm -Rf $@
	mkdir $@
	$(PYTHON) -m fstmorph.tests.create_yaml $(VERB_DATA_FOR_PARADIGM_TESTS_DIR) $(VERB_JSON) ./ --pos=verb
	mv yaml_output/* $@
	$(PYTHON) -m fstmorph.tests.create_yaml $(NOUN_DATA_FOR_PARADIGM_TESTS_DIR) $(NOUN_JSON) ./ --pos=noun
	mv yaml_output/* $@
	rm -d yaml_output

# Create test .log files from the YAML files
check-paradigm-tests:$(NO_LEX_DB_FST) $(PARADIGM_YAML_DIR)
	rm -f $(PARADIGM_TEST_LOG)
	for f in `ls $(PARADIGM_YAML_DIR)/*.yaml | grep -v core`; do \
                  echo "YAML test file $$f"; \
                  $(PYTHON) -m fstmorph.tests.run_yaml_tests --app $(LOOKUP) --surface --mor $(NO_LEX_DB_FST) $$f; \
                  echo ; \
                  done > $(PARADIGM_TEST_LOG)
	$(PYTHON) -m fstmorph.tests.summarize_tests --input_file_name "$(PARADIGM_TEST_LOG)" --yaml_source_csv_dir $(VERB_DATA_FOR_PARADIGM_TESTS_DIR) --paradigm_map_path "$(PARADIGM_MAPS_DIR)/VERBS_paradigm_map.csv" --output_dir $(OUTPUT_DIR) --output_file_identifier $(LABEL_FOR_PARADIGM_TESTS)
	$(PYTHON) -m fstmorph.tests.summarize_tests --input_file_name "$(PARADIGM_TEST_LOG)" --yaml_source_csv_dir $(NOUN_DATA_FOR_PARADIGM_TESTS_DIR) --paradigm_map_path "$(PARADIGM_MAPS_DIR)/NOUNS_paradigm_map.csv" --output_dir $(OUTPUT_DIR) --output_file_identifier $(LABEL_FOR_PARADIGM_TESTS) --for_nouns

# *** The core-only tests are no longer being used -- just keeping this here as an example
# 	  in case these get used in future. ***
# If there are no core YAML files, this will do nothing.
# check-core-tests:$(NO_LEX_DB_FST) $(PARADIGM_YAML_DIR)
# 	rm -f $(CORE_TEST_LOG)
# 	for f in `ls $(PARADIGM_YAML_DIR)/*core.yaml`; do \
#                   echo "YAML test file $$f"; \
#                   $(PYTHON) -m fstmorph.tests.run_yaml_tests --hide-passes --app $(LOOKUP) --surface --mor $(NO_LEX_DB_FST) $$f; \
#                   echo ; \
#                   done > $(CORE_TEST_LOG)
# 	if [ ! -s "$(CORE_TEST_LOG)" ]; then \
# 		rm -f $(CORE_TEST_LOG); \
# 	fi

clean:
	rm -rf $(OUTPUT_DIR)/generated $(OUTPUT_DIR)/check-generated $(PARADIGM_YAML_DIR) $(CORE_TEST_LOG) $(PARADIGM_TEST_LOG) csv_output
