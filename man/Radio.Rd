% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{Radio}
\alias{Radio}
\alias{RadioGroup}
\alias{RadioGroup.shinyInput}
\title{Radio}
\usage{
Radio(...)

RadioGroup(...)

RadioGroup.shinyInput(inputId, ..., value = defaultValue)
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
Documentation: \url{https://blueprintjs.com/docs/#core/components/radio}
}
\examples{
library(shiny.blueprint)
library(shiny)

setInput <- function(inputId, accessor = NULL) {
  JS(paste0("x => Shiny.setInputValue('", inputId, "', x", accessor, ")"))
}

ui <- function(id) {
  ns <- NS(id)
  tagList(
    H3("Favorite animal"),
    RadioGroup.shinyInput(
      inputId = ns("animal"),
      value = "dog",
      Radio(label = "Cat", value = "cat"),
      Radio(label = "Dog", value = "dog")
    ),
    textOutput(ns("favoriteAnimal")),
    H3("Favorite fruit"),
    reactOutput(ns("fruitRadio")),
    textOutput(ns("favoriteFruit"))
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$favoriteAnimal <- renderText(deparse(input$animal))

    fruit <- reactiveVal()
    observeEvent(input$fruit, fruit(input$fruit))
    output$fruitRadio <- renderReact({
      RadioGroup(
        onChange = setInput(ns("fruit"), ".currentTarget.value"),
        selectedValue = fruit(),
        Radio(label = "Apple", value = "a"),
        Radio(label = "Banana", value = "b"),
        Radio(label = "Cherry", value = "c")
      )
    })
    output$favoriteFruit <- renderText(deparse(fruit()))
  })
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
