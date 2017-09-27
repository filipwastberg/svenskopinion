library(tidyr)
library(dplyr)
source("get_polls_funkar.R")

polls <- get_polls() %>%
  select(PublYearMonth, M:FI, house) %>%
  gather("parti", value = procent, -PublYearMonth, -house) %>%
  filter(!is.na(procent))

polls$parti <- as.factor(polls$parti)

# end_range <- max(polls$PublYearMonth) + 31

partycolors <- data.frame(parti = levels(as.factor(polls$parti)) ,
                          color = as.factor(c("#009933", "#CD1B68", "#000077",
                                              "#006AB3", "#52BDEC", "#83CF39",
                                              "#E8112d", "#DDDD00", "#DA291C")))

polls <- full_join(polls, partycolors, by = c("parti"))

#PartyColor <- list(V = "#DA291C",
#                   S = "#E8112d",
#                   MP = "#83CF39",
#                   C = "#009933",
#                   FP = "#006AB3",
#                   L = "#006AB3",
#                   M = "#52BDEC",
#                   KD = "#000077",
#                   SD = "#DDDD00",
#                   FI = "#CD1B68",
#                   PP = "#572B85")
