### leaflet example code for Coen's present ###

library(data.table)
library(leaflet)
library(xlsx)
library(RgoogleMaps)
library(ggmap)
library(shiny)

setwd("C:\\Users\\Schal107\\Documents\\UBU\\Coen_present")

forms <- read.xlsx("Coens culinaire reisgids(1-7).xlsx", sheetIndex = 1)

google_key <- fread("C:\\Users\\Schal107\\Documents\\UBU\\Team DH\\Delpher\\google_key.txt")
register_google(key = paste0(google_key$key))

coordinates <- geocode(forms$Horecagelegenheid..naam..adresgegevens.en.website....)

forms <- cbind(forms, coordinates)

# we can add historical world maps if we like, like this, and then add the url inside addTiles:
# url <- ("https://maps.georeferencer.com/georeferences/5b0b6383-197e-5c57-a5a1-ec88d9b09154/2020-01-17T14:02:54.945310Z/map/{z}/{x}/{y}.png?key=ebGMmpORFAU1M65ypiIz")

leaflet(data = forms) %>% setView(lng = 10.95931966568949, lat = 50.1812298717116, zoom = 4) %>%
  addTiles() %>%
  addCircleMarkers(lat = ~lat, lng = ~lon, popup = paste0("<a href='",forms$link,"'>",
                                                          paste0(forms$Naam...,": ",forms$Dit.gerecht.zou.je.echt.eens.moeten.proberen..),"</a>"), 
                   color = "red", clusterOptions = markerClusterOptions())
