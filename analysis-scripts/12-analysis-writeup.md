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

The inclusion criteria further mean, that disciplines are not represented 
equally in the sample. Since many of the top 100 journals belong to the health
and medical sciences, the sample is slightly skewed in that direction (see 
figure \@ref(fig:sample-skew)).


<div class="figure">
<img src="12-analysis-writeup_files/figure-html/sample-skew-1.png" alt="Sampled journals by discipline"  />
<p class="caption">(\#fig:sample-skew)Sampled journals by discipline</p>
</div>



