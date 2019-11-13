plan <- drake_plan(
  # initial import of data from Google Drive
  data = import_raw_data(
    out_file = file_out("data/joined_data.csv")
  ),
  # create a simple file as overview of the variables
  variables = create_var_overview(
    out_file = file_out("data/var_overview.csv")
  ),
  # recode variables like peer review type
  clean_data = recode_vars(
    raw_data = data,
    oa_data = file_in("data/oa_data.csv"),
    out_path = file_out("data/refined.csv")
  ),
  # expand data so we have a single row per journal per disciplinary area
  data_with_areas = recode_to_areas(clean_data),
  # add areas to journals that were formerly missing
  # for the algorithm to scrape the area categories, see the file XXX
  clean_areas = add_missing_areas(
    data_with_areas = data_with_areas,
    data_on_missing_areas = file_in("data/gs_scraped_total.csv"),
    out_path = file_out("data/refined_w_areas.csv")
  ),
  descriptive_report = rmarkdown::render(
    input = knitr_in("11-overview.Rmd"),
    output_file = file_out("11-overview.html"),
    quiet = TRUE
  ),
  paper_draft = rmarkdown::render(
    input = knitr_in("12-analysis-writeup.Rmd"),
    output_file = file_out("12-analysis-writeup.html"),
    quiet = TRUE
  )
)
