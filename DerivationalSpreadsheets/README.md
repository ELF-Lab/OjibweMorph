# OjibweMorph Derivational Spreadsheets

This folder houses the spreadsheets for derivational morphemes in Ojibwe. There are five column types:

* **Form:** The underlying form of the derivational suffix.
* **Tag:** The tag (analysis) that should be associated with the form.
* **InputParadigm:** The paradigm that a given derivational suffix can attach to.
* **InputClass:** The inflectional class that a given derivational suffix can attach to.
* **OutputParadigm:** The paradigm that a given derivational suffix creates when it attaches.
* **OutputClass:** The inflectional class that a given derivational suffix creates when it attaches.

At present, we are only modeling a handful of derivational morphemes: the augment suffix _-magad_, the reflexive suffix _-dizo_, the reciprocal suffix _-di_, and the deverbal adverb suffix *-ng*. Most have various allomorphs, and there are phonological rules that apply to get the correct surface form.

## Augment

The main thing here is that there are two basic types of "augment". One that is derivational, in that it takes a VAI input and makes a VII. This can happen with all of the VAI types, and for speakers that have the morpheme, it is productive. 

The true augment can only appear on VII_VV or VII_V stems. It is derivational, but it simply takes a VII and makes another VII of a different inflectional class. Its function is not currently well understood in this context.

There is one phonological rules that applies to get the final surface form:

- *LengthenV*: Applies to VII_V and VAI_V. Makes the existing short vowel at the end of those stems long (e.g. the VAI *ikido* becomes a VII *ikidoomagad*)

## Reflexive/reciprocal

Reflexive and reciprocal forms take a VTA and turn it into a VAI for the purposes of inflection. However, these differ from most other VAIs in our set, since they imply an object. The object is just always the exact same as the subject. For example, *niwaabandiz* translates to "I see myself", where both the subject and object are both first person. This set therefore takes a VTA of any sort, and creates a stem with the class VAI_rcp or VAI_rfx.

Besides some hard-coded allomorphy, there are a number of rules that end up applying to get the right result here:

* _nasalAssimilation_: Applies to VTA_C stems, so m -> n as in waabam+dizo = waabandizo.
* _iInsertion:_ Applies to VTA_C stems ending in a glottal stop (e.g. baapi'idizo), n (e.g. aabitoojiinidiwag), w (e.g. wiijiiwidi), or s (because of gikas).
* _woRule_: Applies to VTA_Cw, as in aaba'w+idzio = aaba'odizo.
* _awaaRule_: Applies to VTA_aw, where we get these the aw turning to aa before "dizo", as in mikaw+dizo = mikaadizo.

## Locative deverbal adverbs

This process appears to only apply to VII_VV stems, with the additional semantic restriction of applying to VIIs that describe natural features in particular. This process takes a VII and, for all intents and purposes, makes it a locative adverb. In the OPD, this process is not necessarily described in this way--it is instead treated as a so-called locative VII--but simply treating these forms as an adverb seems to be a reasonable analysis of the state of affairs.

No additional phonological need apply in these cases. The form is fully concatenative. For example, *azhashkiikaa* "there is (a lot) of mud" can create a locative adverb *azhashkiikaang* "in the mud". 