
# This is the server logic for a Shiny web application.
library(shiny)
library(dplyr)
library(plotly)

server <- function(input, output) {
  output$plot <- renderPlotly({
    polls %>%
      filter(house %in% input$house,
             parti %in% input$parti) %>%
      plot_ly(x = ~PublYearMonth,
              y = ~procent,
              text = ~paste('Parti:', parti, '<br>Procent:',
                            procent, '<br>Institut:', house,
                            "<br>Datum:", PublYearMonth),
              hoverinfo = "text", 
              opacity = c(0.8),
              mode = "markers",
              marker = list(color = ~color)) %>%
      layout(
        plot_bgcolor = "rgb(250,250,250)",
        font = list(family = "Gill Sans MT"),
        xaxis = list(title = "", range = c("1998-01-01", "2017-09-01")),
        yaxis = list(title = "", range = c(0, 50)),
        title = c("Svensk opinion över tid"),
        titlefont = list(size = 18, family = "Gill Sans MT"),
        showlegend = F)
  })
}