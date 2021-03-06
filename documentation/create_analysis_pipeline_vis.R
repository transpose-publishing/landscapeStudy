library(drake)
source("R/packages.R")
source("R/correspondence_analysis_funs.R")
source("R/helpers.R")
source("R/plotting_functions.R")
source("R/drake_functions.R")
source("R/plan.R")
res <- drake_graph_info(plan)

# remove some function calls
res$nodes <- filter(res$nodes, !str_detect(label, "::"))

render_drake_graph(res, file = "analysis_pipeline.html")

# two tweaks were added manually to the html file before taking a screenshot:
# 1. the colour was changed to "#228B22" for all nodes that were out of date
# 2. the script for the html-widget was changed so the display would be wider:
# `"browser":{"width":1800,"height":800,"padding":40,"fill":false`
