# Funciones auxiliares
# Funcion para convertir caracteres a minúsculas. En caso de error devuelve NA.
toLower <- function(text)
{
  errorLower <- tryCatch(tolower(text), error=function(e) e)
  
  if (inherits(errorLower, "error"))
    outLower <- NA    # set to NA 
  else  # if can be converted to lowercase
    outLower <- tolower(text)
  # return lowercase text
  return(outLower)
}

# Procesado y limpieza de tweets
preprocess_tweet <- function(tweets) {
  # Extraccion del texto de cada tweet
  tweets_text <- sapply(tweets, function(x) x$getText())

  # Limpieza de caracteres
  tweets_text <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweets_text)
  tweets_text <- gsub("[ \t]{2,}", "", tweets_text)
  tweets_text <- gsub("[[:punct:]]", "", tweets_text)
  tweets_text <- gsub("[[:digit:]]", "", tweets_text)
  tweets_text <- gsub("^\\s+|\\s+$", "", tweets_text)
  tweets_text <- gsub("@\\w+", "", tweets_text)
  tweets_text <- gsub("http\\w+", "", tweets_text)
  
  # Conversion a minusculas
  tweets_text <- sapply(tweets_text, toLower)
  
  # Limpieza de NAs
  tweets_text <- tweets_text[!is.na(tweets_text)]
  
  names(tweets_text) <- NULL
  return(tweets_text)
}

# Clasificacion por emociones
emotionSentimentAnal <- function (inText) {
  # Funcion para clasificacion en emociones
  emotionClass <- classify_emotion(inText, algorithm="bayes", prior=1.0)
  
  # Columna 7
  emotion <- emotionClass[,7]
  
  # Cambio de NA por unknown
  emotion[is.na(emotion)] <- "unknown"
  
  return(emotion)
}

# Clasificacion por polaridades
polaritySentimentAnal <- function (inText) {

  # Polaridades
  polarityClass <- classify_polarity(inText, algorithm="bayes")
  
  # Columna 4
  polarity <- polarityClass[,4]
  
  #Cambio de NA por unknown
  polarity[is.na(polarity)] <- "unknown"
  return (polarity)
}
