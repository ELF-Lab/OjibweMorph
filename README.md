# OjibweMorph
This repository is for creating a finite-state transducer (FST) in the Ojibwe language.  The FST can be used to generate morphological analyses for an inflected form, or vice versa.

Morphological information about Ojibwe words is housed here.  Combined with the FST-generating code in [ParserTools](https://github.com/ELF-Lab/ParserTools) and the Ojibwe lexical information stored in [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon), the FST can be generated as specified [below](#building-the-fst).

## Contents
- [Test Results](#test-results)
  - [OPD Tests](#opd-tests)
    - [OPD Verbs](#opd-verbs)
    - [OPD Nouns](#opd-nouns)
  - [Paradigm Tests](#paradigm-tests)
    - [Paradigm Verbs](#paradigm-verbs)
    - [Paradigm Nouns](#paradigm-nouns)
  - [Corpus Tests](#corpus-tests)
- [User Instructions](#user-instructions)
  - [Building the FST](#building-the-fst)
  - [Using the FST](#using-the-fst)
- [About OjibweMorph](#about-ojibwemorph)
  - [Morphological Info](#morphological-info)
  - [License/Copyright](#licensecopyright)
  - [Acknowledgements](#acknowledgements)
    - [People](#people)
    - [Organizations and resources](#organizations-and-resources)
    - [Funding](#funding)
  - [Citation](#citation)

## Test Results
These results reflect the performance of an FST built from the morphology stored in [OjibweMorph](https://github.com/ELF-Lab/OjibweMorph) and the lemmas stored in [OjibweLexicon/OPD](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD) and [OjibweLexicon/HammerlyFieldwork](https://github.com/ELF-Lab/OjibweLexicon/tree/main/HammerlyFieldwork).

Each test form is inputted to the FST, then the corresponding analysis outputted by the FST is checked for correctness.

### OPD Tests
These inflected test forms come from [the OPD](https://ojibwe.lib.umn.edu), and are stored in [OjibweLexicon/OPD/for_yaml](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD/for_yaml).  This is a large test set covering a variety of word forms.

For these and the paradigm tests, the "# of Forms Without Results" counts the test forms for which the FST provides no analysis whatsoever.  The "Precision" captures how many outputted analyses were correct, while the "Recall" captures how many of the correct analyses were outputted.  Note that some forms have multiple correct analyses.

#### OPD Verbs
| Date Last Updated | # of Forms Tested | # of Forms Without Results | Precision | Recall |
|---|---|---|---|---|
| 2025-06-10 | 54205 | 12 | 85.44% | 97.03% |

#### OPD Nouns
| Date Last Updated | # of Forms Tested | # of Forms Without Results |  Precision | Recall |
|---|---|---|---|---|
| 2025-06-10 | 8563 | 25 | 83.4% | 96.85% |

### Paradigm Tests
The inflected forms used in these tests come from the `NounSpreadsheets/` and `VerbSpreadsheets/` folders here in `OjibweMorph`. This smaller test set is used largely as a sanity check.

#### Paradigm Verbs
| Date Last Updated | # of Forms Tested | # of Forms Without Results | Precision | Recall |
|---|---|---|---|---|
| 2025-06-10 | 8038 | 0 | 93.94% | 100.0% |

#### Paradigm Nouns
| Date Last Updated | # of Forms Tested | # of Forms Without Results |  Precision | Recall |
|---|---|---|---|---|
| 2025-06-10 | 12768 | 0 | 100.0% | 100.0% |

### Corpus Tests
The inflected forms used in these tests come from example sentences in [the OPD](https://ojibwe.lib.umn.edu), stored in [OjibweLexicon/OPD/example_sentences](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD/example_sentences).

The overall results are given at the bottom of the table, but a breakdown by the speaker of the example sentence is also provided first.  Because the speakers come from a variety of communities, this can give an impression of how well the FST is covering different varieties of Ojibwe.  You can learn more about the speakers [here](https://ojibwe.lib.umn.edu/about/voices).

In the table below, we are simply counting 'failures' -- forms that receive no analysis whatsover from the FST.  This is because unlike with the OPD and paradigm tests, we do not have a "gold standard" analysis to check.  The "by-token" failure covers every token (word) in the example sentences, whereas the "by-type" failures consider every *unique* token (i.e., so that each token only counts once towards the score regardless of its frequency).
| Speaker | Region | Community |  By-Token Failure | By-Type Failure |
|---|---|---|---|---|
| NJ | Border Lakes | Nigigoonsiminikaaning | 5.68% (659/11597) | 9.61% (412/4287) |
| GJ | Border Lakes | Lac La Croix | 18.39% (16/87) | 19.44% (14/72) |
| ES | Red Lake | Obaashiing | 7.08% (1191/16813) | 14.8% (729/4925) |
| RG | Red Lake | Odaawaa-Zaaga'iganiing | 3.63% (145/3988) | 6.7% (83/1237) |
| GH | Leech Lake | Jaachaabaaning | 5.75% (19/330) | 5.33% (11/206) |
| LW | Leech Lake | Jaachaabaaning | 8.26% (19/230) | 5.84% (9/154) |
| LS | Mille Lacs | Aazhomog | 8.86% (7/79) | 13.46% (7/52) |
| LSA | Mille Lacs | Lake Lena | 3.22% (1/31) | 3.44% (1/29) |
| Unknown | N/A | N/A | 0.0% (0/10) | 0.0% (0/5) |
| Overall | | | 6.2% (2057/33165) | 12.61% (1237/9803) |

Date Last Updated: 2025-06-10

## User Instructions
### Building the FST
**Prerequisites**: In addition to this repository, you'll also need to get [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon) and [ParserTools](https://github.com/ELF-Lab/ParserTools) installed locally.  To make use of ParserTools, you have to follow [the instructions there](https://github.com/ELF-Lab/ParserTools/tree/dev#getting-set-up-to-build-the-fst) to make sure you have all the necessary prerequisites.

The FST is created using code in ParserTools, which makes use of language-specific information stored in both OjibweMorph and OjibweLexicon.  Once you have downloaded all three repositories, the `create_fst.sh` script in this repo can be used to call the ParserTools code while supplying it with paths to the Ojibwe repos.  
First, go into `create_fst.sh` and change the file path variables to match your system.  Next, when calling `create_fst.sh`, just pass a keyword that will be given to the `Makefile` in ParserTools:
- `sh create_fst.sh all` to simply build the FST
- `sh create_fst.sh check` to run tests on the FST
- `sh create_fst.sh clean` to remove generated files

> Note: When running these commands, we have sometimes encountered an error message related to `malloc`.  It seems to happen randomly, and you can just run the command again (perhaps running the `clean` command above in between) until the error does not occur.

By default, the output will go in a local directory called `FST/`.

By default, the lemma list will be taken from [OjibweLexicon/OPD](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD) and [OjibweLexicon/HammerlyFieldwork](https://github.com/ELF-Lab/OjibweLexicon/tree/main/HammerlyFieldwork).  You can change this in `create_fst.sh` to look elsewhere.  You can use multiple lists by giving a comma-separated list of directories.

### Using the FST
This FST is run using [Foma](https://fomafst.github.io).  Some documentation from their team is available [here](https://github.com/mhulden/foma/blob/master/foma/docs/simpleintro.md).  Additonally, a simple example of using this Ojibwe FST is provided below:

1. Start the Foma program with the following command:  
`foma`  
Some information about foma should appear, and your prompt should now say `foma[0]: `.

2.  Load the Ojibwe FST you created in [the previous section](#building-the-fst) with:  
`load FST/generated/ojibwe.fomabin`  
The output should look something like this:  
`5.0 MB. 160042 states, 328686 arcs, Cyclic.`

3.  Now you can use the FST.  
a. To get an analysis for an inflected form (e.g., *wiigwaas*), use this command:  
`up wiigwaas`  
The output should be:  
`wiigwaas+NI+Sg`  
`wiigwaas+NA+ProxSg`  
b. To get an inflected form from an analysis, use this command:  
`down wiigwaas+NI+Sg`  
The output should be:  
`wiigwaas`  
You can input as many of these commands as you like.

4. Once you're done using the FST, you can exit Foma with:  
`quit` or `exit`

## About OjibweMorph
### Morphological Info
The `XSpreadsheets/` directories contain CSVs with example forms for the various paradigm and class categories within each part-of-speech (POS) category.  The `NounSpreadsheets/`, `PVSpreadsheets/`, and `VerbSpreadsheets/` directories all contain detailed READMEs discussing their respective CSV contents, which also provides quite a lit of linguistic information similar to what one might find in a grammar. There is also detailed documentation of the phonological rules. Here are links to each one:

* [Verbs](VerbSpreadsheets/README.md)
* [Nouns](NounSpreadsheets/README.md)
* [Preverbs/Prenouns](PVSpreadsheets/README.md)
* [Adverbs, numerals, proper nouns, particles](OtherSpreadsheets/README.md)
* [Phonological rules](xfst/README.md)

The directories `config/`, `xsft/`, and `templates` contain additional Ojibwe-specific files used to create the FST.

### License/Copyright
Unless otherwise indicated, the work and content within this repository is copyrighted by The Experimental Linguistics and Fieldwork Lab (ELF-Lab; https://github.com/ELF-Lab) at The University of British Colimbia (UBC) in collaboration with the Alberta Language Technology Lab (ALT-Lab; https://altlab.ualberta.ca/) at the University of Alberta (UofA) and the Ojibwe People's Dictionary (OPD; http://ojibwe.lib.umn.edu) at the University of Minnesota (UofM), as well as various other organizations, unless otherwise attributed.

Unless otherwise indicated, this repository and its contents are copyrighted under the Creative Commons Attribution NonCommercial-ShareAlike 4.0 International License (https://creativecommons.org/licenses/by-nc-sa/4.0/). This means you are free to share the materials (copy and redistribute the material in any medium or format) and adapt the materials (remix, transform, and build upon the material) within this repository under the following conditions:

**Attribution**: You must give appropriate credit when using this material, indicate changes that were made to the original material, and include a statement such as:

> *"Copyrighted under the Creative Commons Attribution NonCommercial-ShareAlike 4.0 International License (https://creativecommons.org/licenses/by-nc-sa/4.0/) by The Experimental Linguistics and Fieldwork Lab (ELF-Lab; https://github.com/ELF-Lab) at The University of British Colimbia (UBC) in collaboration with the Alberta Language Technology Lab (ALT-Lab; https://altlab.ualberta.ca/) at the University of Alberta (UofA) and the Ojibwe People's Dictionary (OPD; http://ojibwe.lib.umn.edu) at the University of Minnesota (UofM)."* 

Your attribution should include the above links, and should not in any way that suggest that ELF-Lab, UBC, ALT-Lab, UofA, the OPD, or the UofM endorses you or your use of the work unless otherwise indicated with a written endorsement.

**Noncommercial**: You may not use any material for commercial purposes unless otherwise authorized by ELF-Lab.

**Share Alike**: If you remix, transform, or build upon our materials, you may distribute the resulting work only under the same the same Creative Commons BY-NC-SA license, and include a link to the license.

### Acknowledgements
Several people and organizations have (directly or indirectly) contributed code, advice, tools and/or materials to this project. We extend our sincerest gratitude for the help! 

#### People

* Antti Arppe
* Chris Hammerly
* Ogimaawigwanebiik Nancy Jones
* Nora Livesay
* Minh Nguyen
* John Nichols
* Scott Parkhill
* Sandra Radic
* Miikka Silfverberg
* Anna Stacey
* Reed Steiner

#### Organizations and resources
* [AltLab](https://altlab.ualberta.ca/)
* [CultureFoundry](https://www.culturefoundrystudios.com/)
* [Foma](https://fomafst.github.io/)
* [Giellatekno](https://giellatekno.uit.no/index.eng.html)
* [Ojibwe People's Dictionary](https://ojibwe.lib.umn.edu/about-ojibwe-language)
* [UBC ELF-Lab](https://github.com/ELF-Lab)

#### Funding

This work was supported by a SSHRC Insight Grant (435-2023-0474) awarded to Hammerly, Arppe, and Silfverberg and a SSHRC Partnership Grant (895-2019-1012) to Arppe, Silfverberg and Hammerly (among others).

### Citation
To cite this work or the contents of the repository (including, but not limited to, datasets, tables, explanations, methods, analysis, structure, etc) in an academic work, please use the following:

> [Hammerly, C., Livesay, N., Arppe A., Stacey, A., & Silfverberg, M. (Submitted) OjibweMorph: An approachable morphological parser for Ojibwe](https://christopherhammerly.com/publication/ojibwemorph/OjibweMorph.pdf)


[def]: VerbSpreadsheets/README.md
