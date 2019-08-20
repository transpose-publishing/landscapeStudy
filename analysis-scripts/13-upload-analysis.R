# For uploading to google drive, the following function was used.

# devtools::install_github("MilesMcBain/markdrive")

markdrive::gdoc_render("analysis-scripts/12-analysis-writeup.Rmd",
                       "analysis-writeup")
