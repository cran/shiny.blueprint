library(shiny.blueprint)
library(shiny)

setInput <- function(inputId, accessor = NULL) {
  JS(paste0("x => Shiny.setInputValue('", inputId, "', x", accessor, ")"))
}

ui <- function(id) {
  ns <- NS(id)
  div(
    style = "width: 20rem; display: grid; row-gap: 0.5rem",
    H4("Uncontrolled"),
    InputGroup(
      onChange = setInput(ns("uncontrolledInputGroup"), ".target.value"),
      disabled = FALSE,
      large = TRUE,
      leftIcon = "filter",
      placeholder = "Filter histogram...",
      rightElement = Spinner(intent = "primary", size = 20)
    ),
    textOutput(ns("uncontrolledInputGroupOutput")),
    H4("Controlled"),
    InputGroup.shinyInput(
      inputId = ns("controlledInputGroup"),
      disabled = FALSE,
      large = FALSE,
      leftIcon = "home",
      placeholder = "Type something..."
    ),
    textOutput(ns("controlledInputGroupOutput")),
    reactOutput(ns("passwordExample")),
    textOutput(ns("passwordOutput"))
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$uncontrolledInputGroupOutput <- renderText(input$uncontrolledInputGroup)
    output$controlledInputGroupOutput <- renderText(input$controlledInputGroup)

    isLocked <- reactiveVal(TRUE)

    observeEvent(input$toggleLock, isLocked(!isLocked()))
    output$passwordOutput <- renderText(input$passwordInput)

    output$passwordExample <- renderReact({
      lockButton <- Button.shinyInput(
        inputId = ns("toggleLock"),
        icon = ifelse(isLocked(), "lock", "unlock"),
        minimal = TRUE,
        intent = "warning"
      )
      InputGroup.shinyInput(
        inputId = ns("passwordInput"),
        disabled = FALSE,
        large = FALSE,
        rightElement = lockButton,
        placeholder = "Enter your password...",
        type = ifelse(isLocked(), "password", "text")
      )
    })
  })
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
