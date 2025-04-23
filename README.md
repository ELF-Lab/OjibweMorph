# OjibweMorph
This repository is for creating a finite-state transducer (FST) in the Ojibwe language.  The FST can be used to generate morphological analyses for an inflected form, or vice versa.

Morphological information about Ojibwe words is housed here.  Combined with the FST-generating code in [ParserTools](https://github.com/ELF-Lab/ParserTools) and the Ojibwe lexical information stored in [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon), the FST can be generated as specified [below](#building-the-fst).

## Contents
-  [Test Results](#test-results)
- [User Instructions](#user-instructions)
    - [Building the FST](#building-the-fst)
    - [Using the FST](#using-the-fst)
- [About OjibweMorph](#about-ojibwemorph)
    - [Morphological Info](#morphological-info)
    - [License/Copyright](#licensecopyright)
    - [Acknowledgements](#acknowledgements)
    - [Citation](#citation)

## Test Results
These results reflect the performance of an FST built from the morphology stored in [OjibweMorph](https://github.com/ELF-Lab/OjibweMorph) and the lemmas stored in [OjibweLexicon/OPD](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD) and [OjibweLexicon/HammerlyFieldwork](https://github.com/ELF-Lab/OjibweLexicon/tree/main/HammerlyFieldwork).  The inflected test forms also come from [the OPD](https://ojibwe.lib.umn.edu), and are stored in [OjibweLexicon/OPD/for_yaml](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD/for_yaml).  Each test form is inputted to the FST, then the corresponding analysis outputted by the FST is checked for correctness.

The "# of Forms Without Results" counts the test forms for which the FST provides no analysis whatsoever.  The "Precision" captures how many outputted analyses were correct, while the "Recall" captures how many of the correct analyses were outputted.  Note that some forms have multiple correct analyses.

### Verbs
| Date Last Updated | # of Forms Tested | # of Forms Without Results | Precision | Recall |
|---|---|---|---|---|
| 2025-04-21 | 54212 | 157 | 86.03% | 96.72% |

### Nouns
| Date Last Updated | # of Forms Tested | # of Forms Without Results |  Precision | Recall |
|---|---|---|---|---|
| 2025-04-21 | 8567 | 450 | 83.35% | 91.56% |
## User Instructions

### Building the FST
**Prerequisites**: In addition to this repository, you'll also need to get [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon) and [ParserTools](https://github.com/ELF-Lab/ParserTools) installed locally.  ParserTools contains the non-language-specific pieces for creating an FST, and you should check out [the relevant documentation](https://github.com/ELF-Lab/ParserTools/tree/main/csv2fst) to make sure you have all the necessary prerequisites to use its code.

The FST is created using code in ParserTools, which makes use of language-specific information stored in both OjibweMorph and OjibweLexicon.  The `create_fst.sh` script in this repo can be used to call the ParserTools code while supplying it with paths to the Ojibwe repos.  
First, go into `create_fst.sh` and change the file path variables to match your system.  Next, when calling `create_fst.sh`, just pass a keyword that will be given to the `Makefile` in ParserTools:
- `sh create_fst.sh all` to simply build the FST
- `sh create_fst.sh check` to run tests on the FST
- `sh create_fst.sh clean` to remove generated files

By default, the output will go in a local directory called `FST/`.

By default, the lemma list will be taken from [OjibweLexicon/OPD](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD) and [OjibweLexicon/HammerlyFieldwork](https://github.com/ELF-Lab/OjibweLexicon/tree/main/HammerlyFieldwork).  You can change this in `create_fst.sh` to look elsewhere.  You can use multiple lists by giving a comma-separated list of directories.

### Using the FST
This FST is created using [Foma](https://fomafst.github.io).  Some documentation from their team is available [here](https://github.com/mhulden/foma/blob/master/foma/docs/simpleintro.md).  Additonally, a simple example of using this Ojibwe FST is provided below:
1. Start Foma with the following command:  
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
`wiigwaasi`  
`wiigwaas`  
You can input as many of these commands as you like.

4. Once you're done using foma, you can exit with:
`quit` or `exit`
## About OjibweMorph
### Morphological Info
The `XSpreadsheets/` directories contain CSVs with example forms for the various paradigm and class categories within each part-of-speech (POS) category.  The `NounSpreadsheets/`, `PVSpreadsheets/`, and `VerbSpreadsheets/` directories all contain detailed READMEs discussing their respective CSV contents.

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

### People
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

### Organizations and resources
* [AltLab](https://altlab.ualberta.ca/)
* [CultureFoundry](https://www.culturefoundrystudios.com/)
* [Foma](https://fomafst.github.io/)
* [Giellatekno](https://giellatekno.uit.no/index.eng.html)
* [Ojibwe People's Dictionary](https://ojibwe.lib.umn.edu/about-ojibwe-language)
* [UBC ELF-Lab](https://github.com/ELF-Lab)

### Citation
To cite this work or the contents of the repository (including, but not limited to, datasets, tables, explanations, methods, analysis, structure, etc) in an academic work, please use the following:

> [Hammerly, C., Livesay, N., Arppe A., Stacey, A., & Silfverberg, M. (Submitted) OjibweMorph: An approachable morphological parser for Ojibwe](https://christopherhammerly.com/publication/ojibwemorph/OjibweMorph.pdf)
