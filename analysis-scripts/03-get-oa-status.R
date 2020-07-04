library(tidyverse)
library(jaod)
library(jsonlite)

refined <- read_csv(here::here("data/transformed/refined.csv"))


# filter out two journals that have no proper issn
refined_clean <- refined %>%
  filter(!str_detect(issn, "Only ISBN|NIPS"))


# create list of vectors for querying, since the API seems to not allow too
# complex queries (nesting all the issn's via "... OR ..." does not work)

issns_split <- refined_clean %>%
  pull(issn) %>%
  split(1:20)

# create queries
create_query <- function(x) paste0("issn:", paste(x, collapse = " OR "))

queries <- issns_split %>%
  map(create_query)

# function for querying the API without hitting the rate limit
safe_search <- function(x) {

  safe_fun <- safely(jaod_journal_search)

  res <- safe_fun(x)

  Sys.sleep(runif(1, 5, 10))

  res

}


# get results
results <- map(queries, safe_search)
results

# flatten them into a tibble
flat_results <- results %>%
  transpose() %>%
  .$result %>%
  map(`[`, "results") %>%
  flatten_df()


selected_results <- flat_results %>%
  unnest(bibjson.identifier) %>%
  select(issn = id1, bibjson.title, bibjson.publisher, bibjson.oa_start.year,
         issn_type = type)


write_csv(selected_results, "data/raw/oa_data.csv")
