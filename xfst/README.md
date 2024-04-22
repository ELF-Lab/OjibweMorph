# Special characters

There are seven special characters:
*	i1, the first person "theme sign" (marking a first person object with the subject is also a first person), which is used to trigger palatalization in certain VTAs (see VTA notes with quotes from Rand Valentine).
*	This is the same as "i2" in the Bowers et al (2017) FST for Odawa
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

The person prefixes, especially the first person prefix, show a lot of variation. We'll want to account for all of it in the parser so we can get coverage, but limit outputs when generating. Variation is due to phonology to some degree, but also dialect and speech rate. This is the only preverb being modelled in this part of spreadsheets, since it is part of the verbal inflection proper.

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

# Suffix Rules

- _y2-deletion:_ Always delete y2

- _d-deletion:_ Delete stem-final "d" when the suffix complex starts with a consonant.

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
	- MUST FOLLOW _ShortV-deletion_

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