---
title: "Analysis Writeup"
author: "Thomas Klebel"
date: "7/2/2019"
output: 
  bookdown::html_document2:
    number_sections: false
    keep_md: true
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
prevalent in the sciences.

<div class="figure">
<img src="12-analysis-writeup_files/figure-html/peer-type-1.png" alt="Type of peer review used"  />
<p class="caption">(\#fig:peer-type)Type of peer review used</p>
</div>




When it comes to recognition of peer review activity, only 11% of
all journals deposit reviewer activity into open datdabases. On the other hand,
the majority of journals (81%) does not state at all, whether peer 
review activity is deposited in any kind of database, open or not. 

# Open Peer Review


Information on open peer review is similarly sparse (see fig. \@ref(fig:opr)). 
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




