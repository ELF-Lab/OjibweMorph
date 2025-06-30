'''
- Summary of corpus test flow:
    - Call to FSTMorph in Makefile creates .fomabin
    - analyze_text.sh creates .tok, .analyzed, etc.
        - output written to corpus_test.txt
    - summarize_corpus_tests.py converts corpus_test.txt to a CSV
    - update_results.py writes those results to the README
- What should happen if .fomabin doesn't exist?
    - We can't run the tests.
    - The README should only change when changes to the FST have led to changes
    in results.  This is a failure to test, not a test that indicates failure.
        - So the CSV should not change either.
        - corpus-test.txt, as the output of running the FST, will indicate a failure to run the tests.
        - Then summarize_corpus_tests.py will indicate that the tests did not run.
'''

# Largely based off test_summary.py in FSTMorph

import argparse
from datetime import date
from os import path

OVERALL_RESULTS_LABEL = "total"
# Check the input file for this word.
# If it's there, assume the tests did not succeed and do not summarize them.
KEYWORD_INDICATING_ERRONEOUS_TEST="ERROR"

# Will check for an indication of failure to run the tests in the .txt
# If such an indication is found, returns None
def extract_results(results_file):
    test_section = OVERALL_RESULTS_LABEL # default
    results = {}
    test_section_results = {}
    erroneous_input = False

    with open(results_file, "r") as file:
        lines = file.readlines()
        # Check for errors while running the tests
        for line in lines:
            if KEYWORD_INDICATING_ERRONEOUS_TEST in line:
                erroneous_input = True
        if not(erroneous_input):
            for index, line in enumerate(lines):
                if line.startswith("Analyzing sentences from speaker"):
                    test_section = (line.partition(":")[2]).strip()
                elif line.startswith("Error rate"):
                    test_section_results["error_rate"] = (((line.partition("=")[2]).partition("(")[0])).strip()
                    test_section_results["forms"] = ((line.partition("/")[2]).split()[0]).strip()
                    test_section_results["forms_with_no_results"] = (line.partition("/")[0]).partition("(")[2]
                elif line.startswith("Unique error rate"):
                    test_section_results["unique_error_rate"] = (((line.partition("=")[2]).partition("(")[0])).strip()
                    test_section_results["unique_forms"] = ((line.partition("/")[2]).split()[0]).strip()
                    test_section_results["unique_forms_with_no_results"] = (line.partition("/")[0]).partition("(")[2]
                    # Last line per section - finish things off
                    results[test_section] = test_section_results
                    test_section_results = {}

    return results

# Expects str, returns as str
# E.g., ".0654" -> "6.54%"
def to_percent(value):
    value = float(value)
    value *= 100
    value = round(value, 2)
    value = str(value)
    value += "%"
    return value

def format_results(results, test_sections):
    output_line = str(date.today()) + ","
    for test_section in test_sections:
        output_line += results[test_section]["forms"] + ","
        output_line += results[test_section]["forms_with_no_results"]
        output_line += " (" + to_percent(results[test_section]["error_rate"]) + "),"
        output_line += results[test_section]["unique_forms"] + ","
        output_line += results[test_section]["unique_forms_with_no_results"]
        output_line += " (" + to_percent(results[test_section]["unique_error_rate"]) + "),"

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
        HEADER_1 += ",,,," # 4 fields per section
        HEADER_2 += "Tokens,Tokens without Results,Unique Tokens,Unique Tokens without Results,"

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
    if results:
        # Determine speaker order
        test_sections = list(results.keys())
        test_sections.sort()
        test_sections.remove(OVERALL_RESULTS_LABEL)
        test_sections.insert(0, OVERALL_RESULTS_LABEL)

        output_line = format_results(results, test_sections)
        prev_output_line = get_prev_output_line(OUTPUT_FILE_NAME)
        if prev_output_line == output_line:
            print(f"\nDid not write to CSV ({OUTPUT_FILE_NAME}) as there were no changes to the test results (or date!).")
        else:
            write_to_csv(output_line, test_sections, OUTPUT_FILE_NAME)
    else:
        print(f"\nDid not write to CSV ({OUTPUT_FILE_NAME}) as the output of the corpus tests indicated an error running the tests.  Check out the output file, {args.input_file_name}, for more information about what went wrong.")

main()