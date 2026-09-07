#
#
#
# This file simply offers some basic examples of data analysis
# and visualisations.
#
#

library("tidyverse")
library("ggplot2")

MEDALS <- read.csv("Output\\04_medals_with_continent.csv")

# ===================
# sort countries by nr. of journals
# ===================
countries <- as.data.frame(table(MEDALS$country))
names(countries) = c("Country", "Freq")
countries <- countries %>%
  group_by(Country) %>%
  summarise(Freq = sum(Freq)) %>%
  arrange(desc(Freq))

# ===================
# plot diffusion
# ===================

df <- MEDALS %>%
  group_by(continent, instituted) %>%
  count()
names(df) <- c("Continent", "Year", "n")
df <- df[complete.cases(df), ]
df$Year = as.numeric(df$Year)

startyear <- 1900

df <- df %>% filter(Year > startyear)

ggplot(df, aes(x = Year, y = n, fill = Continent)) +
  scale_fill_grey() +
  theme_classic() + 
  geom_bar(stat="identity") +
  labs(x = "Year",
       y = "Number of New State Awards") +
  scale_x_continuous(breaks = seq(startyear, 2020, by = 20))
ggsave(path = "Graph\\",
       filename = "new-awards-bw.png",
       device = "png",
       dpi = 700)

# ===================
# CUMULATIVE COUNT OF ORDERS
# ===================
df <- MEDALS %>%
  select(country, continent, instituted)
names(df) <- c("Country", "Continent", "Year")
#df <- df[complete.cases(df), ] %>%
#  arrange(Year)
df <- df %>% arrange(Year)
df$ID <- seq.int(nrow(df))

startyear <- 1900

df %>%
  filter(Year > startyear) %>%
  group_by(Year) %>%
  summarize(cum_n = max(ID)) %>%
  ggplot(aes(x = Year, y = cum_n)) + 
  geom_line() +
  labs(title = "Cumulative Number of State Awards",
       x = "Year",
       y = "State Awards") +
  scale_x_continuous(breaks = seq(startyear, 2020, by = 10)) +
  scale_y_continuous(limits = c(0, 3000), breaks = seq(0, 3000, by = 250)) +
  theme_classic()

ggsave(path = "Graph\\",
       filename = "cumulative-bw.png",
       device = "png",
       dpi = 700)

# ===================
# 1st Order per Country?
# ===================

df <- MEDALS %>%
  select(country, continent, instituted)

library("data.table")
DT <- data.table(df)
DT <- DT[ , .SD[which.min(instituted)], by = country]
names(DT) <- c("Country", "Continent", "Year")

df <- DT %>%
  group_by(Continent, Year) %>%
  count() %>%
  filter(Year > 1200)
df <- df[complete.cases(df), ]

library("ggplot2")
ggplot(df, aes(x = Year, y = n, color = Continent)) +
  geom_bar(stat = "identity") +
  labs(title = "Number of New Orders & Awards",
       x = "Year",
       y = "Number")

# CUMULATIVE  DISTRIBUTION
ggplot(df, aes(x = Year, y = n, color = Continent)) + stat_ecdf()

mydf <- DT %>% select(Country, Year)
mydf = mydf[order(mydf$Year, mydf$Country), ]
mydf$country_id = as.integer(factor(mydf$Country, levels = unique(mydf$Country)))
mydf$cum_n_country = cummax(mydf$country_id)

ggplot(mydf, aes(x = Year)) + stat_ecdf()

mydf %>%
  filter(Year > 1900) %>%
  group_by(Year) %>%
  summarize(cum_n_country = max(cum_n_country)) %>%
  ggplot(aes(x = Year, y = cum_n_country)) + 
  geom_line()

# ===================
# 1st Order per Country? (without Continent)
# ===================

df <- MEDALS %>%
  select(instituted) %>%
  group_by(instituted) %>%
  count()
names(df) <- c("Year", "n")
df <- df[complete.cases(df), ]

ggplot(df, aes(x = Year, y = n)) +
  geom_point() +
  labs(title = "Installments of a Country's First Order",
       x = "Year",
       y = "Number")