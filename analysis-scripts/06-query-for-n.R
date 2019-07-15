library(rcrossref)
library(tidyverse)

# import data
refined <- read_csv(here::here("data-transformed/refined.csv"))

find_articles <- function(issn) {
  journals <- cr_journals(
    issn, works = T, limit = 100,
    cursor = "*", cursor_max = 50000,
    filter = c(from_pub_date = 2017, until_pub_date = 2018),
    .progress = FALSE)

  journals[["data"]]
}


scrape_chunks <- function(issn_spec, out_path) {

  articles <- map_df(issn_spec[["issn"]], find_articles) %>%
    select(container.title:volume)

  write_csv(articles, file.path(out_path, paste0("chunk-", issn_spec[["chunk"]],
                                                 ".csv")))
}

test_issns <- refined %>%
  head(5) %>%
  select(issn) %>%
  mutate(chunk = rep_along(issn, 1:10))


test_issns %>%
  split(.$chunk) %>%
  walk(scrape_chunks, here::here("data-transformed/crossref-data/"))



## code for analysis
# list.files(path = "data-transformed/crossref-data/", full.names = T) %>%
# map_df(read_csv, col_types = cols(.default = col_character())) -> res
#
#
# res_cleaned <- res %>%
#   type_convert()
