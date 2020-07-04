# The script shows the steps taken to perform the MCA and intermediate steps
# in preparing the final figure.
#
# variables that will be examined:
# - area will be used as a supplementary variable in the last stage
#   -> we thus need the version with duplicated journals that belong to multiple
#   disciplines
# - type of peer review
# - co-review policy
# - posting of preprints
# - citing of preprints
# - reviewers being revealed to authors


library(tidyverse)
library(here)
library(ca)
library(landscapeStudy)

theme_set(hrbrmisc::theme_hrbrmstr())


# import data
refined <- read_csv(here("data/transformed/refined.csv"))
refined_with_areas <- read_csv(here("data/transformed/refined_w_areas.csv"))


recoded <- refined_with_areas %>%
  mutate(
    co_review = case_when(
      coreview_email == "Yes" | coreview_email == "No" ~ "Coreview ++",
      TRUE ~ "Coreview ??"
    ),
    preprint_posting = case_when(
      str_detect(preprint_version, "Unsure") ~ "Preprints posting ??",
      str_detect(preprint_version, "Other|Unclear") ~ "Preprints posting ??",
      str_detect(preprint_version, "None") ~ "Preprints posting ++",
      str_detect(preprint_version, "First sub") ~ "Preprints posting ++",
      str_detect(preprint_version, "After peer re") ~ "Preprints posting ++",
      str_detect(preprint_version, "Any|any") ~ "Preprints posting ++",
      str_detect(preprint_version, "No preprint policy") ~ "Preprints posting ??"
    ),
    preprint_citing = case_when(
      str_detect(preprint_citation, "Not spec") ~ "Citing preprints ??",
      str_detect(preprint_citation, "Unsure") ~ "Citing preprints ??",
      str_detect(preprint_citation, "No") ~ "Citing preprints ++",
      str_detect(preprint_citation, "only in the text") ~ "Citing preprints ++",
      str_detect(preprint_citation, "reference list") ~ "Citing preprints ++",
      preprint_citation == "Yes" ~ "Citing preprints ++",
      TRUE ~ "Citing preprints ??"
    ),
    identities_revealed = case_when(
      opr_indenties_author == "No" | opr_indenties_author == "Not specified" ~ "Reviewer identities not revealed to authors",
      TRUE ~ "Reviewer identities revealed to authors"
    ),
    pr_type_clean = case_when(
      pr_type_clean == "Other" ~ "Other type of peer review",
      pr_type_clean == "Unsure" ~ "Peer review ??",
      TRUE ~ pr_type_clean
    )
  )

# check recodings
recoded %>%
  select(co_review, coreview_email) %>%
  table()

recoded %>%
  count(preprint_posting, preprint_version) %>% View()

recoded %>%
  count(preprint_citing, preprint_citation) %>% View()

recoded %>%
  count(identities_revealed, opr_indenties_author)



# start with MCA
first_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed) %>%
  ca::mjca()


summary(first_round)

first_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()


# add peer review type
second_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean) %>%
  ca::mjca()


summary(second_round)

second_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()

# add area
third_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean, area) %>%
  ca::mjca(supcol = 6)


summary(third_round)

third_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()


# remove two cases that are not blinded
fourth_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean, area) %>%
  filter(pr_type_clean != "Not blinded") %>%
  ca::mjca(supcol = 6)


summary(fourth_round)

fourth_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()



# remove peer review type
fith_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         area) %>%
  ca::mjca(supcol = 5)


summary(fith_round)

fith_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()




# add peer review type as supplemental
sixth_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         area, pr_type_clean) %>%
  ca::mjca(supcol = 5:6)


summary(sixth_round)

sixth_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()


# recode peer review type to fit the coding schema
recoded <- recoded %>%
  mutate(pr_type_cat = case_when(
    pr_type_clean == "No clear policy for peer review" ~ "Peer review -",
    TRUE ~ "Peer review +"
  ))

# check recoding
with(recoded, table(pr_type_cat, pr_type_clean))


seventh_round <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_cat, area) %>%
  ca::mjca(supcol = 6)


summary(seventh_round)

seventh_round %>%
  plot_ca(dimensions = c(1, 2)) +
  coord_fixed()
# this doesnt make a lot of sense. If we want to paint the landscape, it is very
# much structured along the distinction, which type of peer review they use. we
# should keep this distinction and not destroy the structure completely by
# recoding



# go back to round four, but first without disciplines
final_1 <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean) %>%
  filter(pr_type_clean != "Not blinded") %>%
  ca::mjca()


summary(final_1)

final_1 %>%
  plot_ca(font_size = 4) +
  coord_fixed() +
  scale_color_manual(values = c("Initial Variables" = "#1B9E77",
                                "Supplementary Variables" = "#D95F02"))

# and now with everything
final_2 <- recoded %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean, area) %>%
  filter(pr_type_clean != "Not blinded") %>%
  ca::mjca(supcol = 6)



summary(final_2)

final_2 %>%
  plot_ca() +
  coord_fixed() +
  scale_color_manual(values = c("Initial Variables" = "#1B9E77",
                                "Supplementary Variables" = "#D95F02")) +
  labs(title = "The Landscape of Open Science Practices",
       caption = paste(
         "Disciplines were added as supplementary (passive) and have no impact on the space.",
         "`++` means that there is a clear policy, `??` that there is no clear policy",
         sep = "\n"))


# look at the "other type" for peer review in detail again
refined %>% filter(pr_type_clean == "Other")

# maybe it would be good to include publisher as well
refined %>%
  count(publisher_clean, sort = T)


final_3 <- recoded %>%
  mutate(publisher_cat = fct_lump(publisher_clean, n = 2,
                                      other_level = "Other publishers")) %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean, area, publisher_cat) %>%
  filter(pr_type_clean != "Not blinded") %>%
  ca::mjca(supcol = 6:7)



summary(final_3)

final_3 %>%
  plot_ca() +
  coord_fixed() +
  scale_color_manual(values = c("Initial Variables" = "#1B9E77",
                                "Supplementary Variables" = "#D95F02")) +
  labs(title = "The Landscape of Open Science Practices",
       caption = paste(
         "Disciplines and publishers were added as supplementary (passive) and have no impact on the space.",
         "`++` means that there is a clear policy, `??` that there is no clear policy",
         sep = "\n"))


# coding of springer nature for coreview is problematic. The policy is clear in
# my eyes. and since this are 15 journals, it has a large effect on the overall
# space.
# Springer nature is high up in the space, because they all are coded as unsure
# for coreview policy, and this coreview has a large effect on the second
# dimension.
# lets try how this looks, if we change springer nature coding for coreview

test_1 <- recoded %>%
  mutate(publisher_cat = fct_lump(publisher_clean, n = 2,
                                  other_level = "Other publishers"),
         co_review = case_when(publisher_cat == "Springer Nature" ~ "Coreview ++",
                               TRUE ~ co_review),
         pr_type_clean = case_when(publisher_cat == "Springer Nature" ~ "Single blind",
                                   TRUE ~ pr_type_clean)) %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean, area, publisher_cat) %>%
  filter(pr_type_clean != "Not blinded") %>%
  ca::mjca(supcol = 6:7)

summary(test_1)

test_1 %>%
  plot_ca() +
  coord_fixed() +
  scale_color_manual(values = c("Initial Variables" = "#1B9E77",
                                "Supplementary Variables" = "#D95F02")) +
  labs(title = "The Landscape of Open Science Pratices",
       caption = paste(
         "Disciplines and publishers were added as supplementary (passive) and have no impact on the space.",
         "`++` means that there is a clear policy, `??` that there is no clear policy",
         sep = "\n"))

# this is not correct. obviously I can't simply change the data (the model should
# follow the data, not the other way around). Furthermore there is one journal
# (nature communications) that has a slightly different policy that would warrant
# an "unsure" here. Maybe there is a way to interpret this and explain it sensibly
# in text.
#
#
# going back to final 3. but there is no severe reason to include "not blinded"
# I should look at the table again: it has not a big impact on the space, it is
# just strongly correlated with this axis.
# in general is this axis most strongly determined by coreview practices.
# the effect taht single blind and other type of peer review are opposite could
# be explained like this: those journal are generally quite similar, expect in
# terms of co-review and peer review type. both differences could be also
# explained as results from decisions in coding. If springer nature journals
# were simply coded as single blind and with coreview ++, this dimension would
# vanish. (as can be seen from above).
final_4 <- recoded %>%
  mutate(publisher_cat = fct_lump(publisher_clean, n = 2,
                                  other_level = "Other publishers")) %>%
  select(co_review, preprint_posting, preprint_citing, identities_revealed,
         pr_type_clean, area, publisher_cat) %>%
  ca::mjca(supcol = 6:7)

summary(final_4)

final_4 %>%
  plot_ca(font_size = 3.5) +
  coord_fixed() +
  theme(legend.position = "top") +
  scale_color_manual(values = c("Initial Variables" = "#1B9E77",
                                "Supplementary Variables" = "#D95F02")) +
  labs(title = "The Landscape of Open Science Practices",
       caption = paste(
         "Disciplines and publishers were added as supplementary (passive) and have no impact on the space.",
         "`++` means that there is a clear policy, `??` that there is no clear policy",
         sep = "\n"))

# Dimension 2: driven by type of peer review (singe blind or other) and
# coreview policy (clear or unclear) and partly unclear peer review policies
#
# Dimension 1: citing prepreints +, open identities +, other type of peer review
# and a bit double blind peer review.

summary(final_3) %>%
  .[["columns"]] %>%
  as_tibble(.name_repair = "unique") %>%
  mutate(name = str_remove(name, ".*?\\:")) %>%
  select(-` qlt`, inertia = ` inr`,
         `correlation with dim 1` = "cor...6",
         `contribution to dim 1` = "ctr...7",
         `correlation with dim 2` = "cor...9",
         `contribution to dim 2` = "ctr...10",) %>%
  knitr::kable()
