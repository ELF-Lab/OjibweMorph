from bs4 import BeautifulSoup
import logging
from os import path
import pandas as pd
from random import randint
import requests
from requests.adapters import HTTPAdapter, Retry
from time import sleep
import argparse

directory_link = "https://ojibwe.lib.umn.edu/browse/ojibwe"
root_link = "https://ojibwe.lib.umn.edu"
num_pages_by_letter = {
    "a": 20,
    "aa": 8,
    "b": 37,
    "ch": 1,
    "d": 11,
    "e": 1,
    "g": 30,
    "g": 30,
    "h": 1,
    "\'": 1,
    "i": 11,
    "ii": 1,
    "j": 4,
    "k": 1,
    "m": 27,
    "n": 25,
    "o": 17,
    "oo": 1,
    "p": 1,
    "s": 1, 
    "sh": 1,
    "t": 1,
    "w": 14,
    "y": 1,
    "z": 8,
    "zh": 8
}

# Returns a list of links to pages to be scraped
def find_URLs():
    print("Getting links from directory pages.\n")
    link_list = []
    # Go letter by letter
    for letter in num_pages_by_letter.keys():
        number_of_pages = num_pages_by_letter[letter]
        current_letter_link = directory_link + "/" + letter
        # Go page by page for this starting letter
        for page_num in range (1, number_of_pages + 1):
            current_page_link = current_letter_link + "?page=" + str(page_num)
            sleep(randint(0,2))
            directory_page = requests.get(current_page_link)
            soup = BeautifulSoup(directory_page.content, "html.parser")

            entry_list = soup.find_all("div", class_ = "english-search-main-entry")
            for entry in entry_list:
                link_list.append(root_link + (entry.find("a"))["href"])

    print("Finished generating URLs.")
    return link_list

# Returns a list of lists of info about a particular inflection form
# i.e. a list of rows, all with the lemma from one page
def scrape_page(page):
    soup = BeautifulSoup(page.content, "html.parser")

    forms_with_full_info = []

    # Get the lemma
    lemma = soup.find("span", class_ = "lemma").text

    # Get the POS
    pos_info = (soup.find("span", class_ = "badge badge-oj"))
    short_pos = pos_info.text
    long_pos = pos_info["title"]

    # Get the inflectional forms and their info
    inflectional_forms_info = soup.find("p", class_ = "inflectional-forms")

    forms_list = []
    for item in inflectional_forms_info:
        # Get the inflectional forms themselves
        if item.name == "strong":
            form_entry = {}
            form_entry.update({"form": item.text})
        # Get the info that goes with each inflectional form
        elif item.name == "em":
            # Get the abbreviated gloss, e.g. "1s - 0s pos"
            form_entry.update({"short_gloss": item.text})
            full_glosses = []
            # Get all the full glosses, e.g. "First person singular subject", "Singular inanimate object", "possessed"
            for gloss in item.findChildren():
                full_glosses.append(gloss["title"])
            form_entry.update({"full_glosses": full_glosses})

            # Once we've grabbed this info, we're done with this inflectional form
            forms_list.append(form_entry)

    # Get the stem (whatever comes after "Stem:")
    stem = (((inflectional_forms_info.text).partition("Stem:"))[2]).strip()

    # Now format the data as a list for EACH inflectional form
    for form in forms_list:
        forms_with_full_info.append([form["form"], form["short_gloss"], form["full_glosses"], lemma, stem, short_pos, long_pos])

    return forms_with_full_info

def print_data(forms_data):
    for form_data in forms_data:
        assert(len(form_data) == 7)
        print("\nForm:", form_data[0])
        print("Gloss:", form_data[1], "-", form_data[2])
        print("Lemma:", form_data[3])
        print("Stem:", form_data[4])
        print("POS:", form_data[5], "-", form_data[6])

# Takes a list of lists
# Each element corresponds to one inflectional form, and each element is itself a list of data for that form
def write_data(data, output_file):
    data_frame = pd.DataFrame(data)
    column_names = ["Inflectional Form", "Abbreviated Gloss", "Gloss", "Lemma", "Stem", "POS", "Full POS"]

    #print("Writing scraped output to", output_file)
    if not path.isfile(output_file):
        data_frame.to_csv(output_file, index = False, header = column_names)
    else:
        data_frame.to_csv(output_file, mode = 'a', index = False, header = False)

def main():
    parser = argparse.ArgumentParser(prog="scraper")
    parser.add_argument("output_file", type=str, help="Path and name of the spreadsheet where the scraped forms will be saved, e.g. '/Documents/ELF/scraped.csv'")
    args = parser.parse_args()

    # Code I got from stack exchange to make it retry when disconnected!
    logging.basicConfig(level=logging.DEBUG)
    s = requests.Session()
    a = requests.adapters.HTTPAdapter(max_retries = Retry(total = 5, backoff_factor= 1))
    s.mount('http://', a)
    s.mount('https://', a)

    URLs = find_URLs()
    scraped_data = []
    print(f"There are {len(URLs)} links to scrape.")
    for i, URL in enumerate(URLs):
        print(URL)
        sleep(randint(0,5))
        if not URL == "https://ojibwe.lib.umn.edu/main-entry/anim-na": # Strange page that redirects you to login?
            page = s.get(URL)
            scraped_data.extend(scrape_page(page))
        # Let's write to the CSV every 10 pages
        if (i + 1) % 10 == 0:
            write_data(scraped_data, args.output_file)
            print(f"Added pages {i + 1 - 9} to {i + 1} to the spreadsheet.  Printed {len(scraped_data)} forms/rows.")
            scraped_data = []

    # Write any remaining data
    write_data(scraped_data, args.output_file)


main()
