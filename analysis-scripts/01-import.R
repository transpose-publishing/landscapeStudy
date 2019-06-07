# This script aims at importing two datasets and merging them:
# - data from GoogleScholar ond the h-index of journals
# - data from the landscape study, which should then be analysed

library(tidyverse)
library(readxl)

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
transpose <- read_excel("data-raw/TRANSPOSE landscape study - 2019-06-02.xlsx",
                        sheet = "Filtered")

# remove dashes from names and replace with underscores
old_names <- names(transpose)
new_names <- str_replace_all(old_names, "-", "_")
names(transpose) <- new_names


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

transpose <- transpose %>% 
  mutate(issn = case_when(str_detect(title, "NIPS") ~ "NIPS-ISSN",
                          TRUE ~ issn))


joined_dataset <- transpose %>% 
  full_join(gs_dat)


# check if matching went right -----
check1 <- transpose %>% 
  anti_join(gs_dat, by = "issn") %>% 
  nrow() 

check2  <- gs_dat %>% 
  anti_join(transpose, by = "issn") %>% 
  nrow()

if (any(check1 != 0, check2 != 0)) {
  stop("Matching wasn't sucessful! Please check the output!")
} else {
  # write result to disk 
  write_csv(joined_dataset, "data-transformed/joined_data.csv")
  
}

