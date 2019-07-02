---
title: "Landscape Study - General Overview"
author: Thomas Klebel
date: Last changed 2019-07-02
output: 
  html_document:
    df_print: paged
    keep_md: true
---







# Summary
The general impression is, that the journals most of the time do not have a 
specific policy regarding the aspect under question, or it was unclear for our
reviewers if there was a policy or not or how to interpret it.

# Missing data
![](11-overview_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

There is quite some missing data, which shouldn't be like this. For example
the field U30 in excel (table RAW), which has the opr-responses for the journal
"Advanced Materials" is missing. It should probably be "Not specified".

The following are all variables, where implicit missings should be checked and
converted to explicit ones (as for opr_responses), or fixed (as for publishers).

![](11-overview_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

# Publisher versus subject area
The question is, whether it is reasonable to split results by publisher.
I think it does not make much sense:

- There are not many publishers, that have multiple publications
- Except Springer Nature and Elsevier, most publishers are confined to one or 
two subject areas. Looking at publishers would misinterprete differences as
being due to the publisher when they are due to the subject area.
- The only thing to compare would be thus Springer Nature vs. Elsevier


![](11-overview_files/figure-html/unnamed-chunk-4-1.png)<!-- -->




# Peer Review



![](11-overview_files/figure-html/unnamed-chunk-6-1.png)<!-- -->


![](11-overview_files/figure-html/unnamed-chunk-7-1.png)<!-- -->



![](11-overview_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


![](11-overview_files/figure-html/unnamed-chunk-9-1.png)<!-- -->




# Open Peer Review
![](11-overview_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

![](11-overview_files/figure-html/unnamed-chunk-11-1.png)<!-- -->





# Co-Review
Let's look at the co-review policy.



Only 87 out of 171 do have a 
coreview-policy. Due to policies being similar across journals of certain 
publishers, there are 45
distinct policies in our dataset.

The following table displays stemmed parts of the distinct policies, sorted by
propensity.
<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["word"],"name":[1],"type":["chr"],"align":["left"]},{"label":["n"],"name":[2],"type":["int"],"align":["right"]}],"data":[{"1":"review","2":"135"},{"1":"manuscript","2":"53"},{"1":"editor","2":"44"},{"1":"confidenti","2":"34"},{"1":"inform","2":"25"},{"1":"colleagu","2":"21"},{"1":"involv","2":"17"},{"1":"journal","2":"17"},{"1":"consult","2":"15"},{"1":"discuss","2":"15"},{"1":"disclos","2":"14"},{"1":"permiss","2":"14"},{"1":"student","2":"14"},{"1":"author","2":"13"},{"1":"peer","2":"13"},{"1":"process","2":"12"},{"1":"ensur","2":"11"},{"1":"obtain","2":"11"},{"1":"person","2":"11"},{"1":"accept","2":"10"},{"1":"advic","2":"10"},{"1":"collabor","2":"10"},{"1":"share","2":"10"},{"1":"submit","2":"10"},{"1":"ident","2":"9"},{"1":"includ","2":"9"},{"1":"paper","2":"9"},{"1":"treat","2":"9"},{"1":"content","2":"8"},{"1":"expect","2":"8"},{"1":"laboratori","2":"8"},{"1":"refere","2":"8"},{"1":"specif","2":"8"},{"1":"commun","2":"7"},{"1":"contact","2":"7"},{"1":"guidelin","2":"7"},{"1":"publish","2":"7"},{"1":"research","2":"7"},{"1":"traine","2":"7"},{"1":"addit","2":"6"},{"1":"comment","2":"6"},{"1":"conflict","2":"6"},{"1":"document","2":"6"},{"1":"invit","2":"6"},{"1":"maintain","2":"6"},{"1":"prior","2":"6"},{"1":"request","2":"6"},{"1":"respons","2":"6"},{"1":"special","2":"6"},{"1":"articl","2":"5"},{"1":"e.g","2":"5"},{"1":"ethic","2":"5"},{"1":"evalu","2":"5"},{"1":"event","2":"5"},{"1":"instanc","2":"5"},{"1":"junior","2":"5"},{"1":"name","2":"5"},{"1":"parti","2":"5"},{"1":"potenti","2":"5"},{"1":"record","2":"5"},{"1":"report","2":"5"},{"1":"sought","2":"5"},{"1":"unpublish","2":"5"},{"1":"abid","2":"4"},{"1":"advanc","2":"4"},{"1":"agre","2":"4"},{"1":"copi","2":"4"},{"1":"experi","2":"4"},{"1":"expert","2":"4"},{"1":"graduat","2":"4"},{"1":"help","2":"4"},{"1":"identifi","2":"4"},{"1":"individu","2":"4"},{"1":"mentor","2":"4"},{"1":"profession","2":"4"},{"1":"receiv","2":"4"},{"1":"requir","2":"4"},{"1":"shown","2":"4"},{"1":"write","2":"4"},{"1":"account","2":"3"},{"1":"accur","2":"3"},{"1":"accuraci","2":"3"},{"1":"compon","2":"3"},{"1":"confid","2":"3"},{"1":"cope","2":"3"},{"1":"doc","2":"3"},{"1":"editori","2":"3"},{"1":"exist","2":"3"},{"1":"feel","2":"3"},{"1":"handl","2":"3"},{"1":"input","2":"3"},{"1":"learn","2":"3"},{"1":"materi","2":"3"},{"1":"minimum","2":"3"},{"1":"note","2":"3"},{"1":"opportun","2":"3"},{"1":"origin","2":"3"},{"1":"permit","2":"3"},{"1":"post","2":"3"},{"1":"practic","2":"3"},{"1":"privileg","2":"3"},{"1":"reflect","2":"3"},{"1":"scientif","2":"3"},{"1":"submiss","2":"3"},{"1":"ultim","2":"3"},{"1":"violat","2":"3"},{"1":"assist","2":"2"},{"1":"avoid","2":"2"},{"1":"awar","2":"2"},{"1":"check","2":"2"},{"1":"choos","2":"2"},{"1":"club","2":"2"},{"1":"committe","2":"2"},{"1":"compet","2":"2"},{"1":"declar","2":"2"},{"1":"difficult","2":"2"},{"1":"divulg","2":"2"},{"1":"encourag","2":"2"},{"1":"exclud","2":"2"},{"1":"exercis","2":"2"},{"1":"financi","2":"2"},{"1":"found","2":"2"},{"1":"function","2":"2"},{"1":"make","2":"2"},{"1":"meet","2":"2"},{"1":"natur","2":"2"},{"1":"offic","2":"2"},{"1":"opinion","2":"2"},{"1":"outlin","2":"2"},{"1":"provid","2":"2"},{"1":"public","2":"2"},{"1":"refrain","2":"2"},{"1":"restrict","2":"2"},{"1":"seek","2":"2"},{"1":"senior","2":"2"},{"1":"strictli","2":"2"},{"1":"subject","2":"2"},{"1":"supervisor","2":"2"},{"1":"time","2":"2"},{"1":"train","2":"2"},{"1":"websit","2":"2"},{"1":"06","2":"1"},{"1":"11","2":"1"},{"1":"14","2":"1"},{"1":"29","2":"1"},{"1":"abstract","2":"1"},{"1":"acknowledg","2":"1"},{"1":"acquir","2":"1"},{"1":"advantag","2":"1"},{"1":"agu’","2":"1"},{"1":"ahead","2":"1"},{"1":"aid","2":"1"},{"1":"allow","2":"1"},{"1":"amr","2":"1"},{"1":"annal","2":"1"},{"1":"anonym","2":"1"},{"1":"another’","2":"1"},{"1":"approv","2":"1"},{"1":"argument","2":"1"},{"1":"aspect","2":"1"},{"1":"assign","2":"1"},{"1":"associ","2":"1"},{"1":"assumpt","2":"1"},{"1":"belief","2":"1"},{"1":"benefit","2":"1"},{"1":"board","2":"1"},{"1":"breach","2":"1"},{"1":"can’t","2":"1"},{"1":"career","2":"1"},{"1":"circumst","2":"1"},{"1":"citat","2":"1"},{"1":"complet","2":"1"},{"1":"consent","2":"1"},{"1":"contain","2":"1"},{"1":"contribut","2":"1"},{"1":"correspond","2":"1"},{"1":"data","2":"1"},{"1":"decis","2":"1"},{"1":"deleg","2":"1"},{"1":"deserv","2":"1"},{"1":"design","2":"1"},{"1":"destroi","2":"1"},{"1":"directli","2":"1"},{"1":"disadvantag","2":"1"},{"1":"disclosur","2":"1"},{"1":"discredit","2":"1"},{"1":"dissemin","2":"1"},{"1":"doctor","2":"1"},{"1":"due","2":"1"},{"1":"editor’","2":"1"},{"1":"effort","2":"1"},{"1":"enlist","2":"1"},{"1":"expertis","2":"1"},{"1":"explicit","2":"1"},{"1":"facilit","2":"1"},{"1":"fairli","2":"1"},{"1":"field","2":"1"},{"1":"file","2":"1"},{"1":"find","2":"1"},{"1":"free","2":"1"},{"1":"gain","2":"1"},{"1":"guid","2":"1"},{"1":"guidanc","2":"1"},{"1":"idea","2":"1"},{"1":"incorpor","2":"1"},{"1":"infer","2":"1"},{"1":"intellectu","2":"1"},{"1":"intern","2":"1"},{"1":"interpret","2":"1"},{"1":"jci","2":"1"},{"1":"journal’","2":"1"},{"1":"lead","2":"1"},{"1":"manner","2":"1"},{"1":"matter","2":"1"},{"1":"mean","2":"1"},{"1":"medicin","2":"1"},{"1":"method","2":"1"},{"1":"necess","2":"1"},{"1":"notif","2":"1"},{"1":"oup","2":"1"},{"1":"perform","2":"1"},{"1":"polici","2":"1"},{"1":"preserv","2":"1"},{"1":"previous","2":"1"},{"1":"principl","2":"1"},{"1":"privat","2":"1"},{"1":"proceed","2":"1"},{"1":"professor","2":"1"},{"1":"prohibit","2":"1"},{"1":"properti","2":"1"},{"1":"protect","2":"1"},{"1":"publicli","2":"1"},{"1":"purpos","2":"1"},{"1":"qualifi","2":"1"},{"1":"qualiti","2":"1"},{"1":"reason","2":"1"},{"1":"recogn","2":"1"},{"1":"recognit","2":"1"},{"1":"recus","2":"1"},{"1":"referee'","2":"1"},{"1":"referee’","2":"1"},{"1":"relat","2":"1"},{"1":"relationship","2":"1"},{"1":"relax","2":"1"},{"1":"resid","2":"1"},{"1":"respect","2":"1"},{"1":"rest","2":"1"},{"1":"scholar","2":"1"},{"1":"sign","2":"1"},{"1":"signific","2":"1"},{"1":"singl","2":"1"},{"1":"site","2":"1"},{"1":"staff","2":"1"},{"1":"strict","2":"1"},{"1":"strong","2":"1"},{"1":"understand","2":"1"},{"1":"uphold","2":"1"},{"1":"wish","2":"1"},{"1":"written","2":"1"},{"1":"you’d","2":"1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


The following graph shows the relationship between to most common bigrams (only
bigrams that occur at least three times).

![](11-overview_files/figure-html/unnamed-chunk-15-1.png)<!-- -->








![](11-overview_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

![](11-overview_files/figure-html/unnamed-chunk-18-1.png)<!-- -->



This doesn't look interesting.
![](11-overview_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

This doesn't look interesting.
![](11-overview_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

# Preprints
![](11-overview_files/figure-html/preprint version-1.png)<!-- -->

![](11-overview_files/figure-html/unnamed-chunk-21-1.png)<!-- -->





<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["word"],"name":[1],"type":["chr"],"align":["left"]},{"label":["n"],"name":[2],"type":["int"],"align":["right"]}],"data":[{"1":"preprint","2":"82"},{"1":"publication","2":"59"},{"1":"authors","2":"55"},{"1":"manuscript","2":"40"},{"1":"version","2":"33"},{"1":"arxiv","2":"32"},{"1":"server","2":"31"},{"1":"published","2":"30"},{"1":"servers","2":"30"},{"1":"article","2":"27"},{"1":"accepted","2":"26"},{"1":"posting","2":"23"},{"1":"submission","2":"23"},{"1":"preprints","2":"22"},{"1":"commercial","2":"21"},{"1":"submitted","2":"20"},{"1":"biorxiv","2":"19"},{"1":"paper","2":"19"},{"1":"posted","2":"19"},{"1":"journal","2":"18"},{"1":"link","2":"17"},{"1":"repositories","2":"17"},{"1":"pre","2":"16"},{"1":"papers","2":"15"},{"1":"policy","2":"15"},{"1":"final","2":"14"},{"1":"prior","2":"14"},{"1":"review","2":"14"},{"1":"chemrxiv","2":"13"},{"1":"print","2":"13"},{"1":"websites","2":"13"},{"1":"doi","2":"12"},{"1":"personal","2":"12"},{"1":"previously","2":"12"},{"1":"time","2":"12"},{"1":"digital","2":"11"},{"1":"institutional","2":"11"},{"1":"manuscripts","2":"11"},{"1":"media","2":"11"},{"1":"profit","2":"11"},{"1":"updated","2":"11"},{"1":"journals","2":"10"},{"1":"post","2":"10"},{"1":"repository","2":"10"},{"1":"access","2":"9"},{"1":"arxiv.org","2":"8"},{"1":"community","2":"8"},{"1":"cover","2":"8"},{"1":"deposit","2":"8"},{"1":"letter","2":"8"},{"1":"peer","2":"8"},{"1":"service","2":"8"},{"1":"university","2":"8"},{"1":"update","2":"8"},{"1":"web","2":"8"},{"1":"agu","2":"7"},{"1":"archiving","2":"7"},{"1":"articles","2":"7"},{"1":"asco","2":"7"},{"1":"author","2":"7"},{"1":"defined","2":"7"},{"1":"deposition","2":"7"},{"1":"identifier","2":"7"},{"1":"include","2":"7"},{"1":"note","2":"7"},{"1":"object","2":"7"},{"1":"acceptance","2":"6"},{"1":"acknowledge","2":"6"},{"1":"author’s","2":"6"},{"1":"based","2":"6"},{"1":"considered","2":"6"},{"1":"content","2":"6"},{"1":"draft","2":"6"},{"1":"e.g","2":"6"},{"1":"includes","2":"6"},{"1":"online","2":"6"},{"1":"original","2":"6"},{"1":"provided","2":"6"},{"1":"research","2":"6"},{"1":"revisions","2":"6"},{"1":"subject","2":"6"},{"1":"versions","2":"6"},{"1":"abstract","2":"5"},{"1":"adjusted","2":"5"},{"1":"allowed","2":"5"},{"1":"approved","2":"5"},{"1":"formal","2":"5"},{"1":"information","2":"5"},{"1":"permitted","2":"5"},{"1":"record","2":"5"},{"1":"related","2":"5"},{"1":"researchers","2":"5"},{"1":"share","2":"5"},{"1":"sharing","2":"5"},{"1":"social","2":"5"},{"1":"society","2":"5"},{"1":"submit","2":"5"},{"1":"website","2":"5"},{"1":"biorn","2":"4"},{"1":"chemical","2":"4"},{"1":"chemrn","2":"4"},{"1":"consideration","2":"4"},{"1":"copyright","2":"4"},{"1":"data","2":"4"},{"1":"definition","2":"4"},{"1":"discuss","2":"4"},{"1":"editorial","2":"4"},{"1":"editors","2":"4"},{"1":"encourage","2":"4"},{"1":"explicitly","2":"4"},{"1":"initial","2":"4"},{"1":"platform","2":"4"},{"1":"platforms","2":"4"},{"1":"policies","2":"4"},{"1":"process","2":"4"},{"1":"public","2":"4"},{"1":"publications","2":"4"},{"1":"recognised","2":"4"},{"1":"redundant","2":"4"},{"1":"refereed","2":"4"},{"1":"reports","2":"4"},{"1":"scientific","2":"4"},{"1":"supports","2":"4"},{"1":"add","2":"3"},{"1":"advised","2":"3"},{"1":"american","2":"3"},{"1":"aov","2":"3"},{"1":"archive","2":"3"},{"1":"blog","2":"3"},{"1":"conflict","2":"3"},{"1":"contact","2":"3"},{"1":"coverage","2":"3"},{"1":"elsevier","2":"3"},{"1":"elsevier's","2":"3"},{"1":"form","2":"3"},{"1":"free","2":"3"},{"1":"ieee","2":"3"},{"1":"including","2":"3"},{"1":"individual","2":"3"},{"1":"lancet","2":"3"},{"1":"letters","2":"3"},{"1":"links","2":"3"},{"1":"makes","2":"3"},{"1":"medrxiv","2":"3"},{"1":"meeting","2":"3"},{"1":"operated","2":"3"},{"1":"oxford","2":"3"},{"1":"poster","2":"3"},{"1":"presentation","2":"3"},{"1":"press","2":"3"},{"1":"publicly","2":"3"},{"1":"repec","2":"3"},{"1":"responsible","2":"3"},{"1":"reviewed","2":"3"},{"1":"reviewers","2":"3"},{"1":"site","2":"3"},{"1":"sites","2":"3"},{"1":"submitting","2":"3"},{"1":"support","2":"3"},{"1":"title","2":"3"},{"1":"1","2":"2"},{"1":"2","2":"2"},{"1":"acceptable","2":"2"},{"1":"accession","2":"2"},{"1":"acs","2":"2"},{"1":"ada","2":"2"},{"1":"addition","2":"2"},{"1":"agree","2":"2"},{"1":"ahead","2":"2"},{"1":"analysis","2":"2"},{"1":"apa","2":"2"},{"1":"applicable","2":"2"},{"1":"applies","2":"2"},{"1":"apply","2":"2"},{"1":"approach","2":"2"},{"1":"author's","2":"2"},{"1":"biorxiv.org","2":"2"},{"1":"bmj","2":"2"},{"1":"broader","2":"2"},{"1":"catalysis","2":"2"},{"1":"cd","2":"2"},{"1":"chemistry","2":"2"},{"1":"citation","2":"2"},{"1":"cite","2":"2"},{"1":"citing","2":"2"},{"1":"constitute","2":"2"},{"1":"databases","2":"2"},{"1":"designed","2":"2"},{"1":"discipline","2":"2"},{"1":"discovery","2":"2"},{"1":"discussions","2":"2"},{"1":"dissemination","2":"2"},{"1":"distribution","2":"2"},{"1":"document","2":"2"},{"1":"earlier","2":"2"},{"1":"encourages","2":"2"},{"1":"engagement","2":"2"},{"1":"evaluation","2":"2"},{"1":"excludes","2":"2"},{"1":"exposure","2":"2"},{"1":"facilitate","2":"2"},{"1":"forbidden","2":"2"},{"1":"hear","2":"2"},{"1":"https","2":"2"},{"1":"id","2":"2"},{"1":"impact","2":"2"},{"1":"input","2":"2"},{"1":"institution","2":"2"},{"1":"jpc","2":"2"},{"1":"line","2":"2"},{"1":"list","2":"2"},{"1":"manuscript's","2":"2"},{"1":"millions","2":"2"},{"1":"months","2":"2"},{"1":"motivations","2":"2"},{"1":"nar","2":"2"},{"1":"neurips","2":"2"},{"1":"office","2":"2"},{"1":"option","2":"2"},{"1":"orally","2":"2"},{"1":"party","2":"2"},{"1":"permission","2":"2"},{"1":"planning","2":"2"},{"1":"preliminary","2":"2"},{"1":"prepublication","2":"2"},{"1":"presence","2":"2"},{"1":"presentations","2":"2"},{"1":"previous","2":"2"},{"1":"proceedings","2":"2"},{"1":"provide","2":"2"},{"1":"publicity","2":"2"},{"1":"publisher","2":"2"},{"1":"publishes","2":"2"},{"1":"publishing","2":"2"},{"1":"purposes","2":"2"},{"1":"recognized","2":"2"},{"1":"regard","2":"2"},{"1":"rejected","2":"2"},{"1":"report","2":"2"},{"1":"requirements","2":"2"},{"1":"requires","2":"2"},{"1":"respond","2":"2"},{"1":"results","2":"2"},{"1":"reviewing","2":"2"},{"1":"revise","2":"2"},{"1":"rights","2":"2"},{"1":"sage","2":"2"},{"1":"sciencedirect","2":"2"},{"1":"sciences","2":"2"},{"1":"series","2":"2"},{"1":"similar","2":"2"},{"1":"situation","2":"2"},{"1":"smj","2":"2"},{"1":"specific","2":"2"},{"1":"specifically","2":"2"},{"1":"strongly","2":"2"},{"1":"studies","2":"2"},{"1":"study","2":"2"},{"1":"technical","2":"2"},{"1":"typically","2":"2"},{"1":"updating","2":"2"},{"1":"users","2":"2"},{"1":"word","2":"2"},{"1":"written","2":"2"},{"1":"12","2":"1"},{"1":"1541596047120","2":"1"},{"1":"3","2":"1"},{"1":"3.5","2":"1"},{"1":"4","2":"1"},{"1":"6","2":"1"},{"1":"8.1.9","2":"1"},{"1":"abide","2":"1"},{"1":"abstracts","2":"1"},{"1":"academia.edu","2":"1"},{"1":"academic","2":"1"},{"1":"accessible","2":"1"},{"1":"accompanying","2":"1"},{"1":"account","2":"1"},{"1":"accounts","2":"1"},{"1":"aces","2":"1"},{"1":"acknowledged","2":"1"},{"1":"active","2":"1"},{"1":"actively","2":"1"},{"1":"adequate","2":"1"},{"1":"advance","2":"1"},{"1":"affect","2":"1"},{"1":"affiliated","2":"1"},{"1":"agreement","2":"1"},{"1":"ajps","2":"1"},{"1":"altered","2":"1"},{"1":"amended","2":"1"},{"1":"amj","2":"1"},{"1":"amj’s","2":"1"},{"1":"angewandte","2":"1"},{"1":"annually","2":"1"},{"1":"anonymization","2":"1"},{"1":"anonymous","2":"1"},{"1":"appears","2":"1"},{"1":"archived","2":"1"},{"1":"archives","2":"1"},{"1":"asian","2":"1"},{"1":"assets","2":"1"},{"1":"astro","2":"1"},{"1":"attempts","2":"1"},{"1":"audience","2":"1"},{"1":"authorities","2":"1"},{"1":"automatically","2":"1"},{"1":"bias","2":"1"},{"1":"blind","2":"1"},{"1":"blogs","2":"1"},{"1":"blood","2":"1"},{"1":"books","2":"1"},{"1":"briefings","2":"1"},{"1":"briefs","2":"1"},{"1":"capabilities","2":"1"},{"1":"care","2":"1"},{"1":"carried","2":"1"},{"1":"categorised","2":"1"},{"1":"cdn.literatumonline.com","2":"1"},{"1":"channels","2":"1"},{"1":"chemie","2":"1"},{"1":"chempubsoc","2":"1"},{"1":"choose","2":"1"},{"1":"chorus","2":"1"},{"1":"circulate","2":"1"},{"1":"circulated","2":"1"},{"1":"cited","2":"1"},{"1":"claims","2":"1"},{"1":"clinical","2":"1"},{"1":"collaborative","2":"1"},{"1":"colleagues","2":"1"},{"1":"comments","2":"1"},{"1":"committee","2":"1"},{"1":"communication","2":"1"},{"1":"company","2":"1"},{"1":"compare","2":"1"},{"1":"compensation","2":"1"},{"1":"complete","2":"1"},{"1":"compulsory","2":"1"},{"1":"conclusions","2":"1"},{"1":"concurrent","2":"1"},{"1":"cond","2":"1"},{"1":"conditions","2":"1"},{"1":"conference","2":"1"},{"1":"conferences","2":"1"},{"1":"consortium","2":"1"},{"1":"constitutes","2":"1"},{"1":"context","2":"1"},{"1":"council","2":"1"},{"1":"count","2":"1"},{"1":"counts","2":"1"},{"1":"creating","2":"1"},{"1":"currents","2":"1"},{"1":"customers","2":"1"},{"1":"date","2":"1"},{"1":"decision","2":"1"},{"1":"declare","2":"1"},{"1":"degree","2":"1"},{"1":"departmental","2":"1"},{"1":"depend","2":"1"},{"1":"deposited","2":"1"},{"1":"derivative","2":"1"},{"1":"designated","2":"1"},{"1":"determining","2":"1"},{"1":"deviate","2":"1"},{"1":"directly","2":"1"},{"1":"disclose","2":"1"},{"1":"discouraged","2":"1"},{"1":"discovered","2":"1"},{"1":"discussion","2":"1"},{"1":"dissertation","2":"1"},{"1":"distinguishes","2":"1"},{"1":"dois","2":"1"},{"1":"double","2":"1"},{"1":"doubt","2":"1"},{"1":"drafts","2":"1"},{"1":"dual","2":"1"},{"1":"earth","2":"1"},{"1":"editing","2":"1"},{"1":"electronic","2":"1"},{"1":"eligible","2":"1"},{"1":"els","2":"1"},{"1":"employer","2":"1"},{"1":"employer’s","2":"1"},{"1":"employers","2":"1"},{"1":"enable","2":"1"},{"1":"encountering","2":"1"},{"1":"encouraged","2":"1"},{"1":"ensure","2":"1"},{"1":"entries","2":"1"},{"1":"epj","2":"1"},{"1":"errata","2":"1"},{"1":"es","2":"1"},{"1":"essoar","2":"1"},{"1":"europe","2":"1"},{"1":"evaluate","2":"1"},{"1":"eventually","2":"1"},{"1":"excluding","2":"1"},{"1":"experimental","2":"1"},{"1":"extent","2":"1"},{"1":"factors","2":"1"},{"1":"failure","2":"1"},{"1":"file","2":"1"},{"1":"files","2":"1"},{"1":"finally","2":"1"},{"1":"findings","2":"1"},{"1":"formats","2":"1"},{"1":"funded","2":"1"},{"1":"future","2":"1"},{"1":"governmental","2":"1"},{"1":"green","2":"1"},{"1":"grounds","2":"1"},{"1":"held","2":"1"},{"1":"hematology","2":"1"},{"1":"hepatology","2":"1"},{"1":"homepage","2":"1"},{"1":"identified","2":"1"},{"1":"immediately","2":"1"},{"1":"implies","2":"1"},{"1":"included","2":"1"},{"1":"incorporate","2":"1"},{"1":"indexed","2":"1"},{"1":"info","2":"1"},{"1":"inform","2":"1"},{"1":"informal","2":"1"},{"1":"innovative","2":"1"},{"1":"insitutional","2":"1"},{"1":"instance","2":"1"},{"1":"institute","2":"1"},{"1":"institutions","2":"1"},{"1":"instructed","2":"1"},{"1":"intellectual","2":"1"},{"1":"internal","2":"1"},{"1":"internet","2":"1"},{"1":"interpretation","2":"1"},{"1":"issued","2":"1"},{"1":"jaci","2":"1"},{"1":"jbs","2":"1"},{"1":"jci","2":"1"},{"1":"jeopardize","2":"1"},{"1":"jhep","2":"1"},{"1":"journal’s","2":"1"},{"1":"knowing","2":"1"},{"1":"lab","2":"1"},{"1":"language","2":"1"},{"1":"legally","2":"1"},{"1":"liberal","2":"1"},{"1":"limited","2":"1"},{"1":"local","2":"1"},{"1":"locations","2":"1"},{"1":"magazines","2":"1"},{"1":"maintained","2":"1"},{"1":"mat.org","2":"1"},{"1":"materials","2":"1"},{"1":"maximize","2":"1"},{"1":"medium","2":"1"},{"1":"medline","2":"1"},{"1":"meetings","2":"1"},{"1":"mentioned","2":"1"},{"1":"met","2":"1"},{"1":"minimum","2":"1"},{"1":"multiple","2":"1"},{"1":"nano","2":"1"},{"1":"nature","2":"1"},{"1":"notebook","2":"1"},{"1":"noted","2":"1"},{"1":"novelty","2":"1"},{"1":"openly","2":"1"},{"1":"organizers","2":"1"},{"1":"overlaps","2":"1"},{"1":"page","2":"1"},{"1":"pages","2":"1"},{"1":"patient","2":"1"},{"1":"pb","2":"1"},{"1":"pdf","2":"1"},{"1":"pdfs","2":"1"},{"1":"peers","2":"1"},{"1":"permits","2":"1"},{"1":"ph.org","2":"1"},{"1":"plos","2":"1"},{"1":"potential","2":"1"},{"1":"preferred","2":"1"},{"1":"preprinted","2":"1"},{"1":"preprints.org","2":"1"},{"1":"preserve","2":"1"},{"1":"prints","2":"1"},{"1":"processes","2":"1"},{"1":"processing","2":"1"},{"1":"prod","2":"1"},{"1":"professional","2":"1"},{"1":"project","2":"1"},{"1":"promote","2":"1"},{"1":"property","2":"1"},{"1":"protocols","2":"1"},{"1":"provisions","2":"1"},{"1":"psyarxiv","2":"1"},{"1":"pubmed","2":"1"},{"1":"qualification","2":"1"},{"1":"quickly","2":"1"},{"1":"raw","2":"1"},{"1":"read","2":"1"},{"1":"readers","2":"1"},{"1":"readership","2":"1"},{"1":"recently","2":"1"},{"1":"recorded","2":"1"},{"1":"records","2":"1"},{"1":"referenced","2":"1"},{"1":"rejection","2":"1"},{"1":"release","2":"1"},{"1":"released","2":"1"},{"1":"releases","2":"1"},{"1":"relevant","2":"1"},{"1":"requested","2":"1"},{"1":"researchgate","2":"1"},{"1":"result","2":"1"},{"1":"resulted","2":"1"},{"1":"retain","2":"1"},{"1":"retains","2":"1"},{"1":"retraction","2":"1"},{"1":"retrieval","2":"1"},{"1":"royal","2":"1"},{"1":"runs","2":"1"},{"1":"sage’s","2":"1"},{"1":"scholarone","2":"1"},{"1":"science","2":"1"},{"1":"scns","2":"1"},{"1":"scoap3","2":"1"},{"1":"secure","2":"1"},{"1":"seeks","2":"1"},{"1":"services","2":"1"},{"1":"shared","2":"1"},{"1":"space","2":"1"},{"1":"stated","2":"1"},{"1":"status","2":"1"},{"1":"style","2":"1"},{"1":"suggest","2":"1"},{"1":"suggestions","2":"1"},{"1":"supplemental","2":"1"},{"1":"supply","2":"1"},{"1":"systematic","2":"1"},{"1":"tacitly","2":"1"},{"1":"text","2":"1"},{"1":"thesis","2":"1"},{"1":"thoughtful","2":"1"},{"1":"tln","2":"1"},{"1":"topics","2":"1"},{"1":"tq","2":"1"},{"1":"tradition","2":"1"},{"1":"traditional","2":"1"},{"1":"transferred","2":"1"},{"1":"tweets","2":"1"},{"1":"understood","2":"1"},{"1":"updates","2":"1"},{"1":"url","2":"1"},{"1":"violation","2":"1"},{"1":"wider","2":"1"},{"1":"wiki","2":"1"},{"1":"wikis","2":"1"},{"1":"write","2":"1"},{"1":"www.elsevier.com","2":"1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

![](11-overview_files/figure-html/unnamed-chunk-24-1.png)<!-- -->




![](11-overview_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

![](11-overview_files/figure-html/unnamed-chunk-26-1.png)<!-- -->


![](11-overview_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

