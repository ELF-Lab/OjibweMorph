- Run the following to analyze a text (altering the path to your example sentences and FST as needed):  
`sh scripts/analyze_text.sh ../OjibweLexicon/OPD/example_sentences/example_sentences.txt ./FST/generated/ojibwe.fomabin`
    - The first argument refers to the text being analyzed.
    - The second argument is where your FST is located.
- Run the following to analyze the texts by speaker:  
`sh scripts/analyze_texts_by_speaker.sh ../OjibweLexicon/OPD/example_sentences/by_speaker ./FST/generated/ojibwe.fomabin`