# Publishing policies are unclear in most major journals

This repository holds code and data for this paper: LINK TO PREPRINT/PAPER.


## Reproducible code
The whole analytic pipeline is reproducible throug the `drake` package. 
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


## Further ressources
You can find more information on the `drake` package here: 
https://books.ropensci.org/drake/



## Package versions used
The analysis was last rendered with the following package versions:

```
─ Session info ─────────────────────────────────────────
 setting  value                       
 version  R version 3.6.1 (2019-07-05)
 os       Windows 10 x64              
 system   x86_64, mingw32             
 ui       RStudio                     
 language (EN)                        
 collate  German_Austria.1252         
 ctype    German_Austria.1252         
 tz       Europe/Berlin               
 date     2019-12-20                  

─ Packages ─────────────────────────────────────────────
 package       * version  date       lib source                            
 ash             1.0-15   2015-09-01 [1] CRAN (R 3.6.0)                    
 assertthat      0.2.1    2019-03-21 [1] CRAN (R 3.6.1)                    
 backports       1.1.5    2019-10-02 [1] CRAN (R 3.6.1)                    
 base64enc       0.1-3    2015-07-28 [1] CRAN (R 3.6.0)                    
 base64url       1.4      2018-05-14 [1] CRAN (R 3.6.1)                    
 broom           0.5.3    2019-12-14 [1] CRAN (R 3.6.1)                    
 ca            * 0.71     2018-10-10 [1] CRAN (R 3.6.1)                    
 callr           3.4.0    2019-12-09 [1] CRAN (R 3.6.1)                    
 cellranger      1.1.0    2016-07-27 [1] CRAN (R 3.6.1)                    
 cli             2.0.0    2019-12-09 [1] CRAN (R 3.6.1)                    
 colorspace      1.4-1    2019-03-18 [1] CRAN (R 3.6.1)                    
 crayon          1.3.4    2017-09-16 [1] CRAN (R 3.6.1)                    
 curl            4.3      2019-12-02 [1] CRAN (R 3.6.1)                    
 DBI             1.1.0    2019-12-15 [1] CRAN (R 3.6.1)                    
 dbplyr          1.4.2    2019-06-17 [1] CRAN (R 3.6.1)                    
 desc            1.2.0    2018-05-01 [1] CRAN (R 3.6.1)                    
 devtools        2.2.1    2019-09-24 [1] CRAN (R 3.6.1)                    
 digest          0.6.23   2019-11-23 [1] CRAN (R 3.6.1)                    
 dplyr         * 0.8.3    2019-07-04 [1] CRAN (R 3.6.1)                    
 drake         * 7.8.0    2019-12-02 [1] CRAN (R 3.6.1)                    
 ellipsis        0.3.0    2019-09-20 [1] CRAN (R 3.6.1)                    
 extrafont       0.17     2014-12-08 [1] CRAN (R 3.6.0)                    
 extrafontdb     1.0      2012-06-11 [1] CRAN (R 3.6.0)                    
 fansi           0.4.0    2018-10-05 [1] CRAN (R 3.6.1)                    
 farver          2.0.1    2019-11-13 [1] CRAN (R 3.6.1)                    
 fastmap         1.0.1    2019-10-08 [1] CRAN (R 3.6.1)                    
 fastmatch     * 1.1-0    2017-01-28 [1] CRAN (R 3.6.0)                    
 filelock        1.0.2    2018-10-05 [1] CRAN (R 3.6.1)                    
 forcats       * 0.4.0    2019-02-17 [1] CRAN (R 3.6.1)                    
 formatR         1.7      2019-06-11 [1] CRAN (R 3.6.1)                    
 fs              1.3.1    2019-05-06 [1] CRAN (R 3.6.1)                    
 gargle        * 0.4.0.9002 2019-12-20 [1] Github (r-lib/gargle@13c2549)
 generics        0.0.2    2018-11-29 [1] CRAN (R 3.6.1)                    
 ggalt         * 0.4.0    2017-02-15 [1] CRAN (R 3.6.1)                    
 ggchicklet    * 0.2.0    2019-09-14 [1] local                             
 ggforce         0.3.1    2019-08-20 [1] CRAN (R 3.6.1)                    
 ggplot2       * 3.2.1    2019-08-10 [1] CRAN (R 3.6.1)                    
 ggraph        * 2.0.0    2019-09-02 [1] CRAN (R 3.6.1)                    
 ggrepel         0.8.1    2019-05-07 [1] CRAN (R 3.6.1)                    
 ggridges      * 0.5.1    2018-09-27 [1] CRAN (R 3.6.1)                    
 glue            1.3.1    2019-03-12 [1] CRAN (R 3.6.1)                    
 googlesheets4 * 0.1.0    2019-11-04 [1] CRAN (R 3.6.1)                    
 graphlayouts    0.5.0    2019-08-20 [1] CRAN (R 3.6.1)                    
 gridExtra       2.3      2017-09-09 [1] CRAN (R 3.6.1)                    
 gtable          0.3.0    2019-03-25 [1] CRAN (R 3.6.1)                    
 haven           2.2.0    2019-11-08 [1] CRAN (R 3.6.1)                    
 highr           0.8      2019-03-20 [1] CRAN (R 3.6.1)                    
 hms             0.5.2    2019-10-30 [1] CRAN (R 3.6.1)                    
 hrbrmisc      * 0.2.0    2019-11-26 [1] Github (hrbrmstr/hrbrmisc@ebb928c)
 htmltools       0.4.0    2019-10-04 [1] CRAN (R 3.6.1)                    
 htmlwidgets     1.5.1    2019-10-08 [1] CRAN (R 3.6.1)                    
 httpuv          1.5.2    2019-09-11 [1] CRAN (R 3.6.1)                    
 httr            1.4.1    2019-08-05 [1] CRAN (R 3.6.1)                    
 igraph        * 1.2.4.2  2019-11-27 [1] CRAN (R 3.6.1)                    
 janeaustenr     0.1.5    2017-06-10 [1] CRAN (R 3.6.1)                    
 janitor       * 1.2.0    2019-04-21 [1] CRAN (R 3.6.1)                    
 jsonlite        1.6      2018-12-07 [1] CRAN (R 3.6.1)                    
 KernSmooth      2.23-15  2015-06-29 [2] CRAN (R 3.6.1)                    
 later           1.0.0    2019-10-04 [1] CRAN (R 3.6.1)                    
 lattice         0.20-38  2018-11-04 [2] CRAN (R 3.6.1)                    
 lazyeval        0.2.2    2019-03-15 [1] CRAN (R 3.6.1)                    
 lifecycle       0.1.0    2019-08-01 [1] CRAN (R 3.6.1)                    
 lubridate       1.7.4    2018-04-11 [1] CRAN (R 3.6.1)                    
 magrittr        1.5      2014-11-22 [1] CRAN (R 3.6.1)                    
 maps            3.3.0    2018-04-03 [1] CRAN (R 3.6.1)                    
 MASS            7.3-51.4 2019-03-31 [2] CRAN (R 3.6.1)                    
 Matrix          1.2-17   2019-03-22 [2] CRAN (R 3.6.1)                    
 memoise         1.1.0    2017-04-21 [1] CRAN (R 3.6.1)                    
 mime            0.7      2019-06-11 [1] CRAN (R 3.6.0)                    
 miniUI          0.1.1.1  2018-05-18 [1] CRAN (R 3.6.1)                    
 modelr          0.1.5    2019-08-08 [1] CRAN (R 3.6.1)                    
 munsell         0.5.0    2018-06-12 [1] CRAN (R 3.6.1)                    
 nlme            3.1-140  2019-05-12 [2] CRAN (R 3.6.1)                    
 patchwork     * 1.0.0    2019-12-01 [1] CRAN (R 3.6.1)                    
 pillar          1.4.3    2019-12-20 [1] CRAN (R 3.6.1)                    
 pkgbuild        1.0.6    2019-10-09 [1] CRAN (R 3.6.1)                    
 pkgconfig       2.0.3    2019-09-22 [1] CRAN (R 3.6.1)                    
 pkgload         1.0.2    2018-10-29 [1] CRAN (R 3.6.1)                    
 plyr            1.8.5    2019-12-10 [1] CRAN (R 3.6.1)                    
 polyclip        1.10-0   2019-03-14 [1] CRAN (R 3.6.0)                    
 prettyunits     1.0.2    2015-07-13 [1] CRAN (R 3.6.1)                    
 processx        3.4.1    2019-07-18 [1] CRAN (R 3.6.1)                    
 proj4           1.0-8.1  2019-09-07 [1] CRAN (R 3.6.1)                    
 promises        1.1.0    2019-10-04 [1] CRAN (R 3.6.1)                    
 ps              1.3.0    2018-12-21 [1] CRAN (R 3.6.1)                    
 purrr         * 0.3.3    2019-10-18 [1] CRAN (R 3.6.1)                    
 questionr     * 0.7.0    2018-11-26 [1] CRAN (R 3.6.1)                    
 R6              2.4.1    2019-11-12 [1] CRAN (R 3.6.1)                    
 RColorBrewer  * 1.1-2    2014-12-07 [1] CRAN (R 3.6.0)                    
 Rcpp            1.0.3    2019-11-08 [1] CRAN (R 3.6.1)                    
 readr         * 1.3.1    2018-12-21 [1] CRAN (R 3.6.1)                    
 readxl          1.3.1    2019-03-13 [1] CRAN (R 3.6.1)                    
 remotes         2.1.0    2019-06-24 [1] CRAN (R 3.6.1)                    
 reprex          0.3.0    2019-05-16 [1] CRAN (R 3.6.1)                    
 rlang           0.4.2    2019-11-23 [1] CRAN (R 3.6.1)                    
 rprojroot       1.3-2    2018-01-03 [1] CRAN (R 3.6.1)                    
 rstudioapi      0.10     2019-03-19 [1] CRAN (R 3.6.1)                    
 Rttf2pt1        1.3.7    2018-06-29 [1] CRAN (R 3.6.0)                    
 rvest           0.3.5    2019-11-08 [1] CRAN (R 3.6.1)                    
 scales          1.1.0    2019-11-18 [1] CRAN (R 3.6.1)                    
 seleniumPipes   0.3.7    2016-10-01 [1] CRAN (R 3.6.1)                    
 sessioninfo     1.1.1    2018-11-05 [1] CRAN (R 3.6.1)                    
 shiny           1.4.0    2019-10-10 [1] CRAN (R 3.6.1)                    
 SnowballC       0.6.0    2019-01-15 [1] CRAN (R 3.6.0)                    
 storr           1.2.1    2018-10-18 [1] CRAN (R 3.6.1)                    
 stringi         1.4.3    2019-03-12 [1] CRAN (R 3.6.0)                    
 stringr       * 1.4.0    2019-02-10 [1] CRAN (R 3.6.1)                    
 testthat        2.3.1    2019-12-01 [1] CRAN (R 3.6.1)                    
 tibble        * 2.1.3    2019-06-06 [1] CRAN (R 3.6.1)                    
 tidygraph       1.1.2    2019-02-18 [1] CRAN (R 3.6.1)                    
 tidyr         * 1.0.0    2019-09-11 [1] CRAN (R 3.6.1)                    
 tidyselect      0.2.5    2018-10-11 [1] CRAN (R 3.6.1)                    
 tidytext      * 0.2.2    2019-07-29 [1] CRAN (R 3.6.1)                    
 tidyverse     * 1.3.0    2019-11-21 [1] CRAN (R 3.6.1)                    
 tokenizers      0.2.1    2018-03-29 [1] CRAN (R 3.6.1)                    
 tweenr          1.0.1    2018-12-14 [1] CRAN (R 3.6.1)                    
 txtq            0.2.0    2019-10-15 [1] CRAN (R 3.6.1)                    
 usethis         1.5.1    2019-07-04 [1] CRAN (R 3.6.1)                    
 vctrs           0.2.0    2019-07-05 [1] CRAN (R 3.6.1)                    
 viridis         0.5.1    2018-03-29 [1] CRAN (R 3.6.1)                    
 viridisLite     0.3.0    2018-02-01 [1] CRAN (R 3.6.1)                    
 visdat        * 0.5.3    2019-02-15 [1] CRAN (R 3.6.1)                    
 whisker         0.4      2019-08-28 [1] CRAN (R 3.6.1)                    
 withr           2.1.2    2018-03-15 [1] CRAN (R 3.6.1)                    
 xml2            1.2.2    2019-08-09 [1] CRAN (R 3.6.1)                    
 xtable          1.8-4    2019-04-21 [1] CRAN (R 3.6.1)                    
 zeallot         0.1.0    2018-01-28 [1] CRAN (R 3.6.1)                    

[1] C:/Users/Thomas Klebel/Documents/R/win-library/3.6
[2] C:/Program Files/R/R-3.6.1/library
```
