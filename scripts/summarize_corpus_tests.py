# Largely based off test_summary.py in ParserTools

import argparse
from datetime import date
from os import path

def extract_results(results_file):
    results = {}
    with open(results_file, "r") as file:
        lines = file.readlines()
        for index, line in enumerate(lines):
            if line.startswith("Error rate"):
                results["error_rate"] = (((line.partition("=")[2]).partition("(")[0])).strip()
            elif line.startswith("Unique error rate"):
                results["unique_error_rate"] = (((line.partition("=")[2]).partition("(")[0])).strip()

    return results

def format_results(results):
    output_line = str(date.today()) + ","
    output_line += str(float(results["error_rate"]) * 100) + "%,"
    output_line += str(float(results["unique_error_rate"]) * 100) + "%"

    return output_line

def get_prev_output_line(summary_output_file_path):
    prev_output_line = ""
    if path.isfile(summary_output_file_path):
        with open(summary_output_file_path, "r") as csv_file:
            lines = csv_file.readlines()
            if len(lines) >= 2: # At least one header and content line
                prev_output_line = lines[-1].strip()

    return prev_output_line

def write_to_csv(output_line, summary_output_file_path):
    HEADER = "Date,Error Rate,Unique Error Rate"

    if not path.isfile(summary_output_file_path):
            with open(summary_output_file_path, "w+") as csv_file:
                print(HEADER, file = csv_file)
    with open(summary_output_file_path, "a") as csv_file:
            csv_file.write(output_line + "\n")
    
    print("Wrote to", summary_output_file_path)
    csv_file.close()

def main():
    # Sets up argparse.
    parser = argparse.ArgumentParser(prog="summarize_corpus_tests")
    parser.add_argument("--input_file_name", type=str, help="The .txt file that is being read in.")
    args = parser.parse_args()

    OUTPUT_FILE_NAME = "./FST/corpus_test_summary.csv"

    results = extract_results(args.input_file_name)
    output_line = format_results(results)
    prev_output_line = get_prev_output_line(OUTPUT_FILE_NAME)
    if prev_output_line == output_line:
        print(f"Did not write to CSV ({OUTPUT_FILE_NAME}) as there were no changes to the test results (or date!).")
    else:
        write_to_csv(output_line, OUTPUT_FILE_NAME)

main()