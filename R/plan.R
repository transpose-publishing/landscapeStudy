plan <- drake_plan(
  data = import_raw_data(
    out_file = file_out("data-transformed/joined_data.csv")
  ),
  variables = create_var_overview(
    out_file = file_out("data-transformed/var_overview.csv")
  ),
  data_recoded = recode_vars(
    raw_data = file_in("data-transformed/joined_data.csv"),
    oa_data = file_in("data-transformed/oa_data.csv"),
    out_path = file_out("data-transformed/refined.csv")
  ),
  data_with_areas = recode_to_areas(
    refined = data_recoded,
    missing_categories = file_in("data-transformed/journals_with_missing_categories.csv"),
    out_path = file_out("data-transformed/refined_w_areas.csv")
  )
)
