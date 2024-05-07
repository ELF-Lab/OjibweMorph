# Special characters

There are seven special characters:
*	i1, the first person "theme sign" (marking a first person object with the subject is also a first person), which is used to trigger palatalization in certain VTAs (see VTA notes with quotes from Rand Valentine).
       *	This is the same as "i2" in the Bowers et al (2017) FST for Odawa
*	i2, the vestigial "inanimate singular" marker that appears in inanimate "short" stems. Resists _ShortV-Deletion_ and triggers palatalization of s1.
*	a1, the vestigial "animate singular" marker that appears in animate "short" stems. Resists _ShortV-Deletion_.
*	n1, the special "changable N" that palatalizes before i1
 	*	This is the same as "n1" in the Bowers et al (2017) FST for Odawa
*	s1, the special "changable S" that palatalizes before i1
 	*	This is the same as "s1" in the Bowers et al (2017) FST for Odawa
*	w1, the independent order third person agreement that is usually deleted, and opaquely blocks short vowel deletion
 	*	This is the same as "w5" in the Bowers et al (2017) FST for Odawa
*	V1, triggers vowel lengthening with certain preterit and delayed imperative forms in the VAIs.
*	y2, appears in Cy noun class stems and is always deleted
*	w2, appears at the end of VV, VVw, Vw, and both regular and irregular Cw noun class stems and is deleted unless the suffix complex starts with non-back vowels (a, aa, i, ii, and e)

# Prefix rules

## Person prefix rules

The person prefixes, especially the first person prefix, show a lot of variation. We'll want to account for all of it in the parser so we can get coverage, but limit outputs when generating. Variation is due to phonology to some degree, but also dialect and speech rate. These rules apply to both verbs and nouns (the person prefix appears in possessed nouns).

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
	- nind-/ind-/nd- OR nid- before vowels
		- At Red Lake, we get niy- before aa

- Second Person
	- gi- before consonants
	- gid- before vowels

- Third Person
	- o- before consonants
	- od- before vowels

In short, ni- can in principle appear before any consonant. Otherwise, the nim-/nin-/nind- allomorphs can lack the initial "n" deriving im-/in-/ind- (whether this is used is primarily a matter of dialect variation), and these can be further subjected to a vowel deletion process deriving m-/n-/nd- (which is primarily a matter of speech rate, I think). Then, sometimes nid- appears before vowels. The second and third person prefixes are generally easier to model, as they just have d-epenthesis before vowels and take the form that lacks a final d before consonants.  

The person prefixes also trigger a lengthening process:

- *o-to-oo-lengthening:* If a stem/preverb starting with "o" is immediately preceded by a person prefix, lengthen "o" to "oo" (and the "d" form of prefix shows up, like normal).

Sources:
- https://ojibwegrammar.langsci.wisc.edu › Assets › Pdfs › InflAnishPersonPrefixes1.02.pdf
- https://ojibwe.lib.umn.edu/main-entry/im-pf
- https://ojibwe.lib.umn.edu/main-entry/g-pf

## Tense Rules

There is an allomorphic alternation in tense based on whether or not a person prefix is present:

- *ga-to-da:* The definitive future marker in the independent order is ga-, unless there is no person prefix, in which case it appears as da-

Certain tenses trigger a phonological process that requires a bit of background on the phonology of the language. There is a distinction known as the lenis/fortis contrast, which is indicated by the use of voiced/voiceless consonants. The "lenis" consonants are prototyically written as "b", "d", "j", "g", "z", and "zh", but in some contexts are "devoiced"/"strengthened"/"tensed" to "p", "t", "ch", "k", "s", and "sh" respectively. In contrast, fortis consonants are invariably written as "p", "t", "ch", "k", "s", and "sh.

- *tense-tensing:* Lenis consonants ("b", "d", "j", "g", "z", "zh") are strengthened to the fortis counterpart ("p", "t", "ch", "k", "s", "sh") following the past tense preverbs (gii-/gii'-) and desiderative future tense preverbs (wii-/wii'-).

The rule is meant to be quite broad, triggering this process not only on stems that follow the relevant tense marker, but also preverbs. It is also worth noting that this is the type of thing that might not *always* be reflected in the orthography, so probably we want to allow some fuzziness when parsing. But in the "standard" orthography of the OPD, this is always reflected. Finally, this is specific to these morphemes, not any preverb that ends in "ii". For example, "maajii-" meaning "start" does not trigger the rule.

*Citation*: See Nichols (1980, pg. 129) *Ojibwe Morphology*, PhD Dissertation, Harvard University for a version of the rule here.

# Suffix Rules

Almost suffix rules target just processes occuring at the stem/suffix juncture, the only part of the phonology that we absolutely need to model. Some rules only end up applying in the verbal or nominal paradgims.

- _y2-deletion:_ Always delete y2

- _Nasal assimilation:_ With stems ending in "m", the "m" changes to "n" when the suffix complex starts with "z", "g", or "d".

- *aw-to-aa:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g" or "k".

- *aw-to-oo:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *w-to-o:* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1". AKA, wi -> o / C __
	- MUST PRECEED _ShortV-deletion_
	- In Border Lakes, this rule only applies with non-word-final "Cwi" sequences. For example, we get "mizhwi" rather than "mizho" for the imerative form.

- *i1-Palatalization:* Stems ending in "n1" palatalize to "zh" and "s1" to "sh" when the suffix complex starts with the first person theme sign "i1".
  	- MUST PRECEED _ShortV-deletion_

- _ShortV-deletion:_ Delete word-final short vowels in multi-syllabic words or mono-syllabic words with a long vowel (preseve the short vowel in mono-syllabic words with a short vowel, e.g. "makwa").
	- MUST PRECEED _w1-deletion_, _w2-deletion_, and _y-deletion_
	- MUST FOLLOW _i1-Palatalization_ and _w-to-o_

- _w1-deletion:_ Delete word-final "w1"
	- MUST PRECEDE _d-deletion_
  	- MUST FOLLOW _ShortV-deletion_

- _d-deletion:_ Delete stem-final "d" when the suffix complex starts with a consonant.
 	- MUST FOLLOW _w1-deletion_

- _w2-deletion:_ w2 deletes word finally, before consonants, before vowels "o", before "oo", and before "V1" (so remains before vowels a, aa, i, ii, and e)
	- MUST PRECEDE _ShortV-Lengthening_
	- MUST FOLLOW _ShortV-Deletion_

- _ShortV-lengthening:_ a short vowel to the left of v1 lengthens (so i -> ii / _ v1, a -> aa / _ v1, o -> oo / _ v1)
	- MUST FOLLOW _w2-Deletion_

- _y-to-h:_ Turn y into h if it follows a long vowel + n sequence at the end of a word (y -> h / VVn_#)
	- This handles some stems that are encoded inconsistently in the OPD; a purely orthographic rule.

- _y-deletion:_ Delete y at the end of words (y -> 0 / _ #)
	- MUST PRECEDE _h-deletion_
	- MUST FOLLOW _ShortV-Deletion_ and _y-to-h_

- _h-deletion (OPTIONAL!):_ Optionally delete h between n and y (h -> 0 / n_y)
	- MUST FOLLOW _y-deletion_
	- Optional, only because sometimes the spelling convention of deleting that "h" is done inconsistently.
