% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{Divider}
\alias{Divider}
\title{Divider}
\usage{
Divider(...)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/divider}
}
\examples{
library(shiny.blueprint)
library(shiny)

ui <- function(id) {
  ButtonGroup(
    minimal = TRUE,
    Button(text = "File"),
    Button(text = "Edit"),
    Divider(),
    Button(text = "Create"),
    Button(text = "Delete"),
    Divider(),
    Button(icon = "add"),
    Button(icon = "remove")
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
