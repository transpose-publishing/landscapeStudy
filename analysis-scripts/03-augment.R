library(tidyverse)
theme_set(hrbrmisc::theme_hrbrmstr())

# import data
base_data <- read_csv("data-transformed/joined_data.csv")

# create clean variable for peer review type
refined <- base_data %>% 
  mutate(pr_type_clean = case_when(
    str_detect(pr_type, "^Double") ~ "double blind",
    str_detect(pr_type, "^Other") ~ "other",
    str_detect(pr_type, "^Single") ~ "single blind",
    str_detect(pr_type, "^Not") ~ "not blinded",
    TRUE ~ "unsure"
  )) 



# data on subject area is a bit messy -> there is no way to split it directly
# we first create a variable with the full area names. then we squash it into
# one row and tuck it onto the original data frame.

recoded <- refined %>% 
  select(issn, starts_with("G_"), -G_100_rank) %>% 
  gather(area, score, -issn) %>% 
  drop_na() %>% 
  mutate(area_clean = case_when(
    str_detect(area, "BEM") ~ "Business, Economics & Life Sciences",
    str_detect(area, "CMS") ~ "Chemical & Materials Sciences", 
    str_detect(area, "ECS") ~ "Engineering & Computer Science",
    str_detect(area, "HMS") ~ "Health & Medical Sciences",
    str_detect(area, "HLA") ~ "Humanities, Literature & Arts", 
    str_detect(area, "LSES") ~ "Life Sciences & Earth Sciences",
    str_detect(area, "PM") ~ "Physics & Mathematics",
    str_detect(area, "SS") ~ "Social Sciences"
  )) %>% 
  select(issn, area = area_clean) %>% 
  arrange(issn) 

subject_areas <- recoded %>% 
  group_by(issn) %>% 
  mutate(area_combined = list(unique(area))) %>% 
  slice(1) %>% 
  select(-area, area = area_combined)

refined_with_areas <- refined %>% 
  left_join(subject_areas) %>% 
  filter(!map_lgl(area, is.null)) %>% 
  unnest() %>% 
  right_join(refined)

# write augmented datasets to disk
write_csv(refined, "data-transformed/refined.csv")
write_csv(refined_with_areas, "data-transformed/refined_w_areas.csv")
