% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R, R/handlers.R
\name{PanelStack}
\alias{PanelStack}
\alias{PanelStack.shinyWrapper}
\alias{openPanel}
\alias{closePanel}
\title{Panel stack}
\usage{
PanelStack(...)

PanelStack.shinyWrapper(panels, ns = "ps", size = c(300, 250), ...)

openPanel(panelId, ns = "ps")

closePanel(ns = "ps")
}
\arguments{
\item{...}{Component props and children. See the official Blueprint docs for details.}

\item{panels}{List of lists - each list contains \code{title} (string) and \code{content} (HTML)}

\item{ns}{Namespace of given panel stack (required if there's more than 1 panel stack)}

\item{size}{Numeric vector of length 2 - \code{c(width, height)}}

\item{panelId}{Id of the panel to be closed}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
Documentation: \url{https://blueprintjs.com/docs/#core/components/panel-stack2}
}
\examples{
library(shiny.blueprint)
library(shiny)

customComponents <- tagList(
  tags$style("
    .panel-stack {
      border: 1px solid lightgrey;
      width: 300px;
      height: 240px;
    }
    .panel {
      position: absolute;
      top: 50\%;
      left: 50\%;
      transform: translate(-50\%, -50\%);
    }
  "),
  tags$script(HTML("(() => {
    const React = jsmodule['react'];
    const Blueprint = jsmodule['@blueprintjs/core'];

    function createPanel(num) {
      return {
        title: `Panel ${num}`,
        renderPanel: Panel,
        props: { num },
      };
    }

    function Panel({ num, openPanel }) {
      const button = React.createElement(
        Blueprint.Button,
        {
          onClick: () => openPanel(createPanel(num + 1)),
          intent: Blueprint.Intent.PRIMARY,
        },
        'Open Panel'
      )
      return React.createElement('div', { className: 'panel' }, button);
    }

    window.createPanel = createPanel;
  })()"))
)

ui <- function(id) {
  tagList(
    customComponents,
    PanelStack(
      className = "panel-stack",
      initialPanel = JS("createPanel(1)")
    ),
    PanelStack.shinyWrapper(
      panels = list(
        list(id = "panel1", title = "Panel 1", content = div(
          class = "panel",
          Button(text = "Open 2", onClick = openPanel("panel2")),
          Button(text = "Open 4", onClick = openPanel("panel4"))
        )),
        list(id = "panel2", title = "Panel 2", content = div(
          class = "panel",
          Button(text = "Open 3", onClick = openPanel("panel3")),
          Button(text = "Close", onClick = closePanel())
        )),
        list(id = "panel3", title = "Panel 3", content = div(
          class = "panel",
          Button(text = "Open 4", onClick = openPanel("panel4")),
          Button(text = "Close", onClick = closePanel())
        )),
        list(id = "panel4", title = "Panel 4", content = div(
          class = "panel",
          Button(text = "Close", onClick = closePanel())
        ))
      )
    )
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

if (interactive()) shinyApp(ui("app"), function(input, output) server("app"))
}
