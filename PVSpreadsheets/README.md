# BorderLakesMorph Preverb Spreadsheets

This folder houses the spreadsheets for the various preverbs in Ojibwe. This description is in progress.

## Initial change

Conjunct order verbs can undergo a non-concatenative vowel ablaut process known as "initial change", which transforms the first vowel of the verbal complex (including preverbs). This produces the so-called "changed conjunct" (AKA C-Form), which is used when some A' process such as topicalization, *wh*-movement, or relativization has occurred.

- *initial-change:* In the presence of the initial change morpheme, alternate the first vowel of the verbal complex according to the tables below.

There are at least three patterns of initial change in the Southwestern group (Nichols 2012, NSF Report: Notes on variation in Minnesota Ojibwa).

Pattern 1 (Mille Lacs, south side of Leech Lake, White Earth)

| Unchanged   | Changed  |
|-------------|----------|
| a           | e        |
| aa          | ayaa     |
| e           | aye	     |
| i           | e        |
| ii          | aa       |
| o           | we       |
| oo          | waa      |

Pattern 2 (north side of Leech Lake, Red Lake):

| Unchanged   | Changed  |
|-------------|----------|
| a           | e        |
| aa          | aa     	 |
| e           | e	     |
| i           | e        |
| ii          | aa       |
| o           | we       |
| oo          | waa      |

Pattern 3 (Nett Lake, Lac la Croix):

| Unchanged   | Changed  |
|-------------|----------|
| a           | e        |
| aa          | aa     	 |
| e           | e	     |
| i           | e        |
| ii          | aa       |
| o           | we       |
| oo          | oo       |

Based on examples from the dictionary, it seems like Border Lakes belongs into Pattern 1.

There is also a class of exceptions. Stems/roots that begin with "dan", "das", dash", and "daa" instead add a prefix "en". For example, *daso-biboonagizid* "if s/he is a certain number of years old" goes to *endaso-biboonagizid* "one who is a certain number of years old" under initial change.

The above description is adapted from here: https://ojibwegrammar.langsci.wisc.edu/Grammar/InflMorphology/InitialChange.htm

There are also a lot of complications with the future tense prefer "ga-" that interact with intial change. Future tense appears as "ga-" in the independent order in the presence of a person prefix, but "da-" in the independent order when there is no prefix. In many dialects the "plain" conjunct (when there is no initial change), the future morpheme is realized as "ji-" (in others, it is realized as "da-" in this context). But, in the changed conjunct, it appears as "ge-". So the changed form is the regular changed form of the independent order allomorph in the presence of a person prefix, but not a changed version the plain conjunct allomorph, nor the independent allomorph in the absence of a prefix. Finally, note that some speakers will epethsize a "d" to "ga-" and "ge-" when the following segment is a vowel. This is probably best modeled as an irregularity and part of a more fullsome modeling of this future tense marker. For details and sources, see here: https://ojibwe.lib.umn.edu/main-entry/ga-pv-tns

Finally, not all of the directional preverbs undergo the expected vowel ablaut process under initial change. One example is "bi-", which takes the same form in the changed conjunct as it does in the plain conjunct and independent orders.

## Subordinating

Subordinating preverbs only combine with conjunct order verbs. There are differences across dialects, and we have included all known subordinators in Ojibwe. In Border Lakes, currently only "gaa-" is attested. It is likely dervied from the past tense marker "gii-" under initial change, but does not have a past tense interpretation synchronically, so is therefore distinct.

## Tense

There are some differences in tense across dialects, and we are attempting to model all variants. There is also some irregularities (dicussed above) in the changed conjunct form of certain tenses, as well as suppletive forms between the independent and conjunct order. 

Here is a summary of the tenses that we are currently modelling:

| Tense                            | Independent | PlainConjunct | ChangedConjunct |
|----------------------------------|-------------|---------------|-----------------|
| Future definitive               	| ga          | ji            | ge              |
| Modal (General Southwestern)    	| daa         | ji            | ge              |
| Modal (Eastern Southwestern Dialects) | daa         | da            | da              |
| Past (General Southwestern)     | gii         | gii           | gaa              |
| Past (Border Lakes)             | gii'        | gii'          | gaa'              |
| Future volitional (General Southwestern) | wii         | wii           | waa              |
| Future volitional (Border Lakes) | wii'        | wii'          | waa'              |

Note that both the general forms (gii-/wii-) and the Border Lakes specific forms (gii'-/wii'-) are both used in Border Lakes. The difference between the two forms is not currently well understood. Note also that many forms are expected under the normal initial change rules. In those cases, we do not specify those forms in the spreadsheets. Only those forms that are not predicted from more general rules are specified. 

- *ga-to-da:* The definitive future marker in the independent order is ga-, unless there is no person prefix, in which case it appears as da-

Certain tenses trigger a phonological process that requires a bit of background on the phonology of the language. There is a distinction known as the lenis/fortis contrast, which is indicated by the use of voiced/voiceless consonants. The "lenis" consonants are prototyically written as "b", "d", "j", "g", "z", and "zh", but in some contexts are "devoiced"/"strengthened"/"tensed" to "p", "t", "ch", "k", "s", and "sh" respectively. In contrast, fortis consonants are invariably written as "p", "t", "ch", "k", "s", and "sh.

- *tense-tensing:* Lenis consonants ("b", "d", "j", "g", "z", "zh") are strengthened to the fortis counterpart ("p", "t", "ch", "k", "s", "sh") following the past tense preverbs (gii-/gii'-) and desiderative future tense preverbs (wii-/wii'-).

The rule is meant to be quite broad, triggering this process not only on stems that follow the relevant tense marker, but also preverbs. It is also worth noting that this is the type of thing that might not *always* be reflected in the orthography, so probably we want to allow some fuzziness when parsing. But in the "standard" orthography of the OPD, this is always reflected. Finally, this is specific to these morphemes, not any preverb that ends in "ii". For example, "maajii-" meaning "start" does not trigger the rule.

*Citation*: See Nichols (1980, pg. 129) *Ojibwe Morphology*, PhD Dissertation, Harvard University for a version of the rule here.

## Directional
