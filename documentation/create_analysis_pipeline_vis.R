library(drake)
library(dplyr)
source("R/plan.R")
res <- drake_graph_info(plan)

# remove some function calls
res$nodes <- filter(res$nodes, !str_detect(label, "::"))

render_drake_graph(res, file = "documentation/analysis_pipeline.html")
