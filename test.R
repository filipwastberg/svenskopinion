library(data.table)
library(plotly)

dt <- data.table(campaign_week = c(1,2,3,1,2,3), category = c(rep("income",3),rep("cost",3)),
                 amount = c(100,50,35,-500,-20,-15))
dt_net <- dt[, .(amount = sum(amount)), by = campaign_week][,.(campaign_week, amount = cumsum(amount))]

y <- list(title = "Income", tickformat = "$,.0f",hoverformat = "$,.2f") 

plot_ly(dt_net, x = ~campaign_week, y = ~amount, type = "scatter",
        mode= "lines+markers",
        line = list(color = "#00AEFF"), name = "Net Income") %>%
  add_trace(data = dt, x = ~campaign_week, y = ~amount, color = ~category, type = "bar",
            colors = c("#00ff00", "#ff0000")) %>%
  layout(yaxis = y, barmode = "relative") 