library(tidyverse)
theme_set(hrbrmisc::theme_hrbrmstr())
library(RColorBrewer)
library(ggalt)
library(rcrossref)
source("R/helpers.R")

# import data
refined <- read_csv("data/transformed//refined.csv")
refined_with_areas <- read_csv("data/transformed/refined_w_areas.csv")

# small tweaks
refined_with_areas <- refined_with_areas %>%
  order_pr_type()

refined %>%
  count(pr_type_clean)

# do some first explorations
ggplot(refined, aes(pr_type_clean)) +
  geom_bar()

ggplot(refined_with_areas, aes(area, fill = area)) +
  geom_bar(show.legend = F) +
  facet_wrap(~pr_type_clean) +
  coord_flip()

refined_with_areas %>%
  group_by(pr_type_clean) %>%
  count(area) %>%
  group_by(area) %>%
  mutate(prop = n/sum(n)) %>%
  ggplot(aes(area, prop, colour = area)) +
  geom_lollipop(show.legend = F) +
  facet_wrap(~pr_type_clean) +
  coord_flip()

ggplot(refined_with_areas, aes(str_wrap(area, 20), fill = pr_type_clean)) +
  geom_bar(position = "fill", width = .7) +
  # coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position = "top") +
  labs(fill = NULL)

refined_with_areas %>%
  filter(is.na(area))

ggplot(refined_with_areas, aes(area)) +
  geom_bar()

# explore h indices
ggplot(refined_with_areas, aes(`h5-index`)) +
  geom_histogram()

ggplot(refined_with_areas, aes(pr_type_clean, `h5-index`)) +
  geom_boxplot()

ggplot(refined_with_areas, aes(area, `h5-index`)) +
  geom_boxplot() +
  coord_flip()

refined_with_areas %>%
  arrange(desc(G_HMS_rank)) %>%
  select(G_100_rank, G_HMS_rank) %>%
  View()


## enrich with data about n of articles from crossref ----
# take first issn
test_issn <- refined %>%
  head(1) %>%
  pull(issn)

test_journal <- cr_journals(test_issn, works = T)

test_journal$data %>%
  View()

test_journal_big <- cr_journals(test_issn, works = T, limit = 1000,
                                filter = c(from_pub_date = 2017,
                                           until_pub_date = 2018))

test_journal_big$data %>%
  as.tibble() %>%
  mutate(reference.count = as.integer(reference.count)) %>% View()

test_journal_very_big <- cr_journals(
  test_issn, works = T, limit = 1000,
  cursor = "*", cursor_max = 5000,
  filter = c(from_pub_date = 2015, until_pub_date = 2018),
  .progress = TRUE)

test_journa_very_big$data %>%
  as.tibble() %>% View()

