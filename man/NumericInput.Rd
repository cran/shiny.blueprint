% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{NumericInput}
\alias{NumericInput}
\alias{NumericInput.shinyInput}
\title{NumericInput}
\usage{
NumericInput(...)

NumericInput.shinyInput(inputId, ..., value = defaultValue)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}

\item{inputId}{The \code{input} slot that will be used to access the value.}

\item{value}{Initial value.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/numeric-input}
}
\examples{
library(shiny)
library(shiny.blueprint)

ui <- function(id) {
  ns <- NS(id)
  tagList(
    NumericInput(
      onValueChange = setInput(ns("value1")),
      intent = "primary"
    ),
    textOutput(ns("value1Output")),
    NumericInput.shinyInput(
      inputId = ns("value2"),
      intent = "primary"
    ),
    textOutput(ns("value2Output"))
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$value1Output <- renderText(input$value1)
    output$value2Output <- renderText(input$value2)
  })
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
