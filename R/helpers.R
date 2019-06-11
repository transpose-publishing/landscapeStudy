order_factors <- function(df) {
  df %>% 
    mutate(
      pr_type_clean = factor(
        pr_type_clean,
        levels = c("single blind", "double blind", "not blinded", "unsure", 
                   "other"))
      )
}
