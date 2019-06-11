## Missing publishers
In the filtered file publishers are missing. This is because sometimes the third
row has of a journal has no info on publishers. Simply taking the first would be
incorrect. Someone would need to go over this again.

# Recoding publishers
Publishers could be unified for several reasons. 
- Some journals are published by a big house (Springer, Wiley) in cooperation 
with a subject area association (like with SAGE/American Sociological 
Association, Wiley & American Finance Association (AFA)).
  -> one could simplify by publisher
  -> possible would be also to create a new category about whether the journal
  is published or co-published by a subject association.
  
  -> for starters, I just fix typos and leave the rest to be decided.
  
  
# Subject areas
Some journals (30) have no subject area. This is because the levels of h-indices
differ widely across disciplines. Thus, some top 30 journals are also included 
in the overall top 100 list, whereas for example in the social sciences all top
20 journals are not in the top 100, since their h-index is too low.

Should we try to enrich this data, so we can use all journals when splitting by
discipline? 
 -> in my opinion it would make sense.
 Question: where to get the category from, since it is afaik not possible to
 directly search in GS for the journal.


# Contrasting with h-index
- not sure how meaningful that would be, since the distribution of h-indices is
heavily influenced by the sample. 
- would only make sense within one discipline, but then we only have 20 cases.
- Multilevel modeling as descriptive model?
  -> this is probably too crazy.
- with what would we correlate the h-index? if the policy is clear or not?


# Data from CrossRef
- get an n for the journal: this is possible. would make sense to limit to 
specific years (for ex. 2015-2018, or five years), because it would otherwise
    - take a long time
    - be not helpful, since year coverage might vary.
- Citations? This is essentially the same as h-index, just decomposed into single
articles. would suffer the same fate.
