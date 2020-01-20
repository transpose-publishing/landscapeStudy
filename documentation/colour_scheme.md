Color Schemes

Type of Peer review
- 5 Colors

Other and unsure (and not specified) could always be the same colors (some grayish)


Disciplines: 8 colors?

Three colors: yes, no, unsure


OPR: 6-7 categories

Coreviewers contribute: 4 - yes, no, unsure, not specified

Preprint version: 7 (incl. unsure)

Preprints can be cited: 6 (incl. not specified, unsure, other)

-----

All in all maximum 8 colours (for disciplines)

Disciplines could be the default one, or from RColorBrewer: Set1, maybe
Dark2 or Accent.

For real content: we need three colours: not specified, other, unsure.

Lets try out "Accent":
The three common classes will be the last colours:


`brewer.pal(8, "Accent")`
- not specified: "#F0027F"
- unsure: "#BF5B17"
- other: "#666666"

The other colours always take from front, depending on how many we need:

````
"#7FC97F" "#BEAED4" "#FDC086" "#FFFF99" "#386CB0"
```

NOPE! The yellow from Accent is too light for white background

Let's try Dark2:
`brewer.pal(8, "Dark2")`
"not specified" =  "#E7298A", "unsure" = "#A6761D", "other" = "#666666"

The other colours always take from front (without pink),
depending on how many we need:

````
"#1B9E77" "#D95F02" "#7570B3" "#66A61E" "#E6AB02"
```

There was still some problem with the brownish vs. the reddish colour. The new 
idea is to combine viridis with grey and brown, i.e. to keep "Unsure" and "Other"
but add the other colours. -> only 6 viridis colours which can be distinguished
easily, and which are fine in terms of colour blindness, except for monocromacy.

`c(viridis(n, option = "D"), "Unsure" = "#A6761D", "Other" = "#666666")`

````
# Violet                    Green                               Yellow         Unsure       Other 
# "#440154" "#414487" "#2A788E" "#22A884" "#7AD151" "#FDE725"   "#A6761D"   "#666666" 
````
