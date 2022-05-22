# The code chunk which creates artist databases.

# Loading the necessary libraries.
library(RSQLite)
library(DBI)

# Creating the #SaveUkraine (SU) data frame, in the ugly way.
# I am NEVER doing it like this again!
artist <- c(
  "Mila Chiral",
  "2fel",
  "Hellbach",
  "Brainquake",
  "Zumaia",
  "HF",
  "Terbeschikkingstelling",
  "Daniel Prendiville",
  "Wilfried Hanrath",
  "Linn Friberg",
  "Toxic Derwish",
  "Nijim",
  "Mora-Tau",
  "DJ_Frankenstone",
  "DJ_Iterate",
  "Noxventus",
  "Pete Swinton",
  "Eumourner",
  "Reflex Condition",
  "Second Harmonic Generation",
  "Thomas Park",
  "Spherical Disrupted",
  "TheOtherSideOfWho?",
  "Deborah Fialkiewicz",
  "KLUST",
  "Lavatone",
  "Temple Music",
  "Nurse Predator",
  "Tribe of Astronauts",
  "Fabian van den Eijnden",
  "Helen Larsson",
  "EISENLAGER",
  "Seward",
  "URZON",
  "D*Time",
  "Abner Malaty",
  "KONVLIKT",
  "Shane Morris",
  "M.NOMIZED",
  "Roberto Vodanović Copor",
  "Tone Tone",
  "Ksenia Kamikaza",
  "New Risen Throne",
  "Artificial Memory Trace",
  "The Owl",
  "Hostile Surgery",
  "Sophia Lund",
  "Khaoman",
  "KR Seward",
  "Gh⊕s††",
  "Lia Mice",
  "Donna Maya",
  "N",
  "Israel Flores Bravo",
  "Adrian Brewer",
  "P. Donohue",
  "Zonevreemd",
  "Devil's Breath",
  "Serpents",
  "dADa sCIENTISTS",
  "Nawa",
  "La Claud",
  "Wurm",
  "MUWN",
  "Mean Flow",
  "FM R IZ",
  "Ecstasphere",
  "Aphexia",
  "Valentin",
  "My Own Cubic Stone",
  "El Zombie Espacial",
  "Lady Maru",
  "Fugue in Sea",
  "Neleratz",
  "Rohton",
  "mutanT.R.I.",
  "Hipnagogia",
  "Federico Balducci",
  "fourthousandblackbirds",
  "Progettosonoro",
  "Panicfad",
  "FutureLight",
  "FutureLight",
  "Temple Music",
  "Viksandur"
)

country <- c(
  "Germany",
  "Germany",
  "Germany",
  "Belgium",
  "France",
  "United States of America",
  "Netherlands",
  "Ireland",
  "Germany",
  "Sweden",
  "Belgium",
  "Germany",
  "Japan",
  "United States of America",
  "United States of America",
  "Germany",
  "Indonesia",
  "Italy",
  "New Zealand",
  "Germany",
  "United States of America",
  "Germany",
  "Germany",
  "United Kingdom",
  "France",
  "United States of America",
  "Greece",
  "United Kingdom",
  "United States of America",
  "Netherlands",
  "Sweden",
  "Germany",
  "France",
  "Belgium",
  "Netherlands",
  "United States of America",
  "Germany",
  "United States of America",
  "France",
  "Croatia",
  "France",
  "Latvia",
  "Italy",
  "Ireland",
  "Czech Republic",
  "Switzerland",
  "Germany",
  "France",
  "United States of America",
  "Malta",
  "United Kingdom",
  "Germany",
  "Germany",
  "United States of America",
  "United Kingdom",
  "Australia",
  "Belgium",
  "Malta",
  "Germany",
  "France",
  "Hungary",
  "Italy",
  "United States of America",
  "France",
  "Greece",
  "United States of America",
  "Germany",
  "Germany",
  "Germany",
  "France",
  "Argentina",
  "Italy",
  "United States of America",
  "Germany",
  "Germany",
  "Slovakia",
  "Uruguay",
  "United States of America",
  "Canada",
  "Italy",
  "United States of America",
  "United States of America",
  "Germany",
  "United Kingdom",
  "Iceland"
)

su_data <- as.data.frame(cbind(artist, country))
rm(artist, country)

# Creating the complete KR (without SU) and AC databases, in a better way
kr_data <- read.delim("kr_artists.txt", sep = "(", header = FALSE)
kr_data <- unique(kr_data)
kr_data[] <- lapply(kr_data, gsub, pattern = ")", replacement = "")
colnames(kr_data) <- c("artist", "country")
ac_data <- read.delim("ac_artists.txt", sep = "(", header = FALSE)
ac_data[] <- lapply(ac_data, gsub, pattern = ")", replacement = "")
colnames(ac_data) <- c("artist", "country")

# Performing SQL queries, should get the copy of the same data frames as a check
con <- dbConnect(RSQLite::SQLite(), "data.db")
dbSendQuery(conn = con, "CREATE TABLE su_data (artist VARCHAR, country VARCHAR)")
dbAppendTable(con, "su_data", su_data)
su_data_check <- dbGetQuery(con, "SELECT * FROM su_data")

dbSendQuery(conn = con, "CREATE TABLE kr_data (artist VARCHAR, country VARCHAR)")
dbAppendTable(con, "kr_data", kr_data)
kr_data_check <- dbGetQuery(con, "SELECT * FROM kr_data")

dbSendQuery(conn = con, "CREATE TABLE ac_data (artist VARCHAR, country VARCHAR)")
dbAppendTable(con, "ac_data", ac_data)
ac_data_check <- dbGetQuery(con, "SELECT * FROM ac_data")

dbDisconnect(con)
