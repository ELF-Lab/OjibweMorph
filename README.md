# OjibweMorph
This repository is for creating a finite-state transducer (FST) in the Ojibwe language.  The FST can be used to generate morphological analyses for an inflected form, or vice versa.

Morphological information about Ojibwe words is housed here.  Combined with the FST-generating code in [FSTmorph](https://github.com/ELF-Lab/FSTmorph) and the Ojibwe lexical information stored in [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon), the FST can be generated as specified [below](#building-the-fst).

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
  - [Preparing to Build the FST](#preparing-to-build-the-fst)
  - [Building the FST](#building-the-fst)
  - [Preparing to Use the FST](#preparing-to-use-the-fst)
  - [Using the FST](#using-the-fst)
  - [Running the Tests](#running-the-tests)
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
| 2025-08-12 | 66801 | 135 | 77.25% | 97.01% |

#### OPD Nouns
| Date Last Updated | # of Forms Tested | # of Forms Without Results |  Precision | Recall |
|---|---|---|---|---|
| 2025-08-12 | 8565 | 15 | 83.4% | 96.92% |

### Paradigm Tests
The inflected forms used in these tests come from the `NounSpreadsheets/` and `VerbSpreadsheets/` folders here in `OjibweMorph`. This smaller test set is used largely as a sanity check.

#### Paradigm Verbs
| Date Last Updated | # of Forms Tested | # of Forms Without Results | Precision | Recall |
|---|---|---|---|---|
| 2025-08-12 | 8089 | 0 | 93.93% | 100.0% |

#### Paradigm Nouns
| Date Last Updated | # of Forms Tested | # of Forms Without Results |  Precision | Recall |
|---|---|---|---|---|
| 2025-08-12 | 14330 | 0 | 99.98% | 100.0% |

### Corpus Tests
The inflected forms used in these tests come from example sentences in [the OPD](https://ojibwe.lib.umn.edu), stored in [OjibweLexicon/OPD/example_sentences](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD/example_sentences).

The overall results are given at the bottom of the table, but a breakdown by the speaker of the example sentence is also provided first.  Because the speakers come from a variety of communities, this can give an impression of how well the FST is covering different varieties of Ojibwe.  You can learn more about the speakers [here](https://ojibwe.lib.umn.edu/about/voices).

In the table below, we are simply counting 'failures' -- forms that receive no analysis whatsover from the FST.  This is because unlike with the OPD and paradigm tests, we do not have a "gold standard" analysis to check.  The "by-token" failure covers every token (word) in the example sentences, whereas the "by-type" failures consider every *unique* token (i.e., so that each token only counts once towards the score regardless of its frequency).
| Speaker | Region | Community |  By-Token Failure | By-Type Failure |
|---|---|---|---|---|
| NJ | Border Lakes | Nigigoonsiminikaaning | 5.03% (335/6651) | 7.32% (314/4285) |
| GJ | Border Lakes | Lac La Croix | 12.32% (9/73) | 12.5% (9/72) |
| ES | Red Lake | Obaashiing | 5.65% (539/9531) | 10.51% (518/4925) |
| RG | Red Lake | Odaawaa-Zaaga'iganiing | 2.54% (56/2197) | 4.44% (55/1237) |
| GH | Leech Lake | Jaachaabaaning | 2.71% (7/258) | 3.39% (7/206) |
| LW | Leech Lake | Jaachaabaaning | 2.63% (5/190) | 3.24% (5/154) |
| LS | Mille Lacs | Aazhomog | 8.19% (5/61) | 9.61% (5/52) |
| LSA | Mille Lacs | Lake Lena | 3.22% (1/31) | 3.44% (1/29) |
| Unknown | N/A | N/A | 0.0% (0/5) | 0.0% (0/5) |
| Overall | | | 5.03% (957/18997) | 9.24% (906/9803) |

Date Last Updated: 2025-08-12

## User Instructions
There are a few different ways to install OjibweMorph (in ascending order of effort involved):
- You can download the zipped files included with the [most recent release](https://github.com/ELF-Lab/OjibweMorph/releases).  The FST is already generated there, and you just need to install `foma` in order to make use of it.
- You can install the relevant files via Docker, and create the FST yourself (within the Docker container).
- You can download the relevant files directly to your system and create the FST yourself.

If you're going for the pre-built FST route, download those files and skip ahead to [*Preparing to Use the FST*](#preparing-to-use-the-fst).  Otherwise, read on for the steps to build the FST yourself.

### Preparing to Build the FST
These steps will get all the necessary pieces installed to ultimately generate the FST.  Two sets of steps are included below -- via Docker and via installing directly on your local system.  
We have included detailed instructions on using Docker so that you shouldn't need to have used it previously to follow the steps.  Essentially, using Docker installs everything in a 'container', separated from your general system, so that the installations are isolated and won't affect other programs you run.

#### Installation via Docker
These instructions will have you create and use a container directly in VSCode, so you can use the `Makefile` to generate the FST from within the container.  
This method includes the installation of `foma`, so you can skip that installation step later.

1. Make sure you have [Docker Desktop](https://docs.docker.com/get-started/get-docker/) installed.
- In order to use docker in the command line, we also had to go to the Settings page in Docker Desktop and Choose `Advanced` > Check `System` > `Apply`.
2. Install the `Dev Containers` extension in VSCode.
3. With OjibweMorph open in VSCode, run `docker build -t ojibwemorph:latest -f .devcontainer/Dockerfile .` in the command line.
  - `-t ojibwemorph:latest` gives the image the name `ojibwemorph` and tag `latest`.
  - `-f .devcontainer/Dockerfile` specifies the Dockerfile to use to build the image, which has to be manually specified because it is not in the build context, which is specified as `.` (i.e., the current directory = the root of OjibweMorph).
  - On Mac, running this may lead to a system prompt saying that VSCode wants to access data from other apps.  You can decline; everything will still build fine.
- You'll see the image being built in the terminal in VSCode.  It may take a minute or two, and when it's done, you can push any key to close it.
- In Docker Desktop, you should now see your built image.
3. Back in VSCode, use `Cmd+Shift+P` to run commands, and choose `Dev Containers: Reopen in Container`.  This will reopen the VSCode window inside the container.
  - You may get asked which `devcontainer.json` to use -- choose `OjibweMorph` (`OjibweMorph/.devcontainer/devcontainer.json`).
4. Here, you should see the directories `OjibweLexicon/` and `OjibweMorph/` ready to go.  You can `cd` into `OjibweMorph/` and use the `Makefile` as normal to generate the FST (see [Buildling the FST](#building-the-fst)).
5. When done, you can click the `Dev Container: OjibweMorph @...` button in the bottom left of VSCode, then choose `Reopen Locally` to close the container.
6. You can use `docker system prune -a -f` to delete all Docker containers and images you've generated (though if you have other containers/images you wish to keep, you can also just manually delete individual ones in Docker Desktop).

#### Regular Installation
1. Clone **OjibweLexicon**  
In addition to this repository, you'll also need to get [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon) installed locally.

2. Install **FSTmorph**
The FST is created using code in [FSTmorph](https://github.com/ELF-Lab/FSTmorph), which makes use of language-specific information stored in both **OjibweMorph** and **OjibweLexicon**.  
**FSTmorph** can be installed via pip (along with a couple other python packages), by running the following (while in the `OjibweMorph/` root directory):
`pip install -r requirements.txt`

3. Make edits to the `Makefile` as needed  
The Makefile in this repo contains variables for various file locations.  For the most part the pre-set values should work fine, but you should ensure that the location of **OjibweLexicon** (i.e., the `OJIBWE_LEXICON` var) is correct for your local installation.

### Building the FST
Use the `Makefile`:
- `make all` to simply build the FST
- `make check` to run tests on the FST
- `make clean` to remove all generated files, if desired

> Note: When running these commands, we have sometimes encountered an error message related to `malloc`.  It seems to happen randomly, and you can just run the command again (perhaps running the `clean` command above in between) until the error does not occur.

By default, the output will go in a local directory called `FST/`.  In there, the directory `generated` contains the FST, lexc files and XFST rules.  The FST itself is `FST/generated/ojibwe.fomabin`.

By default, the lemma list will be taken from [OjibweLexicon/OPD](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD) and [OjibweLexicon/HammerlyFieldwork](https://github.com/ELF-Lab/OjibweLexicon/tree/main/HammerlyFieldwork).  You can change this in the `Makefile` to look elsewhere.  You can use multiple lists by giving a comma-separated list of directories.

### Preparing to Use the FST
To make use of the FST, you will need to install [the foma compiler](https://fomafst.github.io) (and the `flookup` program, included as part of the foma toolkit).  If you installed via Docker, this is already installed for you. Otherwise, on Mac or Linux, the easiest way to install is via [homebrew](https://formulae.brew.sh/formula/foma).  Just use the command `brew install foma`.  Alternatively, there are other installation instructions [here](https://blogs.cornell.edu/finitestatecompling/2016/08/24/installing-foma/) (including for Windows users).

> Note for Windows users: In addition to the page given above, we found [these instructions](https://ufal.mff.cuni.cz/~zeman/vyuka/morfosynt/lab-twolm/get-foma.html) useful for installing.  Also, ensure that the directory you add to your PATH immediately contains `foma.exe` and `flookup.exe`.  For example, if the path to `foma.exe` is `C:\Program Files (x86)\Foma\win32\foma.exe`, then add `C:\Program Files (x86)\Foma\win32` (not `C:\Program Files (x86)\Foma\`) to your PATH.

### Using the FST
This FST is run using [foma](https://fomafst.github.io).  In addition to the example give below, some documentation from their team is available [here](https://github.com/mhulden/foma/blob/master/foma/docs/simpleintro.md).

1. Start the Foma program with the following command:  
`foma`  
Some information about foma should appear, and your prompt should now say `foma[0]: `.

2.  Load the Ojibwe FST you created in [the previous section](#building-the-fst) with:  
`load FST/generated/ojibwe.fomabin`  
Adjust the filepath as necessary -- this will work if you are in `OjibweMorph/` and used the default FST location.
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

### Running the Tests
A call to `make check` will test the generated FST.  As outlined in the [Test Results](#test-results) section of this README, three sets of tests are run: OPD tests, paradigm tests, and corpus tests.

The OPD and paradigm tests are conducted using testing infrastructure in FSTmorph, based on [giella-core](https://github.com/giellalt/giella-core).  Detailed information about the results of the (most recent run of) tests can be found in the generated log files: `FST/opd-test.log` and `FST/paradigm-test.log`.  A CSV summarizing the results of the tests *over time* is also generated: `FST/opd_noun_test_summary.csv` etc.  In the CSV, each row corresponds to a new run of the tests (though it will not add duplicate rows, i.e., no new rows will get printed if the test results and date have not changed).

The corpus tests are specific to this FST and are thus not run via FSTmorph -- the relevant code is all in `scripts/` here in OjibweMorph.  Similarly to the other tests, you can view details about the most recent test results in `FST/corpus_test.txt` and a summary of results over time in `FST/corpus_test_summary.csv`.

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
Unless otherwise indicated, the work and content within this repository is copyrighted by The Experimental Linguistics and Fieldwork Lab (ELF-Lab; https://github.com/ELF-Lab) at The University of British Columbia (UBC) in collaboration with the Alberta Language Technology Lab (ALT-Lab; https://altlab.ualberta.ca/) at the University of Alberta (UofA) and the Ojibwe People's Dictionary (OPD; http://ojibwe.lib.umn.edu) at the University of Minnesota (UofM), as well as various other organizations, unless otherwise attributed.

Unless otherwise indicated, this repository and its contents are copyrighted under the Creative Commons Attribution NonCommercial-ShareAlike 4.0 International License (https://creativecommons.org/licenses/by-nc-sa/4.0/). This means you are free to share the materials (copy and redistribute the material in any medium or format) and adapt the materials (remix, transform, and build upon the material) within this repository under the following conditions:

**Attribution**: You must give appropriate credit when using this material, indicate changes that were made to the original material, and include a statement such as:

> *"Copyrighted under the Creative Commons Attribution NonCommercial-ShareAlike 4.0 International License (https://creativecommons.org/licenses/by-nc-sa/4.0/) by The Experimental Linguistics and Fieldwork Lab (ELF-Lab; https://github.com/ELF-Lab) at The University of British Columbia (UBC) in collaboration with the Alberta Language Technology Lab (ALT-Lab; https://altlab.ualberta.ca/) at the University of Alberta (UofA) and the Ojibwe People's Dictionary (OPD; http://ojibwe.lib.umn.edu) at the University of Minnesota (UofM)."* 

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
