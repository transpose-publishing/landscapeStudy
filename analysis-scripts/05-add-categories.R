library(tidyverse)
library(visdat)
library(here)
source(here("R/helpers.R"))

theme_set(hrbrmisc::theme_hrbrmstr())


# import data
refined <- read_csv(here("data-transformed/refined.csv"))
refined_with_areas <- read_csv(here("data-transformed/refined_w_areas.csv"))



missing_areas <- refined_with_areas %>% 
  select(title, issn, area) %>% 
  filter(is.na(area))


data_from_gs <- read_csv("data-transformed/gs_scraped_total.csv") %>% 
  rename(title = Publication) %>% 
  mutate(title = str_remove(title, "[^[:alnum:] ]") %>% 
           str_remove('"'))

with_matched <- missing_areas %>% 
  mutate(title = str_remove(title, "[^[:alnum:] ]")) %>% 
  full_join(data_from_gs) %>% 
  filter(!is.na(issn))

with_matched <- with_matched %>% 
  mutate(parent_field = str_extract(id, ".{3}")) %>% 
  mutate(area = case_when(
    str_detect(parent_field, "bus") ~ "Business, Economics & Management",
    str_detect(parent_field, "chm") ~ "Chemical & Materials Sciences", 
    str_detect(parent_field, "eng") ~ "Engineering & Computer Science",
    str_detect(parent_field, "med") ~ "Health & Medical Sciences",
    str_detect(parent_field, "hum") ~ "Humanities, Literature & Arts", 
    str_detect(parent_field, "bio") ~ "Life Sciences & Earth Sciences",
    str_detect(parent_field, "phy") ~ "Physics & Mathematics",
    str_detect(parent_field, "soc") ~ "Social Sciences"
  )) %>% 
  select(-parent_field) %>% 
  arrange(title)


# only 3 journals are in two categories
with_matched %>% 
  group_by(title) %>% 
  mutate(n = n()) %>% 
  filter(n > 1)

write_csv(with_matched, "data-transformed/journals_with_missing_categories.csv")
