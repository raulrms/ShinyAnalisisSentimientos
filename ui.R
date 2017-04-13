# Panel Principal de la Aplicacion BTT - Beyond The Tweet
library(shiny)

shinyUI(fluidPage(
  headerPanel('BTT - Beyond The Tweet'),

  sidebarLayout(
    sidebarPanel(
      textInput("searchTerm", label = "Termino de Busqueda", value = "twitter"), 
      
      numericInput('cant', 'Numero de Tweets',50,0,1500),
      radioButtons('lang','Seleccione Idioma',c('English'='en', 'Castellano'='es')),
      submitButton("Buscar")
    ),
    
    mainPanel(tabsetPanel(
      
      tabPanel("Emociones",
               plotOutput("plot_emotion"),
               h4("Numero de tweets clasificados por emociones"),
               verbatimTextOutput("txtoutemo")),
 
      tabPanel("Polaridades",
               plotOutput("plot_polarity"),
               h4("Numero de tweets clasificados por polaridades"),
               verbatimTextOutput("txtoutpol"))
      ))
  )
))
