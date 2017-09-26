##

library(tidyr)
library(dplyr)
library(ggplot2)
library(plotly)

data <- get_polls() %>%
  select(PublYearMonth, M:FI, house)  %>%
  gather("parti", value = procent, -PublYearMonth, -house)

polls %>%
  filter(house == "Demoskop",
         parti == "SD") %>%
  ggplot(aes(x = PublYearMonth, y = procent, col = parti)) +
  geom_point(alpha = 0.5) +
  scale_color_manual(values = c(PartyColor$C, PartyColor$FI, PartyColor$KD,
                               PartyColor$L, PartyColor$M, PartyColor$MP,
                               PartyColor$S, PartyColor$SD, PartyColor$V))

ggplotly(plot, tooltip = c("PublYearMonth", "parti", "procent", "Company"))

# Fungerande plotly
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
            colors = c(PartyColor$C, PartyColor$FI, PartyColor$KD,
                       PartyColor$L, PartyColor$M, PartyColor$MP,
                       PartyColor$S, PartyColor$SD, PartyColor$V)) %>%
    add_markers(color = ~parti) %>%
    layout(
      plot_bgcolor = "rgb(250,250,250)",
      font = list(family = "Gill Sans MT"),
      xaxis = list(title = "", range = c("1998-01-01", "2017-10-01")),
      yaxis = list(title = "", range = c(0, 50)),
      titlefont = list(size = 14),
      showlegend = F)