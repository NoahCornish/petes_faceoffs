#data code


library(googlesheets4)
library(tidyverse)

# Authenticate
#gs4_auth()

gs4_deauth()

faceoff_url <- "https://docs.google.com/spreadsheets/d/1i7EiuwExNF98quHg8EWzsWXuihE0jkfzE4hxD0cKHAo/edit?usp=sharing"

faceoff_raw <- read_sheet(faceoff_url)


faceoff_cleaned <- faceoff_raw %>%
  rename(PLAYER = `FACEOFF PLAYER`, `W/L` = `WIN / LOSS`)

player_win_loss <- faceoff_cleaned %>%
  group_by(PLAYER) %>%
  summarise(Wins = sum(`W/L` == "WIN"),
            Losses = sum(`W/L` == "LOSS")) %>% 
  mutate(Winning_Percentage = paste0(round((Wins / (Wins + Losses)) * 100, 1), "%")) %>%
  arrange(desc(as.numeric(sub("%", "", Winning_Percentage)))) %>% 
  rename(`%` = Winning_Percentage)

