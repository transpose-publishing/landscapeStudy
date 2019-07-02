plot_univariate <- function(data, var, nudge_y = 2) {
  var <- enquo(var)

  pdata <- data %>%
    count(!!var) %>%
    mutate(y = str_trunc(!!var, 40))


  pdata %>%
    ggplot(aes(fct_reorder(y, n), n)) +
    geom_lollipop() +
    geom_label(aes(label = n),
               hjust = 0, nudge_y = nudge_y, label.size = 0) +
    scale_y_continuous(limits = c(0, max(pdata$n) + max(pdata$n)/10)) +
    labs(title = paste("Variable:", rlang::as_name(var)),
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

make_bigram_analysis <- function(df, var, cutoff = 2, .distinct = T) {

  var <- enquo(var)

  if (.distinct) {
    df <- df %>%
      distinct(!!var)
  }


  bigrams <- df %>%
    unnest_tokens(bigram, !!var, token = "ngrams", n = 2)

  bigrams_separated <- bigrams %>%
    separate(bigram, c("word1", "word2"), sep = " ")

  bigrams_filtered <- bigrams_separated %>%
    filter(!word1 %in% stop_words$word) %>%
    filter(!word2 %in% stop_words$word)

  # new bigram counts:
  bigram_counts <- bigrams_filtered %>%
    count(word1, word2, sort = TRUE)

  bigram_graph <- bigram_counts %>%
    filter(n > cutoff) %>%
    igraph::graph_from_data_frame()


  set.seed(2019)

  a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

  ggraph::ggraph(bigram_graph, layout = "fr") +
    ggraph::geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                           arrow = a, end_cap = circle(.07, 'inches')) +
    ggraph::geom_node_point(color = "lightblue", size = 4) +
    ggraph::geom_node_text(aes(label = name), vjust = 1, hjust = 1, repel = T) +
    theme_void()
}
