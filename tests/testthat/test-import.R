library(tidyverse)
library(readxl)
library(janitor)
library(landscapeStudy)


test_that("data from excel is imported consistently", {
  transpose_clean <- read_excel("TRANSPOSE landscape study - 2019-06-02.xlsx",
                                sheet = "Raw", .name_repair = "universal") %>%
    clean_raw_sheet(source = "excel")


  # there are some annoying columns with inconsistent date formats, which are not
  # relevant. info on publisher needs to be removed, since this was the reason for
  # the whole exercise (having missing publishers)
  transpose_test <- transpose_clean %>%
    select(-starts_with("review"), -publisher)

  # import filtered data and do some renaming
  transpose_raw <- read_excel("TRANSPOSE landscape study - 2019-06-02.xlsx",
                              sheet = "Filtered", .name_repair = "universal") %>%
    select(-starts_with("To.dis"), -publisher, -starts_with("review")) %>%
    rename(top_journals_in = starts_with("Top.journals"))


  old_names <- names(transpose_raw)
  new_names <- str_replace_all(old_names, "\\.", "_")
  names(transpose_raw) <- new_names


  expect_equal(transpose_test, transpose_raw)
})

