order_factors <- function(df) {
  df %>% 
    mutate(
      pr_type_clean = factor(
        pr_type_clean,
        levels = c("not blinded", "single blind", "double blind", "unsure", 
                   "other"))
      )
}
