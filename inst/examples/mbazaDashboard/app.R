library(shiny.blueprint)
library(purrr)
library(sass)
library(shiny.router)
library(shiny)
library(stringi)

source("sidebar.R")
source("navbar.R")
source("home.R")

layout <- div(
  navbar,
  div(
    style = "display: flex; flex-direction: row",
    sidebar,
    homePage
  )
)

ui <- fluidPage(
  suppressDependencies("bootstrap"),
  tags$head(
    tags$link(href = "style.css", rel = "stylesheet", type = "text/css")
  ),
  shiny::tags$body(layout)
)

sass(sass_file("style.scss"), output = "www/style.css", cache = FALSE)

server <- function(input, output, session) {
  observeEvent(input$`user-button`, {
    print("User button clicked!")
  })
}

shinyApp(ui, server)
