import click
import pandas
import json
from collections import defaultdict

# We're going to assume there aren't more than 100 surface forms for
# any given analysis (massive overkill).
MAXFORMS=100

NONE="NONE" # Missing tag marker
MISSING="MISSING" # Missing form marker

def get_analysis(row, tag_order):
    tags = [row[feature] for feature in tag_order if (feature in row and
                                                      row[feature] != NONE)]
    return '+'.join(tags)

def subtract(l1, l2):
    """Set subtraction which preserves order (by simulating sets by lists)."""
    subtracted = []
    l2 = set(l2)
    for elem in l1:
        if not elem in l2:
            subtracted.append(elem)
    return subtracted

def symmetric_difference(analysis1, analysis2):
    analysis1 = analysis1.split("+")
    analysis2 = analysis2.split("+")
    return ("+".join(subtract(analysis1,analysis2)),
            "+".join(subtract(analysis2,analysis1)))

@click.command()
@click.option('--spreadsheets', required=True, help="Comma-separated list of spreadsheets to process. E.g. --spreadsheets=\"VTA_IND.csv,VTA_CNJ.csv,VTA_IMP.csv\".")
@click.option('--config-file', required=True, help="Configuration file. E.g. --config-file=../config/ojibwe_verbs.json.")
@click.option('--output-file',required=True, help="Output CSV file name. E.g. --output-file=VTA_ambiguity.csv.")
def main(spreadsheets, config_file, output_file):
    """Find ambiguous forms in CSV spreadsheets. E.g. for English, \"put\"
       would be ambiguous between the reading put+V+NON_3SG+PRES and
       put+V+PAST."""
    with open(config_file) as f:
        config = json.load(f)
    tag_order = config["morph_features"]
    spreadsheets = spreadsheets.split(",")
    # We index analyses first by lemma (and potentially class), then by surface form.
    analysis_sets = defaultdict(lambda : defaultdict(set))
    for spreadsheet in spreadsheets:
        spreadsheet = pandas.read_csv(spreadsheet,
                                      keep_default_na=False)
        for _, row in spreadsheet.iterrows():
            analysis = get_analysis(row, tag_order)
            lemma = row["Lemma"]
            for i in range(1,MAXFORMS+1):
                form_i_key = f"Form{i}Surface"
                if not form_i_key in row.keys():
                    break
                if row[form_i_key] == MISSING or row[form_i_key] == "":
                    continue
                form = row[form_i_key]                
                analysis_sets[lemma][form].add(analysis)

    analysis_sets = set(tuple(analyses) for lemma in analysis_sets
                        for form, analyses in analysis_sets[lemma].items())
    analysis_sets = set(analyses for analyses in analysis_sets
                        if len(analyses) > 1)
    analysis_diffs = defaultdict(set)
    for analyses in analysis_sets:
        for analysis1 in analyses:
            for analysis2 in analyses:
                if analysis1 != analysis2:
                    analysis_diffs[symmetric_difference(analysis1, analysis2)].add((analysis1, analysis2))

    with open(output_file,"w") as output_file:
        print("Unique1Tags,Unique2Tags,Analysis1,Analysis2",file=output_file)
        for (unique_1_tags, unique_2_tags), analysis_set in analysis_diffs.items():
            for (analysis1, analysis2) in sorted(analysis_set):
                print(f"{unique_1_tags},{unique_2_tags},{analysis1},{analysis2}",
                      file=output_file)

if __name__=="__main__":
    main()
