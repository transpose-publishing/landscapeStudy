order_pr_type <- function(df) {
  df %>%
    mutate(
      pr_type_clean = factor(
        pr_type_clean,
        levels = c("Single blind", "Double blind", "Not blinded", "Other",
                   "Unsure"))
      )
}

make_proportion <- function(df, var, group, order_string = NA_character_) {
  df %>%
    group_by({{group}}) %>%
    count({{var}}) %>%
    mutate(prop = n/sum(n),
           order = case_when(
             str_detect({{var}}, order_string) ~ prop,
             TRUE ~ 0
             ),
           order = sum(order))
}

make_single_proportion <- function(df, var, category, accuracy = 1) {
  make_proportion(df, {{var}}, order_string = category) %>%
    ungroup() %>%
    summarise(my_cat = mean(order) %>% scales::percent(., accuracy = accuracy))  %>%
    as.character()
}


clean_raw_sheet <- function(df, source = c("excel", "google", "csv")) {

  if (!is.character(source) || !identical(length(source), 1L)) {
    stop("`source` should either be 'excel' or 'google", call. = FALSE)
  }

  transpose_data <- switch(source,
    excel = {df %>%
      slice(-1:-2) %>%
      rename(review_date_1 = `review.date...3`, review_date_2 = `review.date...5`,
             review_date_3 = `review.3.date`,
             top_journals_in = starts_with("Top.journals")) %>%
      # https://stackoverflow.com/a/46895151/3149349
      mutate_at(vars(starts_with("review_date")),
                ~suppressWarnings(janitor::excel_numeric_to_date(as.numeric(.))))},
    google = {df %>%
      slice(-1:-2) %>%
      rename(review_date_1 = `review.date...3`, review_date_2 = `review.date...5`,
             review_date_3 = `review.3.date`,
             top_journals_in = starts_with("Top.journals"))},
    csv = {df %>%
      slice(-1:-2) %>%
        rename(review_date_1 = `review.date`, review_date_2 = `review.date_1`,
               review_date_3 = `review.3.date`,
               top_journals_in = starts_with("Top.journals"))},

  )



  # remove dashes from names and replace with underscores
  old_names <- names(transpose_data)
  new_names <- str_replace_all(old_names, "\\.", "_")
  names(transpose_data) <- new_names

  # take the first row for general information
  first_part <- transpose_data %>%
    # drop the column "Property" since it doesn't hold any additional information
    select(`reviewer_1`:publisher, -`To_discuss`) %>%
    mutate(group = rep(1:3, length.out = n())) %>%
    filter(group == 1) %>%
    select(-group)

  # take the third row for result of review
  second_part <- transpose_data %>%
    select(pr_type:`Reviewer_2_changes`) %>%
    mutate(group = rep(1:3, length.out = n())) %>%
    filter(group == 3) %>%
    select(-group)

  bind_cols(first_part, second_part)
}


# small helper for displaying percentages
make_percent <- function(x, significant_digits = 1) {
  x %>%
    as.numeric() %>%
    # to enable extraction of vectors as well
    head(1) %>%
    signif(significant_digits) %>%
    scales::percent(accuracy = 1)
}

make_percent2 <- function(x, round_to = c("ten", "one", "comma")) {

  round_to <- match.arg(round_to)
  accuracy <- switch(round_to,
    ten = 10,
    one = 1,
    comma = .1
  )

  x %>%
    as.numeric() %>%
    # to enable extraction of vectors as well
    head(1) %>%
    scales::percent(accuracy = accuracy)
}


select_univariate <- function(var, df = refined) {
  select(df, journal = title, issn, {{var}})
}

select_bivariate <- function(var, df = refined_with_areas) {
  select(df, journal = title, issn, area, {{var}})
}
