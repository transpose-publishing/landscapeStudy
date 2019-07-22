#' ca plots with ggplot2
#'
#' @export
plot_ca <- function(object, font_size = 3, dimensions = c(1, 2),
                    show.legend = F, map = "symmetric") {
  ca_class <- class(object)
  if (!identical(ca_class, "ca") & !identical(ca_class, "mjca")) {
    stop("Input object must be of type 'ca' or 'mjca'")
  }
  assertthat::assert_that(length(dimensions) == 2)

  # find points to plot
  pdf(file = NULL)
  base_data <- plot(object, dim = dimensions, map)
  dev.off()

  # find variances for labelling of axes
  variances <- suppressWarnings(summary(object))

  dim1 <- variances$scree[dimensions[1], 3] %>% round(., 2) %>% unname()
  dim2 <- variances$scree[dimensions[2], 3] %>% round(., 2) %>% unname()

  # create labels
  x_label <- paste0("Dimension ", dimensions[1], " (", dim1, "%)")
  y_label <- paste0("Dimension ", dimensions[2], " (", dim2, "%)")

  # add rownames
  all_data <- base_data %>%
    map(prepare_data)

  # extract col_data
  col_data <- all_data[["cols"]] %>%
    mutate(Profil = rep("Spaltenprofil", length(rowname)),
           rowname = stringr::str_replace(rowname, "(.*):", ""))


  # find supplementary cols
  if (identical(ca_class, "mjca")) {
    col_data <- col_data %>%
      slice(object$colsup) %>%
      mutate(sup_var = factor("Supplementary Variables", levels =
                                c("Initial Variables", "Supplementary Variables"))) %>%
      dplyr::select(rowname, sup_var) %>%
      full_join(col_data, by = "rowname") %>%
      replace_na(list(sup_var = "Initial Variables"))

  } else if (identical(ca_class, "ca")) {
    # create rowdata, in case class is 'ca'
    row_data <- all_data[["rows"]] %>%
      mutate(Profil = rep("Zeilenprofil", length(rowname)))

    if (length(object$rowsup) > 0) {
      row_data <- row_data %>%
        slice(object$rowsup) %>%
        mutate(sup_var = factor("Supplementary Variables", levels =
                                  c("Initial Variables", "Supplementary Variables"))) %>%
        dplyr::select(rowname, sup_var) %>%
        full_join(row_data, by = "rowname") %>%
        replace_na(list(sup_var = "Initial Variables"))
    }
    full_data <- bind_rows(col_data, row_data) %>%
      replace_na(list(sup_var = "Initial Variables"))
  }


  # separate plotting for 'ca' and 'mjca'
  if (identical(ca_class, "ca")) {
    if (sum(!is.na(row_data$sup_var)) == 0) { # catch case with no sup_vars
      # stop("Keine Sup_vars, muss ich noch implementieren")
      ggplot(full_data, aes(x = x, y = y, colour = Profil)) +
        ggrepel::geom_text_repel(aes(label = rowname), size = font_size,
                                 show.legend = F, max.iter = 5000, force = 4) +
        geom_point(show.legend = show.legend, size = 2) +
        geom_hline(yintercept = 0, linetype = "dashed", alpha = .5) +
        geom_vline(xintercept = 0, linetype = "dashed", alpha = .5) +
        labs(x = x_label,
             y = y_label,
             colour = NULL)
    } else {
      ggplot(full_data, aes(x = x, y = y, colour = Profil, shape = sup_var)) +
        ggrepel::geom_text_repel(aes(label = rowname), size = font_size,
                        show.legend = F, max.iter = 5000, force = 4) +
        geom_point(show.legend = show.legend, size = 2) +
        geom_hline(yintercept = 0, linetype = "dashed", alpha = .5) +
        geom_vline(xintercept = 0, linetype = "dashed", alpha = .5) +
        labs(x = x_label,
             y = y_label,
             shape = NULL,
             colour = NULL)
    }
  } else if (identical(ca_class, "mjca")) {

    if (sum(!is.na(col_data$sup_var)) == 0) { # catch case with no sup_vars
      ggplot(col_data, aes(x = x, y = y)) +
        plot_parts(font_size = font_size, x_label = x_label, y_label = y_label,
                   show.legend = show.legend)
    } else {
      ggplot(col_data, aes(x = x, y = y, colour = sup_var)) +
        plot_parts(font_size = font_size, x_label = x_label, y_label = y_label,
                   show.legend = show.legend)
    }
  }

}




#' Parts for plotting ca
plot_parts <- function(font_size = font_size, x_label = x_label,
                       y_label = y_label, show.legend = show.legend) {
  list(
    geom_point(show.legend = show.legend),
    ggrepel::geom_text_repel(aes(label = rowname), size = font_size, show.legend = F,
                    force = 2, max.iter = 5000),
    geom_hline(yintercept = 0, linetype = "dashed", alpha = .5),
    geom_vline(xintercept = 0, linetype = "dashed", alpha = .5),
    labs(x = x_label,
         y = y_label,
         shape = NULL,
         colour = NULL),
    theme(legend.position = "bottom", legend.direction = "horizontal")
  )
}

#' Add rownames as column
#'
#' Helper function to add rownames
prepare_data <- function(x) {
  x <- x %>%
    as.data.frame() %>%
    tibble::rownames_to_column()

  colnames(x) <- c("rowname", "x", "y")
  x
}
