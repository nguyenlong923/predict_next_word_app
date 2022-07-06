#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Library
library(shiny)
library(tm)
library(glue)

# Function to remove unwanted characters
remove_unwant.char <- function(text.dat){
    # Text must be lower case first
    # remove @ from emails
    text.dat <- gsub("[^ ]{1,}@[^ ]{1,}", " ", text.dat)
    text.dat <- gsub(" @[^ ]{1,}", " ", text.dat)
    # remove # from hash tags
    text.dat <- gsub("#[^ ]{1,}", " ", text.dat) 
    # remove :// characters from websites and file systems
    text.dat <- gsub("[^ ]{1,}://[^ ]{1,}", " ", text.dat) 
    # remove unwanted non-alphabetical character
    text.dat <- gsub("[`’‘]", "'", text.dat) # first replace ` ’‘ by '
    text.dat <- gsub("[^a-z']", " ", text.dat) # remove characters that are not alphabet nor '
    text.dat <- gsub("'{2,}", "'", text.dat) # replace '' by '
    text.dat <- gsub("' ", " ", text.dat) # remove ' at the end of a word
    text.dat <- gsub(" '", " ", text.dat) # remove ' at the beginning of a word
    text.dat <- gsub("^'", "", text.dat) # remove ' at the beginning of a word
    text.dat <- gsub("'$", "", text.dat) # remove ' at the end of a word
    return(text.dat)
}
# Function to predict
ngram_model <- function(input.text) {
    if(is.na(input.text)) {
        pred <- c(NA,NA,NA)
        return(pred)
    } else {
        # Clean the text first
        clean.text <- tolower(input.text)
        # Remove unwanted characters
        clean.text <- remove_unwant.char(clean.text)
        text.vector <- words(clean.text)[nchar(words(clean.text)) > 1]
        # Extract two last words
        if (length(text.vector) == 0) {
            pred <- c(NA,NA,NA)
            return(pred) # Case of no input
        } else if (length(text.vector) == 1) {
            first.word <- "*" # Case of only one input word
            second.word <- text.vector[length(text.vector)]
            # Match and extract prediction data frame
            pred <- world.dict[(world.dict$word.1 == first.word | world.dict$word.1 == "*") &
                                   (world.dict$word.2 == second.word | world.dict$word.2 == "*"), ]
            # Avoid similar prediction
            pred <- pred[!duplicated(pred$word.3), ]
            # Return three possibilities of the third word
            return(pred$word.3[1:3])
        } else if (length(text.vector) > 1) {
            first.word <- text.vector[length(text.vector) - 1]
            second.word <- text.vector[length(text.vector)]
            # Match and extract prediction data frame
            pred <- world.dict[(world.dict$word.1 == first.word | world.dict$word.1 == "*") &
                                   (world.dict$word.2 == second.word | world.dict$word.2 == "*"), ]
            # Avoid similar prediction
            pred <- pred[!duplicated(pred$word.3), ]
            # Return three possibilities of the third word
            return(pred$word.3[1:3])
        }
    }
}

# Data
world.dict <- read.csv("./Data/ngram_dict.csv", colClasses=c("character","character","character"))

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    out.text <- reactive({
        ngram_model(input$text)
    })
    # Button 1
    output$pred1 <- renderText({
        if(is.na(out.text()[1])) {
            ""
        } else {
            out.text()[1]
        }
    })
    observe({
        out.text1 <- eventReactive(input$word1, {
            if(is.na(out.text()[1])) {
                input$text
            } else {
                glue_collapse(c(input$text,out.text()[1]), sep = " ")
            }
        })
        updateTextInput(session, "text", value = out.text1())
    })
    # Button 2
    output$pred2 <- renderText({
        if(is.na(out.text()[2])) {
            ""
        } else {
            out.text()[2]
        }
    })
    observe({
        out.text2 <- eventReactive(input$word2, {
            if(is.na(out.text()[2])) {
                input$text
            } else {
                glue_collapse(c(input$text,out.text()[2]), sep = " ")
            }
        })
        updateTextInput(session, "text", value = out.text2())
    })
    # Press 3
    output$pred3 <- renderText({
        if(is.na(out.text()[3])) {
            ""
        } else {
            out.text()[3]
        }
    })
    observe({
        out.text3 <- eventReactive(input$word3, {
            if(is.na(out.text()[3])) {
                input$text
            } else {
                glue_collapse(c(input$text,out.text()[3]), sep = " ")
            }
        })
        updateTextInput(session, "text", value = out.text3())
    })
})
