library(shiny)
library(dplyr)
library(ggplot2)



filename <- file.path("data", "bcl-data.csv")
bcl <- read.csv(filename, stringsAsFactors = FALSE)

server <- function(input, output, session) {
  output$countrySelectorOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })
  
  output$typeSelectOutput <- renderUI({
    selectInput("typeInput", "Product type",
                sort(unique(bcl$Type)),
                multiple = TRUE,
                selected = c("BEER", "WINE"))
  })
  
  output$summaryText <- renderText({
    numOptions <- nrow(prices())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("We found ", numOptions, " options for you")
  })
  
  prices <- reactive({
    prices <- bcl
    
    if (is.null(input$countryInput)) {
      return(NULL)
    }
    
    prices <- dplyr::filter(prices, Type %in% input$typeInput)
    if (input$filterCountry) {
      prices <- dplyr::filter(prices, Country == input$countryInput)
    }
    prices <- dplyr::filter(prices, Price >= input$priceInput[1],
                            Price <= input$priceInput[2])
    
    if(nrow(prices) == 0) {
      return(NULL)
    }
    prices
  })
  
  output$plot <- renderPlot({
    if (is.null(prices())) {
      return(NULL)
    }
    
    ggplot(prices(), aes(Alcohol_Content, fill = Type)) +
      geom_histogram(colour = "black") +
      theme_classic(20)
  })
  
  output$prices <- DT::renderDataTable({
    prices()
  })
  
  output$download <- downloadHandler(
    filename = function() {
      "bcl-results.csv"
    },
    content = function(con) {
      write.csv(prices(), con)
    }
  )
}
