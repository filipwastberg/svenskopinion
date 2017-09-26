# Funktion för get_polls()
#
# Av: Filip Wästberg

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