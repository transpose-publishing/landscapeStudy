plan <- drake_plan(
  # initial import of data
  data_joined = import_raw_data(
    gs_data = file_in("data/raw/Compiled_Landscape study journals list - G_ALL_dedup.csv"),
    survey_data = file_in("data/raw/TRANSPOSE landscape study - round 3 - Raw.csv")
  ),
  # create a simple file as overview of the variables
  variables = create_var_overview(
    in_file = file_in("data/raw/TRANSPOSE landscape study - round 3 - Raw.csv"),
    out_file = file_out("data/transformed/var_overview.csv")
  ),
  # recode variables like peer review type
  clean_data = recode_vars(
    raw_data = data_joined,
    oa_data = file_in("data/raw/oa_data.csv"),
    out_path = file_out("data/transformed/refined.csv")
  ),
  # expand data so we have a single row per journal per disciplinary area
  data_with_areas = recode_to_areas(clean_data),
  # add areas to journals that were formerly missing
  # for the algorithm to scrape the area categories, see the file
  # analysis-scripts/04-scrape-gs-fields.R
  clean_areas = add_missing_areas(
    data_with_areas = data_with_areas,
    data_on_missing_areas = file_in("data/raw/gs_scraped_total.csv"),
    out_path = file_out("data/transformed/refined_w_areas.csv")
  ),
  descriptive_report = rmarkdown::render(
    input = knitr_in("01-overview.Rmd"),
    output_file = file_out("01-overview.html"),
    quiet = TRUE
  ),
  paper_draft = rmarkdown::render(
    input = knitr_in("02-analysis-writeup.Rmd"),
    output_file = file_out("02-analysis-writeup.html"),
    quiet = TRUE
  )
)
