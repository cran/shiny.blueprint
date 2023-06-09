% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{Alert}
\alias{Alert}
\title{Alert}
\usage{
Alert(...)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/alert}
}
\examples{
library(shiny.blueprint)
library(shiny)

ui <- function(id) {
  ns <- NS(id)
  tagList(
    Button.shinyInput(
      inputId = ns("showAlert"),
      "Show alert"
    ),
    reactOutput(ns("alert"))
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    isOpen <- reactiveVal(FALSE)
    observeEvent(input$showAlert, isOpen(TRUE))
    observeEvent(input$closeAlert, isOpen(FALSE))

    output$alert <- renderReact({
      Alert(
        usePortal = FALSE,
        confirmButtonText = "Got it",
        isOpen = isOpen(),
        onClose = triggerEvent(ns("closeAlert")),
        p("Hello, it's me, your alert")
      )
    })
  })
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
