library(tidyverse)
library(readxl)
library(janitor)
library(landscapeStudy)
# library(googlesheets)



transpose_clean <- read_excel("TRANSPOSE landscape study - 2019-06-02.xlsx",
                              sheet = "Raw", .name_repair = "universal") %>%
  clean_raw_sheet(source = "excel")


# there are some annoying columns with inconsistent date formats, which are not
# relevant. info on publisher needs to be removed, since this was the reason for
# the whole exercise (having missing publishers)
transpose_test <- transpose_clean %>%
  select(-starts_with("review"), -publisher)


test_that("data from excel is imported consistently", {


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

# # Testing whether data from google matches excel makes no sense:
# # - There are too many spurious differences in regard to line breaks etc.
# # - The google file *should* change, since we will fix problems there
#
# suppressMessages(gs_auth(token = "googlesheets_token.rds", verbose = FALSE))
#
# test_that("data from google-sheet is consistent with excel", {
#   gs_sheet <- gs_title("fixing missings for transpose landscape study")
#   gs_transpose <- suppressWarnings(
#     gs_read(gs_sheet) %>%
#     as_tibble(.name_repair = "universal") %>%
#     clean_raw_sheet(source = "google")
#   )
#
#
#   gs_test <- gs_transpose %>%
#     select(-starts_with("review"), -publisher)
#
#   # we need to remove carriage returns, because they come with excel
#   transpose_test <- transpose_test %>%
#     mutate_all(~str_remove_all(., "[\r]")) %>%
#     mutate_all(~str_replace_all(., "\\s{2}", " "))
#
#   expect_equal(gs_test, transpose_test)
# })
#
# gs_deauth(verbose = FALSE)
