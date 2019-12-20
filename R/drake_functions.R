# data import functions ------

import_raw_data <- function(out_file) {
  # Import data on google scholar rankings of journals ----
  gsm_sheet <- "1Dluo5DNWU4UrmwIZLzqcToioRdyZ1qc1EofAk4ypiW8"

  gs_dat <- read_sheet(gsm_sheet, sheet = "G_ALL_dedup",
                       col_types = "ccdddddddddddcc")

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
  ls_sheet <- "1WcvxxmDhaV3BwBiIfwC_nEAr6-EKCDD11R6eJ5vZElA"

  transpose_fixed <- read_sheet(ls_sheet, col_types = "c") %>%
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
  ls_sheet <- "1WcvxxmDhaV3BwBiIfwC_nEAr6-EKCDD11R6eJ5vZElA"

  # import list of variables for ease of use
  transpose_vars <- read_sheet(
    ls_sheet, col_types = "c",
    sheet = "Raw", n_max = 2)

  # fix some var names
  transpose_vars <- transpose_vars %>%
    rename(`review date` = `review date...3`, `review date_1` = `review date...5`)

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
  # create clean variable for peer review type
  refined <- raw_data %>%
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



  # unify "no" and "not speccified" for opr-variables where feasible. TRH
  # suggested early on, that this needs to be done. Until now, this was not done
  # since this cannot be done without making some judgement on what should have
  # been coded differently. Nevertheless, a few cases need to be changed, in an
  # attempt to still use the data. otherwise we would need to remove any results
  # for OPR.
  # The approach will be as follows: if all variables for opr (except
  # opr_additional) are coded as "No", this will be changed to "Not specified",
  # since the assumption seems plausible, that it was in fact not specified, but
  # was coded as "No", since the assessors made no difference in this case.
  # In all other cases, values will stay the same. We will furthermore only use
  # the variable regarding whether reviewer identities are revealed to the
  # authors, since this is probably the most reliable one (there is a clear
  # conceptual difference between "Not found" and "No" here. In all other cases,
  # it is unclear which of the two the assesor was referring to.)

  to_fix <- refined %>%
    select(issn, starts_with("opr_"), -opr_additional)

  refined <- to_fix %>%
    mutate_at(vars(starts_with("opr")), str_detect, "No$") %>%
    mutate(only_no = rowSums(select(., starts_with("opr"))),
           # set to recode if all vars are "No"
           recode_opr = if_else(only_no == 8, T, F)) %>%
    select(issn, recode_opr) %>%
    left_join(refined, .) %>%
    # recode those that were determined to be recoded
    mutate_at(vars(starts_with("opr"), -opr_additional),
              ~case_when(recode_opr ~ "Not specified",
                         TRUE ~ .)) %>%
    rename(opr_was_recoded = recode_opr)



  # add data on open access status
  oa_status <- read_csv(oa_data,
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

recode_to_areas <- function(refined) {

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

  refined_with_areas
}


add_missing_areas <- function(data_with_areas, data_on_missing_areas, out_path) {
  missing_areas <- data_with_areas %>%
    select(title, issn, area) %>%
    filter(is.na(area))


  data_from_gs <- read_csv(
    data_on_missing_areas,
    col_types = cols(
      id = col_character(),
      Publication = col_character(),
      `h5-index` = col_double(),
      `h5-median` = col_double()
    )) %>%
    rename(title = Publication) %>%
    mutate(title = str_remove(title, "[^[:alnum:] ]") %>%
             str_remove('"'))

  with_matched <- missing_areas %>%
    mutate(title = str_remove(title, "[^[:alnum:] ]")) %>%
    full_join(data_from_gs, by = "title") %>%
    filter(!is.na(issn))

  with_matched <- with_matched %>%
    mutate(parent_field = str_extract(id, ".{3}")) %>%
    mutate(area = case_when(
      str_detect(parent_field, "bus") ~ "Business, Economics & Management",
      str_detect(parent_field, "chm") ~ "Chemical & Materials Sciences",
      str_detect(parent_field, "eng") ~ "Engineering & Computer Science",
      str_detect(parent_field, "med") ~ "Health & Medical Sciences",
      str_detect(parent_field, "hum") ~ "Humanities, Literature & Arts",
      str_detect(parent_field, "bio") ~ "Life Sciences & Earth Sciences",
      str_detect(parent_field, "phy") ~ "Physics & Mathematics",
      str_detect(parent_field, "soc") ~ "Social Sciences"
    )) %>%
    select(-parent_field) %>%
    arrange(title)


  # # only 3 journals are in two categories, which is not too much
  # with_matched %>%
  #   group_by(title) %>%
  #   mutate(n = n()) %>%
  #   filter(n > 1)

  hand_coded_areas <- with_matched %>%
    select(issn, area) %>%
    mutate(area_was_scraped = TRUE)

  refined_with_areas <- data_with_areas %>%
    full_join(hand_coded_areas, by = "issn") %>%
    mutate(area = dplyr::coalesce(area.x, area.y)) %>%
    select(-area.y, -area.x) %>%
    replace_na(list(area_was_scraped = FALSE))

  write_csv(refined_with_areas, out_path)
}
