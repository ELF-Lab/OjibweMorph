# BorderLakesMorph Spreadsheets

## General
*	Double \>\> marks the stem/suffix juncture (or the end of the stem)
*	Double \<\< marks the prefix/stem juncture (or the start of the stem)
*	Single \> marks boundaries between suffixes outside of the stem (not yet used)
*	Single \< marks boundaries between prefixes outside of the stem (not yet used)
*	Null morphemes will NOT be added unless a rule needs to refer to them. So far there are no such rules.
*	There are three special characters:
	*	i1, the first person "theme sign" (marking a first person object with the subject is also a first person), which is used to trigger palatalization in certain VTAs (see VTA notes with quotes from Rand Valentine).
		*	This is the same as "i2" in the Bowers et al (2017) FST for Odawa
	*	n1, the special "changable N" that palatalizes before i1
 		*	This is the same as "n1" in the Bowers et al (2017) FST for Odawa
	*	s1, the special "changable S" that palatalizes before i1
 		*	This is the same as "s1" in the Bowers et al (2017) FST for Odawa
	*	w1, the independent order third person agreement that is usually deleted, and opaquely blocks short vowel deletion
 		*	This is the same as "w5" in the Bowers et al (2017) FST for Odawa

## Organization

This folder contains the verb paradigm spreadsheets used to create and validate the BorderLakesMorph FST for morphological production and parsing. 

### Descripton of Tags

All spreadsheets contain the following columns:

* **Paradigm:** Traditional Algonquianist split based primarily on transitivity and argument animacy. Exception is added VAI_Pl and VII_Pl, which are special cases of each stem that only allow plural arguments.
* **Order:** Clause-type distinction in traditional Algonquianist terms, which differ in their verb paraidgms. Independent (also known as A-form) is roughly main clauses, conjunct (also known as B-form) is roughly embedded clauses and questions. Imperative are the command forms.
* **Class:** Phonological classes based on the sounds at the right edge of the stem. Change the shape of the suffix complex due to phonological processes at the stem-suffix boundary.
* **Lemma:** Each class within each order/paradigm combination is exemplified by at least one sample verb, often more than one. The lemma is the "dictionary form" of the verb (akin to the infinitive with English verbs) as taken from the OPD. This is usually either the third person singular and/or second person simple imperative form. Lemmas are also used for verb tags in the FST.
* **Stem:** The stem is the underlying form of the example verb. Unless otherwise indicated, we take the stem specified in the OPD. Sometimes, this is the same as the lemma. However, often it is distinct, as various phonological processes can intervene.
* **Subject:** The person/noun associated with the prototpyical "actor" role in transitive paradigms, or the sole person/noun of intransitive paradigms. 
* **Object:** The person/noun associated with the prototypical "undergoer" role in transitive paradigms. Always NA in intransitive paradigms.
* **Mode:** Traditional Algonquianist categories in Ojibwe related to the epistemic/modal/aspectual system.
* **Negation:** Whether the verb is positive or negative. The independent order negatives must be preceded by "gaawiin" to be well-formed.
* **Form\#Surface:** The surface form of the example verb, after all phonological processes have been executed. The source for these forms is indated in a different column. Form1 is the attested or assumed form for Border Lakes, which all other forms are variants from other closely related dialects. Marked MISSING if a form is expected, but not yet attested in a source or extended with a GUESS.
* **Form\#Split:** The part in brackets is a stand-in for any stem within that particular class. Only the pieces of the brackets are used by the model, which simply replaces the part in brackets with the relevant stem. The parts outside of the brackets is the "underlying" form the the prefixal (in the case of the independent order) and suffixal morphology. This is the form before any phonological rules have applied.
* **Form\#Source**: The source for the surface form. See below for some discussion of how to interpret "GUESS" and for a source key.

#### PARADIGM

| Tag   | Description                         |
|-------|-------------------------------------|
| VAI   | Verb Animate Intransitive           |
| VAI_PL   | Verb Animate Intransitive (Plural Only)           |
| VII   | Verb Inanimate Intransitive         |
| VII_PL   | Verb Inanimate Intransitive (Plural Only         |
| VTI   | Verb Transitive Inanimate           |
| VTA   | Verb Transitive Animate             |
| VAIO  | Verb Animate Intransitive + Object  |

#### ORDER

| Tag   | Description                         |
|-------|-------------------------------------|
| Cnj   | Conjunct order                      |
| Ind   | Independent order                   |
| Imp   | Imperative order                    |

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
| VAI_rfx | vai with /-idizo/_P              |
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
| VTA_irr | vta irregular stems            |

#### SUBJECT/OBJECT

| Our Tag        | OPD Tag  | Description                             |
|----------------|----------|-----------------------------------------|
| 1Sg            | 1s       | First person singular                   |
| Excl           | 1p       | First person exclusive (excludes addressee) |
| Incl           | 21p      | First person inclusive (includes addressee) |
| 1Sg/Excl       | 1        | First person (unspecified number)       |
| 2Sg            | 2s       | Second person singular                  |
| 2Pl            | 2p       | Second person plural                    |
| 2Sg/2Pl        | 2        | Second person (unspecified number)      |
| 3SgProx/3PlProx| 3        | Animate third person proximate (unspecified number) |
| 3SgProx        | 3s       | Animate third person singular proximate |
| 3PlProx        | 3p       | Animate third person plural proximate   |
| 3SgObv/3PlObv  | 3'       | Animate third person singular obviative |
| 3SgObv         | 3's      | Animate third person singular obviative |
| 3PlObv         | 3'p      | Animate third person plural obviative   |
| 0Sg/0Pl        | 0        | Inanimate third person (unspecified number) |
| 0Sg            | 0s       | Inanimate third person singular (unspecified obviation) |
| 0Pl            | 0p       | Inanimate third person plural (unspecified obviation) |
| 0SgObv/0PlObv  | 0'       | Inanimate third person obviative (unspecified number) |
| 0SgObv         | 0's      | Inanimate third person singular obviative |
| 0PlObv         |? (No 0'p)| Inanimate third person plural obviative   |
| X              | X        | Unspecified actor                       |

#### MODE

| Tag   | Description                         |
|-------|-------------------------------------|
| Neu   | Neutral                             |
| Prt   | Preterit                            |
| Dub   | Dubitative                          |
| DubPrt| Dubitative-Preterit                 |

#### NEGATION

| Tag   | Description                         |
|-------|-------------------------------------|
| Pos   | Positive                            |
| Neg   | Negative                            |

### Other helpful notes

Right nonw, only Form1 is meant to represent a particular dialect or way of spekaing Anishinaabemowin. Specifically, Border Lakes as spoken at Nigigoonsiminikaaning and Seine River First Nations. Any additional forms (Form2, Form3) are variants oberved in other dialects in the Southwestern group. Often, but not always, Form1 is shared across the dialect group writ large. For example, few dialects, if any, outside of Border Lakes have innovated the obviative plural form. Additional forms are included to expand coverage of the model when parsing, with hopes that we will also have a more proper multi-dialect model in the future (where dialect is tagged in some way).

When a given form is ambiguous, we have represented that indirectly by repeating identical forms in more than one row. 

## Guiding Principles

There are a few principles we used when designing the present system:

1. **Maximize use of spreadsheets.** Start by positing as few phonological rules as possible. Ideally, only rules that entail changes to the stem.
2. **Guesses are based on extending an attested paradigm**, not from-scratch assumption. For example, if we know the forms in one VAI class, and we know how that stem class affects the shape of the suffix complex, then we extended the form to these cells as a "guess". Therefore, these are best interpreted as simply "awaiting final confirmation". They are always forms that are generally attested in the language.
3. **Match the assumptions of previous work**, especially the assumptions regading stems and other classification schemes in the Ojibwe People's Dictionary. This is both because the information is highly accurate and useful, but also because we want to interface cleanly with the dictionary and use terms and schemes that are familiar to language learners, linguists, and Algonquianists.
4. **Be as explcit as possible.** With the tags that the model produces and the labels in the spreadsheet, don't leave anything to assumption or interpretation. For example, use "3ProxSg" rather than interpreting a bare "3" as proximate and singular in contrast to "3Pl" or "3Obv". Indicate all ambiguities. Keep detailed track of sources.

# Linguistic Details

## Verb Inanimate Intransitive (VII)

### STEM TYPES

| Class       | Description                  | Lemmas                             |
|-------------|------------------------------|-----------------------------------|
| VII Class 1 | vii long vowel stems         | "michaa", "ate", "gonzaabii"      |
| VII Class 2 | vii short vowel stems        | "dakaagami", "inamo"              |
| VII Class 3A | vii consonant /d/ stems      | "zanagad", "atemagad"             |
| VII Class 3B | vii consonant /n/ stems      | "bangisin"                        |


### RULES

- _d-deletion:_ Only stem change is "zanagad", where "d" is deleted when the suffix complex starts with a consonant.

- _W-deletion:_ Delete word-final "w1" (occurs with neutral, positive 3sg in the VII Class 2)

### NOTES/ISSUES

- There are certain stems that can only take plural forms. These generally refer to collectives, but their exact semantics is not presently clear. In any case, they are diagnosable based on the dictionary entries (their lemma is plural, but the stem is not). These are fed to a special spreadsheet called VII_Pl, which is a proper subset of the regular VII inflections (i.e. only the plural forms). So far, there is only evidence for certain Class 1 and Class 3A stems behaving this way.
- Note that there is quite limited documentation for the VII Class 2 stems. Also, from a query of a dictionary, there seem to be a small set of VII forming "finals" that fall into this class including "-amo" meaning "it is a path", "-po" meaning "it snows/there is snow"  "-aagami" meaning "it is a liquid". A relevant note for Border Lakes from the dictionary: "Most US dialects add n to the final -po when there is no inflectional ending; For example, US zoogipon 'it is snowing' and Border Lakes zoogipo (https://ojibwe.lib.umn.edu/word-part/po-final)."
	- This is now modelled by the suffix complex having a -w, which will block the short vowel deletion rule, then be deleted by the W-Deletion rule. 

## Verb Animate Intransitive (VAI)

### STEM TYPES

| Class       | Description               | Lemmas                            |
|-------------|---------------------------|----------------------------------|
| VAI Class 1A | vai long vowel stems      | "nibaa", "webinige", "madaabii", "maajibatoo" |
| VAI Class 1B | vai short vowel stems     | "nimi", "nagamo"                 |
| VAI Class 2A | vai consonant /n/ stems   | "washin"                         |
| VAI Class 2B | vai consonant /m/ stems   | "minogwaam"                      |
| VAI2        | vai2 /am/ stems           | "zaaga'am"                        |
| VAI Reflexive | vai with /-idizo/        | "waabandizo"                     |
| VAI Reciprocal | vai with /-idi/         | "waabandi"                       |
| VAIO         | vai with 0sg/pl object    | "adaawe"                         |


### RULES

- _Nasal assimilation:_ With stems ending in "m" (VAI stems "minongwaam"), the "m" changes to "n" when the suffix complex starts with "z" (negation), "g" (3SgProx in the conjunct), or "d" (inclusive simple imperative)

- _ShortV-deletion:_ Delete word-final short vowels, unless deletion creates monosyllabic word with only a short vowel nucleaus. That is, delete from non-monosyllabic words or monosyllabic words with a long vowel. (e.g.\ "i" and "o" delete in "niimi", "nagamo", and "waabandizo"; this rule MUST PRECEED the "w-deletion" rule)

- _W-deletion:_ Delete word-final "w1" (occurs with neutral, positive 3sg; this rule MUST FOLLOW the short-vowel-deletion rule)

### NOTES/ISSUES

- There is a process where stem-final short finals are lengthened to the corresponding long vowels in front of the preterit morpheme "-ban". 
	
	- SOLUTION: This is modelled by adding the second half of the long vowel in the suffix complex, rather than any sort of rule. Questionable, but it works.

- The VAI2's (the -am stems) are modelled by the -am/-aan/-aa as part of the suffix complex.

- There is a separate set of spreadsheets for the reflexive/reciprocal forms. These take normal VAI morpholgy, but are more restricted in the particular argument combinations they can have (the reflexives have an implict object that matches the subject, and the reciprocals must be plural). They are treated as specific VAI stem types (see the table above), but generally behave the same as the VAI short vowel stems in terms of the rules that apply.

- There is a seperate set of spreadsheets for the VAI+O paradigms in each order. These are VAI verbs that can take an inanimate object, and ultimately inflect like a VTI3.

- As in the VIIs, there are certain VAI stems that can only take plural forms. They are diagnosable based on the dictionary entries (their lemma is plural, but the stem is not). These are fed to a special spreadsheet called VAI_Pl, which is a proper subset of the regular VAI inflections (i.e. only the plural forms). So far, there is only evidence for certain Class 1A, 1B, and 2A stems behaving this way.

## Verb Transitive Inanimate (VTI)

### STEM TYPES

| Class | Description    | Lemmas        |
|-------|----------------|--------------|
| VTI1  | vti /am/ stems | "waabandam" |
| VTI2  | vti /oo/ stems | "wanitoon"  |
| VTI3  | vti /i/ stems  | "miijin"    |
| VTI4  | vti /aa/ stems | "ayaan"     |

### RULES

NA

### NOTES/ISSUES

- The TI1's (the -am stems) are now modelled by the -am/-aan/-aa as part of the suffix complex.

- The TI4s like "ayaan/ayaam" are a strange bird. We need to see what Border Lakes does, but in Minnesota, according to some notes by Nichols, they behave like the TI1, TI2, and TI3s in the independent order (so as if the stem ends in an "n"), but like the -am regular TIs in the conjunct (so as if the stem ends in "m").

	- Solution: The OPD shows two verbs like this "ayaan/ayaam" and "gidaan/gidaam". So they are quite exceptional. We have opted to include the "n/m" in the suffix complex, which is generally in line with the OPD's approach where the stems are listed as "ayaa" and "gidaa", without the nasal.

- We are showing different allomorphs of the prefix depending on if the stem starts in a consonant (ni, gi, o) or a vowel (ind, gid, od). We need to model this in a general way with the other allomoprhs that pop up, and make sure to model Border Lakes specifically. This also goes for the VAIs and VTAs.
	- Solution: For now, we are just going to model the "d-epenthesis" so "ni" -> "nid", "gi" -> "gid", and "o" -> "od"

## Verb Transitive Animate (VTA)

### STEM TYPES

| Class      | Description                    | Lemmas         |
|------------|--------------------------------|---------------|
| VTA Class 1 | vta consonant stems            | "waabam"      |
| VTA Class 2 | vta changeable /N/ stems       | "miizh"       |
| VTA Class 3 | vta changeable /S/ stems       | "mawadish"    |
| VTA Class 4 | vta changeable /Nn/ stems      | ???           |
| VTA Class 5 | vta /aw/ stems                 | "mikaw"       |
| VTA Class 6 | vta consonant-w stems          | "mizho"       |
| VTA Class 7 | vta glottal-w stems            | Same as "mizho" |
| VTA Class 8 | vta irregular stems            | "izhi"           |

For VTA Class 2 and 3, we introduce special multicharacter symbols n1 (equivalent to the capital N convention used in the OPD and elsewhere in the literature) and s1 (equivalent to capital S). Then, we need to ensure that our rules are such that the i1-Palatalization rule only applies to n1 and s1, but not other stems ending in n.

For the VTA Class 4, I don't have any examples, but from what I can see in the dictionary I found two verbs that fall into this class. "gonzhi" meaning "swallow h/" and "wiinzh" meaning "name h/". There are some example conjugations of each, but more work is needed for me to fully understand this class. From what I see, they are not discussed in Valentine (2001) or in other notes from Nichols that I have.

For Class 8 (irregulars) there is one known example. Valentine (2001:285) talks about "zhi(n)" meaning "say Y to AN". This corresponds to "izhi" in CIW and has underlying stem form "iN". It patterns with Class 2, except it is completely null when there are the inverse theme signs "-igw" and "igoo" (again, see Valentine 2001:285). There is a specific spreadsheet for this verb, and in principle we could create some rules to deal with it since its "irregularity" is actually quite regular in many ways. At present, we just have the positive independent order, but it could easily be extended with educated guesses.

### RULES

- *aw-to-aa:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g" or "k".

- *aw-to-oo:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *w-to-o:* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1)". AKA, wi -> o / C __
	- In Border Lakes, this rule only applies with non-word-final "Cwi" sequences. For example, we get "mizhwi" rather than "mizho" for the imerative form.  	

- *i1-Palatalization: (UPDATED FEBRUARY 4, 2024)* Stems ending in "n1" palatalize to "zh" and "s1" to "sh" when the suffix complex starts with the first person theme sign "i1". Note that it needs to be this specific, since it isn't just any old "i" that triggers palatalization, and not all n's and s's palatalize either.

- *ShortV-deletion: (UPDATED MARCH 20, 2024)* Delete word-final short vowels, unless deletion creates monosyllabic word with only a short vowel nucleaus. That is, delete from non-monosyllabic words or monosyllabic words with a long vowel. This role MUST FOLLOW i1-Palatalization and w-to-o since it needs to be there to trigger the palatalization, but does not show up in the surface form.

### NOTES/ISSUES

- "Many vta verbs show an alternation in their final consonant between /n/ and /zh/. The form /zh/ shows up before the 1st-person object theme suffix /-i/, the imperative 1st-person object theme suffix /-ishi/, and the 2nd-person imperative theme suffix, /-i/. Elsewhere the form of the final sound of such verbs is /n/." (https://ojibwegrammar.langsci.wisc.edu/Grammar/HTMLParadigms/vtaNindpos.htm)

- "A few vta verbs show an alternation in their final consonant between /s/ and /sh/. The form /sh/ shows up before the 1st-person object theme suffix /-i/, the imperative 1st-person object theme suffix /-ishi/, and the 2nd-person imperative theme suffix, /-i/. Elsewhere the form of the final sound of such verbs is /s/. There is only a small number of verbs showing this alternation" (https://ojibwegrammar.langsci.wisc.edu/Grammar/HTMLParadigms/vtaSindpos.htm)

	- SOLUTION: For both of these, we've introduced a special character "i1" and the "i1-Palatalization" rule.

- UPDATE: I changed the suffixation on the Cw stems to include an initial "i", and changed the w-to-o rule so that "Cwi" -> "Co". The consonant is important context, since it doesn't happen with "aw" stems where the suffix starts with "i". This needs to happen before the short-vowel deletion, since we see that this feeds the deletion in forms that end up ending in this short vowel. We can also get rid of the W-deletion rule.

- ISSUE: in the imperative order, with the 2Sg -> 3SgProx/3PlProx, there is an "i1" that appears only on monosyllabic shortvowel stems: nishi ‘killhim/her’. Otherwise, it is deleted. This is (I am quite certain) a more general rule that limits the word-final short-vowel deletion rule. For example, with the noun "makwa". We need to somehow implement this block into the model. Currently, we have the "i1" in the suffix complex, and it always gets deleted by the rule. It needs to be there to condition the palatalization process before being deleted.

## Summary

### SUMMARY OF STEM CLASSES

| NICHOLS CLASS | CODE   | DESCRIPTION                   | EXAMPLE(S) (FROM YAMLS)                   |
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
| NA 			| VAI_rfx | vai with /-idizo/        	 | "waabandizo"                     		 |
| NA 			| VAI_rcp | vai with /-idi/         	 | "waabandi"                       		 |
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


#### SOURCES

| Key   				| Description                         											  				|
|-----------------------|-----------------------------------------------------------------------------------------------|
| JDN-2010-MS-VAI-pXX   | John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VAI paradigms 				|
| JDN-2010-MS-VII-pXX 	| John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VII paradigms 				|
| JDN-2010-MS-VTA-pXX 	| John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VTA paradigms 				|
| JDN-2010-MS-VTI-pXX 	| John Nichols (2010) Unpublished Manuscript of Southwestern Ojibwe VTI paradigms 				|
| JRV-2001-NISH-pXX		| J. Rand Valentine (2001) grammar of Nishnaabemwin 							  				|
| JRV-Web-ANISH  		| J. Rand Valentine's webpage (https://ojibwegrammar.langsci.wisc.edu/Grammar/GrammarTOC.html) 	|
| OPD-Note-po			| https://ojibwe.lib.umn.edu/word-part/po-final 												|


### SUMMARY OF PREVERB RULES

#### Person prefix

The person prefixes, especially the first person prefix, show a lot of variation. We'll want to account for all of it in the parser so we can get coverage, but limit outputs when generating. Variation is due to phonology to some degree, but also dialect and speech rate.

For Border Lakes, generally:

- ni(m/n/nd)-
	- ni- before m, n, w, p, t, k, s, sh
	- nim- before b
	- nin- before d, j, z, zh, g
	- nind- before vowels

- gi(d)-
	- gi- before consonants
	- gid- before vowels

- o(d)-
	- o- before consonants
	- od- before vowels

More generally for Southerwestern Ojibwe, there is significant variation:

- First Person
	- ni-/n- before m, n, w, p, t, k, s, sh
	- nim-/im-/m-/ni- before b
	- nin-/in-/n-/ni- before d, j, z, zh, g
	- nind-/ind-/nd- before vowels
		- At Red Lake, we get niy- before aa

- Second Person
	- gi- before consonants
	- gid- before vowels

- Third Person
	- o- before consonants
	- od- before vowels

In short, ni- can in principle appear before any consonant. Otherwise, the nim-/nin-/nind- allomorphs can lack the initial "n" deriving im-/in-/ind- (whether this is used is primarily a matter of dialect variation), and these can be further subjected to a vowel deletion process deriving m-/n-/nd- (which is primarily a matter of speech rate, I think). The second and third person prefixes are generally easier to model.  

The person prefixes also trigger a lengthening process:

- *o-to-oo-lengthening:* If a stem/preverb starting with "o" is immediately preceded by a person prefix, lengthen "o" to "oo" (and the "d" form of prefix shows up, like normal).

Sources:
- https://ojibwegrammar.langsci.wisc.edu › Assets › Pdfs › InflAnishPersonPrefixes1.02.pdf
- https://ojibwe.lib.umn.edu/main-entry/im-pf
- https://ojibwe.lib.umn.edu/main-entry/g-pf

#### Tense

*Background*: A distinction known as the lenis/fortis contrast is indicated by the use of voiced/voiceless consonants. The "lenis" consonants are prototyically written as "b", "d", "j", "g", "z", and "zh", but in some contexts are "devoiced"/"strengthened"/"tensed" to "p", "t", "ch", "k", "s", and "sh" respectively. In contrast, fortis consonants are invariably written as "p", "t", "ch", "k", "s", and "sh.

- *tense-tensing:* Lenis consonants ("b", "d", "j", "g", "z", "zh") are strengthened to the fortis counterpart ("p", "t", "ch", "k", "s", "sh") following the past tense preverbs (gii-/gii'-) and desiderative future tense preverbs (wii-/wii'-).

The rule is meant to be quite broad, triggering this process not only on stems that follow the relevant tense marker, but also preverbs. It is also worth noting that this is the type of thing that might not *always* be reflected in the orthography, so probably we want to allow some fuzziness when parsing. But in the "standard" orthography of the OPD, this is always reflected. Finally, this is specific to these morphemes, not any preverb that ends in "ii". For example, "maajii-" meaning "start" does not trigger the rule.

*Citation*: See Nichols (1980, pg. 129) *Ojibwe Morphology*, PhD Dissertation, Harvard University for a version of the rule here.

#### Initial change

Conjunct order verbs can undergo a non-concatenative vowel ablaut process known as "initial change", which transforms the first vowel of the verbal complex (including preverbs). This produces the so-called "changed conjunct", which is used when some A' process such as topicalization, *wh*-movement, or relativization has occurred.

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

### SUMMARY OF SUFFIX RULES

Note: These rules are often crucially ordered! We have indicated when that is the case.

- _d-deletion:_ Delete stem-final "d" when the suffix complex starts with a consonant.

- _Nasal assimilation:_ With stems ending in "m" (e.g. VAI stems "minongwaam"), the "m" changes to "n" when the suffix complex starts with "z" (negation), "g" (3SgProx in the conjunct), or "d" (inclusive simple imperative)

- *aw-to-aa:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g" or "k".

- *aw-to-oo:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *w-to-o:* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1". AKA, wi -> o / C __
	- This rule MUST PRECEED the "ShortV-deletion" rule
	- In Border Lakes, this rule only applies with non-word-final "Cwi" sequences. For example, we get "mizhwi" rather than "mizho" for the imerative form.

- *i1-Palatalization:* Stems ending in "n1" palatalize to "zh" and "s1" to "sh" when the suffix complex starts with the first person theme sign "i1".
  	- This rule MUST PRECEED the "ShortV-deletion" rule

- _ShortV-deletion:_ Delete word-final short vowels
	- This rule MUST PRECEED the "w-deletion" rule
	- This role MUST FOLLOW i1-Palatalization and w-to-o

- _W-deletion:_ Delete word-final "w1" (occurs with neutral, positive 3sg)
	- This rule MUST FOLLOW the "ShortV-deletion" rule

### OLD RULES (defunct)

**M-deletion & vowel lengthening**

Stem-final "m" is deleted and the vowel "a" is elongated to "aa" when the suffix complex starts with "m" or "n" (as in TI -am stems like "waabandam"; VAI2 -am stems "zaaga'am")

**M-assimilation & vowel lengthening**

With stems ending in "m", so both -am and -m stems (VAI stems "minongwaam" and "zaaga'am"; VTI stem "waabandam"), the "m" changes to "n" when the suffix complex starts with "z" (negation) or a "g" (3SgProx in the conjunct)

**w-to-o (REPLACED ON JUNE 29, 2023)**

For TA stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with a consonant.
