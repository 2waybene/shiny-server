library(ggplot2)


shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  plotInput <- reactive({
    df <- datasetInput()
    p <-ggplot(df, aes_string(x=names(df)[1], y=names(df)[2])) +
      geom_point()
  })
  
  output$plot <- renderPlot({
    print(plotInput())
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, '.csv', sep='') },
    content = function(file) {
      df <- datasetInput()
      write.csv(df, file)
    }
  )
  output$downloadPlot <- downloadHandler(
    filename = function() { paste(input$dataset, '.png', sep='') },
    content = function(file) {
      ggsave(file,plotInput())
    }
  )
  
  output$downloadReport <- downloadHandler(
    filename = function() { paste(input$dataset, '.png', sep='') },
    content = function(file) {
      ggsave(file,plotInput())
    }
  )
})