% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{Collapse}
\alias{Collapse}
\title{Collapse}
\usage{
Collapse(...)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/collapse}
}
\examples{
library(shiny.blueprint)
library(shiny)

logs <- Pre(
  "[11:53:30] Finished 'typescript-bundle-blueprint' after 769 ms\n",
  "[11:53:30] Starting 'typescript-typings-blueprint'...\n",
  "[11:53:30] Finished 'typescript-typings-blueprint' after 198 ms\n",
  "[11:53:30] write ./blueprint.css\n",
  "[11:53:30] Finished 'sass-compile-blueprint' after 2.84 s\n"
)

ui <- function(id) {
  ns <- NS(id)
  tagList(
    Button.shinyInput(ns("toggle"), "Toggle logs"),
    reactOutput(ns("ui"))
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    show <- reactiveVal(FALSE)
    observeEvent(input$toggle, show(!show()))
    output$ui <- renderReact({
      Collapse(isOpen = show(), logs)
    })
  })
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
