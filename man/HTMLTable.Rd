% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{HTMLTable}
\alias{HTMLTable}
\title{HTML table}
\usage{
HTMLTable(...)
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/html-table}
}
\examples{
library(shiny.blueprint)
library(shiny)

ui <- function(id) {
  HTMLTable(
    tags$thead(
      tags$tr(tags$th("Project"), tags$th("Stack"), tags$th("Contributors"))
    ),
    tags$tbody(
      tags$tr(tags$td("Blueprint"), tags$td("JS React"), tags$td("268")),
      tags$tr(tags$td("TS"), tags$td("JSX"), tags$td("68")),
      tags$tr(tags$td("shiny.blueprint"), tags$td("R JS"), tags$td("2"))
    ),
    tags$tfoot(
      tags$tr(tags$td("Total", colSpan = 2), tags$td("1508"))
    )
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
\seealso{
Other HTML elements: 
\code{\link{Label}()},
\code{\link{htmlElements}}
}
\concept{HTML elements}
