# OjibweMorph Derivational Spreadsheets

:construction: This description is in progress :construction:

This folder houses the spreadsheets for derivational morphemes in Ojibwe. There are five column types:

* **Form:** The underlying form of the derivational suffix.
* **Tag:** The tag (analysis) that should be associated with the form.
* **InputParadigm:** The paradigm that a given derivational suffix can attach to.
* **InputClass:** The inflectional class that a given derivational suffix can attach to.
* **OutputParadigm:** The paradigm that a given derivational suffix creates when it attaches.
* **OutputClass:** The inflectional class that a given derivational suffix creates when it attaches.

At present, we are only modeling three types of derivational morphemes: the augment suffix _-magad_, the reflexive suffix _-dizo_ and the reciprocal suffix _-di_. Each one has various allomorphs associated with it, and the phonological rules apply to get the correct surface form.

## Augment

The main thing here is that there are two basic types of "augment". One that is derivational, in that it takes a VAI input and makes a VII. This can happen with all of the VAI types. The true augment can only appear on VII_VV or VII_V stems (citation needed here). It is derivational, but just takes a VII and makes another VII of a different class. Its function is not currently well understood in this context.

## Reflexive/reciprocal

There are a number of rules that end up applying to get the right result here.

* _nasalAssimilation_: Applies to VTA_C stems, so m -> n as in waabam+dizo = waabandizo.
* _iInsertion:_ Applies to VTA_C stems ending in a glottal stop (e.g. baapi'idizo), n (e.g. aabitoojiinidiwag), w (e.g. wiijiiwidi), or s (because of gikas).
* _woRule_: Applies to VTA_Cw, as in aaba'w+idzio = aaba'odizo.
* _awaaRule_: Appliues to VTA_aw, where we get these the aw turning to aa before "dizo", as in mikaw+dizo = mikaadizo.