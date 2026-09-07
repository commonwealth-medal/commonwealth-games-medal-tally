library(tidyverse)

MEDALS <- read.csv("Output\\03_yearlist.csv")

MEDALS <- separate(MEDALS,
                   col = medal_name,
                   into = c("country", "medal_name"),
                   sep = "^[^:]+\\K:")

MEDALS$country <- ifelse(grepl("(?<=[a-z])[a-z](?=[A-Z])", MEDALS$country, perl = T),
                         stringr::str_extract(MEDALS$country, "^.*(?<=[a-z])[a-z](?=[A-Z][a-z])"),
                         MEDALS$country)
MEDALS$country <- gsub("\n", " ", MEDALS$country)
MEDALS$country <- gsub("Russian Federation \\(.*",
                       "Russian Federation",
                       MEDALS$country)

MEDALS$country <- stringr::str_remove_all(MEDALS$country,
                                          "The |Kingdom of |Bolivarian Republic of |Federal Republic of |United Republic of |Islamic Republic of |Federative Republic of |Republic of |Principality of |Grand Duchy of |Duchy of |Sultanate of |ODM of |Amirate of |The MEDALS of the |(Unofficial)|Hashemite |State of ") %>%
  trimws()

HARMONIA <- read.delim("Script\\harmonization.txt", sep = "\t")
for(i in 1:nrow(HARMONIA)) {
  MEDALS$country <- ifelse(MEDALS$country == HARMONIA$Deviation[i],
                           HARMONIA$Harmonization[i],
                           MEDALS$country)
}
# ===================
# add continent name
# ===================
library(countrycode)

MEDALS$continent <- countrycode(sourcevar = MEDALS[, "country"],
                                origin = "country.name",
                                destination = "continent")

MEDALS$instituted <- stringr::str_extract(MEDALS$instituted, "\\d\\d\\d\\d")

write.csv(MEDALS, "Output\\04_medals_with_continent.csv")
