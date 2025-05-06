import pandas as pd
from os import path
import re

# In the README, write results in this order
RESULT_HEADERS_ORDERED = ["date", "forms", "forms_without_results", "precision", "recall"]

# Ideally this CSV could be read in really tidily, but for the sake
# of readability it has two "header" rows, which makes it hard to parse
# values automatically.  So this function works but is a little cursed
# (see: all the "unnammed" columns).
def read_results(results_file_path):
    results = pd.read_csv(results_file_path)
    most_recent_results_row = results.tail(1)
    date = most_recent_results_row["Date"].values[0]
    precision = most_recent_results_row["Total"].values[0]
    recall = most_recent_results_row["Unnamed: 2"].values[0]
    forms = most_recent_results_row["Unnamed: 3"].values[0]
    forms_without_results = ((most_recent_results_row["Unnamed: 4"].values[0]).partition(" "))[0]

    print(f"\nReading in results from {results_file_path}...")

    return {"date": date, "precision": precision, "forms_without_results": forms_without_results, "recall": recall, "forms": forms}

def format_results(results):
    RESULTS_ENTRY_PRECEDOR = "| "
    RESULTS_ENTRY_FOLLOWER = " "
    RESULTS_LINE_END = "|\n"

    results_line = ""
    for header in RESULT_HEADERS_ORDERED:
        results_line += RESULTS_ENTRY_PRECEDOR
        results_line += results[header]
        results_line += RESULTS_ENTRY_FOLLOWER
    results_line += RESULTS_LINE_END

    return results_line

def update_readme(results_line, readme_file_path, section_title):
    readme =  open(readme_file_path, "r+")
    lines = readme.readlines()
    for line_index, line in enumerate(lines):
        # Check if this is a) a results line and b) the *right* results line (i.e., for verbs vs. for nouns)
        if re.search(r"\| [0-9]", line) and line_index >= 3 and (section_title in lines[line_index - 3]):
            lines[line_index] = results_line
    # Re-write the file
    readme.truncate(0)
    readme.seek(0)
    readme.writelines(lines)

    print("Wrote to", readme_file_path)
    readme.close()

# Make all the necessary fxn calls for EACH results CSV
def handle_results(results_file_path, readme_file_path, section_title):
    if path.isfile(results_file_path):
        results = read_results(results_file_path)
        results_line = format_results(results)
        update_readme(results_line, readme_file_path, section_title)
    else:
        print(f"ERROR: The README could not be updated because the CSV expected to contain the test results ({results_file_path}) was not found.")

def main():
    opd_verb_results_file_path = "./FST/opd_verb_test_summary.csv"
    opd_noun_results_file_path = "./FST/opd_noun_test_summary.csv"
    paradigm_verb_results_file_path = "./FST/paradigm_verb_test_summary.csv"
    paradigm_noun_results_file_path = "./FST/paradigm_noun_test_summary.csv"
    readme_file_path = "./README.md"

    handle_results(opd_verb_results_file_path, readme_file_path, "OPD Verbs")
    handle_results(opd_noun_results_file_path, readme_file_path, "OPD Nouns")
    handle_results(paradigm_verb_results_file_path, readme_file_path, "Paradigm Verbs")
    handle_results(paradigm_noun_results_file_path, readme_file_path, "Paradigm Nouns")

main()