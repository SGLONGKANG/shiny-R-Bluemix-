library(ibmdbR)
library(shiny)
library(ggplot2)
library(leaflet)

# Connect to the database that contains the data to be processed.
con <- idaConnect("BLUDB", "dash018329", "krHwavvkonVC")
idaInit(con)

#Record longkang data
tf<-idaQuery("SELECT * FROM DASH018329.JIAYISUCKCOCK", as.is=F)


#setting UI for Shiny
shinyUI(fluidPage(
  
  titlePanel("SGLongKang Analytics"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "choose a dataset: ", choices = c("Flowrate", "Depth"), 
                  selected = 1, selectize = TRUE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("tab1", plotOutput("myplot")),
        tabPanel("tab2", leafletOutput("mymap"))
      )
    ),
    position = "left"
  )
))
