# Coreview policies have duplicates. This file computes string distances to aid
# in detecting duplicates.

library(tidyverse)
refined <- read_csv(here::here("data/refined.csv"))

coreview_policies <- refined %>%
  select(coreview_policy) %>%
  filter(!is.na(coreview_policy),
         !(coreview_policy %in% c("Not specified", "Not found")))

# select clearly distinct policies
starting_set <- coreview_policies %>%
  distinct() %>%
  mutate(index1 = 1:n(),
         index2 = index1)

# create difference matrix based on jaccard distance. we used this from personal
# experience and a bit of trial and error
difference_matrix <- starting_set$coreview_policy %>%
  stringdist::stringdistmatrix(method = "jaccard")



d.matrix <- difference_matrix %>%
  as.matrix()

# delete upper part of matrix to avoid duplication
d.matrix[lower.tri(d.matrix)] <- 0

# gather to long format and match with policy texts for comparing manually
d.matrix %>%
  as_tibble() %>%
  mutate(index1 = 1:n()) %>%
  gather(index2, value, -index1) %>%
  mutate(index2 = as.integer(index2)) %>%
  filter(value != 0) %>%
  arrange(value) %>%
  left_join(starting_set, by = "index1") %>%
  select(-index2.y, index2 = index2.x) %>%
  left_join(starting_set, by = "index2") %>%
  select(-index1.y, index1 = index1.x) %>%
  # top 100 entries should be sufficient to find duplicates
  head(100) %>%
  write_csv("data-transformed/coreview-policies.csv")

