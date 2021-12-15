#install.packages("leaflet")
library(leaflet)

# date din leaflet
df1 <- data.frame(lng=47.654288, lat=-336.43426)

#creeare Loc1, Loc2, Loc3
df2 <- data.frame(
  lat = c(47.787326, 47.656138, 46.79968),
  lng = c(-337.131958, -336.434326, -336.412354),
  Description=c("Satu Mare","Baia Mare","Cluj"),
  Size=c(1500, 1000, 500)) #cercurile pentru fiecare loc

df3 <-read.csv("C:/Users/Miruna PC/OneDrive/Documents/R/Proiect/pk.csv")

# Add Color Pallete for categorical input
pallete <- colorFactor(
  palette = c('red', 'purple', 'pink'),
  domain = df2$Description
)
# or
pal <- colorFactor(
  palette = 'Set2',
  domain = df2$Description
)
# Add Color Pallete for continuous input
Contpallete <- colorQuantile("YlOrRd", df2$Size, n = 3)

# Adaugare pagina web
content <- paste(sep = "<br/>",
                 "<b><a href='https://github.com/rehanzfr'>Rehan Zafar</a></b>",
                 "Proiect",
                 "Medii Vizuale"
)


#modurile de a vizualiza mapa
prepare_map <-  df2 %>% leaflet() %>%
   
  addProviderTiles(providers$MtbMap, group = 'MtbMAP') %>% 
  
  addProviderTiles(providers$Stamen.TonerLines, 
                   options = providerTileOptions(opacity = 0.35), group = 'Tonerlines')  %>% 
  
  addProviderTiles(providers$Stamen.TonerLabels,group = 'TonerLabels') %>% 

  addLabelOnlyMarkers(~lng, ~lat, label =  df2$Description, 
                      labelOptions = labelOptions(noHide = T, direction = 'top'
                                                  ,textOnly = T)) %>% 
  
  #adaugarea cercurilor pentru loc1, loc2, loc3 in checkbox   
  addCircles(lng = ~lng, lat = ~lat, weight = 1,
             popup = ~Description, radius = ~sqrt(Size)*15, 
             color = ~Contpallete(Size), fillOpacity = 1, group = "df2") %>%
  #addPopups(lng=-336.434669, lat=47.656369, content)
  
  #legenda
  addLegend("bottomright", pal = Contpallete, values = ~Size, 
            title = "Size", opacity = 1) %>%
  
  #creearea iconitelor pentru locul ales
  addMarkers(lng = -337.131958, lat = 47.787326,
             label = "Satu Mare",
             labelOptions = labelOptions(noHide = T, direction = "bottom",
                                         style = list(
                                           "color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "italic",
                                           "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  
  addMarkers(lng = -336.434326, lat = 47.656138,
             label = "Baia Mare",
             labelOptions = labelOptions(noHide = T, direction = "bottom",
                                         style = list(
                                           "color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "italic",
                                           "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  
  addMarkers(lng = -336.412354, lat = 46.79968,
             label = "Cluj Napoca",
             labelOptions = labelOptions(noHide = T, direction = "bottom",
                                         style = list(
                                           "color" = "red",
                                           "font-family" = "serif",
                                           "font-style" = "italic",
                                           "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                           "font-size" = "15px",
                                           "border-color" = "rgba(0,0,0,0.5)"
                                         ))) %>%
  
  #trasarea ariei data in cod
  addPolygons(data = df2, lng = ~lng, lat = ~lat,
              fill = F, weight = 2, color = "black", group = "Outline") %>%
  
  # mod de vizualizare a infatisarii hartii
  addLayersControl(
    baseGroups = c("MtbMAP", "Tonerlines", "TonerLabels"),
    overlayGroups = c("df2", "Outline"),
    options = layersControlOptions(collapsed = FALSE)
  ) %>%

  #instrumentul de masurare  
  addMeasure(position = "bottomleft",
             primaryLengthUnit = "meters",
             primaryAreaUnit = "sqmeters",
             activeColor = "#3D535D",
             completedColor = "#7D4479") %>%
  
#mini harta  
  addMiniMap(
    tiles = providers$Esri.WorldStreetMap,
    toggleDisplay = TRUE) %>% addScaleBar()

#printarea hartii
prepare_map  

