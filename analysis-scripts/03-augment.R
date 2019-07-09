library(tidyverse)

# import data
base_data <- read_csv(
  "data-transformed/joined_data.csv",
  col_types = cols(
    .default = col_character(),
    review_date_1 = col_date(format = ""),
    review_date_2 = col_date(format = ""),
    review_date_3 = col_date(format = ""),
    `h5-index` = col_double(),
    `h5-median` = col_double(),
    G_100_rank = col_double(),
    G_BEM_rank = col_double(),
    G_CMS_rank = col_double(),
    G_ECS_rank = col_double(),
    G_HMS_rank = col_double(),
    G_HLA_rank = col_double(),
    G_LSES_rank = col_double(),
    G_PM_rank = col_double(),
    G_SS_rank = col_double()
  ))

# create clean variable for peer review type
refined <- base_data %>%
  mutate(pr_type_clean = case_when(
    str_detect(pr_type, "^Double") ~ "Double blind",
    str_detect(pr_type, "^Other") ~ "Other",
    str_detect(pr_type, "^Single") ~ "Single blind",
    str_detect(pr_type, "^Not") ~ "Not blinded",
    TRUE ~ "Unsure"
  ))


# # check publisher names
# refined %>%
#   count(publisher) %>%
#   arrange(publisher)

refined <- refined %>%
  mutate(publisher_clean = case_when(
    str_detect(publisher, "^American Chemical Society") ~ "American Chemical Society",
    str_detect(publisher, "^American Heart Association") ~ "American Heart Association",
    str_detect(publisher, "^Cell") ~ "Cell Press (Elsevier)",
    str_detect(publisher, "^IEEE") ~ "IEEE",
    str_detect(publisher, "^IOP") ~ "IOP",
    str_detect(publisher, "^SpringerNature") ~ "Springer Nature",
    TRUE ~ publisher
  ))


# fix missings for coreview_policy
refined <- refined %>%
  mutate(coreview_policy = fct_explicit_na(coreview_policy, "Not specified"))


# data on subject area is a bit messy -> there is no way to split it directly
# we first create a variable with the full area names. this can be easily joined
# with the rest of the data via a full_join

recoded <- refined %>%
  select(issn, starts_with("G_"), -G_100_rank) %>%
  gather(area, score, -issn) %>%
  drop_na() %>%
  mutate(area_clean = case_when(
    str_detect(area, "BEM") ~ "Business, Economics & Management",
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


refined_with_areas <- refined %>%
  full_join(recoded, by = "issn")

# data on areas for some journals was not included. here we import the scraped
# data and join it with the rest
hand_coded_areas <- read_csv(
  "data-transformed/journals_with_missing_categories.csv",
  col_types = cols(
    title = col_character(),
    issn = col_character(),
    area = col_character(),
    id = col_character(),
    `h5-index` = col_double(),
    `h5-median` = col_double()
  )) %>%
  select(issn, area) %>%
  mutate(area_was_scraped = TRUE)

refined_with_areas <- refined_with_areas %>%
  full_join(hand_coded_areas, by = "issn") %>%
  mutate(area = coalesce(area.x, area.y)) %>%
  select(-area.y, -area.x) %>%
  replace_na(list(area_was_scraped = FALSE))


# write augmented datasets to disk
write_csv(refined, "data-transformed/refined.csv")
write_csv(refined_with_areas, "data-transformed/refined_w_areas.csv")
