
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# Lösning?? https://community.plot.ly/t/same-color-assigned-to-same-level-of-factor-in-r/655

library(shiny)
library(dplyr)
library(plotly)

server <- function(input, output) {
  output$plot <- renderPlot({
    polls %>%
      filter(house %in% input$house,
             parti %in% input$parti) %>%
    ggplot(aes(x = PublYearMonth, y = procent, col = parti)) +
      geom_point(alpha = 0.5) +
      scale_color_manual(values = c(PartyColor$C, PartyColor$FI, PartyColor$KD,
                                    PartyColor$L, PartyColor$M, PartyColor$MP,
                                    PartyColor$S, PartyColor$SD, PartyColor$V),
                         drop = FALSE)
  })
}