# OjibweMorph Preverb Spreadsheets

This folder houses the spreadsheets for the various preverbs in Ojibwe. All preverb tags produced by the FST have the following form: `PVType/Lemma`, where `Type` refers to the broad classification (Subordinating, Tense, Lexical, etc), and `Lemma` points to the specific prever, usually as listed as the head of an entry of the Ojibwe People's Dictionary. We also maintain separate tags for two types of prenouns. All tags are summarized here:

| Tag | Description |
|-----|------------|
| PVSub | Subordinating preverb |
| PVTense | Tense/modal preverb |
| PVDir | Directional preverb |
| PVRel | Relative preverb |
| PVLex | Lexical preverb. Also attaches to adverbs |
| PVQnt | Quantificational preverb. Also attaches to adverbs |
| PNLex | Lexical prenoun |
| PNQnt | Quantificational prenoun |

## General overview

Preverbs are semi-phonologically dependent elements that are added before a verb stem. The preverbs, together with the stem (and the person prefix, which we treat as part of the inflectional system), form the *verbal complex*. Many preverbs also overlap with so-called prenouns, and many can also attach to adverbs as well. In the OPD, there is no separate category for prenouns versus preverbs (or preadverbs); in the Valentine (2001) grammar of Odawa, there is some discussion of the what specific elements are prenouns. Here, most prenouns and preadverbs are in the "lexical preverb" bin.

We follow the basic ordering and classification scheme for preverbs as outlined in Valentine (2001), and also used in the OPD. The basic order of preverbs is given in the table below, where 1-4 are the "functional" preverbs, and are generally closed-class and play a more grammatical role.

| Subordinator | Tense/Modal | Directional | Relative | Lexical/Quantificational |
|----------|----------|----------|----------|----------|
|   1   |   2   |   3   |   4   |   5   |

Note also that, when present, the "person prefix" appears in the leftmost position in the verbal complex, so always appears before any preverbs. This element, however, is *not* considered a preverb, and is instead modelled within the VerbSpreadsheets.

The lexical preverb spreadsheet (PV_lex) and quantificational preverb spreadsheet (PV_qnt) are shells, showing just a small handful of representative examples. The bulk of the preverbs that fill out these categories are stored in the OjibweLexicon repository. All of these elements also double as prenouns and preadverbs

The other types of preverbs are all functional elements. This includes subordinating, tense/mode, directional, and relative cateogries. The full set of preverbs in each of these categories is specifed in these spreadsheets -- none are sourced from OjibweLexicon. 

There are various dependencies between the functional preverbs and the wider clause structure. For example, subordinating preverbs all require the use of the conjunct order (and some are perhaps best thought of as a type of changed conjunct marker). As a result, none of the subordinating preverbs have an independent order form. Similarly, the tense/modal preverbs often show allomorphy depending on order.

The overall strategy for the functional preverbs is to create spreadsheets with forms for the indpendent and/or conjunct orders, as well as the changed conjunct when the changed form is not predictable from the regular (or sub-regular) phonological rules. For example, the tense preverb "daa-" becomes "ge-" under initial change. In the FST, the exceptions apply first, and if applied, they block the regular rules from applying. This ensures that we only get a single process related to initial change within a given changed conjunct verb complex.

## Initial change

In fact, initial change can be thought of as a subordinating preverb that tiggers a non-concatenative vowel ablaut process. This transforms the first vowel of the verbal complex (including other preverbs) in a predictable way, as outlined below. All verbs that are specificed for the initial change preverb take conjunct order morphology. This produces the so-called "changed conjunct" (AKA C-Form), which is used when some A' process such as topicalization, *wh*-movement, or relativization has occurred. We are currently modelling this by an affix, which triggers either the insertion of the appropriate idisyncratic allomorph or the regular initial change vowel ablaut process.

- *initial-change:* In the presence of the initial change morpheme, alternate the first vowel of the verbal complex according to the tables below.

| Unchanged   | Changed  |
|-------------|----------|
| a           | e        |
| aa          | ayaa     |
| e           | aye	     |
| i           | e        |
| ii          | aa       |
| o           | we       |
| oo          | waa      |


Note, there are further complications. There are at least three patterns of initial change in the Southwestern group (Nichols 2012, NSF Report: Notes on variation in Minnesota Ojibwa). There are also various exceptions to the regular rules. These are all disucssed in more detail in the readme for phonology.xfst, where these intricacies are modelled.

## Subordinating

Subordinating preverbs only combine with conjunct order verbs. There are differences across dialects, and we have included all known subordinators in Ojibwe. In Border Lakes, currently only "gaa-" is attested. It is likely dervied from the tense marker "gii-" under initial change, but does not have a past tense interpretation synchronically, so is therefore distinct.

## Tense

There are some differences in tense across dialects, and we are attempting to model all variants. There is also some irregularities (dicussed above) in the changed conjunct form of certain tenses, as well as suppletive forms between the independent and conjunct order. 

Here is a summary of the tenses that we are currently modelling:

| Tense                            | Independent | PlainConjunct | ChangedConjunct |
|----------------------------------|-------------|---------------|-----------------|
| Future definitive (General Southwestern)               	| ga/da          | ji            | ge              |
| Future definitive (Eastern Southwestern Dialects)               	| ga/da          | da            | ge              |
| Modal (General Southwestern)    	| daa         | ji            | ge              |
| Modal (Eastern Southwestern Dialects) | daa         | da            | ge              |
| Past (General Southwestern)     | gii         | gii           | gaa              |
| Past (Border Lakes)             | gii'        | gii'          | gaa'              |
| Future volitional (General Southwestern) | wii         | wii           | waa              |
| Future volitional (Border Lakes) | wii'        | wii'          | waa'              |

Our current approach is for the FST to output tags for each tense on its own terms for the Independent and Conjunct orders. That is, if a (conjunct order) verb has *ji-*, then the system will output `PVTense/ji+`, rather than linking it to *ga-/da-* or *daa-*, even though *ji-* is considered the plain conjunct form of those preverbs. In the changed conjunct, the form, even if irregular, is tied to the plain conjunct order form. 

Note that both the general forms (gii-/wii-) and the Border Lakes specific forms (gii'-/wii'-) are both used in Border Lakes. The difference between the two forms is not currently well understood, but those that lack the glottal stop seem to be associated less with past tense, and more with simultaneous tense. 

Many forms are simply expected under the normal initial change rules. In those cases, we do not specify those forms in the spreadsheets. The system will take whatever form is listed in the PlainConjunct column and modify the form accordingly. Only those forms that are not predicted from more general rules are specified.

The definitive future marker in the independent order is ga-, unless there is no person prefix, in which case it appears as da-. This is handled by a phonological rule:

- *gadaRule:* The definitive future marker in the independent order is ga-, unless there is no person prefix, in which case it appears as da-

Certain tenses trigger a phonological process that requires a bit of background on the phonology of the language. There is a distinction known as the lenis/fortis contrast, which is indicated by the use of voiced/voiceless consonants. The "lenis" consonants are prototyically written as "b", "d", "j", "g", "z", and "zh", but in some contexts are "devoiced"/"strengthened"/"tensed" to "p", "t", "ch", "k", "s", and "sh" respectively. In contrast, fortis consonants are invariably written as "p", "t", "ch", "k", "s", and "sh.

- *tense-tensing:* Lenis consonants ("b", "d", "j", "g", "z", "zh") are strengthened to the fortis counterpart (respectively, "p", "t", "ch", "k", "s", "sh") following the past tense preverbs (gii-/gii'-) and desiderative future tense preverbs (wii-/wii'-).

The rule is meant to be quite broad, triggering this process not only on stems that follow the relevant tense marker, but also preverbs. It is also worth noting that this is the type of thing that might not *always* be reflected in the orthography, so we want to allow some fuzziness when parsing. But in the "standard" orthography of the OPD, this is always reflected. Finally, this is specific to these morphemes, not any preverb that ends in "ii". For example, "maajii-" meaning "start" does not trigger the rule.

*Citation*: See Nichols (1980, pg. 129) *Ojibwe Morphology*, PhD Dissertation, Harvard University for a version of the rule here.

## Directional

Directional preverbs indicate spatial/temporal orientation. We have included directional preverbs from both the OPD and from the Bowers et al (2017) Odawa model. As indicated above, some are irregular under initial change, and these forms are specified in the spreadsheets only where necessary.

## Relative

Relative preverbs are the preverb equivalent of relative roots. Valentine (2001, p. 160) says it well: "[they] relate the verbal event to various associated
circumstances, such as way in which it takes place, where it takes place, the reason it takes place, how long since it's taken place, how many times, and how often.

## Lexical/quantificational

These preverbs, which can be further broken down into more particular sub-types, indicate things like the manner or quality of the action. Quantificational preverbs are numeric elements directly attaching to the verb, and are most frequent in verbs referring to units of time.