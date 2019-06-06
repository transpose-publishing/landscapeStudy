library(tidyverse)
theme_set(hrbrmisc::theme_hrbrmstr())

base_data <- read_csv("data-transformed/joined_data.csv")

refined <- base_data %>% 
  mutate(pr_type_clean = case_when(
    str_detect(pr_type, "^Double") ~ "double blind",
    str_detect(pr_type, "^Other") ~ "other",
    str_detect(pr_type, "^Single") ~ "single blind",
    str_detect(pr_type, "^Not") ~ "not blinded",
    TRUE ~ "unsure"
  )) 

refined %>% 
  count(pr_type_clean)

ggplot(refined, aes(pr_type_clean)) +
  geom_bar()

ggplot(refined, aes(pr_type_clean)) +
  geom_bar() +
  facet_wrap()

# todo: create a set where the column "top journals in" is splitted (by ",")
# with separate rows
