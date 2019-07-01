library(tidyverse)
library(readxl)
library(janitor)


test_that("data cleaning doesn't break", {
  transpose_clean <- read_excel("TRANSPOSE landscape study - 2019-06-02.xlsx",
                                sheet = "Raw") %>%
    clean_raw_sheet()


  # there are some annoying columns with inconsistent date formats, which are not
  # relevant. info on publisher needs to be removed, since this was the reason for
  # the whole exercise (having missing publishers)
  transpose_test <- transpose_clean %>%
    select(-starts_with("review_date"), -publisher)

  # import filtered data and do some renaming
  transpose_raw <- read_excel("TRANSPOSE landscape study - 2019-06-02.xlsx",
                              sheet = "Filtered") %>%
    select(-starts_with("To dis")) %>%
    select(-`review date...2`, -`review date...4`, -`review 3 date`,
           top_journals_in = starts_with("Top journals"),
           -publisher)


  old_names <- names(transpose_raw)
  new_names <- str_replace_all(old_names, "-", "_")
  names(transpose_raw) <- new_names


  expect_equal(transpose_test, transpose_raw)
})

