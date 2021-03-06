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

vis_drake_graph(plan)
```
A rendered version of the dependency graph is available under
`documentation/analysis_pipeline.png`.


All packages that are used during the analysis are specified in `R/packages.R`.
For the analysis files to render you will need to install the font "Hind" (for
example from [Google Fonts](https://fonts.google.com/)) and 
register it with
[`extrafont`](https://cran.r-project.org/web/packages/extrafont/README.html). 
See the file `load_fonts.R` for specific instructions.


The basis for the paper is `02-analysis-writeup.Rmd` (which is transformed into
`02-analysis-writeup.html` with the `knitr` package). Since writing the paper
was a collaborative effort, we used a GoogleSheet to work on the manuscript. For
this reason, the text in `02-analysis-writeup.html` is not identical to the 
paper, but rather a first draft version. The code and figures are identical to
the paper. Data for all figures has been exported to `data/figures/`.

Initial explorations can be found in `01-overview.html`, as well as 
executing `R/01-explore.R` and `R/02-explore-missings.R`. 

### Code files

**Core files for reproducing the analysis**

|Filename                        |Purpose                                                                    |
|:-------------------------------|:--------------------------------------------------------------------------|
|drake.R                         |Core file for building the analysis. Run with `drake::r_make("drake.R")`.| 
|R/plan.R                        |Describes all inputs and outputs along with the functions processing them.|
|R/packages.R                    |Lists and loads all packages relevant to the analysis.                 |
|R/plotting_functions.R          |Functions for plotting that are re-used in multiple places.            |
|R/drake_functions.R             |Functions that wrap preprocessing tasks as outlined in `plan.R`.|
|R/correspondence_analysis_funs.R|Functions for conducting and plotting the multiple correspondence analysis (Fig 2).|
|R/helpers.R                     |General helper functions.|


**Additional files for scraping and exploring data**

|Filename                       |Purpose                                                                  |
|:------------------------------|:------------------------------------------------------------------------|
|analysis-scripts/01-explore.R   |General exploratory graphs from early in the analysis.|
|analysis-scripts/02-explore-missings.R|Exploration of missing values.|
|analysis-scripts/03-get-oa-status.R|Matching the journals surveyed against the DOAJ to determine whether they are open access or not.|
|analysis-scripts/04-scrape-gs-fields.R |Scraping h5-index and h5-median for all journals from GSM to fill in gaps in the initial data collection.|
|analysis-scripts/05-do-correspondence-analysis.R |Script which records the steps taken while developing the multiple correspondence analysis for figure 2.|
|analysis-scripts/06-clean-coreview.R|Script computing string-distances between co-review-policies to identify duplicates.|
|analysis-scripts/07-print-coreview-policies.Rmd|Notebook that displays all co-review-policies so they can be printed out on paper for further inspection (finding duplicates).|
|analysis-scripts/08-upload-analysis.R|Script used to upload the rendered analysis to GoogleDrive.|





## Data files
The original data file for the data we collected lives in a Google Sheet (A),
which is available here: https://docs.google.com/spreadsheets/d/1WcvxxmDhaV3BwBiIfwC_nEAr6-EKCDD11R6eJ5vZElA/edit?usp=sharing

The original data from Google Scholar Metrics (GSM) on which journals are 
included, alongside data on their respective h5-index (B), is available here:
https://docs.google.com/spreadsheets/d/1Dluo5DNWU4UrmwIZLzqcToioRdyZ1qc1EofAk4ypiW8/edit?usp=sharing

The files were downloaded as `.csv` and `.xlsx` for archival. The analysis 
builds on the `.csv` files, while the `.xlsx` files are supposed to preserve as
much of the original formatting as possible, should the GoogleSheets become 
unavailable one day. These data, along with data which we scraped from
GSM and the DOAJ, as well as a plain language description of the fields from (A)
can be found in the `data/raw` directory.


Some data cleaning was necessary before conducting the analysis. The output of
these operations are the files `data/refined.csv` and `data/refined_w_areas.csv`.
The latter file contains more rows, since some journals belong to more than
one area in GSM. Those journals have duplicate entries 
except for the column `area` which specifies the GSM area.
All subsequent analysis is based on either of the two files (depending on
whether `area` was considered or not). The files - along with other intermediate
data-files - can be found in the directory `data/transformed`. 

### Overview of data files

**Raw data files**

|Filename                        |Purpose                                                               |
|:-------------------------------|:---------------------------------------------------------------------|
|data/raw/TRANSPOSE landscape study - round 3 - Raw.csv|Raw data of the landscape scan on 171 journals. Conducted with the data collection instrument.|
|data/raw/Compiled_Landscape study journals list - G_ALL_dedup.csv |Data from GSM on journals and their respective ranking within the overall top 100 and top 20 per subject area. Retrieved on 2018-10-13.|
|data/raw/data_collection_instrument.csv |This file preserves the instrument used when collecting data on journals.|
|data/raw/gs_scraped_total.csv|All journals listed in GSM as of 2019-06-18, including h5-index and h5-median. This file was generated via the script `analysis-scripts/04-scrape-gs-fields.R`|
|data/raw/oa_data.csv| Data on open access status of all journals surveyed. Generated via `analysis-scripts/04-get-oa-status.R`|



**Transformed data files**

|Filename                        |Purpose                                                                    |
|:-------------------------------|:--------------------------------------------------------------------------|
|data/transformed/refined.csv|Cleaned data from our landscape scan, joined with data from GSM. This file is the basis for the analysis presented in our paper.|
|data/transformed/refined_w_areas.csv|This file is identical to `refined.csv`, except for the additional variable "area" which holds data on the subject category from GSM. Since some journals appear in multiple categories, this file has more rows (193) than `refined.csv` (which has 171 rows on 171 journals).|
|data/transformed/var_overview.csv|Plain language descriptions of the variables in `data/raw/TRANSPOSE landscape study - round 3 - Raw.csv`.|
|data/transformed/coreview-policies.csv|String distances between different coreview policies for detecting duplicates. Produced via `analysis-scripts/06-clean-coreview.R`|
|data/transformed/journals_with_missing_categories.csv|List of journals for which no subject category from GSM is available in `data/raw/Compiled_Landscape study journals list - G_ALL_dedup.csv`. The missing data for these journals is taken from `data/raw/gs_scraped_total.csv`. |
|data/transformed/policies.txt|A plain language file containing the raw text of the journals' policies on coreviewing.




## Further resources
You can find more information on the `drake` package here: 
https://books.ropensci.org/drake/



## Package versions used
The analysis was last rendered with the following package versions:

```
─ Session info ─────────────────────────────────────────
 setting  value                       
 version  R version 4.0.2 (2020-06-22)
 os       Windows 10 x64              
 system   x86_64, mingw32             
 ui       RStudio                     
 language (EN)                        
 collate  German_Austria.1252         
 ctype    German_Austria.1252         
 tz       Europe/Berlin               
 date     2020-07-04                    

─ Packages ─────────────────────────────────────────────
 package       * version  date       lib source                             
 ash             1.0-15   2015-09-01 [1] CRAN (R 4.0.0)                     
 assertthat      0.2.1    2019-03-21 [1] CRAN (R 4.0.0)                     
 backports       1.1.8    2020-06-17 [1] CRAN (R 4.0.2)                     
 base64enc       0.1-3    2015-07-28 [1] CRAN (R 4.0.0)                     
 base64url       1.4      2018-05-14 [1] CRAN (R 4.0.0)                     
 blob            1.2.1    2020-01-20 [1] CRAN (R 4.0.0)                     
 bookdown      * 0.20     2020-06-23 [1] CRAN (R 4.0.2)                     
 broom           0.5.6    2020-04-20 [1] CRAN (R 4.0.0)                     
 ca            * 0.71.1   2020-01-24 [1] CRAN (R 4.0.2)                     
 callr           3.4.3    2020-03-28 [1] CRAN (R 4.0.0)                     
 cellranger      1.1.0    2016-07-27 [1] CRAN (R 4.0.0)                     
 cli             2.0.2    2020-02-28 [1] CRAN (R 4.0.0)                     
 clisymbols      1.2.0    2017-05-21 [1] CRAN (R 4.0.2)                     
 colorspace      1.4-1    2019-03-18 [1] CRAN (R 4.0.0)                     
 crayon          1.3.4    2017-09-16 [1] CRAN (R 4.0.0)                     
 curl            4.3      2019-12-02 [1] CRAN (R 4.0.0)                     
 DBI             1.1.0    2019-12-15 [1] CRAN (R 4.0.0)                     
 dbplyr          1.4.4    2020-05-27 [1] CRAN (R 4.0.0)                     
 desc            1.2.0    2018-05-01 [1] CRAN (R 4.0.0)                     
 devtools        2.3.0    2020-04-10 [1] CRAN (R 4.0.0)                     
 digest          0.6.25   2020-02-23 [1] CRAN (R 4.0.0)                     
 dplyr         * 1.0.0    2020-05-29 [1] CRAN (R 4.0.0)                     
 drake         * 7.12.4   2020-06-29 [1] CRAN (R 4.0.2)                     
 ellipsis        0.3.1    2020-05-15 [1] CRAN (R 4.0.0)                     
 extrafont       0.17     2014-12-08 [1] CRAN (R 4.0.0)                     
 extrafontdb     1.0      2012-06-11 [1] CRAN (R 4.0.0)                     
 fansi           0.4.1    2020-01-08 [1] CRAN (R 4.0.0)                     
 farver          2.0.3    2020-01-16 [1] CRAN (R 4.0.0)                     
 fastmap         1.0.1    2019-10-08 [1] CRAN (R 4.0.2)                     
 fastmatch     * 1.1-0    2017-01-28 [1] CRAN (R 4.0.0)                     
 filelock        1.0.2    2018-10-05 [1] CRAN (R 4.0.0)                     
 forcats       * 0.5.0    2020-03-01 [1] CRAN (R 4.0.0)                     
 formatR         1.7      2019-06-11 [1] CRAN (R 4.0.2)                     
 fs              1.4.2    2020-06-30 [1] CRAN (R 4.0.2)                     
 generics        0.0.2    2018-11-29 [1] CRAN (R 4.0.0)                     
 ggalt         * 0.4.0    2017-02-15 [1] CRAN (R 4.0.2)                     
 ggchicklet    * 0.5.0    2020-06-25 [1] local                              
 ggforce         0.3.2    2020-06-23 [1] CRAN (R 4.0.2)                     
 ggplot2       * 3.3.2    2020-06-19 [1] CRAN (R 4.0.2)                     
 ggraph        * 2.0.3    2020-05-20 [1] CRAN (R 4.0.2)                     
 ggrepel         0.8.2    2020-03-08 [1] CRAN (R 4.0.2)                     
 ggridges      * 0.5.2    2020-01-12 [1] CRAN (R 4.0.2)                     
 glue            1.4.1    2020-05-13 [1] CRAN (R 4.0.0)                     
 graphlayouts    0.7.0    2020-04-25 [1] CRAN (R 4.0.2)                     
 gridExtra       2.3      2017-09-09 [1] CRAN (R 4.0.0)                     
 gtable          0.3.0    2019-03-25 [1] CRAN (R 4.0.0)                     
 haven           2.3.1    2020-06-01 [1] CRAN (R 4.0.0)                     
 highr           0.8      2019-03-20 [1] CRAN (R 4.0.0)                     
 hms             0.5.3    2020-01-08 [1] CRAN (R 4.0.0)                     
 hrbrmisc      * 0.2.0    2020-07-01 [1] Github (hrbrmstr/hrbrmisc@ebb928c) 
 htmltools       0.5.0    2020-06-16 [1] CRAN (R 4.0.0)                     
 htmlwidgets     1.5.1    2019-10-08 [1] CRAN (R 4.0.0)                     
 httpuv          1.5.4    2020-06-06 [1] CRAN (R 4.0.2)                     
 httr            1.4.1    2019-08-05 [1] CRAN (R 4.0.0)                     
 igraph        * 1.2.5    2020-03-19 [1] CRAN (R 4.0.0)                     
 janeaustenr     0.1.5    2017-06-10 [1] CRAN (R 4.0.2)                     
 janitor       * 2.0.1    2020-04-12 [1] CRAN (R 4.0.2)                     
 jsonlite        1.7.0    2020-06-25 [1] CRAN (R 4.0.2)                     
 KernSmooth      2.23-17  2020-04-26 [2] CRAN (R 4.0.2)                     
 knitr           1.29     2020-06-23 [1] CRAN (R 4.0.2)                     
 labelled        2.5.0    2020-06-17 [1] CRAN (R 4.0.2)                     
 later           1.1.0.1  2020-06-05 [1] CRAN (R 4.0.0)                     
 lattice         0.20-41  2020-04-02 [2] CRAN (R 4.0.2)                     
 lifecycle       0.2.0    2020-03-06 [1] CRAN (R 4.0.0)                     
 lubridate       1.7.9    2020-06-08 [1] CRAN (R 4.0.0)                     
 magrittr        1.5      2014-11-22 [1] CRAN (R 4.0.0)                     
 maps            3.3.0    2018-04-03 [1] CRAN (R 4.0.2)                     
 MASS            7.3-51.6 2020-04-26 [2] CRAN (R 4.0.2)                     
 Matrix          1.2-18   2019-11-27 [2] CRAN (R 4.0.2)                     
 memoise         1.1.0    2017-04-21 [1] CRAN (R 4.0.0)                     
 mime            0.9      2020-02-04 [1] CRAN (R 4.0.0)                     
 miniUI          0.1.1.1  2018-05-18 [1] CRAN (R 4.0.2)                     
 modelr          0.1.8    2020-05-19 [1] CRAN (R 4.0.0)                     
 munsell         0.5.0    2018-06-12 [1] CRAN (R 4.0.0)                     
 nlme            3.1-148  2020-05-24 [2] CRAN (R 4.0.2)                     
 patchwork     * 1.0.1    2020-06-22 [1] CRAN (R 4.0.2)                     
 pillar          1.4.4    2020-05-05 [1] CRAN (R 4.0.0)                     
 pkgbuild        1.0.8    2020-05-07 [1] CRAN (R 4.0.0)                     
 pkgconfig       2.0.3    2019-09-22 [1] CRAN (R 4.0.0)                     
 pkgload         1.1.0    2020-05-29 [1] CRAN (R 4.0.0)                     
 plyr            1.8.6    2020-03-03 [1] CRAN (R 4.0.0)                     
 polyclip        1.10-0   2019-03-14 [1] CRAN (R 4.0.0)                     
 prettyunits     1.1.1    2020-01-24 [1] CRAN (R 4.0.0)                     
 processx        3.4.2    2020-02-09 [1] CRAN (R 4.0.0)                     
 progress        1.2.2    2019-05-16 [1] CRAN (R 4.0.0)                     
 proj4           1.0-10   2020-03-02 [1] CRAN (R 4.0.0)                     
 promises        1.1.1    2020-06-09 [1] CRAN (R 4.0.0)                     
 prompt          1.0.0    2020-07-01 [1] Github (gaborcsardi/prompt@b332c42)
 ps              1.3.3    2020-05-08 [1] CRAN (R 4.0.0)                     
 purrr         * 0.3.4    2020-04-17 [1] CRAN (R 4.0.0)                     
 questionr     * 0.7.1    2020-05-26 [1] CRAN (R 4.0.2)                     
 R6              2.4.1    2019-11-12 [1] CRAN (R 4.0.0)                     
 RColorBrewer  * 1.1-2    2014-12-07 [1] CRAN (R 4.0.0)                     
 Rcpp            1.0.4.6  2020-04-09 [1] CRAN (R 4.0.0)                     
 readODS       * 1.6.7    2018-11-26 [1] CRAN (R 4.0.2)                     
 readr         * 1.3.1    2018-12-21 [1] CRAN (R 4.0.0)                     
 readxl          1.3.1    2019-03-13 [1] CRAN (R 4.0.0)                     
 remotes         2.1.1    2020-02-15 [1] CRAN (R 4.0.0)                     
 reprex          0.3.0    2019-05-16 [1] CRAN (R 4.0.0)                     
 rlang           0.4.6    2020-05-02 [1] CRAN (R 4.0.0)                     
 rprojroot       1.3-2    2018-01-03 [1] CRAN (R 4.0.0)                     
 rstudioapi      0.11     2020-02-07 [1] CRAN (R 4.0.0)                     
 Rttf2pt1        1.3.8    2020-01-10 [1] CRAN (R 4.0.0)                     
 rvest           0.3.5    2019-11-08 [1] CRAN (R 4.0.0)                     
 scales          1.1.1    2020-05-11 [1] CRAN (R 4.0.0)                     
 seleniumPipes   0.3.7    2016-10-01 [1] CRAN (R 4.0.2)                     
 sessioninfo     1.1.1    2018-11-05 [1] CRAN (R 4.0.0)                     
 shiny           1.5.0    2020-06-23 [1] CRAN (R 4.0.2)                     
 snakecase       0.11.0   2019-05-25 [1] CRAN (R 4.0.2)                     
 SnowballC       0.7.0    2020-04-01 [1] CRAN (R 4.0.0)                     
 storr           1.2.1    2018-10-18 [1] CRAN (R 4.0.0)                     
 stringi         1.4.6    2020-02-17 [1] CRAN (R 4.0.0)                     
 stringr       * 1.4.0    2019-02-10 [1] CRAN (R 4.0.0)                     
 testthat        2.3.2    2020-03-02 [1] CRAN (R 4.0.0)                     
 tibble        * 3.0.1    2020-04-20 [1] CRAN (R 4.0.0)                     
 tidygraph       1.2.0    2020-05-12 [1] CRAN (R 4.0.2)                     
 tidyr         * 1.1.0    2020-05-20 [1] CRAN (R 4.0.0)                     
 tidyselect      1.1.0    2020-05-11 [1] CRAN (R 4.0.0)                     
 tidytext      * 0.2.4    2020-04-17 [1] CRAN (R 4.0.2)                     
 tidyverse     * 1.3.0    2019-11-21 [1] CRAN (R 4.0.0)                     
 tokenizers      0.2.1    2018-03-29 [1] CRAN (R 4.0.2)                     
 tweenr          1.0.1    2018-12-14 [1] CRAN (R 4.0.2)                     
 txtq            0.2.3    2020-06-23 [1] CRAN (R 4.0.2)                     
 usethis         1.6.1    2020-04-29 [1] CRAN (R 4.0.0)                     
 vctrs           0.3.1    2020-06-05 [1] CRAN (R 4.0.0)                     
 viridis         0.5.1    2018-03-29 [1] CRAN (R 4.0.2)                     
 viridisLite   * 0.3.0    2018-02-01 [1] CRAN (R 4.0.0)                     
 visdat        * 0.5.3    2019-02-15 [1] CRAN (R 4.0.2)                     
 whisker         0.4      2019-08-28 [1] CRAN (R 4.0.0)                     
 withr           2.2.0    2020-04-20 [1] CRAN (R 4.0.0)                     
 xfun            0.15     2020-06-21 [1] CRAN (R 4.0.2)                     
 xml2            1.3.2    2020-04-23 [1] CRAN (R 4.0.0)                     
 xtable          1.8-4    2019-04-21 [1] CRAN (R 4.0.2)                        
```
