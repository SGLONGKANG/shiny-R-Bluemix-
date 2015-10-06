library(ggplot2)
library(ibmdbR)
library(shiny)
library(leaflet)

# Connect to the database that contains the data to be processed.
con <- idaConnect("BLUDB", "dash018329", "krHwavvkonVC")
idaInit(con)

#Record longkang data
tf<-idaQuery("SELECT * FROM DASH018329.JIAYISUCKCOCK", as.is=F)

shinyServer(
  function(input, output){
    
    output$mymap <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%  # Add default OpenStreetMap map tiles
        addMarkers(lng=tf$LONGTITUDE, lat=tf$LONGTITUDE, popup="The data point")
      m  # Print the map
    })
    
    
    output$myplot <- renderPlot({
      if(input$dataset == "Flowrate")
        s <- ggplot(data = tf, aes(x=tf$TIME, y=tf$FLOWRATE, group=1)) +
        geom_line(colour = "red", size = 1)  +
        geom_point(size = 2) +
        xlab("Time") + ylab("Flowrate")
      
      else if(input$dataset == "Depth")
        s <- ggplot(data = tf, aes(x=tf$TIME, y=tf$DEPTH, group=1)) +
        geom_line(colour = "red", size = 1)  +
        geom_point(size = 2) +
        xlab("Time") + ylab("Depth")
      print(s)
    })
  })