% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{NonIdealState}
\alias{NonIdealState}
\title{Non-ideal state}
\usage{
NonIdealState(...)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/non-ideal-state}
}
\examples{
library(shiny.blueprint)
library(shiny)

ui <- function(id) {
  NonIdealState(
    icon = "search",
    title = "No search results",
    description = Card(
      "Your search didn't match any files.",
      tags$br(),
      "Try searching for something else, or create a new file."
    ),
    action = Button(icon = "plus", text = "New file", intent = "primary", outlined = TRUE)
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
