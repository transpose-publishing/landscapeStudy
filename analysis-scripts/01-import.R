# This script aims at importing two datasets and merging them:
# - data from GoogleScholar ond the h-index of journals
# - data from the landscape study, which should then be analysed

library(tidyverse)
library(readxl)
library(janitor)

# Import GS data ----
gs_dat <- read_excel("data-raw/Compiled_Landscape study journals list.xlsx",
                     sheet = "G_ALL_dedup")

gs_dat <- select(gs_dat, -contains("Reviewer"), issn = ISSN, 
                 gs_title = `Journal Title`)

# fix error for American Journal of Political Science: rank was missing
gs_dat <- gs_dat %>% 
  mutate(G_SS_rank = case_when(
    issn == "1540-5907" ~ 8,
    TRUE ~ G_SS_rank)
  )

# Import landscape data ----
# we are re-doing the import which was done by Jessica inside the sheet.
# so we have to import the raw sheet, and then take either the first or the
# third row.
transpose <- read_excel("data-raw/TRANSPOSE landscape study - 2019-06-02.xlsx",
                        sheet = "Raw") %>% 
  slice(-1:-2) %>% 
  # https://stackoverflow.com/a/46895151/3149349
  mutate_at(vars(starts_with("review date")), ~excel_numeric_to_date(as.numeric(.))) %>% 
  rename(review_date_1 = `review date...3`, review_date_2 = `review date...5`,
         review_date_3 = `review 3 date`,
         top_journals_in = starts_with("Top journals"))


# remove dashes from names and replace with underscores
old_names <- names(transpose)
new_names <- str_replace_all(old_names, "-", "_")
names(transpose) <- new_names

# take the first row for general information
first_part <- transpose %>% 
  # drop the column "Property" since it doesn't hold any additional information
  select(`reviewer 1`:publisher, -`To discuss`) %>% 
  mutate(group = rep(1:3, length.out = n())) %>% 
  filter(group == 1) %>% 
  select(-group)

# take the third row for result of review
second_part <- transpose %>% 
  select(pr_type:`Reviewer 2 changes`) %>% 
  mutate(group = rep(1:3, length.out = n())) %>% 
  filter(group == 3) %>% 
  select(-group)

transpose_clean <- bind_cols(first_part, second_part)


# just to check, whether there are any changes, we import the Filtered sheet as
# well and check if they are identical

# there are some annoying columns with inconsistent date formats, which are not
# relevant. info on publisher needs to be removed, since this was the reason for
# the whole exercise (having missing publishers)
transpose_test <- bind_cols(first_part, second_part) %>% 
  select(-starts_with("review_date"), -publisher)

# import filtered data and do some renaming
transpose_raw <- read_excel("data-raw/TRANSPOSE landscape study - 2019-06-02.xlsx",
                        sheet = "Filtered") %>% 
  select(-starts_with("To dis")) %>% 
  select(-`review date...2`, -`review date...4`, -`review 3 date`,
         top_journals_in = starts_with("Top journals"),
         -publisher) 


old_names <- names(transpose_raw)
new_names <- str_replace_all(old_names, "-", "_")
names(transpose_raw) <- new_names

if (all.equal(transpose_test, transpose_raw)) {
  "Everything is fine!"
} else {
  stop("There is a problem here!!", call. = FALSE)
}


# export the newly filtered data as csv
write_csv(transpose_clean, "data-transformed/before_manual_fixing.csv")


# What will be fixed:
# - missing publisher
# - missing data in other places

transpose_fixed <- read_csv("data-transformed/after_manual_fixing.csv")




# Merge datasets -----
# two issn's are problematic:
# - for "Neural Information Processing Systems (NIPS)" there is no issn
# - for "Annals of the Rheumatic Diseases", once online and once print issn 
# where used.


# steps to solve:
# - dummy issn for NIPS
# - change issn to online version
gs_dat <- gs_dat %>% 
  mutate(issn = case_when(str_detect(gs_title, "Rheuma") ~ "1468-2060",
                          str_detect(gs_title, "NIPS") ~ "NIPS-ISSN",
                          TRUE ~ issn))

transpose_fixed <- transpose_fixed %>% 
  mutate(issn = case_when(str_detect(title, "NIPS") ~ "NIPS-ISSN",
                          TRUE ~ issn))


joined_dataset <- transpose_fixed %>% 
  full_join(gs_dat)


# check if matching went right -----
check1 <- transpose_fixed %>% 
  anti_join(gs_dat, by = "issn") %>% 
  nrow() 

check2  <- gs_dat %>% 
  anti_join(transpose_fixed, by = "issn") %>% 
  nrow()

if (any(check1 != 0, check2 != 0)) {
  stop("Matching wasn't sucessful! Please check the output!")
} else {
  # write result to disk 
  write_csv(joined_dataset, "data-transformed/joined_data.csv")
  
}


# import list of variables for ease of use
transpose_vars <- read_excel(
  "data-raw/TRANSPOSE landscape study - 2019-06-02.xlsx",
  sheet = "Raw", n_max = 2)
  
part1 <- transpose_vars %>% 
  slice(1) %>% 
  gather(variable, description) %>% 
  slice(-1)

part2 <- transpose_vars %>% 
  slice(2) %>% 
  gather(variable, type) %>% 
  slice(-1)

part1 %>% 
  left_join(part2) %>% 
  mutate(var_number = 1:n())   -> var_overview

write_csv(var_overview, "data-transformed/var_overview.csv")
