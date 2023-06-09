% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{ButtonGroup}
\alias{ButtonGroup}
\title{Button group}
\usage{
ButtonGroup(...)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/button-group}
}
\examples{
library(shiny.blueprint)
library(shiny)

ui <- function(id) {
  ButtonGroup(
    Button(icon = "database", "Queries"),
    Button(icon = "function", "Functions"),
    AnchorButton(rightIcon = "caret-down", "Options")
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
