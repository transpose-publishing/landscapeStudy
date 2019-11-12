# data import functions ------

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


create_var_overview <- function(out_file) {
  ls_sheet <- gs_title("TRANSPOSE landscape study - round 3")

  # import list of variables for ease of use
  transpose_vars <- gs_read(
    ls_sheet,
    col_types = cols(.default = col_character()),
    ws = "Raw", n_max = 2)

  part1 <- transpose_vars %>%
    slice(1) %>%
    gather(variable, description) %>%
    slice(-1)

  part2 <- transpose_vars %>%
    slice(2) %>%
    gather(variable, type) %>%
    slice(-1)

  part1 %>%
    left_join(part2, by = "variable") %>%
    mutate(var_number = 1:n())   -> var_overview

  write_csv(var_overview, out_file)
}

recode_vars <- function(raw_data, oa_data, out_path) {
  # import data
  base_data <- read_csv(
    raw_data,
    col_types = cols(
      .default = col_character(),
      review_date_1 = col_character(),
      review_date_2 = col_character(),
      review_date_3 = col_character(),
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
      G_SS_rank = col_double()
    ))

  # create clean variable for peer review type
  refined <- base_data %>%
    mutate(pr_type_clean = case_when(
      str_detect(pr_type, "^Double") ~ "Double blind",
      str_detect(pr_type, "^Other") ~ "Other",
      str_detect(pr_type, "^Single") ~ "Single blind",
      str_detect(pr_type, "^Not") ~ "Not blinded",
      TRUE ~ "Unsure"
    ))


  # # check publisher names
  # refined %>%
  #   count(publisher) %>%
  #   arrange(publisher)

  refined <- refined %>%
    mutate(publisher_clean = case_when(
      str_detect(publisher, "^American Chemical Society") ~ "American Chemical Society",
      str_detect(publisher, "^American Heart Association") ~ "American Heart Association",
      str_detect(publisher, "^Cell") ~ "Cell Press (Elsevier)",
      str_detect(publisher, "^IEEE") ~ "IEEE",
      str_detect(publisher, "^IOP") ~ "IOP",
      str_detect(publisher, "^SpringerNature") ~ "Springer Nature",
      TRUE ~ publisher
    ))


  # fix missings for coreview_policy
  refined <- refined %>%
    mutate(coreview_policy = fct_explicit_na(coreview_policy, "Not specified"))



  # add data on open access status
  oa_status <- read_csv(here::here(oa_data),
                        col_types = cols(
                          issn = col_character(),
                          bibjson.title = col_character(),
                          bibjson.publisher = col_character(),
                          bibjson.oa_start.year = col_double(),
                          issn_type = col_character()
                        ))

  refined %>%
    left_join(oa_status, by = "issn") %>%
    write_csv(out_path)
}

recode_to_areas <- function(refined, missing_categories, out_path) {

  recoded <- refined %>%
    select(issn, starts_with("G_"), -G_100_rank) %>%
    gather(area, score, -issn) %>%
    drop_na() %>%
    mutate(area_clean = case_when(
      str_detect(area, "BEM") ~ "Business, Economics & Management",
      str_detect(area, "CMS") ~ "Chemical & Materials Sciences",
      str_detect(area, "ECS") ~ "Engineering & Computer Science",
      str_detect(area, "HMS") ~ "Health & Medical Sciences",
      str_detect(area, "HLA") ~ "Humanities, Literature & Arts",
      str_detect(area, "LSES") ~ "Life Sciences & Earth Sciences",
      str_detect(area, "PM") ~ "Physics & Mathematics",
      str_detect(area, "SS") ~ "Social Sciences"
    )) %>%
    select(issn, area = area_clean) %>%
    arrange(issn)


  refined_with_areas <- refined %>%
    full_join(recoded, by = "issn")

  # data on areas for some journals was not included. here we import the scraped
  # data and join it with the rest
  hand_coded_areas <- read_csv(
    missing_categories,
    col_types = cols(
      title = col_character(),
      issn = col_character(),
      area = col_character(),
      id = col_character(),
      `h5-index` = col_double(),
      `h5-median` = col_double()
    )) %>%
    select(issn, area) %>%
    mutate(area_was_scraped = TRUE)

  refined_with_areas <- refined_with_areas %>%
    full_join(hand_coded_areas, by = "issn") %>%
    mutate(area = coalesce(area.x, area.y)) %>%
    select(-area.y, -area.x) %>%
    replace_na(list(area_was_scraped = FALSE))



  write_csv(refined_with_areas, out_path)
}
