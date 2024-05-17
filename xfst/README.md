# Special characters

There are ten special characters:
*	i1, the first person "theme sign" (marking a first person object with the subject is also a first person), which is used to trigger palatalization in certain VTAs (see VTA notes with quotes from Rand Valentine).
       *	This is the same as "i2" in the Bowers et al (2017) FST for Odawa
*	i2, the vestigial "inanimate singular" marker that appears in inanimate "short" stems. Resists _ShortV-Deletion_ and triggers palatalization of s1.
*	a1, the vestigial "animate singular" marker that appears in animate "short" stems. Resists _ShortV-Deletion_.
*	V1, triggers vowel lengthening with certain preterit and delayed imperative forms in the VAIs.
*	n1, the special "changable N" that palatalizes before i1
 	*	This is the same as "n1" in the Bowers et al (2017) FST for Odawa
*	s1, the special "changable S" that palatalizes before i1
 	*	This is the same as "s1" in the Bowers et al (2017) FST for Odawa
*	w1, the independent order third person agreement that is usually deleted, and opaquely blocks short vowel deletion
 	*	This is the same as "w5" in the Bowers et al (2017) FST for Odawa
*	w2, appears at the end of VV, VVw, Vw, and both regular and irregular Cw noun class stems and is deleted unless the suffix complex starts with non-back vowels (a, aa, i, ii, and e)
* 	y1, appears in VVy and VVny stems and is deleted at the end of words only
*	y2, appears in Cy noun class stems (regular and short) and is always deleted

# Prefix rules

## Person prefix rules

The person prefixes, especially the first person prefix, show a lot of variation. We'll want to account for all of it in the parser so we can get coverage, but limit outputs when generating to be tuned to a specific dialect. Variation is due to phonology to some degree, but also dialect and speech rate. These rules apply to both verbs and nouns (the person prefix appears in possessed nouns).

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

This is captured by the following rules on verbs:

- _PrefixDInsertion_: insert d at the end of the person prefix if whatever appears to the right starts with a vowel (derive nid-, gid-, od-)
- _PrefixNDInsertion_: Optionally insert "n" between "ni" and "d" (derives "nind-")
- _PrefixDDeletion_: Optionally delete "d" at the end of "nind" (derives "nin-")
- _PrefixIND_: Optionally turn "nid" to "ind" and "nd" (derices "ind-" and "nd")
- _PrefixMInsertion_: Optionally insert "m" after "ni" if whatever appears to the right starts with "b" (derives "nim-")
- _PrefixNInsertion_: Optionally insert "n" after "ni" if whatever appears to the right starts with "d", "j", z", "zh", or "g".

In dependent nouns, the rules are a little different. For the first and second person prefixes, we get "n" and "g" before vowels, and "gi" and "ni" before consonants. The third person prefix alternates between "w" before "ii", "o" before consonants, and null before "oo". The following rules account for this:

- _DepPrefixIInsertion_: Insert "i" after "n" or "g" if whatever to the right is a consonant (derives "ni" and "gi")
- _DepPrefixWtoO_: change "w" to "o" if whatever to the right is a consonant (derives "o")
- _DepPrefixWDeletion_: delete "w" if whatever to the right starts with "o" or "oo" (derives null third person prefix)

The person prefixes in the verbs in particular also trigger a lengthening process:

- *prefixOLengthening:* If a stem/preverb starting with "o" is immediately preceded by a person prefix, lengthen "o" to "oo" (and the "d" form of prefix shows up, like normal).

Sources:
- https://ojibwegrammar.langsci.wisc.edu › Assets › Pdfs › InflAnishPersonPrefixes1.02.pdf
- https://ojibwe.lib.umn.edu/main-entry/im-pf
- https://ojibwe.lib.umn.edu/main-entry/g-pf

## Tense Rules

There is an allomorphic alternation in tense based on whether or not a person prefix is present:

- *ga-to-da:* The definitive future marker in the independent order is ga-, unless there is no person prefix, in which case it appears as da-

Certain tenses trigger a phonological process that requires a bit of background on the phonology of the language. There is a distinction known as the lenis/fortis contrast, which is indicated by the use of voiced/voiceless consonants. The "lenis" consonants are prototyically written as "b", "d", "j", "g", "z", and "zh", but in some contexts are "devoiced"/"strengthened"/"tensed" to "p", "t", "ch", "k", "s", and "sh" respectively. In contrast, fortis consonants are invariably written as "p", "t", "ch", "k", "s", and "sh.

- *tenseTensing:* Lenis consonants ("b", "d", "j", "g", "z", "zh") are strengthened to the fortis counterpart ("p", "t", "ch", "k", "s", "sh") following the past tense preverbs (gii-/gii'-) and desiderative future tense preverbs (wii-/wii'-).

The rule is meant to be quite broad, triggering this process not only on stems that follow the relevant tense marker, but also preverbs. It is also worth noting that this is the type of thing that might not *always* be reflected in the orthography, so probably we want to allow some fuzziness when parsing. But in the "standard" orthography of the OPD, this is always reflected. Finally, this is specific to these morphemes, not any preverb that ends in "ii". For example, "maajii-" meaning "start" does not trigger the rule.

*Citation*: See Nichols (1980, pg. 129) *Ojibwe Morphology*, PhD Dissertation, Harvard University for a version of the rule here.

# Suffix Rules

Almost suffix rules target just processes occuring at the stem/suffix juncture, the only part of the phonology that we absolutely need to model. Some rules only end up applying in the verbal or nominal paradgims.

- _y2Deletion:_ Always delete y2

- _nasalAssimilation:_ With stems ending in "m", the "m" changes to "n" when the suffix complex starts with "z", "g", or "d".

- *awaaRule:* For stems that end in "aw", the "aw" goes to "aa" when the suffix complex starts with "g" or "k".

- *awooRule:* For stems that end in "aw", the "aw" goes to "oo" when the suffix complex starts with "n" or "s".

- *woRule1, woRule2:* For stems that end in "Cw", the "w" goes to "o" when the suffix complex starts with an "i" or "i1". AKA, wi -> o / C __. In Border Lakes, this rule only applies with non-word-final "Cwi" sequences. For example, we get "mizhwi" rather than "mizho" for the imerative form.
	- MUST PRECEED _vowelDeletion_

- *n1Rule, s1Rule:* Stems ending in "n1" palatalize to "zh" and "s1" to "sh" when the suffix complex starts with the first person theme sign "i1" or inanimate singular marker "i2".
  	- MUST PRECEED _vowelDeletion_

- _vowelDeletion:_ Delete word-final short vowels in multi-syllabic words or mono-syllabic words with a long vowel (preseve the short vowel in mono-syllabic words with a short vowel, e.g. "makwa").
	- MUST PRECEED _w1Deletion_, _w2Deletion_, and _yDeletion_
	- MUST FOLLOW _n1Rule_, _s1Rule_, _woRule1_, and _woRule2_

- _w1Deletion:_ Delete word-final "w1"
	- MUST PRECEDE _dDeletion_
  	- MUST FOLLOW _vowelDeletion_

- _dDeletion:_ Delete stem-final "d" when the suffix complex starts with a consonant.
 	- MUST FOLLOW _w1Deletion_

- _w2Deletion:_ w2 deletes word finally, before consonants, before vowels "o", before "oo", and before "V1" (so remains before vowels a, aa, i, ii, and e)
	- MUST PRECEDE _LengthenV_
	- MUST FOLLOW _vowelDeletion_

- _LengthenV:_ a short vowel to the left of v1 lengthens (so i -> ii / _ v1, a -> aa / _ v1, o -> oo / _ v1)
	- MUST FOLLOW _w2Deletion_

- _y1hRule:_ Turn y1 into h if it follows a long vowel + n sequence at the end of a word (y1 -> h / VVn_#). This handles some stems that are encoded inconsistently in the OPD; a purely orthographic rule.
    - MUST PRECEDE _y1Deletion_

- _y1Deletion:_ Delete y1 at the end of words (y1 -> 0 / _ #)
	- MUST PRECEDE _hDeletion_
	- MUST FOLLOW _vowelDeletion_ and _y1hRule_

- _hDeletion (OPTIONAL!):_ Optionally delete h between n and y (h -> 0 / n_y). Optional, only because sometimes the spelling convention of deleting that "h" is done inconsistently.
	- MUST FOLLOW _y1deletion_

