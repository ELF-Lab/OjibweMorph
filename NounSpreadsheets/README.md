# Noun Spreadsheets

## Contents

- [Noun Spreadsheets](#noun-spreadsheets)
	- [Contents](#contents)
	- [General Information](#general-information)
		- [Special characters](#special-characters)
		- [Description of Tags](#description-of-tags)
			- [Spreadsheet columns](#spreadsheet-columns)
			- [Paradigm](#paradigm)
			- [Class](#class)
			- [PossPers](#posspers)
			- [Dim](#dim)
			- [Poss](#poss)
			- [Pej](#pej)
			- [Pret](#pret)
			- [Basic](#basic)
	- [Linguistic Details for Nouns](#linguistic-details-for-nouns)
		- [Noun Animate (NA)](#noun-animate-na)
		- [Noun Inanimate (NI)](#noun-inanimate-ni)
		- [Noun Animate Dependent (NAD)](#noun-animate-dependent-nad)
		- [Noun Inanimate Dependent (NID)](#noun-inanimate-dependent-nid)
	- [Stacking rules](#stacking-rules)
		- [Order of noun suffixes](#order-of-noun-suffixes)
		- [Restrictions on noun suffix combinations](#restrictions-on-noun-suffix-combinations)
		- [Sound changes between stacked suffixes](#sound-changes-between-stacked-suffixes)

## General Information

### Special characters

*	Double \>\> marks the stem/suffix juncture (or the end of the stem)
*	Double \<\< marks the prefix/stem juncture (or the start of the stem)
*	Single \> marks boundaries between suffixes outside of the stem (not yet used)
*	Single \< marks boundaries between prefixes outside of the stem (not yet used)
*	Null morphemes will NOT be added unless a rule needs to refer to them. So far there are no such rules.
*	There are seven special characters used in the nouns:
	*	V1, triggers vowel lengthening with certain preterit and delayed imperative forms in the VAIs.
	*	s1, the special "s" that palatalizes to "sh" under certain conditions. Here, triggered by "i2".
	*	y2, appears in Cy noun class stems and is always deleted
	*	w1, appears at the end of the obviative possessor suffix and blocks _shortV-deletion_
	*	w2, appears at the end of VV, VVw, Vw, and both regular and irregular Cw noun class stems and is deleted unless the suffix complex starts with non-back vowels (a, aa, i, ii, and e)
	*	i2, the vestigial "inanimate singular" marker that appears in inanimate "short" stems. Resists _ShortV-Deletion_ and triggers palatalization of s1.
	*	a1, the vestigial "animate singular" marker that appears in animate "short" stems, and also with NI_kana stems. Resists _ShortV-Deletion_.

### Description of Tags

#### Spreadsheet columns

All spreadsheets contain the following columns:

* **Paradigm:** Traditional Algonquianist split based primarily on animacy and the independent/dependent noun distinction. 
* **Class:** Phonological classes based on the sounds at the right edge of the stem. Change the shape of the suffix complex due to phonological processes at the stem-suffix boundary.
* **Lemma:** Each class within each order/paradigm combination is exemplified by at least one sample noun. The lemma is the "dictionary form" of the noun as taken from the OPD. This is usually either the singular form, but dependent nouns are preceded by "=" and followed by "-". Lemmas are also used for verb tags in the FST.
* **Stem:** The stem is the underlying form of the example noun. Unless otherwise indicated, we take the stem specified in the OPD. Sometimes, this is the same as the lemma. However, often it is distinct, as various phonological processes can intervene.
* **PersPoss:** The person/number associated with the possessor, if any.
* **Dim:** Whether noun is a diminuative, or not.
* **Poss:** Whether or not the special possessive marker is present.
* **Pej:** Whether or not the pejorative marker is present.
* **Pret:** Whether or not the preterit marker is present.
* **Basic:** A morpheme slot that alternates in obviation/number, locative marking, and vocative marking.
* **Form\#Surface:** The surface form of the example noun, after all phonological processes have been executed. The source for these forms is indated in a different column. Form1 is the attested or assumed form for Border Lakes, which all other forms are variants from other closely related dialects. Marked MISSING if a form is expected, but not yet attested in a source or extended with a GUESS. Surface forms are used to test the FST.
* **Form\#Split:** The part in brackets is a stand-in for any stem within that particular class. Only the pieces of the brackets are used by the model, which simply replaces the part in brackets with the relevant stem. The parts outside of the brackets is the "underlying" form the the prefixal (in the case of possessed nouns) and suffixal morphology. This is the form before any phonological rules have applied, and is what is directly used to build the FST.
* **Form\#Source**: The source for the surface form.

#### Paradigm

| Tag   | Description                         |
|-------|-------------------------------------|
| NA   	| Noun Animate          			  |
| NAD   | Noun Animate Dependent              |
| NI   	| Noun Inanimate         			  |
| NID   | Noun Inanimate Dependent 			  |

#### Class

Still need to add the dependent nouns:

| Tag     | Description                    |
|---------|--------------------------------|
| NA_C 	  | na consonant           		   |
| NA_Cw   | na consonant w          	   |
| NA_Cy   | na consonant y       		   |
| NA_irrCw| na irregular consonant w       |
| NA_VV   | na long vowel            	   |
| NA_VVny | na nasal long vowel      	   |
| NA_VVw  | na long vowel w        		   |
| NA_Vw   | na short vowel w        	   |
| NI_C 	  | ni consonant           		   |
| NI_Cw   | ni consonant w          	   |
| NI_Cy   | ni consonant y       		   |
| NI_VV   | ni long vowel            	   |
| NI_VVny | ni nasal long vowel      	   |
| NI_Vw   | ni short vowel w        	   |
| NI_aa   | ni aa-augment 		       	   |

#### PossPers

All tags end with "Poss" to indicate that they are the possessor of the noun.

| Our Tag        | Description                             |
|----------------|-----------------------------------------|
| 1Sg            | First person singular                   |
| Excl           | First person exclusive (excludes addressee) |
| Incl           | First person inclusive (includes addressee) |
| 2Sg            | Second person singular                  |
| 2Pl            | Second person plural                    |
| 3SgProx        | Animate third person singular proximate |
| 3PlProx        | Animate third person plural proximate   |
| 3SgObv         | Animate third person singular obviative |
| 3PlObv         | Animate third person plural obviative   |

#### Dim

| Tag   | Description                         |
|-------|-------------------------------------|
| Dim   | Diminuative                         |
| NONE  | Regular 	                          |

#### Poss

| Tag   | Description                         |
|-------|-------------------------------------|
| Poss  | Possessive                          |
| NONE  | Regular 	                          |

#### Pej

| Tag   | Description                         |
|-------|-------------------------------------|
| Pej   | Pejorative                          |
| NONE  | Regular 	                          |

#### Pret

| Tag   | Description                         |
|-------|-------------------------------------|
| Pret  | Preterit                         	  |
| NONE  | Regular 	                          |

#### Basic

| Tag   | Description                         |
|-------|-------------------------------------|
| Sg	| Singular (inanimate)                |
| Pl	| Plural (inanimate)                    |
| ProxSg| Proximate singular                  |
| ProxPl| Proximate plural                    |
| ObvSg | Obviative singular                  |
| ObvPl | Obviative plural 	                  |
| Loc   | Locative                            |
| Voc   | Vocative 	                          |

## Linguistic Details for Nouns

This section is devoted to detailing the paradigms and stem classes as intantiated in the model, as well as the phonological rules that are needed to derive the surface form from the split (underlying) forms. It follows most closely the classification system developed by John Nichols and Rand Valentine in the tradition of Algonquianist linguistics, which is also commonly used in educational settings.

### Noun Animate (NA)

| Tag       | Nichols/Valentine | Description                    | Example Lemmas 		 | Example Stems 	      |
|-----------|-------------------|--------------------------------|-----------------------|------------------------|
| NA_C 	    | Class 1A	   	    | na consonant (regular)    	 | "zhiishiib"	 		 | /zhiishiib/            |
| NA_ShortC | Class 1B	   	    | na consonant (short)      	 | "nika"	 			 | /nik/                  |
| NA_Cw     | Class 4A	   	    | na consonant /w/ (regular) 	 | "mitig"		 		 | /mitigw2/			  |
| NA_ShortCw| Class 4C	   	    | na consonant /w/ (short) 		 | "makwa"		 		 | /makw2/				  |
| NA_Cy     | Class 5A   	    | na consonant /y/ (regular)     | "asin"				 | /asiny2/				  |
| NA_irrCw  | Class 4B		    | na irregular consonant /w/     | "amik"				 | /amikw2/				  |
| NA_VV     | Class 2A		    | na long vowel            	   	 | "anishinaabe"		 | /anishinaabew2/		  |
| NA_VVny   | Class 1C		    | na nasal long vowel      	   	 | "giihoonh"			 | /giihoonhy1/			  |
| NA_VVw    | Class 2B		    | na long vowel /w/        		 | "ikwe"				 | /ikwew2/				  |
| NA_Vw     | Class 3		    | na short vowel /w/       	   	 | "inini"				 | /ininiw2/			  |
| NA_VVy    | N/A		    	| na long vowel /y/           	 | "akiwenzii"		 	 | /akiwenziiy1/		  |

- At present, there are no known cases of the animate Class 5B (shorter na consonant y stems). Nichols (2010) indicates that the word for "paddle" _abwi_ (/abwy2/) is animate for some speakers, but this variation is not represented in the OPD, so we do not attempt to model it.

- For all of the NA nouns that end in "w", we use a special character "w2" in order to capture the specific contexts where it deletes or surfaces, as captured by the _w2-deletion_ rule.

- The NA_Cy stems end in a special "y2", which always deletes via the _y2-deletion_ rule.

- The special character "V1", which triggers the _ShortV-Lengthening_ rule, occurs in the NA_Vw stems when the suffix complex begins with the possessive suffix, the personal suffixes, the locative suffix, or the diminuative suffix.

- The special character "a1" appears in the singular forms of the two "short" stems (Classes 1B and 4C). This resists deletion. Very few nouns fall into these classes.

- The "irregular plural" with stems ending in _-(i)gan_, which appears as _-(i)gaans_ rather than _-(i)ganens_ is handled by a phonological rule.


### Noun Inanimate (NI)

| Tag     	 | Nichols/Valentine | Description                    | Example Lemmas 		    | Example Stems 		 |
|------------|-------------------|--------------------------------|-------------------------|------------------------|
| NI_C 	  	 | Class 1A 		 | ni consonant (regular)         | "jiimaan"				| /jiimaan/		 		 |
| NI_ShortC  | Class 1B 	   	 | ni consonant (short)           | "mishi"					| /mis1/		 		 |
| NI_Cw   	 | Class 4A 		 | ni consonant /w/ (regular)     | "aniibiishibag"			| /aniibiishibagw2/		 |
| NI_Cy 	 | Class 5A	         | ni consonant /y/ (regular)     | "anit"					| /anity2/		 		 |
| NI_ShortCy | Class 5B  		 | ni consonant /y/ (short)   	  | "aki"					| /aky2/		 		 |
| NI_VV   	 | Class 2A		  	 | ni long vowel            	  | "ishkode"				| /ishkodew2/			 |
| NI_VVny 	 | Class 1C		  	 | ni nasal long vowel      	  | "wiiyagasenh"			| /wiiyagasenhy1/		 |
| NI_Vw   	 | Class 3		  	 | ni short vowel /w/        	  | "mashkiki"				| /mashkikiw2/			 |
| NI_aa    	 | Class 6		  	 | ni /aa/-augment 		       	  | "mashkimod"				| /mashkimod/			 |
| NI_kana    | N/A		  	 	 | ni -kana ending 		       	  | "miikana"				| /miikan/			 	 |

- At present, there are no known examples of inanimate Class 4C, a shorter inanimate consonant w stem. None are cited either in Nichols (2010) or turned up on a detailed search of the OPD.

- For all of the NI nouns that end in "w", we use a special character "w2" in order to capture the specific contexts where it deletes or surfaces, as captured by the _w2-deletion_ rule.

- The NI_Cy stems end in a special "y2", which always deletes via the _y2-deletion_ rule.

- The special character "V1", which triggers the _ShortV-Lengthening_ rule, occurs in the NI_Vw stems when the suffix complex begins with the possessive suffix, the personal suffixes, the locative suffix, or the diminuative suffix.

- The special character "i2" appears in the singular forms of the two "short" stems (Classes 1B and 5B). This resists deletion and triggers palatalization of s1 (the same as i1 does in many verb forms). Very few nouns fall into these classes.

- The words ending in "-kana" eaming "road, path" are treated in a special class, as they are irregular. We assume the underlying stem lacks the underlying final vowel, which is instead added in the inflection as the "a1" (non-deleting "a").

### Noun Animate Dependent (NAD)

| Tag     	 | Nichols/Valentine | Description                    | Example Lemmas 		    | Example Stems 		 |
|------------|-------------------|--------------------------------|-------------------------|------------------------|
| NAD_C		 |	Class 1A		 |	nad consonant (regular)		  |	"=naan-"				| /naan/				 |
| NAD_VVny	 |	Class 1C		 |	nad nasal long vowel		  |	"=daangosheny-"			| /daangosheny2/		 |
| NAD_VV	 |	Class 2A		 |	nad long vowel				  |	"=dawemaaw-"			| /dawemaaw2/			 |
| NAD_Vw	 |	Class 3			 |	nad short vowel /w/			  |	"=nishiw-"				| /nishiw2/				 |
| NAD_Cw	 |	Class 4A		 |	nad consonant /w/ (regular)	  |	"=niigi'igw-"			| /niigi'igw2/			 |
| NAD_Cy	 |	Class 5A		 |	nad consonant /y/ (regular)	  |	"=shkanzhy-"			| /shkanzhy2/			 |
| NAD_VVy    |  N/A		    	 |  nad long vowel /y/            | "=maamaa-"		 	    | /maamaay1/			 |

### Noun Inanimate Dependent (NID)

| Tag     	 | Nichols/Valentine | Description                    | Example Lemmas 		    | Example Stems 		 |
|------------|-------------------|--------------------------------|-------------------------|------------------------|
| NID_C		 |	Class 1A		 | na consonant (regular)		  | "=kaad-"				| /kaad/				 |
| NID_Cw	 |	Class 4A		 | na consonant /w/ (regular)	  | "=gidigw-"				| /gidigw2/			 	 |
| NID_Cy	 |	Class 5A		 | na consonant /y/ (regular)	  | "=disy-"				| /disy2/			 	 |
| NID_aa	 |	Class 6			 | ni /aa/-augment				  | "=denaniw-"				| /denaniw/			 	|


## Stacking rules

The overall approach we are taking means that we have hard-coded all possible "stacked" suffix forms rather than generating these forms from scratch. For example, an independent noun (e.g.\ _jiimaan_ "boat") can have just diminutive suffix (_jiimaanens_), just a plural suffix (_jiimaanan_), or can stack both (_jiimaanensan_). Both the individual and the stacked forms can be found in the spreadsheets. These stackings occur in a set order, can condition sound changes to forms between suffixes, and are subject to certain restrictions. This section gives a brief overview of the ordering and combinatorial restrictions, as well as some of the sound changes that occur between suffixes. 

### Order of noun suffixes

Noun stems show the following ordering restrictions:

| Person Prefix | STEM | Diminutive | Possessive | Pejorative | Person Suffix | Preterit | Basic |
|---------------|------|------------|------------|------------|---------------|----------|-------|
|   -1   		|   0  |   1   		|   2  	 	 |   3   	  | 4			  |	5		 |	6	 |

A few notes:

- In the spreadsheets, the Person Prefix + Person Suffix is respresented in a single column PossPers, since these two slots can be thought of as a circumfix (a single morpheme that appears on both sides of the stem).

- The Basic suffix is a single slot that can take one of six forms: ProxSg, ProxPl, ObvSg, ObvPl, Loc, and Voc. Therefore none of these suffixes can appear at the same time, as they "compete" for expression at the same location.


### Restrictions on noun suffix combinations

Beyond the restrictions based on "slot competition", the following retrictions are adopted:

- The Preterit and Vocative suffixes never appear together (Nichols 2010, pg. 33)
- The Preterit and Pejorative suffixes never appear together (assumption)
- Vocatives only appear in non-possessed nouns (assumption, since no possessed vocative forms have been observed)
- We assume that the Preterit and Locative suffixes never appear together (assumption)
- The Possessor (PossPers) and the noun cannot both be proximate; the noun must be obviative with a third person possessor (Nichols 2010).
- The Possessive Suffix (Poss) only appears (but is optional) in the presence of a possessor (PossPers) (Nichols 2010, p. 9).

### Sound changes between stacked suffixes

These rules are summarized and re-organized versions of the description of noun suffixation in Nichols (2010). They may not be exahustive of all the rules at play.

- The first person plural suffix =inaan loses its final n when a preterit or locative suffix immediately follows it (final n is preserved with number/obviation marking)

- The animate plural, inanimate plural, and obviative basic suffixes show up with an initial "i" rather than "a" after =inaan

- The animate plural (-ag), inanimate plural (-an), obviative singular (-an), obviative plural (-a'), and locative (-ing) basic suffixes lose their initial vowel if whatever is to the left ends in a vowel

- When a diminutive nouns also has a pejorative suffix, the diminutive suffix may change its s to zh; Pejorative nouns may undergo a change of some of the consonants in the stem when =(i)sh is added: an s or z near the end of the stem can change to zh.
	- This is s/z -> zh, rather than sh; so this is a different rule than palatalization seen with s1 and n1 in the verbs.
	- Some speakers will "unwind" this according to Nichols, so may be sort of optional in some cases.

- Following the preterit suffix -ban, the "a" in the animate plural (-ag), inanimate plural (-an), obviative singular (-an), and obviative plural (-a') turns to "ii" or "e"
	- really, "-ban" is probably underlyingly "-bany", so behaves like a Class 5 Cy stem would

- Inflection added after diminutive stems is generally the regular form; they are treated as a Class I stem, no matter what the class of the non-diminutive noun stem

- Other suffixes appear in the usual form for Class 1 (consonant) stems when immediately following the pejorative suffix, including the personal suffixes and the basic suffixes

- Other suffixes appear in the usual form for Class 1 (consonant) stems when immediately following the possession suffix
