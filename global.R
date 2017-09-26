library(tidyr)
library(dplyr)
source("get_polls_funkar.R")

polls <- get_polls() %>%
  select(PublYearMonth, M:FI, house) %>%
  gather("parti", value = procent, -PublYearMonth, -house)