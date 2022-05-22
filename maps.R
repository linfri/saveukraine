# The code chunks which plot the maps and word clouds.

# Loading the libraries.
library(RSQLite)
library(DBI)
library(rworldmap)
library(wordcloud2)
library(fuzzyjoin)
library(tidyverse)
library(wordcloud)

# Getting data out of the database.
con <- dbConnect(RSQLite::SQLite(), "data.db")
su_data <- dbGetQuery(con, "SELECT * FROM su_data")
kr_data <- dbGetQuery(con, "SELECT * FROM kr_data")
ac_data <- dbGetQuery(con, "SELECT * FROM ac_data")
dbDisconnect(con)

# Getting the frequency table.
su_data_t <- as.data.frame(table(su_data$country))
su_data_t$Freq <- as.numeric(su_data_t$Freq)
colnames(su_data_t) <- c("Country", "Frequency")

# Preparing some additional data:
# - artists who weren't on KR before #SaveUkraine
# - artists who appeared on both #SaveUkraine and Stop All Wars
new_artists <- stringdist_anti_join(su_data, kr_data)
acsu_artists <- stringdist_semi_join(su_data, ac_data)

# ...and some more data for the homogeneity test...
# (doing it all for SU again, wouldn't do it if the data set was large)
ac_data_freq <- as.data.frame(table(ac_data$country))
su_data_freq <- as.data.frame(table(su_data$country))
group_test <- inner_join(ac_data_freq, su_data_freq, by = "Var1")

new_artists <- as.data.frame(table(new_artists$country))
new_artists$Freq <- as.numeric(new_artists$Freq)
colnames(new_artists) <- c("Country", "Frequency")

acsu_artists <- as.data.frame(table(acsu_artists$country))
acsu_artists$Freq <- as.numeric(acsu_artists$Freq)
colnames(acsu_artists) <- c("Country", "Frequency")

# Plotting the maps.
capture.output(su_data_map <- joinCountryData2Map(su_data_t,
  joinCode = "NAME",
  nameJoinColumn = "Country"
),
file = "NUL"
)
mapCountryData(su_data_map,
  nameColumnToPlot = "Frequency",
  catMethod = "categorical",
  colourPalette = "heat",
  missingCountryCol = "gray98",
  addLegend = FALSE,
  mapTitle = "Contributing countries (World)"
)
mapCountryData(su_data_map,
  nameColumnToPlot = "Frequency",
  catMethod = "categorical",
  colourPalette = "heat",
  missingCountryCol = "gray98",
  mapRegion = "Europe",
  addLegend = FALSE,
  mapTitle = "Contributing countries (Europe)"
)

# Plotting the word cloud.
su_wordcloud_data <- su_data_t
su_wordcloud_data$Country <- as.character(su_wordcloud_data$Country)
su_wordcloud_data$Country[24] <- "USA"
wordcloud2(
  data = su_wordcloud_data, size = 0.5, minRotation = 1, maxRotation = 1,
  fontWeight = "normal", shuffle = FALSE
)

# Getting the frequency table.
ac_data_t <- as.data.frame(table(ac_data$country))
ac_data_t$Freq <- as.numeric(ac_data_t$Freq)
colnames(ac_data_t) <- c("Country", "Frequency")

# Plotting the maps.
capture.output(ac_data_map <- joinCountryData2Map(ac_data_t,
  joinCode = "NAME",
  nameJoinColumn = "Country"
),
file = "NUL"
)
mapCountryData(ac_data_map,
  nameColumnToPlot = "Frequency",
  catMethod = "categorical",
  colourPalette = "heat",
  missingCountryCol = "gray98",
  addLegend = FALSE,
  mapTitle = "Contributing countries (World)"
)
mapCountryData(ac_data_map,
  nameColumnToPlot = "Frequency",
  catMethod = "categorical",
  colourPalette = "heat",
  missingCountryCol = "gray98",
  mapRegion = "Europe",
  addLegend = FALSE,
  mapTitle = "Contributing countries (Europe)"
)

# Plotting the word cloud.
ac_wordcloud_data <- ac_data_t
ac_wordcloud_data$Country <- as.character(ac_wordcloud_data$Country)
ac_wordcloud_data$Country[30] <- "USA"
wordcloud(
  ac_wordcloud_data$Country, ac_wordcloud_data$Frequency,
  min.freq = 1,
  colors = c("brown3", "brown4")
)
