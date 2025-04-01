box::use(
  shiny[fluidPage, titlePanel, sidebarLayout, sidebarPanel, textInput, textOutput, mainPanel, NS, moduleServer,
        renderText],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  fluidPage(
    titlePanel("Hello Rhino!"),
    sidebarLayout(
      sidebarPanel(
        textInput(ns("name"), "Your name:", "World")
      ),
      mainPanel(
        textOutput(ns("greeting"))
      )
    )
  )
}


#' @export

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$greeting <- renderText({
      paste("Hello,", input$name, "!")
    })
  })
}
