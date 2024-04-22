# Noun Spreadsheets

## General

*	Double \>\> marks the stem/suffix juncture (or the end of the stem)
*	Double \<\< marks the prefix/stem juncture (or the start of the stem)
*	Single \> marks boundaries between suffixes outside of the stem (not yet used)
*	Single \< marks boundaries between prefixes outside of the stem (not yet used)
*	Null morphemes will NOT be added unless a rule needs to refer to them. So far there are no such rules.
*	There are three special characters used in the nouns:
	*	V1, triggers vowel lengthening with certain preterit and delayed imperative forms in the VAIs.
	*	y2, appears in Cy noun class stems and is always deleted
	*	w2, appears at the end of VV, VVw, Vw, and both regular and irregular Cw noun class stems and is deleted unless the suffix complex starts with non-back vowels (a, aa, i, ii, and e)

## Organization

### Description of Tags (Nouns)

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


## OTHER

Need to deal with "mishi", where the signular volwe is "i" rather than "a".

Need to deal with irregular diminutives in the VVny stem class.

## STACKING RULES

The first person plural suffix =inaan loses its final n when a preterit or locative suffix immediately follows it (final n is preserved with number/obviation marking)

The animate plural, inanimate plural, and obviative basic suffixes show up with an initial "i" rather than "a" after =inaan
	- This does not exactly match any of the noun classes.

The animate plural (-ag), inanimate plural (-an), obviative singular (-an), obviative plural (-a'), and locative (-ing) basic suffixes lose their initial vowel if whatever is to the left ends in a vowel
	- vowel hiatus rule

When a diminutive nouns also has a pejorative suffix, the diminutive suffix may change its s to zh; Pejorative nouns may undergo a change of some of the consonants in the stem when =(i)sh is added: an s or z near the end of the stem can change to zh.
	- probably, preterit is actually -i1sh, so triggers palatalization sort of like i1 does in verbs.
		- I have not seen any examples, though, of n palatalizing
		- Also, s/z -> zh, rather than sh; so this is a different rule
	- Might want this to be optional, since some speakers will "unwind" this according to Nichols.


Following the preterit suffix -ban, the "a" in the animate plural (-ag), inanimate plural (-an), obviative singular (-an), and obviative plural (-a') turns to "ii" or "e"
	- really, "-ban" is probably underlyingly "-bany", so behaves like a Class 5 Cy stem would

No Pret+Voc is allowed

Inflection of diminutive stems is generally regular; they are treated as a Class I stem, no matter what the class of the non-diminutive noun stem (Nichols 2010)

Other suffixes appear in the usual form for class 1 (consonant) stems following the pejorative suffix, including the personal suffixes and the basic suffixes (Nichols 2010)