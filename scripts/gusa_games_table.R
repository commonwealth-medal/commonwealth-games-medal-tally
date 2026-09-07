################################################################
#               GUSA GAMES TABLE (2014 -> 2018)                #
#                Created 20th January, 2018                    #
################################################################

## Load Libraries
library(ggplot2)
library(grid)
library(gridExtra)
library(dplyr)
library(magrittr)

## Import data into R
gusa_games_table <- readr::read_csv("C:/Users/DAVID/Documents/gusa_games/gusa_games_2014_2018.csv")


## Add up medals for each University
gusa_games_table <- gusa_games_table %>% 
    group_by(university) %>% 
    summarise(Gold = sum(gold), Silver = sum(silver), Bronze = sum(bronze), Total = sum(gold, silver, bronze))
  

## Change University names caps
gusa_games_table$university <- stringr::str_to_upper(gusa_games_table$university)
  
  
## Order Universities by gold medals 
gusa_games_table <- arrange(gusa_games_table, desc(Gold)) %>% 
  arrange(desc(Silver)) ## When 2 rows are equal, arrange ranks other row without touching rank of how it receives data
  
## Change colname to `School`
colnames(gusa_games_table)[1] <- "School"


## Create table of School medals
gusa_games_table <- tableGrob(gusa_games_table, rows = NULL)
grid.draw(gusa_games_table)
