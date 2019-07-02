# This script aims at importing two datasets and merging them:
# - data from GoogleScholar ond the h-index of journals
# - data from the landscape study, which should then be analysed

library(tidyverse)
library(readxl)
library(janitor)
library(landscapeStudy)

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
transpose_clean <- read_excel("data-raw/TRANSPOSE landscape study - 2019-06-02.xlsx",
                        sheet = "Raw", .name_repair = "universal") %>%
  clean_raw_sheet(source = "excel")



# just to check, whether there are any changes, we import the Filtered sheet as
# well and check if they are identical

# there are some annoying columns with inconsistent date formats, which are not
# relevant. info on publisher needs to be removed, since this was the reason for
# the whole exercise (having missing publishers)
transpose_test <- transpose_clean %>%
  select(-starts_with("review_date"), -publisher)

# import filtered data and do some renaming
transpose_raw <- read_excel("data-raw/TRANSPOSE landscape study - 2019-06-02.xlsx",
                        sheet = "Filtered", .name_repair = "universal") %>%
  select(-starts_with("To dis")) %>%
  select(-`review.date...2`, -`review.date...4`, -`review.3.date`,
         top_journals_in = starts_with("Top.journals"),
         -publisher)


old_names <- names(transpose_raw)
new_names <- str_replace_all(old_names, "\\.", "_")
names(transpose_raw) <- new_names

if (identical(transpose_test, transpose_raw)) {
  "Everything is fine!"
} else {
  cat(all.equal(transpose_test, transpose_raw), "\n")
  stop("There is a problem here!!", call. = FALSE)
}


# export the newly filtered data as csv
write_csv(transpose_clean, "data-transformed/before_manual_fixing.csv")


# What will be fixed:
# - missing publisher
# - missing data in other places
#
# diffing can be done via:
# git diff --color-words="[^[:space:],]+" *after*
# git diff --color-words="[^[:space:],]+" 16ad54bf e1e2b554
# git diff --no-index --color-words="[^[:space:],]+" before_manual_fixing.csv after_manual_fixing.csv
# the last one is not very helpful since quoting changes a lot of things...
# --no-index is needed, since these are two uncommited files

transpose_fixed <- read_csv("data-transformed/before_manual_fixing.csv")




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
