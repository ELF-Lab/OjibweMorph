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
    return f"{row['Lemma']}+{'+'.join(tags)}"

@click.command()
@click.option('--spreadsheets', required=True, help="Comma-separated list of spreadsheets to process. E.g. --spreadsheets=\"VTA_IND.csv,VTA_CNJ.csv,VTA_IMP.csv\".")
@click.option('--config-file', required=True, help="Configuration file. E.g. --config-file=../config/ojibwe_verbs.json.")
@click.option('--output-file',required=True, help="Output CSV file name. E.g. --output-file=VTA_ambiguity.csv.")
@click.option('--include-class', required=False, default=False, help="Index both by lemma and indflection class (aka type). E.g. --include-class=True.")
def main(spreadsheets, config_file, include_class,output_file):
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
            if include_class:
                lemma += f",{row['Class']}"
            for i in range(1,MAXFORMS+1):
                form_i_key = f"Form{i}Surface"
                if not form_i_key in row.keys():
                    break
                if row[form_i_key] == MISSING or row[form_i_key] == "":
                    continue
                form = row[form_i_key]                
                analysis_sets[lemma][form].add(analysis)

    with open(output_file,"w") as output_file:
        if include_class:
            print("Lemma,Class,SurfaceForm,Analysis",file=output_file)
        else:
            print("Lemma,SurfaceForm,Analysis", file=output_file)
        for lemma, forms in analysis_sets.items():
            for form, analyses in sorted(forms.items()):
                if len(analyses) < 2:
                    continue
                for analysis in analyses:
                    print(lemma, form, analysis, sep=",",file=output_file)
            
if __name__=="__main__":
    main()
