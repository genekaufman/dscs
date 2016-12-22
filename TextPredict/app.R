#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source('../load_ngrams.R')
#library(xtable)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  theme = shinythemes::shinytheme("yeti"),

    # Application title
   titlePanel("Text Prediction"),


   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        textInput("input_text",
                  "Please enter some text:",
                  ""),
         br(),
         actionButton("goButton", "Go!")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        h4("Predicted text:"),
#        textOutput("summary"),
        br(),
        verbatimTextOutput("summary"),
br(),
verbatimTextOutput("summary2")

      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {

  output$summary <- renderPrint({
    # Simply accessing input$goButton here makes this reactive
    # object take a dependency on it. That means when
    # input$goButton changes, this code will re-execute.
    input$goButton

    isolate(predictTermsNgrams(input$input_text))

  })

  output$summary2 <- renderText({
    # Simply accessing input$goButton here makes this reactive
    # object take a dependency on it. That means when
    # input$goButton changes, this code will re-execute.
    input$goButton

    isolate(predictTermsNgramsV2(input$input_text))
  })

})

# Run the application
shinyApp(ui = ui, server = server)

