
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

ui <- fluidPage(
  sidebarPanel(
    checkboxGroupInput(inputId = "house", label = "Välj opinionsinstitut",
                   choices = unique(polls$house),
                   selected = "Demoskop"),
    width = 3),
  sidebarPanel(
    checkboxGroupInput(inputId = "parti", label = "Välj parti",
                       choices = unique(polls$parti),
                       selected = c("M", "L", "C", "KD",
                                    "S", "V", "MP",
                                    "SD", "FI")),
    width = 2),
  mainPanel(plotlyOutput("plot"))
  )

#ui <- fluidPage(
#  plotOutput("plot"),
#  headerPanel("Svensk opinion"),
#  sidebarPanel(
#    checkboxGroupInput(inputId = "house", 
#                       label = "house", 
#                       choices = levels(polls$house))
#  ))
