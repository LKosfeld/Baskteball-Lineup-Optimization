library(tidyverse)
library(plotly)
library(corrplot)
library(reactable)


lineup5x5 <- read.csv("D:/Luca/Documentos/Note_Williams/Baskteball Analytics/Knicks_Lineup5x5 DF.csv")

#Remove the lineups with 3 or less games played
lineup5x5 <- lineup5x5 %>%
  filter(GP >= 4)

#Calculate statistics measures to understand a bit more the lineups
stats <- function(x){
  c(Mean = round(mean(x), digits = 1), Median = round(median(x), digits = 1),
    Min = round(min(x), digits = 1), Max = round(max(x), digits = 1))
}
statistics <- sapply(select(lineup5x5, -Lineups), stats)

#Make a table with the statistics measured
reactable(statistics,
          bordered = TRUE,           # Add borders to cells
          highlight = TRUE,           # Highlight rows on hover
          striped = TRUE,             # Alternate row colors
          theme = reactableTheme(
            color = "#333",           # Font color
            backgroundColor = "#f9f9f9",  # Background color
            borderColor = "#ccc",     # Border color
            stripedColor = "#f2f2f2" # Stripe color for alternate rows
          )
)


#Create visualizations of the lineups based on the offensive, defensive and net rating#

#scatter diagram to compare the offensive and defensive rating of each lineup, the size of the point varies according to the games played
#and the lines represent the mean of each of the ratings
scatter_off_def <- ggplot(data = lineup5x5, aes(x = OffRtg, y = DefRtg, color = Lineups, size = GP)) +
  geom_point(alpha = 0.7) +
  geom_vline(xintercept = mean(lineup5x5$OffRtg), color = "black") +
  geom_hline(yintercept = mean(lineup5x5$DefRtg), color = "black") +
  theme_bw()
sctt_off_def_int <- ggplotly(scatter_off_def)
sctt_off_def_int <- sctt_off_def_int%>%
  layout(showlegend = FALSE)
sctt_off_def_int

#Create a correlation graphic to see what variables have a correlation
Matrix_Lineup <- cor(select(lineup5x5, -Lineups))
corrplot(Matrix_Lineup, method = 'square', order = 'FPC', type = 'lower', diag = FALSE)


