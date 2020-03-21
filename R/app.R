#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(wbstats)
library(httr)
library(jsonlite)
library(leaflet)
library(shinycssloaders)



#########
# Figure out the Source ID for SDGs
#########
# Get all the source names from the World Bank API
sourceRequest <- GET(url = "http://api.worldbank.org/v2/sources?format=json")
sourceResponse <- content(sourceRequest, as = "text", encoding = "UTF-8")

# Parse the JSON content and convert it to a data frame.
sourceJSON <- fromJSON(sourceResponse, flatten = TRUE) %>%
    data.frame()

# Print the data frame and review the source names and ids
cols <- c("id","name")
sourceJSON[,cols]


##########
# Pull Tags for SDG Data
##########

# make request to World Bank API
indicatorRequest <- GET(url = "http://api.worldbank.org/v2/indicator?per_page=500&format=json&source=46")
indicatorResponse <- content(indicatorRequest, as = "text", encoding = "UTF-8")

# Parse the JSON content and convert it to a data frame.
indicatorsJSON <- fromJSON(indicatorResponse, flatten = TRUE) %>%
    data.frame()

# Print and review the indicator names and ids from the dataframe
cols <- c("id","name")
#indicatorsJSON[,cols] # to view all the indicator names, remove the # at the beginning of this line. Please note that there are over 500 indicators.




#read in TopoJSON polygon file 
#downloaded https://datahub.io/core/geo-countries#data


#read in TopoJSON from World Bank
countries <- geojsonio::geojson_read("WB_countries_Admin0_lowres.geojson",
                                     what = "sp")



# Define UI for application that draws a histogram
ui <- navbarPage("Statistical Performance Index - Availability of Key Indicators", id="nav",
                 
                 tabPanel("Indicator map",
                        div(class="outer",
                 
                 
                          
                                
                              
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("indicator_map"
                                            , width = "100%", height = "600px")),
                              
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                            draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                            
                                            h2("Indicator Selection"),
                                            
                                            selectizeInput("indicator",
                                                           "  Indicator:",
                                                           choices=NULL)
                                            
                                            
                              )
                              
                        )
                 )
                              
                          
                 )
    

    
    
    
    

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    #update choices for indicators    
    updateSelectizeInput(session, 'indicator', choices = indicatorsJSON$name, server = TRUE,
                         selected = 'GNI per capita (current US$)')
    
    #get id tag for selected choice
    get_tag <- reactive({
        
        get_tag_df<-indicatorsJSON %>%
            filter(name==input$indicator)
        
        
        get_tag_df[,'id']
        
    })
    
    ###########
    # Now pull data using IDs for SDGs
    ###########
    

    
    df_sdgs <- reactive({
       wb(country="all", 
                  indicator=get_tag(),
                  mrv=1) %>%
        mutate(ISO_A3=iso3c) 
    
    })

    
    
    output$indicator_map <- renderLeaflet({
        
        map_df<-countries
        
        map_df@data <- map_df@data %>%
            left_join(df_sdgs()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", map_df@data$value, 10, pretty = T)
        
        
        
        #create labels
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong>%s</strong><br/> <hr size=2>
            <strong> %g </strong>",
            map_df@data$NAME_EN, input$indicator, round(map_df@data$value, digits = 1)
            
        ) %>% 
            lapply(htmltools::HTML)
        
        
        leaflet(map_df) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(value),
                        popup=labels) %>%
            addLegend(pal=pal, values=~value, opacity=0.7, title=input$indicator, position="bottomright")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
