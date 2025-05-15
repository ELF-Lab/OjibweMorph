import pandas as pd
from os import path
import re

# In the README, write results in this order
RESULT_HEADERS_ORDERED = ["date", "forms", "forms_without_results", "precision", "recall"]

# Ideally this CSV could be read in really tidily, but for the sake
# of readability it has two "header" rows, which makes it hard to parse
# values automatically.  So this function works but is a little cursed
# (see: all the "unnammed" columns).
def read_results(results_file_path, is_corpus = False):
    CORPUS_CSV_COLUMNS_PER_SPEAKER = ["Tokens","Tokens without Results","Unique Tokens","Unique Tokens without Results"]
    # Read the spreadsheet and get just the last row
    print(f"\nReading in results from {results_file_path}...")
    all_results = pd.read_csv(results_file_path)
    most_recent_results_row = all_results.tail(1)
    most_recent_results_dict = {}

    # Grab all the info we want to print
    date = most_recent_results_row["Date"].values[0]
    if is_corpus:
        columns = all_results.columns
        # Get the list of speaker initials, because we want a set of results for each speaker
        speakers = [column for column in columns if re.search("^[a-z]", column)]
        current_speaker = ""
        current_speaker_results = {}
        # Go through all the columns
        for index, column in enumerate(columns):
            # Check if we're switching to a new speaker
            if column in speakers:
                # Save the results from the last speaker (if there is one)
                if current_speaker:
                    most_recent_results_dict.update({current_speaker: current_speaker_results})
                # Reset things for this new speaker
                current_speaker = column
                current_speaker_results = {}
                # Now, get the data for this speaker!
                # The first column for this speaker
                current_speaker_results.update({CORPUS_CSV_COLUMNS_PER_SPEAKER[0]: most_recent_results_row[column].values[0]})
            # The second column for this speaker
            elif index > 0 and columns[index - 1] == current_speaker:
                current_speaker_results.update({CORPUS_CSV_COLUMNS_PER_SPEAKER[1]: most_recent_results_row[column].values[0]})
            # The third column for this speaker
            elif index > 0 and columns[index - 2] == current_speaker:
                current_speaker_results.update({CORPUS_CSV_COLUMNS_PER_SPEAKER[2]: most_recent_results_row[column].values[0]})
            # The fourth column for this speaker
            elif index > 0 and columns[index - 3] == current_speaker:
                current_speaker_results.update({CORPUS_CSV_COLUMNS_PER_SPEAKER[3]: most_recent_results_row[column].values[0]})
                # Now that we're done using the speaker as a key, convert the speaker string to the desired format
                if "unknown" in current_speaker:
                    current_speaker = "Unknown"
                elif "total" in current_speaker:
                    current_speaker = "Overall"
                else: # Speaker initials
                    current_speaker = current_speaker.upper()

        # All done!  Add the final speaker's results too
        most_recent_results_dict.update({current_speaker: current_speaker_results})

    else:
        precision = most_recent_results_row["Total"].values[0]
        recall = most_recent_results_row["Unnamed: 2"].values[0]
        forms = most_recent_results_row["Unnamed: 3"].values[0]
        forms_without_results = ((most_recent_results_row["Unnamed: 4"].values[0]).partition(" "))[0]

        most_recent_results_dict = {"date": date, "precision": precision, "forms_without_results": forms_without_results, "recall": recall, "forms": forms}

    return most_recent_results_dict, date

def format_results(results, is_corpus = False):
    RESULTS_ENTRY_PRECEDOR = "| "
    RESULTS_ENTRY_FOLLOWER = " "
    RESULTS_LINE_END = "|\n"

    results_line = ""
    # For the OPD/paradigm tests, we replace the whole row in the README.
    # For the corpus tests, we only want to replace *part* of the content,
    # because there is additional info about the speaker that should stay there.
    # For these, let's prepare just the "| X | Y |" portion with the scores.
    if is_corpus:
        results_line += RESULTS_ENTRY_PRECEDOR
        # By-Token Failure: "X% (Tokens without Results/Token)"
        results_line += (re.search(r"[0-9]+.[0-9]+%", results["Tokens without Results"])).group()
        results_line += " ("
        results_line += (re.search(r"[0-9]+ ", results["Tokens without Results"])).group()
        results_line = results_line[:-1] # Remove that last space
        results_line += "/"
        results_line += results["Tokens"]
        results_line += ")"
        results_line += RESULTS_ENTRY_FOLLOWER + RESULTS_ENTRY_PRECEDOR
        # By-Type Failure: "Y% (Unique Tokens without Results/Unique Tokens)"
        results_line += (re.search(r"[0-9]+.[0-9]+%", results["Unique Tokens without Results"])).group()
        results_line += " ("
        results_line += (re.search(r"[0-9]+ ", results["Unique Tokens without Results"])).group()
        results_line = results_line[:-1] # Remove that last space
        results_line += "/"
        results_line += results["Unique Tokens"]
        results_line += ")"
        results_line += RESULTS_ENTRY_FOLLOWER
        results_line += RESULTS_LINE_END
    else:
        for header in RESULT_HEADERS_ORDERED:
            results_line += RESULTS_ENTRY_PRECEDOR
            results_line += results[header]
            results_line += RESULTS_ENTRY_FOLLOWER
        results_line += RESULTS_LINE_END

    return results_line

# line_ID is just used for the corpus tests, where there is not only one line in the table to choose from
def update_readme(results_line, readme_file_path, section_title, is_corpus = False, line_ID = None):
    # For the corpus results, we only want to replace the final 2 columns: so match "| A% (B/C) | D% (E/F)"
    CORPUS_SECTION_REGEX = r"\| [0-9]+\.[0-9]+\% \([0-9]+\/[0-9]+\)+ \| [0-9]+\.[0-9]+\% \([0-9]+\/[0-9]+\)+ \|$\n"

    readme = open(readme_file_path, "r+")
    lines = readme.readlines()
    # Keep track of the current section in the README via the title
    current_section_title = ""
    for line_index, line in enumerate(lines):
        if line.startswith("#"):
            current_section_title = line
        # Check if this is a) a results line and b) the *right* results line
        if re.search(r"\| [0-9]", line) and line_index >= 3 and (section_title in current_section_title):
            if is_corpus:
                # Check if this is the results line for the right speaker!
                if (" " + line_ID + " ") in line:
                    updated_line = re.sub(CORPUS_SECTION_REGEX, results_line, line)
                    lines[line_index] = updated_line
            else: # For OPD/paradigm tests, just rewrite the whole line
                lines[line_index] = results_line

    # Re-write the file
    readme.truncate(0)
    readme.seek(0)
    readme.writelines(lines)

    readme.close()

# For the corpus tests
# Here, the date is not in the table as usual, but a separate line
def update_date_only(date, readme_file_path):
    DATE_LINE_START = "Date Last Updated: "
    # Get the current file contents
    readme = open(readme_file_path, "r+")
    lines = readme.readlines()

    # Modify the date line
    for index, line in enumerate(lines):
        if line.startswith(DATE_LINE_START):
            lines[index] = DATE_LINE_START + date + "\n"

    # Re-write the file
    readme.truncate(0)
    readme.seek(0)
    readme.writelines(lines)

    readme.close()

# Make all the necessary fxn calls for EACH results CSV
def handle_results(results_file_path, readme_file_path, section_title, is_corpus_tests = False):
    if path.isfile(results_file_path):
        # The paradigm/opd tests are the same format (precision, recall, etc.)
        # and so can be handled the same way, but the corpus tests are of a different nature.
        if is_corpus_tests:
            results, date = read_results(results_file_path, is_corpus = True)
            for speaker in results.keys():
                speaker_results = results[speaker]
                results_line = format_results(speaker_results, is_corpus = True)
                update_readme(results_line, readme_file_path, section_title, is_corpus = True, line_ID = speaker)
                update_date_only(date, readme_file_path)
        else:
            results, _ = read_results(results_file_path)
            results_line = format_results(results)
            update_readme(results_line, readme_file_path, section_title)
        print("Wrote to", readme_file_path)
    else:
        print(f"ERROR: The README could not be updated because the CSV expected to contain the test results ({results_file_path}) was not found.")

def main():
    opd_verb_results_file_path = "./FST/opd_verb_test_summary.csv"
    opd_noun_results_file_path = "./FST/opd_noun_test_summary.csv"
    paradigm_verb_results_file_path = "./FST/paradigm_verb_test_summary.csv"
    paradigm_noun_results_file_path = "./FST/paradigm_noun_test_summary.csv"
    corpus_results_file_path = "./FST/corpus_test_summary.csv"
    readme_file_path = "./README.md"

    handle_results(opd_verb_results_file_path, readme_file_path, "OPD Verbs")
    handle_results(opd_noun_results_file_path, readme_file_path, "OPD Nouns")
    handle_results(paradigm_verb_results_file_path, readme_file_path, "Paradigm Verbs")
    handle_results(paradigm_noun_results_file_path, readme_file_path, "Paradigm Nouns")
    handle_results(corpus_results_file_path, readme_file_path, "Corpus", True)

main()