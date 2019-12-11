# For uploading to google drive, the following function was used.
#
# The following code block needs to be inserted into the second chunk (import)
# at the top:
# source("R/packages.R")
# source("R/correspondence_analysis_funs.R")
# source("R/helpers.R")
# source("R/plotting_functions.R")
# source("R/drake_functions.R")

# devtools::install_github("MilesMcBain/markdrive")

markdrive::gdoc_render("02-analysis-writeup.Rmd",
                       "analysis-writeup")
