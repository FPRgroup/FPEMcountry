% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_fp_c.R
\name{calc_fp_c}
\alias{calc_fp_c}
\title{Calculate fp indicators from samples}
\usage{
calc_fp_c(fit, population_data = NULL)
}
\arguments{
\item{fit}{\emph{\sQuote{List}} The list returned from \code{\link{fit_fp_csub}}}

\item{population_data}{\emph{\sQuote{Data.frame}} Population count data such as \code{\link{population_counts}}.}
}
\value{
\emph{List} A list of long format data.frames
}
\description{
Maps multiple sets of runs to \code{\link{calc_fp}}
}
