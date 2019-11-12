plan <- drake_plan(
  data = import_raw_data(out_file = file_out("data-transformed/joined_data.csv"))
)
