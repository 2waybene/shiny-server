library(shiny)

# YOU CAN IGNORE THIS: metadata for when sharing the app on facebook/twitter
share <- list(
  title = "BC Liquor Store prices",
  url = "http://daattali.com/shiny/bcl/",
  image = "http://daattali.com/shiny/img/bcl.png",
  description = "Had a long day? This app will help you find the right drink for tonight!",
  twitter_user = "daattali"
)

ui <- fluidPage(
  # Ignore this tags$head section, just adding metadata for facebook/twitter sharing
  tags$head(
    tags$link(rel = "shortcut icon", type="image/x-icon", href="http://daattali.com/shiny/img/favicon.ico"),
    # Facebook OpenGraph tags
    tags$meta(property = "og:title", content = share$title),
    tags$meta(property = "og:type", content = "website"),
    tags$meta(property = "og:url", content = share$url),
    tags$meta(property = "og:image", content = share$image),
    tags$meta(property = "og:description", content = share$description),
    
    # Twitter summary cards
    tags$meta(name = "twitter:card", content = "summary"),
    tags$meta(name = "twitter:site", content = paste0("@", share$twitter_user)),
    tags$meta(name = "twitter:creator", content = paste0("@", share$twitter_user)),
    tags$meta(name = "twitter:title", content = share$title),
    tags$meta(name = "twitter:description", content = share$description),
    tags$meta(name = "twitter:image", content = share$image)
  ),
  
  
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      h4(
        "Had a long day?  This app will help you find the right drink for tonight! Just use the filters below..."
      ),
      br(),
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      
      uiOutput("typeSelectOutput"),
      
      checkboxInput("filterCountry", "Filter by country", FALSE),
      
      conditionalPanel(
        condition = "input.filterCountry",
        uiOutput("countrySelectorOutput")
      ),
      
      hr(),
      
           span("Data source:", 
           tags$a("OpenDataBC",
                  href = "https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices")),
      br(),
      
      span("Learn how to build this app", a(href = "http://deanattali.com/blog/building-shiny-apps-tutorial/", "with my Shiny tutorial")),
      
      br(), br(),
      
      em(
        span("I learned from ", a(href = "http://deanattali.com", "Dean Attali")),
        HTML("&bull;"),
        span("Code", a(href = "https://github.com/daattali/shiny-server/tree/master/bcl", "on my GitHub"))
      )
    ),
    
    
    mainPanel(
      h3(textOutput("summaryText")),
      downloadButton("download", "Download results"),
      br(),
      plotOutput("plot"),
      br(), br(),
      #tableOutput("prices")
      DT::dataTableOutput("prices")
    )
  )
)
