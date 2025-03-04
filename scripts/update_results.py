import pandas as pd
from os import path
import re

def read_results(results_file_path):
    results = pd.read_csv(results_file_path)
    most_recent_results_row = results.tail(1)
    date = most_recent_results_row["Date"].values[0]
    precision = most_recent_results_row["Total"].values[0]
    recall = most_recent_results_row["Unnamed: 2"].values[0]
    forms = most_recent_results_row["Unnamed: 3"].values[0]

    print("Reading in results...")

    return {"date": date, "precision": precision, "recall": recall, "forms": forms}

def update_readme(results, readme_file_path):
    RESULTS_LINE_START = "| "
    RESULTS_LINE_ENTRY_SEPARATOR = " | "
    RESULTS_LINE_END = " |\n"

    readme =  open(readme_file_path, "r+")
    lines = readme.readlines()
    for i, line in enumerate(lines):
        # Check if this is the results line (to be edited)
        if re.search("\\" + RESULTS_LINE_START + "[0-9]", line):
            lines[i] = RESULTS_LINE_START + results["date"] + RESULTS_LINE_ENTRY_SEPARATOR + results["forms"] + RESULTS_LINE_ENTRY_SEPARATOR + results["precision"] + RESULTS_LINE_ENTRY_SEPARATOR + results["recall"] + RESULTS_LINE_END

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
        update_readme(results, readme_file_path)
    else:
        print(f"ERROR: The CSV expected to contain the test results ({results_file_path}) was not found.")

main()