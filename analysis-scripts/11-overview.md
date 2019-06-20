---
title: "Landscape Study - General Overview"
author: Thomas Klebel
date: Last changed 2019-06-19
output: 
  html_document:
    df_print: paged
    keep_md: true
---








# General overview
![](11-overview_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

There is quite some missing data, which shouldn't be like this. For example
the field U30 in excel (table RAW), which has the opr-responses for the journal
"Advanced Materials" is missing. It should probably be "Not specified".

The following are all variables, where implicit missings should be checked and
converted to explicit ones (as for opr_responses), or fixed (as for publishers).

![](11-overview_files/figure-html/unnamed-chunk-3-1.png)<!-- -->




# Peer Review



![](11-overview_files/figure-html/unnamed-chunk-5-1.png)<!-- -->


![](11-overview_files/figure-html/unnamed-chunk-6-1.png)<!-- -->






![](11-overview_files/figure-html/unnamed-chunk-8-1.png)<!-- -->






# Open Peer Review
![](11-overview_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

![](11-overview_files/figure-html/unnamed-chunk-10-1.png)<!-- -->



![](11-overview_files/figure-html/unnamed-chunk-11-1.png)<!-- -->![](11-overview_files/figure-html/unnamed-chunk-11-2.png)<!-- -->![](11-overview_files/figure-html/unnamed-chunk-11-3.png)<!-- -->![](11-overview_files/figure-html/unnamed-chunk-11-4.png)<!-- -->

# Co-Review
Let's look at the co-review policy.



Only 87 out of 171 do have a 
coreview-policy.

The following table displays stemmed parts of the policies, sorted by propensity.
<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["word"],"name":[1],"type":["chr"],"align":["left"]},{"label":["n"],"name":[2],"type":["int"],"align":["right"]}],"data":[{"1":"review","2":"135"},{"1":"manuscript","2":"53"},{"1":"editor","2":"44"},{"1":"confidenti","2":"34"},{"1":"inform","2":"25"},{"1":"colleagu","2":"21"},{"1":"involv","2":"17"},{"1":"journal","2":"17"},{"1":"consult","2":"15"},{"1":"discuss","2":"15"},{"1":"disclos","2":"14"},{"1":"permiss","2":"14"},{"1":"student","2":"14"},{"1":"author","2":"13"},{"1":"peer","2":"13"},{"1":"process","2":"12"},{"1":"ensur","2":"11"},{"1":"obtain","2":"11"},{"1":"person","2":"11"},{"1":"accept","2":"10"},{"1":"advic","2":"10"},{"1":"collabor","2":"10"},{"1":"share","2":"10"},{"1":"submit","2":"10"},{"1":"ident","2":"9"},{"1":"includ","2":"9"},{"1":"paper","2":"9"},{"1":"treat","2":"9"},{"1":"content","2":"8"},{"1":"expect","2":"8"},{"1":"laboratori","2":"8"},{"1":"refere","2":"8"},{"1":"specif","2":"8"},{"1":"commun","2":"7"},{"1":"contact","2":"7"},{"1":"guidelin","2":"7"},{"1":"publish","2":"7"},{"1":"research","2":"7"},{"1":"traine","2":"7"},{"1":"addit","2":"6"},{"1":"comment","2":"6"},{"1":"conflict","2":"6"},{"1":"document","2":"6"},{"1":"invit","2":"6"},{"1":"maintain","2":"6"},{"1":"prior","2":"6"},{"1":"request","2":"6"},{"1":"respons","2":"6"},{"1":"special","2":"6"},{"1":"articl","2":"5"},{"1":"e.g","2":"5"},{"1":"ethic","2":"5"},{"1":"evalu","2":"5"},{"1":"event","2":"5"},{"1":"instanc","2":"5"},{"1":"junior","2":"5"},{"1":"name","2":"5"},{"1":"parti","2":"5"},{"1":"potenti","2":"5"},{"1":"record","2":"5"},{"1":"report","2":"5"},{"1":"sought","2":"5"},{"1":"unpublish","2":"5"},{"1":"abid","2":"4"},{"1":"advanc","2":"4"},{"1":"agre","2":"4"},{"1":"copi","2":"4"},{"1":"experi","2":"4"},{"1":"expert","2":"4"},{"1":"graduat","2":"4"},{"1":"help","2":"4"},{"1":"identifi","2":"4"},{"1":"individu","2":"4"},{"1":"mentor","2":"4"},{"1":"profession","2":"4"},{"1":"receiv","2":"4"},{"1":"requir","2":"4"},{"1":"shown","2":"4"},{"1":"write","2":"4"},{"1":"account","2":"3"},{"1":"accur","2":"3"},{"1":"accuraci","2":"3"},{"1":"compon","2":"3"},{"1":"confid","2":"3"},{"1":"cope","2":"3"},{"1":"doc","2":"3"},{"1":"editori","2":"3"},{"1":"exist","2":"3"},{"1":"feel","2":"3"},{"1":"handl","2":"3"},{"1":"input","2":"3"},{"1":"learn","2":"3"},{"1":"materi","2":"3"},{"1":"minimum","2":"3"},{"1":"note","2":"3"},{"1":"opportun","2":"3"},{"1":"origin","2":"3"},{"1":"permit","2":"3"},{"1":"post","2":"3"},{"1":"practic","2":"3"},{"1":"privileg","2":"3"},{"1":"reflect","2":"3"},{"1":"scientif","2":"3"},{"1":"submiss","2":"3"},{"1":"ultim","2":"3"},{"1":"violat","2":"3"},{"1":"assist","2":"2"},{"1":"avoid","2":"2"},{"1":"awar","2":"2"},{"1":"check","2":"2"},{"1":"choos","2":"2"},{"1":"club","2":"2"},{"1":"committe","2":"2"},{"1":"compet","2":"2"},{"1":"declar","2":"2"},{"1":"difficult","2":"2"},{"1":"divulg","2":"2"},{"1":"encourag","2":"2"},{"1":"exclud","2":"2"},{"1":"exercis","2":"2"},{"1":"financi","2":"2"},{"1":"found","2":"2"},{"1":"function","2":"2"},{"1":"make","2":"2"},{"1":"meet","2":"2"},{"1":"natur","2":"2"},{"1":"offic","2":"2"},{"1":"opinion","2":"2"},{"1":"outlin","2":"2"},{"1":"provid","2":"2"},{"1":"public","2":"2"},{"1":"refrain","2":"2"},{"1":"restrict","2":"2"},{"1":"seek","2":"2"},{"1":"senior","2":"2"},{"1":"strictli","2":"2"},{"1":"subject","2":"2"},{"1":"supervisor","2":"2"},{"1":"time","2":"2"},{"1":"train","2":"2"},{"1":"websit","2":"2"},{"1":"06","2":"1"},{"1":"11","2":"1"},{"1":"14","2":"1"},{"1":"29","2":"1"},{"1":"abstract","2":"1"},{"1":"acknowledg","2":"1"},{"1":"acquir","2":"1"},{"1":"advantag","2":"1"},{"1":"agu’","2":"1"},{"1":"ahead","2":"1"},{"1":"aid","2":"1"},{"1":"allow","2":"1"},{"1":"amr","2":"1"},{"1":"annal","2":"1"},{"1":"anonym","2":"1"},{"1":"another’","2":"1"},{"1":"approv","2":"1"},{"1":"argument","2":"1"},{"1":"aspect","2":"1"},{"1":"assign","2":"1"},{"1":"associ","2":"1"},{"1":"assumpt","2":"1"},{"1":"belief","2":"1"},{"1":"benefit","2":"1"},{"1":"board","2":"1"},{"1":"breach","2":"1"},{"1":"can’t","2":"1"},{"1":"career","2":"1"},{"1":"circumst","2":"1"},{"1":"citat","2":"1"},{"1":"complet","2":"1"},{"1":"consent","2":"1"},{"1":"contain","2":"1"},{"1":"contribut","2":"1"},{"1":"correspond","2":"1"},{"1":"data","2":"1"},{"1":"decis","2":"1"},{"1":"deleg","2":"1"},{"1":"deserv","2":"1"},{"1":"design","2":"1"},{"1":"destroi","2":"1"},{"1":"directli","2":"1"},{"1":"disadvantag","2":"1"},{"1":"disclosur","2":"1"},{"1":"discredit","2":"1"},{"1":"dissemin","2":"1"},{"1":"doctor","2":"1"},{"1":"due","2":"1"},{"1":"editor’","2":"1"},{"1":"effort","2":"1"},{"1":"enlist","2":"1"},{"1":"expertis","2":"1"},{"1":"explicit","2":"1"},{"1":"facilit","2":"1"},{"1":"fairli","2":"1"},{"1":"field","2":"1"},{"1":"file","2":"1"},{"1":"find","2":"1"},{"1":"free","2":"1"},{"1":"gain","2":"1"},{"1":"guid","2":"1"},{"1":"guidanc","2":"1"},{"1":"idea","2":"1"},{"1":"incorpor","2":"1"},{"1":"infer","2":"1"},{"1":"intellectu","2":"1"},{"1":"intern","2":"1"},{"1":"interpret","2":"1"},{"1":"jci","2":"1"},{"1":"journal’","2":"1"},{"1":"lead","2":"1"},{"1":"manner","2":"1"},{"1":"matter","2":"1"},{"1":"mean","2":"1"},{"1":"medicin","2":"1"},{"1":"method","2":"1"},{"1":"necess","2":"1"},{"1":"notif","2":"1"},{"1":"oup","2":"1"},{"1":"perform","2":"1"},{"1":"polici","2":"1"},{"1":"preserv","2":"1"},{"1":"previous","2":"1"},{"1":"principl","2":"1"},{"1":"privat","2":"1"},{"1":"proceed","2":"1"},{"1":"professor","2":"1"},{"1":"prohibit","2":"1"},{"1":"properti","2":"1"},{"1":"protect","2":"1"},{"1":"publicli","2":"1"},{"1":"purpos","2":"1"},{"1":"qualifi","2":"1"},{"1":"qualiti","2":"1"},{"1":"reason","2":"1"},{"1":"recogn","2":"1"},{"1":"recognit","2":"1"},{"1":"recus","2":"1"},{"1":"referee'","2":"1"},{"1":"referee’","2":"1"},{"1":"relat","2":"1"},{"1":"relationship","2":"1"},{"1":"relax","2":"1"},{"1":"resid","2":"1"},{"1":"respect","2":"1"},{"1":"rest","2":"1"},{"1":"scholar","2":"1"},{"1":"sign","2":"1"},{"1":"signific","2":"1"},{"1":"singl","2":"1"},{"1":"site","2":"1"},{"1":"staff","2":"1"},{"1":"strict","2":"1"},{"1":"strong","2":"1"},{"1":"understand","2":"1"},{"1":"uphold","2":"1"},{"1":"wish","2":"1"},{"1":"written","2":"1"},{"1":"you’d","2":"1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>




The following graph shows the relationship between to most common bigrams (only
bigrams that occur at least three times).

![](11-overview_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

![](11-overview_files/figure-html/unnamed-chunk-16-1.png)<!-- -->![](11-overview_files/figure-html/unnamed-chunk-16-2.png)<!-- -->![](11-overview_files/figure-html/unnamed-chunk-16-3.png)<!-- -->

# Preprints
![](11-overview_files/figure-html/preprint version-1.png)<!-- -->


![](11-overview_files/figure-html/unnamed-chunk-17-1.png)<!-- -->![](11-overview_files/figure-html/unnamed-chunk-17-2.png)<!-- -->
