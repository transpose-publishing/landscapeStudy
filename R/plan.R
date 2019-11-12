plan <- drake_plan(
  # initial import of data from Google Drive
  data = import_raw_data(
    out_file = file_out("data-transformed/joined_data.csv")
  ),
  # create a simple file as overview of the variables
  variables = create_var_overview(
    out_file = file_out("data-transformed/var_overview.csv")
  ),
  # recode variables like peer review type
  data_recoded = recode_vars(
    raw_data = data,
    oa_data = file_in("data-transformed/oa_data.csv"),
    out_path = file_out("data-transformed/refined.csv")
  ),
  # expand data so we have a single row per journal per disciplinary area
  data_with_areas = recode_to_areas(data_recoded),
  # add areas to journals that were formerly missing
  # for the algorithm to scrape the area categories, see the file XXX
  data_clean = add_missing_areas(
    data_with_areas = data_with_areas,
    data_on_missing_areas = file_in("data-transformed/gs_scraped_total.csv"),
    out_path = file_out("data-transformed/refined_w_areas.csv")
  ),
)
