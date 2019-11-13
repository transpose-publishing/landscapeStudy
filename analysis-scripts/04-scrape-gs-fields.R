# this script collects all journal titles from google scholar for major and for
# subcategories. 
library(rvest)
library(tidyverse)

# function definitions
get_sub_fields <- function(page) {
  page %>% 
    read_html() %>% 
    html_nodes(".gs_md_li") %>% 
    html_attr("href") %>% 
    keep(str_detect(., "vq"))
}

scraper <- function(page) {
  pb$tick()
  res <- read_html(page) %>% 
    html_table %>% 
    .[[1]] %>% 
    select(Publication, `h5-index`, `h5-median`)
  
  Sys.sleep(1)
  
  res
}


# base links for top level disciplines -----
all_fields <- c(
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=bus",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=chm",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=eng",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=med",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=hum",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=bio",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=phy",
  "https://scholar.google.at/citations?view_op=top_venues&hl=en&vq=soc"
)





# find links to subfields subfields ----
all_links <- all_fields %>% 
  map(get_sub_fields) %>% 
  flatten_chr()



# scrape tables of subfields -----
to_scrape <- all_links

ticks <- length(to_scrape)
pb <- progress::progress_bar$new(total = ticks)


res <- to_scrape %>% 
  paste0("https://scholar.google.at", .) %>% 
  set_names(., str_extract(., "(?<=vq\\=).*$")) %>% 
  map_dfr(scraper, .id = "id")


write_csv(res, here::here("data-transformed/gs_scraped_total.csv"))
