# Github Issue
# Wierd behaviour when assigning colors to data with NA's

# I'm building a shiny app for data on all polls made in Sweden from 1998-2017. 

# Here's the data

get_polls <- function(){
  # Get URL
  x <- RCurl::getURL("https://raw.githubusercontent.com/MansMeg/SwedishPolls/master/Data/Polls.csv")
  
  # Read csv
  df <- utils::read.csv(textConnection(x), stringsAsFactors = FALSE)
  df$PublYearMonth <- as.Date(paste("01", df$PublYearMonth, sep = " "), format="%d%Y-%b")
  df$Company <- factor(df$Company)
  df$PublDate <- lubridate::ymd(df$PublDate)
  df$collectPeriodFrom <- lubridate::ymd(df$collectPeriodFrom)
  df$collectPeriodTo <- lubridate::ymd(df$collectPeriodTo)
  df$house <- factor(df$house)
  dplyr::as_data_frame(df)
}

# So basically you will be able to chose which house that has carried out the poll and what party you are interested in.

polls <- get_polls() %>%
  select(PublYearMonth, M:FI, house) %>%
  gather("parti", value = procent, -PublYearMonth, -house)

# Each party has a official colour that needs to be consistent for different inputs
# So I create a data frame with party colors in order to join with data
partycolors <- data.frame(parti = levels(as.factor(polls$parti)) ,
                          color = as.factor(c("#009933", "#CD1B68", "#000077",
                                              "#006AB3", "#52BDEC", "#83CF39",
                                              "#E8112d", "#DDDD00", "#DA291C")))

# Join data
polls <- full_join(polls, partycolors, by = c("parti"))

# When I plot the data the last party, FI, gets the color of SD. 
polls %>%
  filter(house == "Demoskop") %>%
  plot_ly(x = ~PublYearMonth,
          y = ~procent,
          text = ~paste('Party:', parti,
                        '<br>Percent:', procent,
                        '<br>Date:', PublYearMonth),
          hoverinfo = 'text',
          mode = "markers",
          marker = list(color = ~color))

# However, when I filter out NA's (both SD and FI are reletively new parties)
polls <- polls %>%
  filter(!is.na(procent))

# The colors are correct.
polls %>%
  filter(house == "Demoskop") %>%
  plot_ly(x = ~PublYearMonth,
          y = ~procent,
          text = ~paste('Party:', parti,
                        '<br>Percent:', procent,
                        '<br>Date:', PublYearMonth),
          hoverinfo = 'text',
          mode = "markers",
          marker = list(color = ~color))

# Any idea why? 
