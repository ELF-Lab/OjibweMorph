# README for spreadsheets in BorderLakesMorph

## GENERAL
*	\>\> marks the stem/suffix juncture (or the end of the stem)
*	\<\< marks the prefix/stem juncture (or the start of the stem)
*	Null morphemes will NOT be added unless a rule needs to refer to them. So far there are no such rules.
*	There is one special character, i1, the first person "theme sign" (marking a first person object with the subject is also a first person), which is used to trigger palatalization in certain VTAs (see VTA notes with quotes from Rand Valentine).

## Verb Inanimate Intransitive (VII)

### STEM TYPES

| Class       | Description                  | Stems                             |
|-------------|------------------------------|-----------------------------------|
| VII Class 1 | vii long vowel stems         | "michaa", "ate", "gonzaabii"      |
| VII Class 2 | vii short vowel stems        | "dakaagami", "inamo"              |
| VII Class 3A | vii consonant /d/ stems      | "zanagad", "atemagad"             |
| VII Class 3B | vii consonant /n/ stems      | "bangisin"                        |

Note that there is quite limited documentation for the VII Class 2 stems. Also, from a query of a dictionary, there seem to be a small set of VII forming "finals" that fall into this class including "-amo" meaning "it is a path", "-po" meaning "it snows/there is snow"  "-aagami" meaning "it is a liquid". A relevant note for Border Lakes from the dictionary: "Most US dialects add n to the final -po when there is no inflectional ending; For example, US zoogipon 'it is snowing' and Border Lakes zoogipo (https://ojibwe.lib.umn.edu/word-part/po-final)."

### RULES

- _d-deletion:_ Only stem change is "zanagad", where "d" is deleted when the suffix complex starts with a consonant.

### NOTES/ISSUES

NA

## Verb Animate Intransitive (VAI)

### STEM TYPES

| Class       | Description               | Stems                            |
|-------------|---------------------------|----------------------------------|
| VAI Class 1A | vai long vowel stems      | "nibaa", "webinige", "madaabii", "maajibatoo" |
| VAI Class 1B | vai short vowel stems     | "nimi", "nagamo"                 |
| VAI Class 2A | vai consonant /n/ stems   | "washin"                         |
| VAI Class 2B | vai consonant /m/ stems   | "minogwaam"                      |
| VAI2        | vai2 /am/ stems           | "zaaga'am"                       |

### RULES

- _Nasal assimilation:_ With stems ending in "m"(VAI stems "minongwaam"), the "m" changes to "n" when the suffix complex starts with "z" (negation) or a "g" (3SgProx in the conjunct)

- _ShortV-deletion:_ Delete word-final short vowels ("i" and "o" as in "niimi" and "nagamo"; this rule MUST PRECEED the "w-deletion" rule)

- _W-deletion:_ Delete word-final "w" (occurs with neutral, positive 3sg; this rule MUST FOLLOW the short-vowel-deletion rule)

### NOTES/ISSUES

- There is a process where stem-final short finals are lengthened to the corresponding long vowels in front of the preterit morpheme "-ban". 
	
	- SOLUTION: This is modelled by adding the second half of the long vowel in the suffix complex, rather than any sort of rule. Questionable, but it works.

- The VAI2's (the -am stems) are modelled by the -am/-aan/-aa as part of the suffix complex.

## Verb Transitive Inanimate

### STEM TYPES

| Class | Description    | Stems        |
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

## Verb Transitive Animate

### STEM TYPES

| Class      | Description                    | Stems         |
|------------|--------------------------------|---------------|
| VTA Class 1 | vta consonant stems            | "waabam"      |
| VTA Class 2 | vta changeable /N/ stems       | "miizh"       |
| VTA Class 3 | vta changeable /s/ stems       | "mawadish"    |
| VTA Class 4 | vta changeable /Nn/ stems      | ???           |
| VTA Class 5 | vta /aw/ stems                 | "mikaw"       |
| VTA Class 6 | vta consonant-w stems          | "mizho"       |
| VTA Class 7 | vta glottal-w stems            | Same as "mizho" |
| VTA Class 8 | vta irregular stems            | ???           |

For the VTA Class 4, I don't have any examples, but from what I can see in the dictionary I found two verbs that fall into this class. "gonzhi" meaning "swallow h/" and "wiinzh" meaning "name h/". There are some example conjugations of each, but more work is needed for me to fully understand this class. From what I see, they are not discussed in Valentine (2001) or in other notes from Nichols that I have.

For Class 8 (irregulars) I also don't have examples. But Valentine (2001:285) mentions one irregular verb "zhi(n)" meaning "say Y to AN". This would correspond to "izhi" in CIW and has underlying stem form "iN". It mostly patterns with Class 2, except it is completely null when there are the inverse theme signs "-igw" and "igoo" (again, see Valentine 2001:285). In the long run, we probably want to just hard code this specific verb into the model.

### RULES

- *aw-to-aa:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g".

- *aw-to-oo:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *w-to-o (UPDATED JUNE 29, 2023):* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1)". AKA, wi -> o / C __

- *i1-Palatalization:* Stems ending in "n" palatalize to "zh" and "s" to "sh" when the suffix complex starts with the first person theme sign "i1". Note that it needs to be this specific, since it isn't just any old "i" that triggers palatalization.

- *ShortV-deletion:* Delete word-final short vowels (as "i1"). This role MUST FOLLOW i1-Palatalization and w-to-o since it needs to be there to trigger the palatalization, but does not show up in the surface form.

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
| VTI1          | VTI_am | vti /am/ stems                | "waabandam"                               |
| VTI2          | VTI_oo | vti /oo/ stems                | "wanitoon"                                |
| VTI3          | VTI_i  | vti /i/ stems                 | "miijin"                                  |
| VTI4          | VTI_aa | vti /aa/ stems                | "ayaan"                                   |
| VTA1          | VTA_C  | vta consonant stems           | "waabam"                                  |
| VTA2          | VTA_n  | vta changeable /N/ stems      | "miizh"                                   |
| VTA3          | VTA_s  | vta changeable /s/ stems      | "mawadish"                                |
| VTA4          | ???    | vta changeable /Nn/ stems     | ???                                       |
| VTA5          | VTA_aw | vta /aw/ stems                | "mikaw"                                   |
| VTA6/7        | VTA_Cw | vta consonant-w stems         | "mizho"                                   |
| VTA8          | ???    | vta irregular stems           | ???                                       |

### SUMMARY OF PREFIX RULES

- Person prefixes triggering changes to the stem (e.g. stems starting with "o" lengthen to "oo") and prefix rules in general.
	-  https://ojibwegrammar.langsci.wisc.edu › Assets › Pdfs › InflAnishPersonPrefixes1.02.pdf
	- https://ojibwe.lib.umn.edu/main-entry/im-pf
	- https://ojibwe.lib.umn.edu/main-entry/g-pf

- ni(d/m/n)-
	- ni- before m, n, w, p, t, k, s, sh
	- nim- before b
	- nin- before d, j, z, zh, g
	- nid- before vowels

- gi(d)-
	- gi- before consonants
	- gid- before vowels

- o(d)-
	- o- before consonants
	- od- before vowels

- *o-to-oo-lengthening:* If a stem starting with "o" is immediately preceded by a prefix, lengthen "o" to "oo" (and epthensize the "d" on the prefix like normal). 

### SUMMARY OF SUFFIX RULES

Note: These rules are often crucially ordered! We have indicated when that is the case.

- _d-deletion:_ Delete stem-final "d" when the suffix complex starts with a consonant.

- _Nasal assimilation:_ With stems ending in "m" (e.g. VAI stems "minongwaam"), the "m" changes to "n" when the suffix complex starts with "z" (negation) or a "g" (3SgProx in the conjunct)

- *aw-to-aa:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g".

- *aw-to-oo:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *w-to-o:* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1)". AKA, wi -> o / C __
	- This rule MUST PRECEED the "ShortV-deletion" rule

- *i1-Palatalization:* Stems ending in "n" palatalize to "zh" and "s" to "sh" when the suffix complex starts with the first person theme sign "i1".
  	- This rule MUST PRECEED the "ShortV-deletion" rule

- _ShortV-deletion:_ Delete word-final short vowels
	- This rule MUST PRECEED the "w-deletion" rule
	- This role MUST FOLLOW i1-Palatalization and w-to-o

- _W-deletion:_ Delete word-final "w" (occurs with neutral, positive 3sg)
	- This rule MUST FOLLOW the "ShortV-deletion" rule

### OLD RULES (defunct)

**M-deletion & vowel lengthening**

Stem-final "m" is deleted and the vowel "a" is elongated to "aa" when the suffix complex starts with "m" or "n" (as in TI -am stems like "waabandam"; VAI2 -am stems "zaaga'am")

**M-assimilation & vowel lengthening**

With stems ending in "m", so both -am and -m stems (VAI stems "minongwaam" and "zaaga'am"; VTI stem "waabandam"), the "m" changes to "n" when the suffix complex starts with "z" (negation) or a "g" (3SgProx in the conjunct)

**w-to-o (REPLACED ON JUNE 29, 2023)**

For TA stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with a consonant.

**W-deletion**

Delete word-final "w" (as in "gimizh", 2sg>1sg neutral positive)
