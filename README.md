# Working title: Publishing policies are unclear in the majority of journals

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


Some data wrangling was necessary before conducting the analysis. The output of
these operations are the files `data/refined.csv` and `data/refined_w_areas.csv`.
The latter file contains more rows, since some journals belong to more than
one area in GoogleScholarMetrics (GSM). Those journals have duplicate entries 
except for the column `area` which specifies the GSM area.


## Further ressources
You can find more information on the `drake` package here: 
https://books.ropensci.org/drake/



