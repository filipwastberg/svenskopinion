##

library(tidyr)
library(dplyr)
library(ggplot2)
library(plotly)

data <- get_polls() %>%
  select(PublYearMonth, M:FI, house)  %>%
  gather("parti", value = procent, -PublYearMonth, -house)

polls %>%
  filter(house == "Demoskop") %>%
  ggplot(aes(x = PublYearMonth, y = procent, colour = parti)) +
  geom_point(alpha = 0.5) +
  scale_color_manual(name = "parti", values = pcol)

ggplotly(plot, tooltip = c("PublYearMonth", "parti", "procent", "Company"))

# Fungerande plotly
  polls %>%
    filter(house == "Demoskop") %>%
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
  
 #Test line plot 
  polls %>%
    filter(house == "Demoskop") %>%
    plot_ly(x = ~PublYearMonth,
            y = ~procent,
            text = ~paste('Parti:', parti, '<br>Procent:',
                          procent, '<br>Institut:', house,
                          "<br>Datum:", PublYearMonth),
            hoverinfo = "text", 
            opacity = c(0.8),
            mode = "lines",
            color = ~parti,
            line = list(color = ~color)) %>%
    layout(
      plot_bgcolor = "rgb(250,250,250)",
      font = list(family = "Gill Sans MT"),
      xaxis = list(title = "", range = c("1998-01-01", "2017-09-01")),
      yaxis = list(title = "", range = c(0, 50)),
      title = c("Svensk opinion över tid"),
      titlefont = list(size = 18, family = "Gill Sans MT"),
      showlegend = F) %>%
    add_trace(color = ~parti)
  