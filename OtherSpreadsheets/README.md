# OjibweMorph Other Spreadsheets

This folder houses the spreadsheets for the various "other" elements in Ojibwe that are not nouns, verbs, preverbs, or derivational morphemes. This includes adverbs, numerals, proper nouns, various particles, and enclitics.

# Adverbs, Numerals, and Particles

Adverbs, numerals, and particles are stand-alone words that do not show any sort of inflection. Generally, adverbs serve a similar function to preverbs, adding additional information about the action denoted by the verb. Some adverbs are lexical, specifying information related to things like the manner, degree, duration, location, or timing of the action. Others are functional, playing a more grammatical role including introducing negation or conjoining elements in a sentence or discourse. 

Particles are generally emphatic and expressive words, often quite small in form. They often appear in the "second position" of a sentence (that is, immediately after the first full word), and frequently appear in a clitic form.

Numerals are number-related words, including not only numbers themselves, but also other elements realted to numbers such as the words for "half". Quantifiers like *gakina* "all" are not classified in this category, and are instead parsed as quantificational adverbs.

Note, these spreadsheets just have a single form for each "type" of element, as they never inflect. If you add a new type of lexical element (e.g. a different type of adverb), these spreadsheets will also need to be updated accordingly.

We follow the [classification of the Ojibwe People's Dictionary](https://ojibwe.lib.umn.edu/help/ojibwe-parts-of-speech), and have the following tags and categories for these various elements:

## Adverb tags

| Tag | Description |
|------|-----|
| ADVConj | Conjunctive adverb |
| ADVDisc | Discourse adverb |
| ADVDub | Dubitative adverb |
| ADVGram | Grammatical adverb |
| ADVInter | Interrogative adverb |
| ADVLoc | Locative adverb |
| ADVMan | Manner adverb |
| ADVNeg | Negative adverb |
| ADVPred | Predicative adverb |
| ADVQnt | Quantificational adverb |
| ADVTmp | Temporal adverb |
| ADVDeg | Degree adverb |

## Particle tags

| Tag | Description |
|------|-----|
| PCInterj | Interjective particles |
| PCEmph | Emphatic particles |
| PCDisc | Discourse particles |
| PCAsp | Aspectual particles |

## Numeral tags

| Tag | Description |
|------|-----|
| NUM | Numerals |

# Pronouns

Similar to the adverbs, numerals, and particles, these spreadsheets show a single representative type of element that appears in the FST. For the pronouns, there is a much wider set of possibilities, since they can vary according to animacy, obviation, and number. 

The general tag set, referred to below as POSTag, is as follows:

| Tag | Description |
|------|-----|
| PRONDem | Demonstrative pronoun |
| PRONDub | Dubitative pronoun |
| PRONIndf | Indefinite pronoun |
| PRONInter | Interogative pronoun |
| PRONPret | Preterit pronoun |
| PRONSim | Similative pronoun |
| PRONPer | Personal pronoun |

These core tags are then augmented by the information related to obviation and, if relevant, person, obviation, and number. The general form is `POSTag+Animacy+Person/Obviation/Number`.

Animacy values:

| Tag | Description |
|------|-----|
| NA | Description |
| NI | Description |

Person/Obviation/Number values:

| Tag | Description |
|------|-----|
| ProxSg | Proximate singular |
| ProxPl | Proximate plural |
| ObvSg | Obviative singular |
| ObvPl | Obviative plural |
| Sg | Inanimate singular |
| Pl | Inanimate plural |
| 1Sg | First person singular |
| 2Sg | Second person singular |
| 2Pl | Second person plural |
| Excl | Exclusive first person |
| Incl | Inclusive first person |

For example, the animate singular demonstrative *wa'aw* gets the analysis `PRONDem+NA+ProxSg`, and the first person exclusive pronoun *niinawind* is analyzed as `PRONPer+NA+Excl`.

# Proper Nouns

Proper nouns refer to a specific person or place. For example, someone's name or the name of a town. There are currently three paradigms of proper nouns: `NamePerson`, `NamePlace`, and `NameVocative`, with all serving as the tag in combination with the lemma (e.g. `LEMMA+NameType`). For example, *Bemijigamaag* is analyzed as `Bemijigamaag+NamePlace`. Like English, it is typical to capitalize the initial character in a proper noun, regardless of where it appears in the sentence. Personal and place names are encoded to enforce this convention, so analyzing the string *bemijigamaag* (without capitalization) will return `+?`.

The items that receive the tag `NameVocative` are unique to the FST, and are not directly listed as such in the OPD. These are items like *niijjii* "my friend; bro" that get used as vocative terms of address, usually for close friends or family. We treat these as proper nouns, since they do not inflect in the same way as other nouns, and generally have functional overlap with personal names. Similarly, they serve a similar function to regular animate nouns inflected with the vocative suffix *-dog*, as in *anishinaabedog* "fellow Ojibwe people!", but are usually formed by shortening a longer word (i.e. how "bro" is a shortening of "brother" in English) and not by adding the vocative suffix. We retain a distinct tag to ensure they can be easily identified when parsing text.

Currently, we have just a very initial version of personal name inflection. Names can appear with obviative marking, and names referring to people who have passed away can be inflected for the preterit. The spreadsheets have this capability, but many names are not yet integrated. Expanding this is on the docket.

# Enclitics

Enclitics are elements that can attach to the end of another word. In English, an example is *n't*, as in *don't*. Like English, enclitics in Ojibwe also often have a "full" form in addition to a contracted form. For example, the enclitic *sh* in Ojibwe has the full form *dash*. This is analogous to how *don't* can be alternatively realized as *do not*.

In Ojibwe, there is in principle no restriction as to what elements a clitic can attach to. That is, enclitics in Ojibwe attach to whatever word is to its left. This distinguishes them from an affix, which usually has specific requirements to attach to something of a particular category such as a noun or a verb. This is why they are modelled separately in the FST.

Much like the role of the apostrphe in English, clitics are written with a dash to the left. For example *gaawiin-sh* (full form: *gaawiin dash*). This is handled by the FST, as specified in the lexc templates.

Clitic tags will appear at the end of the word that it attaches to. For example: *gaawiin-sh* gets the analysis `gaawiin+ADVNeg+CL/ADVConj/dash`. The abstract form of the clitic tag is `+CL/POS/Full_Form`. 