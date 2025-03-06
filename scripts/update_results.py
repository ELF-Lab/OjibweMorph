import pandas as pd
from os import path
import re

# In the README, write results in this order
RESULT_HEADERS_ORDERED = ["date", "forms", "precision", "recall"]

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

    print("Reading in results...")

    return {"date": date, "precision": precision, "recall": recall, "forms": forms}

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

def update_readme(results_line, readme_file_path):
    readme =  open(readme_file_path, "r+")
    lines = readme.readlines()
    for i, line in enumerate(lines):
        # Check if this is the results line (to be edited)
        if re.search("\| [0-9]", line):
            lines[i] = results_line
    # Re-write the file
    readme.truncate(0)
    readme.seek(0)
    readme.writelines(lines)

    print("Wrote to", readme_file_path)
    readme.close()

def main():
    results_file_path = "./FST/verb_test_summary.csv"
    readme_file_path = "./README.md"
    if path.isfile(results_file_path):
        results = read_results(results_file_path)
        results_line = format_results(results)
        update_readme(results_line, readme_file_path)
    else:
        print(f"ERROR: The CSV expected to contain the test results ({results_file_path}) was not found.")

main()