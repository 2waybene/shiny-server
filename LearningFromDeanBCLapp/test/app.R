library(shiny)
library(ggplot2)
ui <- fluidPage(
  sliderInput("obs", "Number of observations", 0, 1000, 500),
 
  actionButton("goButton", "Go!"),
  downloadButton("reportButton", "Report"),
  plotOutput("distPlot")
)

server <- function(input, output) {
 # plotInput <-  NULL 
  
  output$distPlot <- renderPlot({
    # Take a dependency on input$goButton. This will run once initially,
    # because the value changes from NULL to 0.
    input$goButton
    
    # Use isolate() to avoid dependency on input$obs
    dist <- isolate(rnorm(input$obs))
    ggsave("plot.png", qplot(dist, geom="histogram") )
    qplot(dist, geom="histogram") 
    
    #ggsave("plot.pdf", hist(dist))
    #hist(dist)
  })
  
  output$download <- downloadHandler(
    filename = function() {
      "plot.png"
    },
    content = function(file) {
      file.copy(filename, file, overwrite=TRUE)
    }
  )
  
}

shinyApp(ui, server)