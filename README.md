# Peer review and preprint policies are unclear at most major journals

[![DOI](https://zenodo.org/badge/191401145.svg)](https://zenodo.org/badge/latestdoi/191401145)

This repository holds code and data for the preprint [Peer review and preprint policies are unclear at most major journals](https://www.biorxiv.org/content/10.1101/2020.01.24.918995v2)
on bioRxiv.


## Reproducible code
The whole analytic pipeline is reproducible through the `drake` package. 
Executing `r_make("drake.R")` will rebuild the analysis.

The pipeline is specified in the file `R/plan.R`. You can visualise the 
dependencies with the following code:

```r
library(drake)
source("R/plan.R")

config <- drake_config(plan)
vis_drake_graph(config)
```

All packages that are used during the analysis are specified in `R/packages.R`.
For the analysis files to render you will need to install the font "Hind" (for
example from [Google Fonts](https://fonts.google.com/)) and 
register it with
[`extrafont`](https://cran.r-project.org/web/packages/extrafont/README.html). 
Furthermore, you will need the `bookdown` package installed to render the
analysis notebook.


The basis for the paper was `02-analysis-writeup.html`. Since writing the paper
was a collaborative effort, we used a GoogleSheet to work on the manuscript. For
this reason, the text in `02-analysis-writeup.html` is not identical to the 
paper, but rather a first draft version. The code and figures are identical to
the paper.

Further results
and initial explorations can be found in `01-overview.html`, as well as 
executing `R/01-explore.R` and `R/02-explore-missings.R`. 


## Data files
The original data file for the data we collected lives in a Google Sheet, which
is available here: https://docs.google.com/spreadsheets/d/1WcvxxmDhaV3BwBiIfwC_nEAr6-EKCDD11R6eJ5vZElA/edit?usp=sharing

The original file with data on which journals are included is available here:
https://docs.google.com/spreadsheets/d/1Dluo5DNWU4UrmwIZLzqcToioRdyZ1qc1EofAk4ypiW8/edit?usp=sharing

The files were downloaded as `.csv` and `.xlsx` for archival. The analysis 
builds on the `.csv` files, while the `.xlsx` files are supposed to preserve as
much of the original formatting as possible, should the GoogleSheets become 
unavailable one day. 


Some data wrangling was necessary before conducting the analysis. The output of
these operations are the files `data/refined.csv` and `data/refined_w_areas.csv`.
The latter file contains more rows, since some journals belong to more than
one area in GoogleScholarMetrics (GSM). Those journals have duplicate entries 
except for the column `area` which specifies the GSM area.


## Further resources
You can find more information on the `drake` package here: 
https://books.ropensci.org/drake/



## Package versions used
The analysis was last rendered with the following package versions:

```
─ Session info ─────────────────────────────────────────
 setting  value                       
 version  R version 3.6.2 (2019-12-12)
 os       Windows 10 x64              
 system   x86_64, mingw32             
 ui       RStudio                     
 language (EN)                        
 collate  German_Austria.1252         
 ctype    German_Austria.1252         
 tz       Europe/Berlin               
 date     2020-01-24                   

─ Packages ─────────────────────────────────────────────
 package       * version  date       lib source                            
 ash             1.0-15   2015-09-01 [1] CRAN (R 3.6.0)                     
 assertthat      0.2.1    2019-03-21 [1] CRAN (R 3.6.2)                     
 backports       1.1.5    2019-10-02 [1] CRAN (R 3.6.1)                     
 base64enc       0.1-3    2015-07-28 [1] CRAN (R 3.6.0)                     
 base64url       1.4      2018-05-14 [1] CRAN (R 3.6.2)                     
 broom           0.5.3    2019-12-14 [1] CRAN (R 3.6.2)                     
 ca            * 0.71     2018-10-10 [1] CRAN (R 3.6.2)                     
 callr           3.4.0    2019-12-09 [1] CRAN (R 3.6.2)                     
 cellranger      1.1.0    2016-07-27 [1] CRAN (R 3.6.2)                     
 cli             2.0.1    2020-01-08 [1] CRAN (R 3.6.2)                     
 clisymbols      1.2.0    2017-05-21 [1] CRAN (R 3.6.2)                     
 colorspace      1.4-1    2019-03-18 [1] CRAN (R 3.6.1)                     
 crayon          1.3.4    2017-09-16 [1] CRAN (R 3.6.2)                     
 curl            4.3      2019-12-02 [1] CRAN (R 3.6.2)                     
 DBI             1.1.0    2019-12-15 [1] CRAN (R 3.6.2)                     
 dbplyr          1.4.2    2019-06-17 [1] CRAN (R 3.6.2)                     
 desc            1.2.0    2018-05-01 [1] CRAN (R 3.6.2)                     
 devtools        2.2.1    2019-09-24 [1] CRAN (R 3.6.2)                     
 digest          0.6.23   2019-11-23 [1] CRAN (R 3.6.2)                     
 dplyr         * 0.8.3    2019-07-04 [1] CRAN (R 3.6.2)                     
 drake         * 7.9.0    2020-01-08 [1] CRAN (R 3.6.2)                     
 ellipsis        0.3.0    2019-09-20 [1] CRAN (R 3.6.2)                     
 extrafont       0.17     2014-12-08 [1] CRAN (R 3.6.2)                     
 extrafontdb     1.0      2012-06-11 [1] CRAN (R 3.6.0)                     
 fansi           0.4.1    2020-01-08 [1] CRAN (R 3.6.2)                     
 farver          2.0.3    2020-01-16 [1] CRAN (R 3.6.2)                     
 fastmap         1.0.1    2019-10-08 [1] CRAN (R 3.6.2)                     
 fastmatch     * 1.1-0    2017-01-28 [1] CRAN (R 3.6.0)                     
 filelock        1.0.2    2018-10-05 [1] CRAN (R 3.6.2)                     
 forcats       * 0.4.0    2019-02-17 [1] CRAN (R 3.6.2)                     
 formatR         1.7      2019-06-11 [1] CRAN (R 3.6.2)                     
 fs              1.3.1    2019-05-06 [1] CRAN (R 3.6.2)                     
 generics        0.0.2    2018-11-29 [1] CRAN (R 3.6.2)                     
 ggalt         * 0.4.0    2017-02-15 [1] CRAN (R 3.6.2)                     
 ggchicklet    * 0.3.0    2019-12-20 [1] local                              
 ggforce         0.3.1    2019-08-20 [1] CRAN (R 3.6.2)                     
 ggplot2       * 3.2.1    2019-08-10 [1] CRAN (R 3.6.2)                     
 ggraph        * 2.0.0    2019-09-02 [1] CRAN (R 3.6.2)                     
 ggrepel         0.8.1    2019-05-07 [1] CRAN (R 3.6.2)                     
 ggridges      * 0.5.2    2020-01-12 [1] CRAN (R 3.6.2)                     
 glue            1.3.1    2019-03-12 [1] CRAN (R 3.6.2)                     
 graphlayouts    0.5.0    2019-08-20 [1] CRAN (R 3.6.2)                     
 gridExtra       2.3      2017-09-09 [1] CRAN (R 3.6.2)                     
 gtable          0.3.0    2019-03-25 [1] CRAN (R 3.6.2)                     
 haven           2.2.0    2019-11-08 [1] CRAN (R 3.6.2)                     
 highr           0.8      2019-03-20 [1] CRAN (R 3.6.2)                     
 hms             0.5.3    2020-01-08 [1] CRAN (R 3.6.2)                     
 hrbrmisc      * 0.2.0    2020-01-17 [1] Github (hrbrmstr/hrbrmisc@ebb928c) 
 htmltools       0.4.0    2019-10-04 [1] CRAN (R 3.6.2)                     
 htmlwidgets     1.5.1    2019-10-08 [1] CRAN (R 3.6.2)                     
 httpuv          1.5.2    2019-09-11 [1] CRAN (R 3.6.2)                     
 httr            1.4.1    2019-08-05 [1] CRAN (R 3.6.2)                     
 igraph        * 1.2.4.2  2019-11-27 [1] CRAN (R 3.6.2)                     
 janeaustenr     0.1.5    2017-06-10 [1] CRAN (R 3.6.2)                     
 janitor       * 1.2.0    2019-04-21 [1] CRAN (R 3.6.2)                     
 jsonlite        1.6      2018-12-07 [1] CRAN (R 3.6.2)                     
 KernSmooth      2.23-16  2019-10-15 [1] CRAN (R 3.6.2)                     
 later           1.0.0    2019-10-04 [1] CRAN (R 3.6.2)                     
 lattice         0.20-38  2018-11-04 [1] CRAN (R 3.6.2)                     
 lazyeval        0.2.2    2019-03-15 [1] CRAN (R 3.6.2)                     
 lifecycle       0.1.0    2019-08-01 [1] CRAN (R 3.6.2)                     
 lubridate       1.7.4    2018-04-11 [1] CRAN (R 3.6.2)                     
 magrittr        1.5      2014-11-22 [1] CRAN (R 3.6.2)                     
 maps            3.3.0    2018-04-03 [1] CRAN (R 3.6.2)                     
 MASS            7.3-51.4 2019-03-31 [1] CRAN (R 3.6.2)                     
 Matrix          1.2-18   2019-11-27 [1] CRAN (R 3.6.2)                     
 memoise         1.1.0    2017-04-21 [1] CRAN (R 3.6.2)                     
 mime            0.8      2019-12-19 [1] CRAN (R 3.6.2)                     
 miniUI          0.1.1.1  2018-05-18 [1] CRAN (R 3.6.2)                     
 modelr          0.1.5    2019-08-08 [1] CRAN (R 3.6.2)                     
 munsell         0.5.0    2018-06-12 [1] CRAN (R 3.6.2)                     
 nlme            3.1-142  2019-11-07 [1] CRAN (R 3.6.2)                     
 patchwork     * 1.0.0    2019-12-01 [1] CRAN (R 3.6.2)                     
 pillar          1.4.3    2019-12-20 [1] CRAN (R 3.6.2)                     
 pkgbuild        1.0.6    2019-10-09 [1] CRAN (R 3.6.2)                     
 pkgconfig       2.0.3    2019-09-22 [1] CRAN (R 3.6.2)                     
 pkgload         1.0.2    2018-10-29 [1] CRAN (R 3.6.2)                     
 plyr            1.8.5    2019-12-10 [1] CRAN (R 3.6.2)                     
 polyclip        1.10-0   2019-03-14 [1] CRAN (R 3.6.0)                     
 prettyunits     1.1.0    2020-01-09 [1] CRAN (R 3.6.2)                     
 processx        3.4.1    2019-07-18 [1] CRAN (R 3.6.2)                     
 proj4           1.0-8.1  2019-09-07 [1] CRAN (R 3.6.1)                     
 promises        1.1.0    2019-10-04 [1] CRAN (R 3.6.2)                     
 prompt          1.0.0    2020-01-15 [1] Github (gaborcsardi/prompt@b332c42)
 ps              1.3.0    2018-12-21 [1] CRAN (R 3.6.2)                     
 purrr         * 0.3.3    2019-10-18 [1] CRAN (R 3.6.2)                     
 questionr     * 0.7.0    2018-11-26 [1] CRAN (R 3.6.2)                     
 R6              2.4.1    2019-11-12 [1] CRAN (R 3.6.2)                     
 RColorBrewer  * 1.1-2    2014-12-07 [1] CRAN (R 3.6.0)                     
 Rcpp            1.0.3    2019-11-08 [1] CRAN (R 3.6.2)                     
 readODS       * 1.6.7    2018-11-26 [1] CRAN (R 3.6.2)                     
 readr         * 1.3.1    2018-12-21 [1] CRAN (R 3.6.2)                     
 readxl          1.3.1    2019-03-13 [1] CRAN (R 3.6.2)                     
 remotes         2.1.0    2019-06-24 [1] CRAN (R 3.6.2)                     
 reprex          0.3.0    2019-05-16 [1] CRAN (R 3.6.2)                     
 rlang           0.4.2    2019-11-23 [1] CRAN (R 3.6.2)                     
 rprojroot       1.3-2    2018-01-03 [1] CRAN (R 3.6.2)                     
 rstudioapi      0.10     2019-03-19 [1] CRAN (R 3.6.2)                     
 Rttf2pt1        1.3.8    2020-01-10 [1] CRAN (R 3.6.2)                     
 rvest           0.3.5    2019-11-08 [1] CRAN (R 3.6.2)                     
 scales          1.1.0    2019-11-18 [1] CRAN (R 3.6.2)                     
 seleniumPipes   0.3.7    2016-10-01 [1] CRAN (R 3.6.2)                     
 sessioninfo     1.1.1    2018-11-05 [1] CRAN (R 3.6.2)                     
 shiny           1.4.0    2019-10-10 [1] CRAN (R 3.6.2)                     
 SnowballC       0.6.0    2019-01-15 [1] CRAN (R 3.6.0)                     
 storr           1.2.1    2018-10-18 [1] CRAN (R 3.6.2)                     
 stringi         1.4.5    2020-01-11 [1] CRAN (R 3.6.2)                     
 stringr       * 1.4.0    2019-02-10 [1] CRAN (R 3.6.2)                     
 testthat        2.3.1    2019-12-01 [1] CRAN (R 3.6.2)                     
 tibble        * 2.1.3    2019-06-06 [1] CRAN (R 3.6.2)                     
 tidygraph       1.1.2    2019-02-18 [1] CRAN (R 3.6.2)                     
 tidyr         * 1.0.0    2019-09-11 [1] CRAN (R 3.6.2)                     
 tidyselect      0.2.5    2018-10-11 [1] CRAN (R 3.6.2)                     
 tidytext      * 0.2.2    2019-07-29 [1] CRAN (R 3.6.2)                     
 tidyverse     * 1.3.0    2019-11-21 [1] CRAN (R 3.6.2)                     
 tokenizers      0.2.1    2018-03-29 [1] CRAN (R 3.6.2)                     
 tweenr          1.0.1    2018-12-14 [1] CRAN (R 3.6.2)                     
 txtq            0.2.0    2019-10-15 [1] CRAN (R 3.6.2)                     
 usethis         1.5.1    2019-07-04 [1] CRAN (R 3.6.2)                     
 vctrs           0.2.1    2019-12-17 [1] CRAN (R 3.6.2)                     
 viridis         0.5.1    2018-03-29 [1] CRAN (R 3.6.2)                     
 viridisLite   * 0.3.0    2018-02-01 [1] CRAN (R 3.6.2)                     
 visdat        * 0.5.3    2019-02-15 [1] CRAN (R 3.6.2)                     
 whisker         0.4      2019-08-28 [1] CRAN (R 3.6.2)                     
 withr           2.1.2    2018-03-15 [1] CRAN (R 3.6.2)                     
 xml2            1.2.2    2019-08-09 [1] CRAN (R 3.6.2)                     
 xtable          1.8-4    2019-04-21 [1] CRAN (R 3.6.2)                     
 zeallot         0.1.0    2018-01-28 [1] CRAN (R 3.6.2)                   

[1] C:/Program Files/R/R-3.6.2/library
```
