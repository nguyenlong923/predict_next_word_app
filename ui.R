#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    span(titlePanel("Predicting Your Next Word !"), style="color:steelblue"),
    fluidRow(
        column(12,
              span(h4("by Long Nguyen Hoang"), style="color:steelblue"),
              textAreaInput("text", "Please enter an unfinished English phrase:", 
                            width = "800px", 
                            height = "200px"),
              h5("Click on one of these prediction if correct"),
              actionButton("word1", span(textOutput("pred1"), style="color:indianred")),
              actionButton("word2", span(textOutput("pred2"), style="color:dodgerblue")),
              actionButton("word3", span(textOutput("pred3"), style="color:limegreen"))
        )
    )

))
