# Verb Spreadsheets

## Contents

- [Verb Spreadsheets](#verb-spreadsheets)
	- [Contents](#contents)
	- [General](#general)
	- [Organization](#organization)
		- [Descripton of Tags (Verbs)](#descripton-of-tags-verbs)
			- [PARADIGM](#paradigm)
			- [ORDER](#order)
			- [CLASS](#class)
			- [SUBJECT/OBJECT](#subjectobject)
			- [MODE](#mode)
			- [NEGATION](#negation)
			- [SOURCES](#sources)
		- [Notes on ambiguous forms and alternate forms](#notes-on-ambiguous-forms-and-alternate-forms)
	- [Guiding Principles](#guiding-principles)
- [Linguistic Details for Verbs](#linguistic-details-for-verbs)
	- [Verb Inanimate Intransitive (VII)](#verb-inanimate-intransitive-vii)
		- [STEM TYPES](#stem-types)
		- [RULES](#rules)
		- [NOTES/ISSUES](#notesissues)
	- [Verb Animate Intransitive (VAI)](#verb-animate-intransitive-vai)
		- [STEM TYPES](#stem-types-1)
		- [RULES](#rules-1)
		- [NOTES/ISSUES](#notesissues-1)
	- [Verb Transitive Inanimate (VTI)](#verb-transitive-inanimate-vti)
		- [STEM TYPES](#stem-types-2)
		- [RULES](#rules-2)
		- [NOTES/ISSUES](#notesissues-2)
	- [Verb Transitive Animate (VTA)](#verb-transitive-animate-vta)
		- [STEM TYPES](#stem-types-3)
		- [RULES](#rules-3)
		- [NOTES/ISSUES](#notesissues-3)
	- [Summary](#summary)
		- [SUMMARY OF STEM CLASSES](#summary-of-stem-classes)

## General
*	Double \>\> marks the stem/suffix juncture (or the end of the stem)
*	Double \<\< marks the prefix/stem juncture (or the start of the stem)
*	Single \> marks boundaries between suffixes outside of the stem (not yet used)
*	Single \< marks boundaries between prefixes outside of the stem (not yet used)
*	Null morphemes will NOT be added unless a rule needs to refer to them. So far there are no such rules.
*	There are five special characters in the verbs:
	*	i1, the first person "theme sign" (marking a first person object with the subject is also a first person), which is used to trigger palatalization in certain VTAs (see VTA notes with quotes from Rand Valentine).
		*	This is the same as "i2" in the Bowers et al (2017) FST for Odawa
	*	n1, the special "changable N" that palatalizes before i1
 		*	This is the same as "n1" in the Bowers et al (2017) FST for Odawa
	*	s1, the special "changable S" that palatalizes before i1
 		*	This is the same as "s1" in the Bowers et al (2017) FST for Odawa
	*	w1, the independent order third person agreement that is usually deleted, and opaquely blocks short vowel deletion
 		*	This is the same as "w5" in the Bowers et al (2017) FST for Odawa
 	*	V1, triggers vowel lengthening with certain preterit and delayed imperative forms in the VAIs.

## Organization

This folder (VerbSpreadsheets) contains the verb paradigm spreadsheets used to build and validate the OjibweMorph FST for morphological production and parsing. Spreadsheets are

### Descripton of Tags (Verbs)

All spreadsheets contain the following columns:

* **Paradigm:** Traditional Algonquianist split based primarily on transitivity and argument animacy. Exception is added VAI_Pl and VII_Pl, which are special cases of each stem that only allow plural arguments.
* **Order:** Clause-type distinction in traditional Algonquianist terms, which differ in their verb paraidgms. Independent (also known as A-form) is roughly main clauses, conjunct (also known as B-form) is roughly embedded clauses and questions. Imperative are the command forms.
* **Class:** Phonological classes based on the sounds at the right edge of the stem. Change the shape of the suffix complex due to phonological processes at the stem-suffix boundary.
* **Lemma:** Each class within each order/paradigm combination is exemplified by at least one sample verb, often more than one. The lemma is the "dictionary form" of the verb (akin to the infinitive with English verbs) as taken from the OPD. This is usually either the third person singular and/or second person simple imperative form. Lemmas are also used for verb tags in the FST.
* **Stem:** The stem is the underlying form of the example verb. Unless otherwise indicated, we take the stem specified in the OPD. Sometimes, this is the same as the lemma. However, often it is distinct, as various phonological processes can intervene.
* **Subject:** The person/noun associated with the prototpyical "actor" role in transitive paradigms, or the sole person/noun of intransitive paradigms. 
* **Object:** The person/noun associated with the prototypical "undergoer" role in transitive paradigms. Always NA in intransitive paradigms.
* **Mode:** Traditional Algonquianist categories in Ojibwe related to the epistemic/modal/aspectual system. In the imperative order (command forms) this encodes whether it is "simple", "delayed", or "prohibative". The prohibative must be precede by "gego" to be well-formed.
* **Negation:** Whether the verb is positive or negative. The independent order negatives must be preceded by "gaawiin" to be well-formed.
* **Form\#Surface:** The surface form of the example verb, after all phonological processes have been executed. The source for these forms is indated in a different column. Form1 is the attested or assumed form for Border Lakes, which all other forms are variants from other closely related dialects. Marked MISSING if a form is expected, but not yet attested in a source or extended with a GUESS. Surface forms are used to test the FST.
* **Form\#Split:** The part in brackets is a stand-in for any stem within that particular class. Only the pieces of the brackets are used by the model, which simply replaces the part in brackets with the relevant stem. The parts outside of the brackets is the "underlying" form the the prefixal (in the case of the independent order) and suffixal morphology. This is the form before any phonological rules have applied, and is what is directly used to build the FST.
* **Form\#Source**: The source for the surface form. See below for some discussion of how to interpret "GUESS" and for a source key.

#### PARADIGM

| Tag   | Description                         |
|-------|-------------------------------------|
| VAI   | Verb Animate Intransitive           |
| VAIPL   | Verb Animate Intransitive (Plural Only)           |
| VII   | Verb Inanimate Intransitive         |
| VIIPL   | Verb Inanimate Intransitive (Plural Only         |
| VTI   | Verb Transitive Inanimate           |
| VTA   | Verb Transitive Animate             |
| VAIO  | Verb Animate Intransitive + Object  |

#### ORDER

| Tag   | Description                         |
|-------|-------------------------------------|
| Cnj   | Conjunct order                      |
| Ind   | Independent order                   |
| Imp   | Imperative order                    |
| Pcp   | Participles	                      |

#### CLASS

| Tag     | Description                    |
|---------|--------------------------------|
| VII_VV  | vii long vowel stems           |
| VII_V   | vii short vowel stems          |
| VII_d   | vii consonant /d/ stems        |
| VII_n   | vii consonant /n/ stems        |
| VAI_VV  | vai long vowel stems           |
| VAI_V   | vai short vowel stems          |
| VAI_n   | vai consonant /n/ stems        |
| VAI_m   | vai consonant /m/ stems        |
| VAI_am  | vai2 /am/ stems                |
| VAI_rfx | vai with /-idizo/              |
| VAI_rcp | vai with /-idi/                |
| VAIO    | vai with 0sg/pl object         |
| VTI_am  | vti /am/ stems                 |
| VTI_oo  | vti /oo/ stems                 |
| VTI_i   | vti /i/ stems                  |
| VTI_aa  | vti /aa/ stems                 |
| VTA_C   | vta consonant stems            |
| VTA_n   | vta changeable /N/ stems       |
| VTA_s   | vta changeable /S/ stems       |
| VTA_aw  | vta /aw/ stems                 |
| VTA_Cw  | vta consonant-w stems          |

#### SUBJECT/OBJECT

| Our Tag        | OPD Tag  | Description                             |
|----------------|----------|-----------------------------------------|
| 1Sg            | 1s       | First person singular                   |
| Excl           | 1p       | First person exclusive (excludes addressee) |
| Incl           | 21p      | First person inclusive (includes addressee) |
| 2Sg            | 2s       | Second person singular                  |
| 2Pl            | 2p       | Second person plural                    |
| 3SgProx        | 3s       | Animate third person singular proximate |
| 3PlProx        | 3p       | Animate third person plural proximate   |
| 3SgObv         | 3's      | Animate third person singular obviative |
| 3PlObv         | 3'p      | Animate third person plural obviative   |
| 0Sg            | 0s       | Inanimate third person singular (unspecified obviation) |
| 0Pl            | 0p       | Inanimate third person plural (unspecified obviation) |
| 0SgObv         | 0's      | Inanimate third person singular obviative |
| 0PlObv         |? (No 0'p)| Inanimate third person plural obviative   |
| X              | X        | Unspecified actor                       |

#### MODE

| Our Tag | OPD Tag | Description             |
|---------|---------|-------------------------|
| Neu   | no tag; default | Neutral           |
| Prt   | pret      | Preterit                |
| Dub   | dub       | Dubitative              |
| DubPrt| dub pret (to be confirmed) | Dubitative-Preterit |
| Sim   | imp       | Simple (imperative only)|
| Del	| imp del   | Delayed (imperative only)|
| Prb	| imp prohib| Prohibative (imperative only)|

#### NEGATION

| Tag   | Description                         |
|-------|-------------------------------------|
| Pos   | Positive                            |
| Neg   | Negative                            |

#### SOURCES

| Key   				| Description                         											  				|
|-----------------------|-----------------------------------------------------------------------------------------------|
| NJ-ngs-20XX-MonXX   	| X's replaced with date where form confirmed by Nancy Jones during in person interview with C. Hammerly |
| NJ-zoom-20XX-MonXX   	| X's replaced with date where form confirmed by Nancy Jones during zoom interview with C. Hammerly |
| JDN-2010-MS-VAI-pXX   | John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VAI paradigms 				|
| JDN-2010-MS-VII-pXX 	| John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VII paradigms 				|
| JDN-2010-MS-VTA-pXX 	| John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VTA paradigms 				|
| JDN-2010-MS-VTI-pXX 	| John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VTI paradigms 				|
| JRV-2001-NISH-pXX		| J. Rand Valentine (2001) grammar of Nishnaabemwin 							  				|
| JRV-Web-ANISH  		| J. Rand Valentine's webpage (https://ojibwegrammar.langsci.wisc.edu/Grammar/GrammarTOC.html) 	|
| OPD-Note-po			| https://ojibwe.lib.umn.edu/word-part/po-final 												|

### Notes on ambiguous forms and alternate forms

Right now, only Form1 is meant to represent a particular dialect or way of spekaing Anishinaabemowin. Specifically, Border Lakes as spoken at Nigigoonsiminikaaning and Seine River First Nations in Northwestern Ontario, just east of Fort Frances. Any additional forms (Form2, Form3, etc) are variants oberved in other dialects in the Southwestern group. Often, but not always, Form1 is shared across the dialect group writ large. For example, few dialects, if any, outside of Border Lakes have innovated the obviative plural form. Additional forms are included to expand coverage of the model when parsing, and also with hopes that we will also have a more proper multi-dialect model in the future (where dialect is more clearly indicated in some way).

When a given form is ambiguous, we have represented that indirectly by repeating identical forms in more than one row. There are no "composite" tags to indicate ambiguity. On the FST side, this will result in an ambiguous form being ambiguous as to which particular tag set is appropriate. In other uses such as the conjugator, this means the same form will appear in more than one place in the table.

## Guiding Principles

There are a few principles we used when designing the present system:

1. **Maximize use of spreadsheets.** Start by positing as few phonological rules as possible. Ideally, only rules that entail changes to the stem or allow a consistent stem to be used across all forms within a verb class.
2. **Guesses are based on extending an attested paradigm**, not from-scratch assumption. For example, if we know the forms in one VAI class, and we know how that stem class affects the shape of the suffix complex, then we extended the form to these cells as a "guess". Therefore, these are best interpreted as simply "awaiting final confirmation". They are always forms that are generally attested in the language.
3. **Match the assumptions of previous work**, especially the assumptions regading stems and other classification schemes in the Ojibwe People's Dictionary. This is both because the information is highly accurate and useful, but also because we want to interface cleanly with the dictionary and use terms and schemes that are familiar to language learners, linguists, and Algonquianists.
4. **Be as explcit as possible.** With the tags that the model produces and the labels in the spreadsheet, don't leave anything to assumption or interpretation. For example, use "3ProxSg" rather than interpreting a bare "3" as proximate and singular in contrast to "3Pl" or "3Obv". Indicate all ambiguities. Keep detailed track of sources.

# Linguistic Details for Verbs

This section is devoted to detailing the paradigms and stem classes as intantiated in the model, as well as the phonological rules that are needed to derive the surface form from the split (underlying) forms. It follows most closely the classification system developed by John Nichols in the tradition of Algonquianist linguistics, which is also commonly used in educational settings. The first four sections are organized by broad paradigm and detail: (i) the stem types in each paradigm, (ii) the phonological rules needed in the model to capture variation at the stem/suffix juncture, (iii) any important notes or issues on the approach taken. 

## Verb Inanimate Intransitive (VII)

### STEM TYPES

| Class       | Description                  | Example Lemmas                    | Example Stems           		|
|-------------|------------------------------|-----------------------------------|----------------------------------|
| VII Class 1 | vii long vowel stems         | "michaa", "ate", "gonzaabii"      |	/michaa/, /ate/, gonzaabii/		|
| VII Class 2 | vii short vowel stems        | "dakaagami", "inamo"              |	/dakaamgi/, /inamo/				|
| VII Class 3A | vii consonant /d/ stems     | "zanagad", "atemagad"             |	/zanagad/, /atemagad/			|
| VII Class 3B | vii consonant /n/ stems     | "bangisin"                        |	/bangisin/ 						|


### RULES

- _dDeletion:_ Only stem change is "zanagad", where "d" is deleted when the suffix complex starts with a consonant.

- _w1Deletion:_ Delete word-final "w1" (occurs with neutral, positive 3sg in the VII Class 2)

### NOTES/ISSUES

- There are certain stems that can only take plural forms, which are modelled as their own sub-paradigm VII_Pl. These generally refer to collectives, but their exact semantics is not presently clear. In any case, they are diagnosable based on the dictionary entries (their lemma is plural, but the stem is not). These are fed to a special spreadsheet called VII_Pl, which is a proper subset of the regular VII inflections (i.e. only the plural forms). So far, there is only evidence for certain Class 1 and Class 3A stems behaving this way.
- Note that there is limited documentation for the VII Class 2 stems. Also, from a query of the OPD, there seem to be a small set of VII forming "finals" that fall into this class including "-amo" meaning "it is a path", "-po" meaning "it snows/there is snow"  "-aagami" meaning "it is a liquid". A relevant note for Border Lakes from the dictionary: "Most US dialects add n to the final -po when there is no inflectional ending; For example, US zoogipon 'it is snowing' and Border Lakes zoogipo (https://ojibwe.lib.umn.edu/word-part/po-final)."
	- This is modelled by the suffix complex having a -w, which will block the short vowel deletion rule, then be deleted by the W-Deletion rule. 

## Verb Animate Intransitive (VAI)

### STEM TYPES

| Class       | Description               | Example Lemmas                            	   | Example Stems 		|
|-------------|---------------------------|------------------------------------------------|--------------------|
| VAI Class 1A | vai long vowel stems      | "nibaa", "webinige", "madaabii", "maajibatoo" | /nibaa/, /webinige/, /madaabii/, /maajibatoo/	|
| VAI Class 1B | vai short vowel stems     | "nimi", "nagamo"                 			   | /nimi/, /nagamo/   |
| VAI Class 2A | vai consonant /n/ stems   | "washin"                         			   | /washin/           |
| VAI Class 2B | vai consonant /m/ stems   | "minogwaam"                      			   | /minogwaam/        |
| VAI2        | vai2 /am/ stems           |	 "zaaga'am"                        			   | /zaaga'am/         |
| VAI Reflexive | vai with /-idizo/        | "waabandizo"                     			   | /waabandizo/       |
| VAI Reciprocal | vai with /-idi/         | "waabandi"                       			   | /waabandi/         |
| VAIO         | vai with 0sg/pl object    | "adaawe"                         			   | /adaawe/           |


### RULES

- _nasalAssimilation:_ With stems ending in "m" (VAI stems "minongwaam"), the "m" changes to "n" when the suffix complex starts with "z" (negation), "g" (3SgProx in the conjunct), or "d" (inclusive simple imperative)

- _vowelDeletion:_ Delete word-final short vowels, unless deletion creates monosyllabic word with only a short vowel nucleaus. That is, delete from non-monosyllabic words or monosyllabic words with a long vowel. (e.g.\ "i" and "o" delete in "niimi", "nagamo", and "waabandizo"; this rule MUST PRECEED the "w-deletion" rule)

- _w1Deletion:_ Delete word-final "w1" (occurs with neutral, positive 3sg; this rule MUST FOLLOW the short-vowel-deletion rule)

- _LengthenV:_ A short vowel to the left of V1 lengthens (so i -> ii / _ v1, a -> aa / _ v1, o -> oo / _ v1). That is, stem-final short vowels are lengthened in front of the preterit morpheme "-ban" and the delayed imperative mode.

### NOTES/ISSUES

- The VAI2's (the -am stems) are modelled by the -am/-aan/-aa as part of the suffix complex.

- There is a separate set of spreadsheets for the reflexive/reciprocal forms. These take normal VAI morpholgy, but are more restricted in the particular argument combinations they can have (the reflexives have an implict object that matches the subject, and the reciprocals must be plural). They are treated as specific VAI stem types (see the table above), but generally behave the same as the VAI short vowel stems in terms of the rules that apply.

- There is a seperate set of spreadsheets for the VAI+O paradigms in each order. These are VAI verbs that can take an inanimate object, and ultimately inflect like a VTI3 in addition to regular VAI inflection.

- As in the VIIs, there are certain VAI stems that can only take plural forms. These are captured by a unique sub-paradigm VAIPl. They are diagnosable based on the dictionary entries (their lemma is plural, but the stem is not). These are fed to a special spreadsheet called VAIPl, which is a proper subset of the regular VAI inflections (i.e. only the plural forms). So far, there is only evidence for certain Class 1A, 1B, and 2A stems behaving this way.

## Verb Transitive Inanimate (VTI)

### STEM TYPES

| Class | Description    | Example Lemmas | Example Stems   |
|-------|----------------|----------------|-----------------|
| VTI1  | vti /am/ stems | "waabandam"    | /waaband/     	|
| VTI2  | vti /oo/ stems | "wanitoon"     | /wanit/      	|
| VTI3  | vti /i/ stems  | "miijin"       | /miiji/        	|
| VTI4  | vti /aa/ stems | "ayaan"        | /ayaa/         	|

### RULES

NA

### NOTES/ISSUES

- The TI1's (the -am stems) are now modelled by the -am/-aan/-aa as part of the suffix complex.

- The TI4s like "ayaan/ayaam" are a strange bird. We need to see what Border Lakes does, but in Minnesota, according to some notes by Nichols, they behave like the TI1, TI2, and TI3s in the independent order (so as if the stem ends in an "n"), but like the -am regular TIs in the conjunct (so as if the stem ends in "m").

	- Solution: The OPD shows two verbs like this "ayaan/ayaam" and "gidaan/gidaam". So they are quite exceptional. We have opted to include the "n/m" in the suffix complex, which is generally in line with the OPD's approach where the stems are listed as "ayaa" and "gidaa", without the nasal.

- We are showing different allomorphs of the prefix depending on if the stem starts in a consonant (ni, gi, o) or a vowel (nind, gid, od).

## Verb Transitive Animate (VTA)

### STEM TYPES

| Class      | Description                     | Example Lemmas    	|Example Lemmas    	|
|------------|-------------------------------- |--------------------|-------------------|
| VTA Class 1  | vta consonant stems            | "waabam"      	| /waabam/      	|
| VTA Class 2  | vta changeable /N/ stems       | "miizh"       	| /miin1/       	|
| VTA Class 3  | vta changeable /S/ stems       | "mawadish"    	| /mawadis1/    	|
| VTA Class 4  | vta changeable /Nn/ stems      | ???           	| ???           	|
| VTA Class 5  | vta /aw/ stems                 | "mikaw"       	| /mikaw/       	|
| VTA Class 6/7 | vta consonant-w stems          | "mizho"       	| /mizhw/       	|
| VTA Class 8  | vta irregular stems            | "izhi"           	| /in/           	|

For VTA Class 2 and 3, we introduce special multicharacter symbols n1 (equivalent to the capital N convention used in the OPD and elsewhere in the literature) and s1 (equivalent to capital S). Then, we need to ensure that our rules are such that the i1-Palatalization rule only applies to n1 and s1, but not other stems ending in n.

For the VTA Class 4, we don't have any examples, but from what we can see in the dictionary we found two verbs that fall into this class. "gonzhi" meaning "swallow h/" and "wiinzh" meaning "name h/". There are some example conjugations of each, but more work is needed for me to fully understand this class. From what I see, they are not discussed in Valentine (2001) or in other notes from Nichols that I have.

For Class 8 (irregulars) there is one known example. Valentine (2001:285) talks about "zhi(n)" meaning "say Y to AN". This corresponds to "izhi" in CIW and has underlying stem form "iN". It patterns with Class 2, except it is completely null when there are the inverse theme signs "-igw" and "igoo" (again, see Valentine 2001:285). We capture this behavior with a number of rules detailed below.

### RULES

- *awaaRule:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g" or "k".

- *awooRule:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *woRule1, woRule2, woRule3:* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1". AKA, wi -> o / C __
	- In Border Lakes, this rule only applies with non-word-final "Cwi" sequences where C is anything other than the glottal stop. For example, we get "mizhwi" rather than "mizho" for the imerative form and "nindoodita'wig" rather than "nindoodita'og" with the proximate acting on 1sg inverse.  
  	
- *awowRule (optional):* The "amaw" ending of benefactive verbs is replaced by "amow" in third person only direct forms (with theme sign "-aa") by some speakers at Red Lake (and elsewhere?).

- *n1Rule, s1Rule:* Stems ending in "n1" palatalize to "zh" and "s1" to "sh" when the suffix complex starts with the first person theme sign "i1". Note that it needs to be this specific, since it isn't just any old "i" that triggers palatalization, and not all n's and s's palatalize either.

- *vowelDeletion:* Delete word-final short vowels in multi-syllabic words or mono-syllabic words with a long vowel (preseve the short vowel in mono-syllabic words with a short vowel, e.g. "makwa"). This role MUST FOLLOW i1-Palatalization and w-to-o since it needs to be there to trigger the palatalization, but does not show up in the surface form.

- *izhiInverseDel:* Stem for izhi "in1" deletes just in case the theme sign is inverse (igo or igoo)

- *izhiShortVPreservation:* Insert a w2 at the end of the word when irregular stem izhi "in1" is presnt just in case it only ends in "i1". This prevents the short vowel from getting deleted when a preverb is added.

### NOTES/ISSUES

- "Many vta verbs show an alternation in their final consonant between /n/ and /zh/. The form /zh/ shows up before the 1st-person object theme suffix /-i/, the imperative 1st-person object theme suffix /-ishi/, and the 2nd-person imperative theme suffix, /-i/. Elsewhere the form of the final sound of such verbs is /n/." (https://ojibwegrammar.langsci.wisc.edu/Grammar/HTMLParadigms/vtaNindpos.htm)

- "A few vta verbs show an alternation in their final consonant between /s/ and /sh/. The form /sh/ shows up before the 1st-person object theme suffix /-i/, the imperative 1st-person object theme suffix /-ishi/, and the 2nd-person imperative theme suffix, /-i/. Elsewhere the form of the final sound of such verbs is /s/. There is only a small number of verbs showing this alternation" (https://ojibwegrammar.langsci.wisc.edu/Grammar/HTMLParadigms/vtaSindpos.htm)

	- SOLUTION: For both of these, we've introduced a special character "i1" and the "i1-Palatalization" rule.

- In the imperative order, with the 2Sg -> 3SgProx/3PlProx, there is an "i1" that appears only on monosyllabic shortvowel stems: nishi ‘kill him/her’. Otherwise, it is deleted. This is due to a more general rule that limits the word-final short-vowel deletion rule. For example, with the noun "makwa". This is implemented by only deleting in multisyllable words or monosyllable words that have a long vowel.

## Summary

### SUMMARY OF STEM CLASSES

| NICHOLS CLASS | CODE   | DESCRIPTION                   | Example Lemmas                   |
|---------------|--------|-------------------------------|-------------------------------------------|
| VII1          | VII_VV | vii long vowel stems          | "michaa", "ate", "gonzaabii"              |
| VII2          | VII_V  | vii short vowel stems         | "dakaagami", "inamo"                      |
| VII3A         | VII_d  | vii consonant /d/ stems       | "zanagad", "atemagad"                     |
| VII3B         | VII_n  | vii consonant /n/ stems       | "bangisin"                                |
| VAI1A         | VAI_VV | vai long vowel stems          | "nibaa", "webinige", "madaabii", "maajibatoo" |
| VAI1B         | VAI_V  | vai short vowel stems         | "nimi", "nagamo"                          |
| VAI2A         | VAI_n  | vai consonant /n/ stems       | "washin"                                  |
| VAI2B         | VAI_m  | vai consonant /m/ stems       | "minogwaam"                               |
| VAI2          | VAI_am | vai2 /am/ stems               | "zaaga'am"                                |
| N/A 			| VAI_rfx | vai with /-idizo/        	 | "waabandizo"                     		 |
| N/A 			| VAI_rcp | vai with /-idi/         	 | "waabandi"                       		 |
| VAIO          | VAIO	 | vai with 0sg/pl object        | "adaawe"                                  |
| VTI1          | VTI_am | vti /am/ stems                | "waabandam"                               |
| VTI2          | VTI_oo | vti /oo/ stems                | "wanitoon"                                |
| VTI3          | VTI_i  | vti /i/ stems                 | "miijin"                                  |
| VTI4          | VTI_aa | vti /aa/ stems                | "ayaan"                                   |
| VTA1          | VTA_C  | vta consonant stems           | "waabam"                                  |
| VTA2          | VTA_n  | vta changeable /N/ stems      | "miizh"                                   |
| VTA3          | VTA_s  | vta changeable /S/ stems      | "mawadish"                                |
| VTA4          | ???    | vta changeable /Nn/ stems     | ???                                       |
| VTA5          | VTA_aw | vta /aw/ stems                | "mikaw"                                   |
| VTA6/7        | VTA_Cw | vta consonant-w stems         | "mizho"                                   |
| VTA8          | VTA_irr    | vta irregular stems           | "izhi"                                       |


[def]: #verb-spreadsheets