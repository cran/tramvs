## ----setup, echo = FALSE, results = "hide", message = FALSE-------------------
set.seed(241068)

knitr::opts_chunk$set(echo = TRUE, results = 'markup', error = FALSE,
                      warning = FALSE, message = FALSE,
                      tidy = FALSE, cache = TRUE, size = "small",
                      fig.width = 5, fig.height = 4, fig.align = "center",
                      out.width = NULL, ###'.6\\linewidth',
                      out.height = NULL,
                      fig.scap = NA)
## R settings
options(width = 80, digits = 3)

library("tramvs")

abess_available <- require("abess")
tramnet_available <- require("tramnet")

# Colors
if (require("colorspace")) {
  col <- diverge_hcl(2, h = c(246, 40), c = 96, l = c(65, 90))
  fill <- diverge_hcl(2, h = c(246, 40), c = 96, l = c(65, 90), alpha = .3)
}

