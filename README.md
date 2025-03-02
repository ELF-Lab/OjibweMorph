# Test Results

TBD

# Citation

To cite this work or the contents of the repository (including, but not limited to, datasets, tables, explanations, methods, analysis, structure, etc) in an academic work, please use the following:

> Hammerly, C., Livesay, N., Arppe, A., Stacey, A., Steiner, R., & Silfverberg, M. (2024). OjibweMorph (Version 1.0.0) [Computer software]. https://doi.org/10.5281/zenodo.1234

# License/Copyright

Unless otherwise indicated, the work and content within this repository is copyrighted by The Experimental Linguistics and Fieldwork Lab (ELF-Lab; https://github.com/ELF-Lab) at The University of British Colimbia (UBC) in collaboration with the Alberta Language Technology Lab (ALT-Lab; https://altlab.ualberta.ca/) at the University of Alberta (UofA) and the Ojibwe People's Dictionary (OPD; http://ojibwe.lib.umn.edu) at the University of Minnesota (UofM), as well as various other organizations, unless otherwise attributed.

Unless otherwise indicated, this repository and its contents are copyrighted under the Creative Commons Attribution NonCommercial-ShareAlike 4.0 International License (https://creativecommons.org/licenses/by-nc-sa/4.0/). This means you are free to share the materials (copy and redistribute the material in any medium or format) and adapt the materials (remix, transform, and build upon the material) within this repository under the following conditions:

**Attribution**: You must give appropriate credit when using this material, indicate changes that were made to the original material, and include a statement such as:

> *"Copyrighted under the Creative Commons Attribution NonCommercial-ShareAlike 4.0 International License (https://creativecommons.org/licenses/by-nc-sa/4.0/) by The Experimental Linguistics and Fieldwork Lab (ELF-Lab; https://github.com/ELF-Lab) at The University of British Colimbia (UBC) in collaboration with the Alberta Language Technology Lab (ALT-Lab; https://altlab.ualberta.ca/) at the University of Alberta (UofA) and the Ojibwe People's Dictionary (OPD; http://ojibwe.lib.umn.edu) at the University of Minnesota (UofM)."* 

Your attribution should include the above links, and should not in any way that suggest that ELF-Lab, UBC, ALT-Lab, UofA, the OPD, or the UofM endorses you or your use of the work unless otherwise indicated with a written endorsement.

**Noncommercial**: You may not use any material for commercial purposes unless otherwise authorized by ELF-Lab.

**Share Alike**: If you remix, transform, or build upon our materials, you may distribute the resulting work only under the same the same Creative Commons BY-NC-SA license, and include a link to the license.

# Building the FST
**Prerequisites**: In addition to this repository, you'll also need to get [OjibweLexicon](https://github.com/ELF-Lab/OjibweLexicon) and [ParserTools](https://github.com/ELF-Lab/ParserTools) installed locally.  ParserTools contains the non-language-specific pieces for creating an FST, and you should check out [the relevant documentation](https://github.com/ELF-Lab/ParserTools/tree/main/csv2fst) to make sure you have all the necessary prerequisites to use its code.

The FST is created using code in ParserTools, which makes use of language-specific information stored in both OjibweMorph and OjibweLexicon.  The `create_fst.sh` script in this repo can be used to call the ParserTools code while supplying it with paths to the Ojibwe repos.  
First, go into `create_fst.sh` and change the file path variables to match your system.  Next, when calling `create_fst.sh`, just pass a keyword that will be given to the `Makefile` in ParserTools:
- `sh create_fst.sh all` to simply build the FST
- `sh create_fst.sh check` to run tests on the FST
- `sh create_fst.sh clean` to remove generated files

By default, the lemma list will be taken from [OjibweLexicon/OPD](https://github.com/ELF-Lab/OjibweLexicon/tree/main/OPD).  You can change this in `create_fst.sh` to look elsewhere *or* use multiple lists by giving a comma-separated list of directories.