- Run the following to analyze a text (altering the path to your example sentences and FST as needed):  
`sh scripts/analyze_text.sh ../OjibweLexicon/OPD/example_sentences/example_sentences.txt ./FST/generated/ojibwe.fomabin`
    - The first argument refers to the text being analyzed.
    - The second argument is where your FST is located.
- Run the following to analyze the texts by speaker:  
`sh scripts/analyze_texts_by_speaker.sh ../OjibweLexicon/OPD/example_sentences/by_speaker ./FST/generated/ojibwe.fomabin`
- Run the following to get a summary of ambiguity:  
`python3 scripts/ambiguity.py ../OjibweLexicon/OPD/example_sentences/example_sentences_analyzed.txt ../OjibweLexicon/OPD/example_sentences/`
    - The first argument is the input file path.
    - The second argument is the output directory to print to.
- `ambiguity.py` can be tested with the following command:  
`sh scripts/test_ambiguity.sh`