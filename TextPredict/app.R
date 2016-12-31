#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source('load_ngrams.R')
#library(xtable)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  theme = shinythemes::shinytheme("yeti"),

    # Application title
   titlePanel("Coursera Data Sciences Capstone Project - Text Prediction"),


   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        textInput("input_text",
                "Please enter some text:",
                ""),
        br(),
        actionButton("goButton", "Predict!"),
        hr(),
        strong("Directions:"),
        p("Enter some text in the field above, click",strong("Predict!"),"button to predict what the next word might be."),
        p("See output generated from 2 different methods:"),
        p("- ",strong("Stupid Back Off:"),
          br(),
          "-",
          em("Largest n-gram:"),
          "The largest n-gram where the preceding",em("n-1"),"words were found.",
          br(),
          "-",
          em("Score:"),
          "The frequency percentage of the utilized n-gram term."
        ),
        p("- ",strong("My Hybrid Back Off:"),
          br(),
          "-",
          em("Largest n-gram:"),
          "The largest n-gram where the preceding",em("n-1"),"words were found.",
          br(),
          "-",
          em("Total Weight:"),
          "The summed",em("weight")," of all utilized n-gram terms."
        )
      ),

      # Show a plot of the generated distribution
      mainPanel(
        titlePanel("Predicted Text"),
#        textOutput("summary"),
#        br(),
        wellPanel(
          strong("Method: "),
                em("Stupid Back Off"),
                htmlOutput("outputSBO")
        ),
#        br(),
        wellPanel(
          strong("Method: "),
          em("My Hybrid Back Off"),
          htmlOutput("outputMYBO")
        )
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, session) {

  output$outputSBO <- renderText({
    # Simply accessing input$goButton here makes this reactive
    # object take a dependency on it. That means when
    # input$goButton changes, this code will re-execute.
    if (input$goButton > 0) {
      input$goButton

      isolate(makeOutputSBO(getBestTermSBO(input$input_text),inText = input$input_text)
        )
    }
  })

  output$outputMYBO <- renderText({
    # Simply accessing input$goButton here makes this reactive
    # object take a dependency on it. That means when
    # input$goButton changes, this code will re-execute.
    if (input$goButton > 0) {
      input$goButton

      isolate(makeOutput_MYBO(getBestPrediction_MYBO(input$input_text),inText = input$input_text)
      )

    }
  })

})

getDecimalNums <- function(floatVal) {
#  options("scipen"=100);
  for(n in 3:15){
    thisH <- floatVal;
    thisOne <- paste0("1e",n);
    if (thisH > 1 / eval(parse(text=thisOne))) {
      #      print(paste("7 n=",n,"->",round(thisH,n)));
      break;
    }
  }
#  options("scipen"=0);
  n;
}

makeOutput<-function(p_term,n_gram,qscore = 0,qterm = "P-Score:",inText) {
  predTerm <- h3(paste("Prediction:",p_term));
  predTerm <- paste(predTerm,paste(inText,"<em><strong>",p_term,"</strong></em><br><br>"));
  ng <- strong(paste("Largest n-gram:",n_gram));
  qs <- "";
 # message("length qscore:",length(qscore)," qscore:",qscore);
  options("scipen"=100);

  if (qscore > 0) {
    numDigits <- getDecimalNums(qscore);
#    if (qscore / 100)
    qs <- paste(br(), strong(paste( qterm,round(qscore,numDigits))));
#    qs <- br()
  }
  options("scipen"=0);

  myOutput <- paste(predTerm,ng,qs);

}

makeOutputSBO<-function(myObj, inText){
  log2File(inText);
  makeOutput(p_term=myObj$pred_term,
             n_gram=myObj$ngram,
             qscore=(myObj$terms_perc * 100),
             qterm=paste("Score:",myObj$ngram,":"),
             inText = inText);

}

makeOutput_MYBO<-function(myObj, inText){
  makeOutput(p_term=myObj$pred_term,
             n_gram=myObj$max_n,
             qscore=myObj$total_weight,
             qterm="Total Weight:",
             inText = inText);

}

# Run the application
shinyApp(ui = ui, server = server)

