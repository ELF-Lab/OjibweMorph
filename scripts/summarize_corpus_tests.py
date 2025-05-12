# Largely based off test_summary.py in ParserTools

import argparse
from datetime import date
from os import path

OVERALL_RESULTS_LABEL = "total"

def extract_results(results_file):
    test_section = OVERALL_RESULTS_LABEL # default
    results = {}
    test_section_results = {}
    with open(results_file, "r") as file:
        lines = file.readlines()
        for index, line in enumerate(lines):
            if line.startswith("Analyzing sentences from speaker"):
                test_section = (line.partition(":")[2]).strip()
            elif line.startswith("Error rate"):
                test_section_results["error_rate"] = (((line.partition("=")[2]).partition("(")[0])).strip()
            elif line.startswith("Unique error rate"):
                test_section_results["unique_error_rate"] = (((line.partition("=")[2]).partition("(")[0])).strip()
                # Last line per section - finish things off
                results[test_section] = test_section_results
                test_section_results = {}

    return results

# Expects str, returns as str
# E.g., ".0654" -> "6.54%"
def format_value(value):
    value = float(value)
    value *= 100
    value = round(value, 2)
    value = str(value)
    value += "%,"
    return value

def format_results(results, test_sections):
    output_line = str(date.today()) + ","
    for test_section in test_sections:
        output_line += format_value(results[test_section]["error_rate"])
        output_line += format_value(results[test_section]["unique_error_rate"])

    return output_line

def get_prev_output_line(summary_output_file_path):
    prev_output_line = ""
    if path.isfile(summary_output_file_path):
        with open(summary_output_file_path, "r") as csv_file:
            lines = csv_file.readlines()
            if len(lines) >= 2: # At least one header and content line
                prev_output_line = lines[-1].strip()

    return prev_output_line

def write_to_csv(output_line, test_sections, summary_output_file_path):
    HEADER_1 = "Date,"
    HEADER_2 = ","
    for section in test_sections:
        HEADER_1 += section
        HEADER_1 += ",," # 2 fields per section
        HEADER_2 += "Error Rate,Unique Error Rate,"

    if not path.isfile(summary_output_file_path):
            with open(summary_output_file_path, "w+") as csv_file:
                print(HEADER_1, file = csv_file)
                print(HEADER_2, file = csv_file)
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

    # Determine speaker order
    test_sections = list(results.keys())
    test_sections.sort()
    test_sections.remove(OVERALL_RESULTS_LABEL)
    test_sections.insert(0, OVERALL_RESULTS_LABEL)

    output_line = format_results(results, test_sections)
    prev_output_line = get_prev_output_line(OUTPUT_FILE_NAME)
    if prev_output_line == output_line:
        print(f"Did not write to CSV ({OUTPUT_FILE_NAME}) as there were no changes to the test results (or date!).")
    else:
        write_to_csv(output_line, test_sections, OUTPUT_FILE_NAME)

main()