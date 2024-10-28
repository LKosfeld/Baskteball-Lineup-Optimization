library(tidyverse)

#Load all the datasets with, individual players and 2, 3, 4 and 5 players lineups 
lineup2x2 <- read.csv("D:/Luca/Documentos/Note_Williams/Baskteball Analytics/Knick_Roster DF.csv")
lineup2x2 <- read.csv("D:/Luca/Documentos/Note_Williams/Baskteball Analytics/Knicks_Lineup2x2 DF.csv")
lineup3x3 <- read.csv("D:/Luca/Documentos/Note_Williams/Baskteball Analytics/Knicks_Lineup3x3 DF.csv")
lineup4x4 <- read.csv("D:/Luca/Documentos/Note_Williams/Baskteball Analytics/Knicks_Lineup4x4 DF.csv")
lineup5x5 <- read.csv("D:/Luca/Documentos/Note_Williams/Baskteball Analytics/Knicks_Lineup5x5 DF.csv")

#Remove the player and/or lineups with less than 10 games played
remove <- function(x){
  x <- x %>%
    filter(GP >= 10)
  return(x)
}
roster <- remove(roster)
lineup2x2 <- remove(lineup2x2)
lineup3x3 <- remove(lineup3x3)
lineup4x4 <- remove(lineup4x4)
lineup5x5 <- remove(lineup5x5)
