shinyUI(
  
  pageWithSidebar(
  
    headerPanel('Downloading Data'),
  
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
              choices = c("rock", "pressure", "cars")),
      
     downloadButton('downloadData', 'Download Data'),
     downloadButton('downloadPlot', 'Download Plot'),
     downloadButton('downloadReport', 'Download Report')
     # textInput('filename', "Filename"),
    #  checkboxInput('savePlot', "Check to save")
    ),
 
  mainPanel(
     plotOutput('plot')
  )
))
