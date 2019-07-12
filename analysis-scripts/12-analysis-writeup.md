---
title: "Analysis Writeup"
author: "Thomas Klebel"
date: "7/2/2019"
output: 
  bookdown::html_document2:
    number_sections: false
    keep_md: true
bibliography: landscape.bib
---





# Subject areas
The approach taken to create the sample of journals led to a few journals 
having no data on subject area: some journals like "Gut" were within the top
100 journals, but not within any of the sub-categories. This is because the
h-index varies greatly between sub-categories, as can be seen from figure 
\@ref(fig:h-indices).

<div class="figure">
<img src="12-analysis-writeup_files/figure-html/h-indices-1.png" alt="Distribution of h5-index across disciplines"  />
<p class="caption">(\#fig:h-indices)Distribution of h5-index across disciplines</p>
</div>

To be able to include all journals for analysis that splits by discipline, the
missing categorisations were added afterwards. To this end, we scraped all 
disciplines and subdisciplines from GoogleScholar and matched those to our data.
^[The code for collecting the data from GoogleScholar can be found here:
ADD LINKS HERE TO DATA AND SCRIPT]

As stated, the criteria for inclusion into the GoogleScholar rankings are opaque
and non-reproducible. For example it is possible for a journal to be included in
different disciplines, which makes a lot of sense
(for example "Physics & Mathematics" along with 
"Engineering & Computer Science"). It is however also possible for a journal to
be included in a sub-discipline, and not in the parent discipline, despite 
having a higher h-index than all journals listed in the parten discipline.^[As
of 2019-07-02, the "Journal of Cleaner Production" is listed in the social 
sciences under "sustainable development"
(https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=soc_sustainabledevelopment). 
But it is not listed under the parent category 
(https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=soc).]





The nature of our selection means that 
22 out of 171 journals are assigned to two
disciplines. The inclusion criteria further mean, that disciplines are not 
represented equally in the sample. Since many of the top 100 journals belong to 
the health and medical sciences, the sample is slightly skewed in that direction
(see figure \@ref(fig:sample-skew)).


<div class="figure">
<img src="12-analysis-writeup_files/figure-html/sample-skew-1.png" alt="Sampled journals by discipline"  />
<p class="caption">(\#fig:sample-skew)Sampled journals by discipline</p>
</div>


# Peer Review


Information on what type of peer review is used by a journal is mixed 
(see figure \@ref(fig:peer-type)).
Overall, around 30% of all journals do not provide clear information
about their peer review process. However, there are major differences between 
disciplines. In the social sciences and humanities, double blind peer review is
more prevalent, and the proportion of unclear policies the lowest. Business,
Economics and Management, along with most disciplines from the sciences, display
higher levels of unclear policies, with single blind peer review being more 
prevalent in the sciences. Some journals also offer the option for authors to 
choose whether to use single or double blind peer review. These cases have been
coded as "Other" and amount to the majority of this category. 

<div class="figure">
<img src="12-analysis-writeup_files/figure-html/peer-type-1.png" alt="Type of peer review used"  />
<p class="caption">(\#fig:peer-type)Type of peer review used</p>
</div>




When it comes to recognition of peer review activity, only 11% of
all journals deposit reviewer activity into open datdabases. On the other hand,
the majority of journals (81%) does not state at all whether peer 
review activity is deposited in any kind of database, open or not. 

# Open Peer Review


Information on open peer review is similarly sparse (see fig. \@ref(fig:opr)). 
<!--- Maybe write here about what aspects where surveyed. --->
All surveyed aspects of 
open peer review lack any kind of information in more than 50% of journals 
surveyed.
Furthermore, seven out of eight aspects are not specified in more than three 
quarters of all journals. When there is information, in most cases it is 
dismissive of open peer review. No journal in our sample allows public 
commenting during formal peer review. Other forms of openness are similarly 
scarce, with the only expection that some journals may reveal reviewer 
identities to the authors.

<div class="figure">
<img src="12-analysis-writeup_files/figure-html/opr-1.png" alt="Aspects of open peer review"  />
<p class="caption">(\#fig:opr)Aspects of open peer review</p>
</div>

Splitting the aspect of revealed reviewer identities by discipline shows a few
key distictions (see fig. \@ref(fig:opr-authors)). Whereas revealing reviewer
identities to the authors is absent from the social sciences, humanities and
business, it is not unusual in the sciences, at least on an optional basis 
(for example in case the referee requests it).


<div class="figure">
<img src="12-analysis-writeup_files/figure-html/opr-authors-1.png" alt="Open reviewer identities towards authors"  />
<p class="caption">(\#fig:opr-authors)Open reviewer identities towards authors</p>
</div>

# Co-Review Policy

Information on coreview policies is sparse. 
Only 87 out of 171 journals do have an
explicit coreview.

Splitting the results by discipline
reveals noticable differences (see fig. \@ref(fig:co-rev)).
While in the life and earth sciences more
than one third of journals permit contributions from co-reviewers, in the 
humanities, chemical & materials sciences, and in business, economics & 
management about 90% of journals have no policy on co-reviewing.

<div class="figure">
<img src="12-analysis-writeup_files/figure-html/co-rev-1.png" alt="Prevalence of co-review"  />
<p class="caption">(\#fig:co-rev)Prevalence of co-review</p>
</div>


To obtain a more nuanced view of the policies' contents, we also analysed their
full text via text mining. Due to policies being similar across journals of 
certain publishers, there are 45
distinct policies in our dataset (compared to 87 
policies in total). Since the policies are rather short, we are 
somewhat limited in regard to what insight we can gain from automated 
procedures.




To extract meaningful information we first removed common words of the english
language (via the list of stopwords from the tidytext package
[@silge_tidytext_2016], except for the word "not", which is relevant since some
policies state, that it is *not* appropriate to share information with students
or colleagues). The resulting list contains 1151 words in 
total. 

For a simple overview, the words were stemmed to reduce similar but not 
identical versions of certain words (like editor/editors).
The following table displays the most frequent parts of the distinct policies,
sorted by propensity.

word            n
-----------  ----
review        135
manuscript     53
editor         44
confidenti     34
not            30
inform         25
colleagu       21
involv         17
journal        17
consult        15
discuss        15
disclos        14
permiss        14
student        14
author         13
peer           13
process        12
ensur          11
obtain         11
person         11

The most prominent themes that emerge are:

- Individuals with varying stakes regarding peer review: editor, colleague, 
author, student, peer
- Confidentiality as a central principle
- Important elements of scholarly publishing: manuscript, journal, review, 
process
- Verbal forms pertaining to relationships between the individuals: inform,
involve, consult, discuss, disclose, ensure, obtain

These directions become more intelligible when we look at bigrams (see fig.
\@ref(fig:bigrams)). With this procedure the text is
split into pairs of words (for example the sentence "All humans are equal" 
becomes "All humans", "humans are", "are equal"). The most prominent bigrams 
where "peer -> review" and "review -> process". To take a look at the strength 
of other associations, the term "review" was removed from the figure.


<div class="figure">
<img src="12-analysis-writeup_files/figure-html/bigrams-1.png" alt="Bigrams of co-review policies"  />
<p class="caption">(\#fig:bigrams)Bigrams of co-review policies</p>
</div>

From both displays it is obvious, that journals stress the importance of 
"maintaining confidentiality", by "not shar[ing]" or disclosing information,
neither to "junior researchers", "laboratory colleagues" nor "graduate 
students". Even if the policies do not explicitly forbid or allow the 
involvement of other researchers, in many cases they mandate the reviewer to 
first obtain permission from the editor in case they want to involve someone
else in their review. The editor's prominent role can also be observed by the 
terms frequent appearance in the policies. Almost three quarters of all policies
contain the term "editor". 





# Preprints



Preprints are more common within our sample than open peer review or co-review
policies. Almost
70.0%
of all journals allow preprints at least in some way. Most of them however only
allow preprints before peer review 
(39.0%)
while 
23.0%
do not have a preprint policy.


<div class="figure">
<img src="12-analysis-writeup_files/figure-html/preprint-version-1.png" alt="Allowed preprint versions"  />
<p class="caption">(\#fig:preprint-version)Allowed preprint versions</p>
</div>

Similar to our earlier results, preprint policies show a wide disciplinary 
range (see fig. \@ref(fig:preprint-version). While in the life sciences & earth 
sciences 
90.0%
of all journals allow preprints in some way, in the Humanities only 
45.0%
do.
The Sciences in general tend towards allowing preprints only on first submission
while the social sciences commonly have no clear policy on which version of a
preprint is allowed. 
The humanities and also journal from business, economics and management 
generally have either no preprint policy at all or are more diverse in regard to
preprint version, often allowing preprints after peer review, which is a lot 
less common in the sciences.




A complementary aspect of using preprints is, whether they can be cited. The
majority of journals
(57.0%)
does not specify, whether this is possible. Unclear policies are also quite 
common (15.0%). In case
citations of preprints are allowed, this is commonly possible in the reference,
with some journals restricting citations of preprints to the text.


<div class="figure">
<img src="12-analysis-writeup_files/figure-html/preprint-citation-1.png" alt="Citation of preprints"  />
<p class="caption">(\#fig:preprint-citation)Citation of preprints</p>
</div>

Disciplinary differences are again very apparent (see fig.
\@ref(fig:preprint-citation)). Citing preprints is more common in the sciences,
with 
50.0%
of all journals in the life and earth sciences allowing citations to preprints
either in the text or in the reference list. In contrast, the social sciences 
and humanities either have unclear or no policies regarding whether preprints 
can be cited or not. 


# Bibliography

