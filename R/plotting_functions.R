plot_univariate <- function(data, var, nudge_y = 2) {
    pdata <- data %>%
    count({{var}}) %>%
    mutate(y = str_trunc({{var}}, 40),
           prop = {n/sum(n)} %>% scales::percent(accuracy = 1),
           label = glue::glue("{n} ({prop})"))


  pdata %>%
    ggplot(aes(fct_reorder(y, n), n)) +
    ggalt::geom_lollipop(show.legend = F) +
    geom_label(aes(label = label),
               hjust = 0, nudge_y = nudge_y, label.size = 0,
               show.legend = F) +
    scale_y_continuous(limits = c(0, max(pdata$n) + max(pdata$n)/5)) +
    labs(title = paste("Variable:", rlang::as_name(enquo(var))),
         x = NULL, y = NULL)
}

plot_with_areas <- function(data, var, title = NULL) {
  var <- enquo(var)

  ggplot(data, aes(str_wrap(area, 20), fill = !!var)) +
    geom_bar(position = "fill", width = .7) +
    scale_fill_brewer(palette = "Set3") +
    scale_y_continuous(labels = scales::percent) +
    theme(legend.position = "top") +
    labs(fill = NULL, x = NULL, y = NULL,
         title = title)
}

make_bigram_analysis <- function(df, var, cutoff = 2, .distinct = T,
                                 remove = "", point_col = "lightblue") {


  if (.distinct) {
    df <- df %>%
      distinct({{var}})
  }


  bigrams <- df %>%
    tidytext::unnest_tokens(bigram, {{var}}, token = "ngrams", n = 2)

  bigrams_separated <- bigrams %>%
    separate(bigram, c("word1", "word2"), sep = " ")


  my_stop_words <- c(remove, tidytext::stop_words$word) %>%
    str_remove("not")

  bigrams_filtered <- bigrams_separated %>%
    filter(!word1 %in% my_stop_words) %>%
    filter(!word2 %in% my_stop_words)

  # new bigram counts:
  bigram_counts <- bigrams_filtered %>%
    count(word1, word2, sort = TRUE)

  bigram_graph <- bigram_counts %>%
    filter(n > cutoff) %>%
    igraph::graph_from_data_frame()


  set.seed(2019)

  a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

  ggraph::ggraph(bigram_graph, layout = "fr") +
    ggraph::geom_edge_link(aes(edge_alpha = as.factor(n)), arrow = a,
                           end_cap = circle(.07, 'inches')) +
    ggraph::geom_node_point(color = point_col, size = 4) +
    ggraph::geom_node_text(aes(label = name), vjust = 1, hjust = 1, repel = T) +
    theme_void()
}
