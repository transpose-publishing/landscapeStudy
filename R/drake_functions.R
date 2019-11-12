import_raw_data <- function(out_file) {
  # Import data on google scholar rankings of journals ----
  gsm_sheet <- gs_title("Compiled_Landscape study journals list")
  gs_dat <- gs_read(gsm_sheet, ws = "G_ALL_dedup",
                    col_types = cols(
                      `Journal Title` = col_character(),
                      ISSN = col_character(),
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
                      G_SS_rank = col_double(),
                      Reviewer1 = col_character(),
                      Reviewer2 = col_character()
                    ))

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
  ls_sheet <- gs_title("TRANSPOSE landscape study - round 3")

  transpose_fixed <- gs_read(ls_sheet,
                             col_types = cols(.default = col_character())) %>%
    as_tibble(.name_repair = "universal") %>%
    clean_raw_sheet(source = "google")


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
    full_join(gs_dat, by = "issn")


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
    write_csv(joined_dataset, out_file)
  }
}
