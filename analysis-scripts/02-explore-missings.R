# this script aims at exploring and displaying, which colums need fixing.
library(tidyverse)
library(visdat)
library(here)
source(here("R/helpers.R"))

theme_set(hrbrmisc::theme_hrbrmstr())


# import data
refined <- read_csv(here("data/transformed/refined.csv"))
refined_with_areas <- read_csv(here("data/transformed/refined_w_areas.csv"))


# general overview
refined %>%
  vis_miss()

# only columns with missing data
with_missings <- refined %>%
  select(-starts_with("G_"), -ends_with("clean")) %>%
  select_if(~any(is.na(.))) %>%
  # remove a few columns where missing data is ok
  select(-starts_with("review date"),
         -starts_with("To dis"),
         -starts_with("Time ta"),
         -starts_with("Review"),
         -starts_with("Free"),
         # Top journals are being removed as well, since these are legit
         # missings
         -starts_with("Top journals in")
         )

with_missings %>%
  vis_miss() +
  theme(plot.margin = margin(r = 50))
