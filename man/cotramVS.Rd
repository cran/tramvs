% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/models.R
\name{cotramVS}
\alias{cotramVS}
\title{Optimal subset selection in a cotram model}
\usage{
cotramVS(
  formula,
  data,
  supp_max = NULL,
  k_max = NULL,
  thresh = NULL,
  init = TRUE,
  m_max = 10,
  ...
)
}
\arguments{
\item{formula}{object of class \code{"formula"}.}

\item{data}{data frame containing the variables in the model.}

\item{supp_max}{maximum support which to call \code{abess_tram} with.}

\item{k_max}{maximum support size to consider during the splicing algorithm.
Defaults to \code{supp}.}

\item{thresh}{threshold when to stop splicing. Defaults to
0.01 * \code{supp} * p * log(log(n)) / n$, where p denotes the number of predictors
and n the sample size.}

\item{init}{initialize active set. Defaults to \code{TRUE} and initializes the
active set with those covariates that are most correlated with score residuals
of an unconditional \code{modFUN(update(formula, . ~ 1))}.}

\item{m_max}{maximum number of iterating the splicing algorithm.}

\item{...}{Additional arguments supplied to \code{\link[cotram]{cotram}}}
}
\value{
See \code{\link[tramvs]{tramvs}}
}
\description{
Optimal subset selection in a cotram model
}
