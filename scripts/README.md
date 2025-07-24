- Run the following to analyze a text (altering the path to your example sentences and FST as needed):  
`sh scripts/analyze_text.sh ../OjibweLexicon/OPD/example_sentences/example_sentences.txt ./FST/generated/ojibwe.fomabin`
    - The first argument refers to the text being analyzed.
    - The second argument is where your FST is located.
- Run the following to analyze the texts by speaker:  
`sh scripts/analyze_texts_by_speaker.sh ../OjibweLexicon/OPD/example_sentences/by_speaker ./FST/generated/ojibwe.fomabin`
- Run the following to get some stats on **ambiguity**:  
`python3 scripts/ambiguity.py ../OjibweLexicon/OPD/example_sentences/example_sentences_analyzed.txt ../OjibweLexicon/OPD/example_sentences/`
    - The first argument is the input file path.
    - The second argument is the output directory to print to.
    - This will generate `ambiguity_by_wordform.csv`, which tells you how many analyses the FST gives for each word form.
- `ambiguity.py` can be tested with the following command:  
`sh scripts/test_ambiguity.sh`
- To get more of a snapshot of the overall amount of ambiguity, run the following:
`cat ../OjibweLexicon/OPD/example_sentences/ambiguity_by_wordform.csv | cut -d ',' -f2 | sort -n | uniq -c > ../OjibweLexicon/OPD/example_sentences/ambiguity_summary.txt`
    - Modify the OjibweLexicon paths as needed to point to the right input file, and desired output file name.
    - This will write a .txt that has the analysis counts on the right, and the count of each count on the left.  For example, the row `29 8` means that there were 29 words that received exactly 8 analyses from the FST.
    - You can test this summary with `sh scripts/test_ambiguity_summary.sh`.