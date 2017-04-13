# Backend de la aplicacion
# Clasificacion por emociones y polaridades y representacon grafica.

# Paquetes requeridos
library(twitteR)
library(sentiment)
library(plyr)
library(ggplot2)
library(RColorBrewer)

# loading twitter credentials
#load("twitteR_credentials")
#registerTwitterOAuth(twitCred)

# Carga de funciones auxialiares
source('helpers.R')

shinyServer(function(input, output) {
  
  # Extraccion de tweets
  tweets <- reactive ({ searchTwitter(input$searchTerm, n=input$cant,lang=input$lang) })
  
   # Llamada a funcion de procesado de tweets
  txtTweets <- reactive ({ preprocess_tweet (tweets()) })
  
  #Representacion de emociones
  output$plot_emotion <- renderPlot({  
    
  # Funcion de clasificacion por emociones
  emotion <- emotionSentimentAnal(txtTweets())
    
  # Funcion de clasificacion por polaridades
  polarity <- polaritySentimentAnal(txtTweets())
    
  # Data frame
  results_df <- data.frame(text=txtTweets(), emotion=emotion, polarity=polarity)

  # Grafico de barras
      ggplot(results_df) +
        geom_bar(aes(x=emotion, y=..count.., fill=emotion)) +
        ggtitle(paste('Clasificacion de emociones para  "', input$searchTerm, '"', sep='')) +      
        xlab("Emociones") + ylab("Numero de Tweets") +
        scale_fill_brewer(palette="Set1") +
        theme_bw() +
        theme(axis.text.y = element_text(colour="black", size=18, face='plain')) +
        theme(axis.title.y = element_text(colour="black", size=18, face='plain', vjust=2)) + 
        theme(axis.text.x = element_text(colour="black", size=18, face='plain', angle=90, hjust=1)) +
        theme(axis.title.x = element_text(colour="black", size=18, face='plain')) + 
        theme(plot.title = element_text(colour="black", size=20, face='plain', vjust=2.5)) +
        theme(legend.text = element_text(colour="black", size=16, face='plain')) +
        theme(legend.title = element_text(colour="black", size=18, face='plain')) +
        guides(fill = guide_legend(keywidth = 2, keyheight = 2))
      
    })  
  
  output$plot_polarity <- renderPlot({  
    
  # Funcion de clasificacion por emociones
  emotion <- emotionSentimentAnal(txtTweets())
    
  # Funcion de clasificacion por polaridades
  polarity <- polaritySentimentAnal(txtTweets())
    
  # Data frame
  results_df <- data.frame(text=txtTweets(), emotion=emotion, polarity=polarity)
    
  # Grafico de barras
         ggplot(results_df, aes()) +
        geom_bar(aes(x=polarity, y=..count.., fill=polarity), width=0.6) +
        ggtitle(paste('Clasificacion de polaridades para "', input$searchTerm, '"', sep='')) +
        xlab("Polaridades") + ylab("Numero de Tweets") +   
        scale_fill_brewer(palette="Set1") +
        theme_bw() +
        theme(axis.text.y = element_text(colour="black", size=18, face='plain')) +
        theme(axis.title.y = element_text(colour="black", size=18, face='plain', vjust=2)) + 
        theme(axis.text.x = element_text(colour="black", size=18, face='plain', angle=90, hjust=1)) +
        theme(axis.title.x = element_text(colour="black", size=18, face='plain')) + 
        theme(plot.title = element_text(colour="black", size=20, face='plain', vjust=2.5)) +
        theme(legend.text = element_text(colour="black", size=16, face='plain')) +
        theme(legend.title = element_text(colour="black", size=18, face='plain')) +
        guides(fill = guide_legend(keywidth = 2, keyheight = 2))
  }) 

  output$txtoutemo <- renderPrint({  
    emotion <- emotionSentimentAnal(txtTweets())
    count(emotion)
    
  })
  
  output$txtoutpol <- renderPrint({  
    polarity <- polaritySentimentAnal(txtTweets())
    count(polarity)
    
  })
})
