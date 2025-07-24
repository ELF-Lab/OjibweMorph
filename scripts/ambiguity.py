import argparse
import statistics
from os import mkdir, path

PRINT_ANALYSES = False

def read_file(file_path):
    lines = []
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if line:
                lines.append(line)

    print(f"\nRead in {len(lines)} lines.")
    return lines

# The keys are words, and the values are lists of analyses (with duplicates)
def make_form_analyses_dict(lines):
    duplicate_analysis_lines = ["inaa	izhi+VTA+Ind+Pos+Neu+XSubj+3SgProxObj", "ninandawendam	andawendam+VAI+Ind+Pos+Neu+1SgSubj"]
    analysis_dict = {}
    for i, line in enumerate(lines):
        # Deal with some anomalous forms: inaa and ninandawendam
        # Only add the duplicate analysis once each time they appear
        if line in duplicate_analysis_lines and ((i > 0 and lines[i - 1] == line) or (i > 1 and lines[i - 2] == line)):
            pass
        else:
            line = line.partition("\t")
            form = line[0]
            analysis = line[2]
            if form in analysis_dict.keys():
                analyses = analysis_dict[form]
                analyses.append(analysis)
                analysis_dict.update({form: analyses})
            else:
                analysis_dict.update({form: [analysis]})

    print(f"\nCreated analysis dictionary with {len(analysis_dict.keys())} unique word entries.")
    return analysis_dict

# Only keeps forms that have at least one real analysis
def remove_forms_with_unknown_analysis(analyses_dict):
    forms_with_actual_analyses = {}
    for form in analyses_dict.keys():
        # If there are some non-"+?" analyses in the list
        if len(analyses_dict[form]) > analyses_dict[form].count("+?"):
            forms_with_actual_analyses.update({form: analyses_dict[form]})
            # There shouldn't be any cases of words that had +? *and* real analyses
            assert(not("+?" in forms_with_actual_analyses[form]))

    print(f"\nAfter removing forms with \"+?\" (i.e., no analysis), {len(forms_with_actual_analyses)} unique forms remain.")
    return forms_with_actual_analyses

def calculate_amount_of_ambiguity(form_analyses_dict):
    number_of_digits_after_decimal = 2
    number_of_analyses_by_form = []
    number_of_analyses_by_form_occurrence = []
    # Get the number of *unique* analyses per form
    for form in form_analyses_dict:
        analyses = form_analyses_dict[form]
        assert(len(analyses) >= 1)
        assert(not("+?" in analyses))
        unique_analyses = set(analyses)
        number_of_analyses_by_form.append(len(unique_analyses))
        occurrence_count = int(len(analyses) / len(unique_analyses))
        for i in range(occurrence_count):
            number_of_analyses_by_form_occurrence.append(len(unique_analyses))

    mean = round(statistics.mean(number_of_analyses_by_form), number_of_digits_after_decimal)
    median = round(statistics.median(number_of_analyses_by_form), number_of_digits_after_decimal)
    print(f"\nAmbiguity summary for {len(number_of_analyses_by_form)} *unique* forms (i.e., each form counted only once):")
    print("Mean number of analyses (excl. those with 0):", mean)
    print("Median number of analyses (excl. those with 0):", median)

    mean = round(statistics.mean(number_of_analyses_by_form_occurrence), number_of_digits_after_decimal)
    median = round(statistics.median(number_of_analyses_by_form_occurrence), number_of_digits_after_decimal)
    print(f"\nAmbiguity summary for {len(number_of_analyses_by_form_occurrence)} *non-unique* forms (i.e., each form counted every time it occurs):")
    print("Mean number of analyses (excl. those with 0):", mean)
    print("Median number of analyses (excl. those with 0):", median)

def write_csv(form_analyses_dict, output_dir):
    CSV_HEADER = "Form,# of Analyses\n"
    CSV_NAME = "ambiguity_by_wordform.csv"

    if not path.exists(output_dir):
        mkdir(output_dir)

    with open(output_dir + CSV_NAME, "w") as csv:
        csv.write(CSV_HEADER)    
        for form in form_analyses_dict.keys():
            analyses = form_analyses_dict[form]
            assert(len(analyses) >= 1)
            assert(not("+?" in analyses))
            unique_analyses = set(analyses)
            output_line = form + "," + str(len(unique_analyses))
            if PRINT_ANALYSES:
                output_line += "," + str(unique_analyses) + "\n"
            else:
                output_line += "\n"
            csv.write(output_line)

    print(f"\nWrote {len(form_analyses_dict.keys())} forms and analysis counts (excl. those with 0 analyses) to", output_dir + CSV_NAME)

def main():
    # Sets up argparse.
    parser = argparse.ArgumentParser(prog="ambiguity")
    parser.add_argument("analyses_file", type=str, help="Path to the analyzed text FOMA output.")
    parser.add_argument("output_dir", type=str, help="Directory where the summary CSV will be written.")
    args = parser.parse_args()

    lines = read_file(args.analyses_file)
    form_analyses_dict = make_form_analyses_dict(lines)
    form_analyses_dict = remove_forms_with_unknown_analysis(form_analyses_dict)
    calculate_amount_of_ambiguity(form_analyses_dict)
    write_csv(form_analyses_dict, args.output_dir)

main()