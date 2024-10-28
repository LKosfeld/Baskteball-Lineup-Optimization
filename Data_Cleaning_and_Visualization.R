library(tidyverse)
library(plotly)
#install.packages("corrplot")
#library(reactable)
#library(formattable)

lineup <- read.csv("C:/Users/Luca/Documents/Baskteball Analytics/Knicks Lineup DF.csv")

#Remove the lineups with 3 or less games played
lineup <- lineup %>%
  filter(GP >= 4)

#Calculate the offensive, defensive and net rating per game#
lineup["OffRtg_per_game"] <- lineup$OffRtg / lineup$GP
lineup["DefRtg_per_game"] <- lineup$DefRtg / lineup$GP
lineup["NetRtg_per_game"] <- lineup$NetRtg / lineup$GP

#Round the mean of the metrics to 1 decimal digit
lineup <- lineup %>%
  mutate(OffRtg_per_game = round(OffRtg_per_game, digits = 1),
         DefRtg_per_game = round(DefRtg_per_game, digits = 1),
         NetRtg_per_game = round(NetRtg_per_game, digits = 1))


#Calculate statistics measures to understand a bit more the lineups
stats <- function(x){
  c(Mean = round(mean(x), digits = 1), Median = round(median(x), digits = 1),
    Min = round(min(x), digits = 1), Max = round(max(x), digits = 1))
}
statistics <- sapply(select(lineup, -Lineups), stats)
reactable(statistics)


#Create visualization of the lineups based on the offensive, defensive and net rating#

#scatter diagram to compare the offensive and defensive rating of each lineup, the size of the point varies according to the games played
#and the lines represent the mean of each of the ratings
scatter_off_def <- ggplot(data = lineup, aes(x = OffRtg, y = DefRtg, color = Lineups, size = GP)) +
  geom_point(alpha = 0.7) +
  geom_vline(xintercept = mean(lineup$OffRtg), color = "black") +
  geom_hline(yintercept = mean(lineup$DefRtg), color = "black") +
  theme_bw()
sctt_off_def_int <- ggplotly(scatter_off_def)
sctt_off_def_int <- sctt_off_def_int%>%
  layout(showlegend = FALSE)
sctt_off_def_int



