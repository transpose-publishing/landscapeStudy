## Missing publishers
In the filtered file publishers are missing. This is because sometimes the third
row has of a journal has no info on publishers. Simply taking the first would be
incorrect. Someone would need to go over this again.

- in general there is some missing data -> see RNotebook.

# Recoding publishers
Publishers could be unified for several reasons. 
- Some journals are published by a big house (Springer, Wiley) in cooperation 
with a subject area association (like with SAGE/American Sociological 
Association, Wiley & American Finance Association (AFA)).
  -> one could simplify by publisher
  -> possible would be also to create a new category about whether the journal
  is published or co-published by a subject association.
  
  -> for starters, I just fix typos and leave the rest to be decided.
  
  -> sounds interesting -> lets do it
  
  
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

  -> add them by hand (look at journal, come up with suggestion -> cross check
  afterwards)


# Contrasting with h-index
- not sure how meaningful that would be, since the distribution of h-indices is
heavily influenced by the sample. 
- would only make sense within one discipline, but then we only have 20 cases.
- Multilevel modeling as descriptive model?
  -> this is probably too crazy.
- with what would we correlate the h-index? if the policy is clear or not?


Tony: presumably higher impact journals have more ressources, but maybe they make
more money and thus dont need open policies.

-> crossref for landscape study with general database.


# Data from CrossRef
- get an n for the journal: this is possible. would make sense to limit to 
specific years (for ex. 2017-2018, or five years), because it would otherwise
    - take a long time
    - be not helpful, since year coverage might vary.
- Citations? This is essentially the same as h-index, just decomposed into single
articles. would suffer the same fate.


# Missing data questions
What about column AC? (coreview Policy)
rows 24 and 27 are not clear.

apart from those rows, in most instances data can be copied two rows down


# Diffing two csv files
```r
# diffing can be done via:
# git diff --color-words="[^[:space:],]+" *after*
# git diff --color-words="[^[:space:],]+" 16ad54bf e1e2b554
# git diff --no-index --color-words="[^[:space:],]+" before_manual_fixing.csv after_manual_fixing.csv
# the last one is not very helpful since quoting changes a lot of things...
# --no-index is needed, since these are two uncommited files
```

# Moving from ecxel data to gs data
Tony will check once more, if there is a more recent file. There are still 
errors to fix in the columns `opr-reports` and one in `opr-responses`.

The move from excel to googlesheet data lead to two co-review policies being
lost, furthermore the graph on preprint policies is changed, thus implying
a potential loss here as well. The loss is most likely due to errors that had
already been fixed now being "unfixed" again. Should be solved by a proper 
data source. Otherwise the following variables should be inspected:
`coreview_policy` and `preprint_servers`. 

There is actually a much bigger issue: copying the data led to fields landing in
the wrong column. The data in the GS is thus not usable.


# Highlighting missing data

I created a new excel file (a simple copy of the original) where I highlighted
problems in the following columns:

- pr-database DONE
- opr-reports DONE
- opr-responses DONE
- preprint-citation DONE

The correct count of missings can be counted as such:

```
refined %>% 
  select(pr_database, opr_reports, opr_responses, coreview_policy, 
         preprint_citation) %>% 
  summarise_all(~sum(is.na(.)))
# # A tibble: 1 x 5
# pr_database opr_reports opr_responses coreview_policy preprint_citation
#       <int>       <int>         <int>           <int>             <int>
#           5           3             1              70                10
```

I checked my highlights and they fit (now) with those counts.

Thus coreview_policy has still many missings.

Primary source is now: "TRANSPOSE landscape study - round 3"


# Category system
For open peer review, it is unclear to me what the difference between "No" and
"not specified" is. In some instances, it is meaningful (in case of reviewer
identities being revealed to the authors this is fine, since a "No" is more or
less equal to single blind peer review. In that sense, this question is not
very interesting, since it is an approximate translation on the question of
peer review. It is also unclear, why the social sciences have such a big 
proportion of "Not specified", since above they mainly are identified as having
double blind peer review. Thus it should be obviously in majority "No", unless
the addendum "even if not published" leads coders to mark it as unclear. 
The question thus is not clear, involving two distinct aspects:

- Are reviewer identities revealed to the author in general?
- Are they revelead if the paper is not published?

The former should be clearly no for the social sciences (double blind), the 
latter might be rightfully "not specified".)


Besides this disgression: for questions like "is there public commenting during
formal peer review?" the difference between "no" and "not specified" is unclear.
"not specified" in this case is simply a special type of "no", with no 
meaningful explanation (to me) how a "no" is different from "not specified". 
Usually those policies wouldn't explicitly state, that they are not doing 
something that exists. 


# Follow up on N of articles via crossref
Idea: scatter plot of h5 index vs. number of articles. This could go in the 
first section as a general overview of the sample. Depending on the result, this
could be used as principle of division for the rest of the paper. But I
suspect it to be not meaningful.

Querying all journals from crossref would take approx. 8 hours.

