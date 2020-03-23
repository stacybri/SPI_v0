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
library(rgdal)
library(geojsonio)
############
# set reference year
############
reference_year=2018



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


##########
# Pull Tags for WDI Data
##########

# make request to World Bank API
wdiRequest <- GET(url = "http://api.worldbank.org/v2/indicator?per_page=20000&format=json&source=2")
wdiResponse <- content(wdiRequest, as = "text", encoding = "UTF-8")

# Parse the JSON content and convert it to a data frame.
wdisJSON <- fromJSON(wdiResponse, flatten = TRUE) %>%
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
                 
                 tabPanel("SPI AKI map",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("aki_map"
                                                        , width = "100%", height = "900px")),
                              
                              
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "aki_controls", class = "panel panel-default", fixed = TRUE,
                                            draggable = FALSE, top = 60, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                           
                                           h2("AKI Indicator Selection"),
                                           h4("Change the indicators to recalcuate the Availability of Key Indicators metric on the fly to see how country values change.  
                                              In the interactive map popup, indicators with a value of '1' are available while indicators with a value of '0' are not available"),
                                           selectizeInput("aki",
                                                       "AKI Indicator Choices",
                                                       choices=wdisJSON$name,
                                                       selected=c('Poverty headcount ratio at national poverty lines (% of population)',
                                                                  'Mortality rate, under-5 (per 1,000 live births)',
                                                                  'Immunization, measles (% of children ages 12-23 months)',
                                                                  'Primary completion rate, total (% of relevant age group)',
                                                                  'Literacy rate, adult total (% of people ages 15 and above)',
                                                                  'People using at least basic drinking water services (% of population)',
                                                                  'Unemployment, total (% of total labor force) (national estimate)',
                                                                  'Manufacturing, value added (% of GDP)',
                                                                  'Gross capital formation (% of GDP)',
                                                                  'Inflation, GDP deflator (annual %)',
                                                                  'Net trade in goods and services (BoP, current US$)',
                                                                  'Prevalence of undernourishment (% of population)'  ),
                                                       multiple=TRUE
                                           ),
                                            h4("Availability of Key Indicator Country Score = Weighted Score / Maximum Category Score X 100")
                              )
                              
                              
                              
                              
                                            
                                            
                                            
                              
                              
                          )
                 ),
                 tabPanel("SDG Indicator map",
                        div(class="outer",
                 
                 
                          
                                
                              
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("indicator_map_sdg"
                                            , width = "100%", height = "900px")),
                              
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                            draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                            
                                            h2("Indicator Selection"),
                                            h4("This tool allows us to see the geographic coverage of any specific indicator among the SDG indicators.  This may help us choose replacement indicators."),
                                            selectizeInput("indicator",
                                                           "  Indicator:",
                                                           choices = indicatorsJSON$name,
                                                           selected = 'GNI per capita (current US$)')
                                            
                                            
                              )
                              
                        )
                 ),
                 tabPanel("WDI Indicator map",
                          div(class="outer",
                              
                              
                              
                              
                              
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("indicator_map_wdis"
                                                        , width = "100%", height = "900px")),
                              
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls_wdis", class = "panel panel-default", fixed = TRUE,
                                            draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                            
                                            h2("WDI Indicator Selection"),
                                            h4("This tool allows us to see the geographic coverage of any specific indicator among the WDI indicators."),
                                            selectizeInput("indicator_wdis",
                                                           "  Indicator:",
                                                           choices = wdisJSON$name,
                                                           selected = 'Unemployment, total (% of total labor force) (national estimate)')
                                            
                                            
                              )
                              
                          )
                 )
                 
                 
                 
                 
                 
                              
                          
                 )
    

    

    
    

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    
    #######################
    # SPI AKI Map
    #######################
    

    #get id tag for selected choice
    get_tag_aki <- reactive({
        
        get_tag_aki_df<-wdisJSON %>%
            filter(name %in% input$aki) %>%
            arrange(factor(name, levels = input$aki))
        
        
        get_tag_aki_df[,'id']
        
    })
    
    ###########
    # Now pull data using IDs for WDI and calculate AKI
    ###########
    
    # Availability of Key Indicator Country Score equals Weighted Score divided by Maximum Category Score time 100
    
df_aki<- reactive({
    wb(country="countries_only", #pull country data
                indicator=get_tag_aki(),
                mrv=5,
                return_wide = T) %>%
    filter((reference_year-as.numeric(date))<=3) %>% #filter out years outside reference window of 3 years
    mutate_at(.vars=get_tag_aki(), ~if_else(is.na(.),0,1)) %>% #create 0,1 variable for whether data point exists for country
    group_by(country) %>%
    summarise_all((~(if(is.numeric(.)) max(., na.rm = TRUE) else first(.)))) %>% #group by country to create one observation per country containing whether or not data point existed
    mutate(AKI=100*rowMeans(.[get_tag_aki()], na.rm=T)) %>%
    mutate(ISO_A3_EH=iso3c) 
        
    })
    
    
    
    output$aki_map <- renderLeaflet({
        
        aki_map_df<-countries
        
        aki_map_df@data <- aki_map_df@data %>%
            left_join(df_aki()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", aki_map_df@data$AKI, 10, pretty = T)
        
        

        ##############
        #create labels
        ##############
        
        if (length(input$aki)==12) {
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
            aki_map_df@data$NAME_EN, 
            round(aki_map_df@data$AKI, digits = 1),
            input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
            input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
            input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
            input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
            input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
            input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
            input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
            input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
            input$aki[9],  aki_map_df@data[,get_tag_aki()[9]],
            input$aki[10], aki_map_df@data[,get_tag_aki()[10]],
            input$aki[11], aki_map_df@data[,get_tag_aki()[11]],
            input$aki[12], aki_map_df@data[,get_tag_aki()[12]]
        ) %>% 
            lapply(htmltools::HTML)
        }  else if (length(input$aki)==11) {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
                input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
                input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
                input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
                input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
                input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
                input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
                input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
                input$aki[9],  aki_map_df@data[,get_tag_aki()[9]],
                input$aki[10], aki_map_df@data[,get_tag_aki()[10]],
                input$aki[11], aki_map_df@data[,get_tag_aki()[11]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki)==10) {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
                input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
                input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
                input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
                input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
                input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
                input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
                input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
                input$aki[9],  aki_map_df@data[,get_tag_aki()[9]],
                input$aki[10], aki_map_df@data[,get_tag_aki()[10]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki)==9) {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
                input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
                input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
                input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
                input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
                input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
                input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
                input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
                input$aki[9],  aki_map_df@data[,get_tag_aki()[9]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki)==13) {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>

            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
                input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
                input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
                input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
                input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
                input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
                input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
                input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
                input$aki[9],  aki_map_df@data[,get_tag_aki()[9]],
                input$aki[10], aki_map_df@data[,get_tag_aki()[10]],
                input$aki[11], aki_map_df@data[,get_tag_aki()[11]],
                input$aki[12], aki_map_df@data[,get_tag_aki()[12]],
                input$aki[13], aki_map_df@data[,get_tag_aki()[13]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki)==14) {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
                input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
                input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
                input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
                input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
                input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
                input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
                input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
                input$aki[9],  aki_map_df@data[,get_tag_aki()[9]],
                input$aki[10], aki_map_df@data[,get_tag_aki()[10]],
                input$aki[11], aki_map_df@data[,get_tag_aki()[11]],
                input$aki[12], aki_map_df@data[,get_tag_aki()[12]],
                input$aki[13], aki_map_df@data[,get_tag_aki()[13]],
                input$aki[14], aki_map_df@data[,get_tag_aki()[14]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki)==15) {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki[1],  aki_map_df@data[,get_tag_aki()[1]],
                input$aki[2],  aki_map_df@data[,get_tag_aki()[2]],
                input$aki[3],  aki_map_df@data[,get_tag_aki()[3]],
                input$aki[4],  aki_map_df@data[,get_tag_aki()[4]],
                input$aki[5],  aki_map_df@data[,get_tag_aki()[5]],
                input$aki[6],  aki_map_df@data[,get_tag_aki()[6]],
                input$aki[7],  aki_map_df@data[,get_tag_aki()[7]],
                input$aki[8],  aki_map_df@data[,get_tag_aki()[8]],
                input$aki[9],  aki_map_df@data[,get_tag_aki()[9]],
                input$aki[10], aki_map_df@data[,get_tag_aki()[10]],
                input$aki[11], aki_map_df@data[,get_tag_aki()[11]],
                input$aki[12], aki_map_df@data[,get_tag_aki()[12]],
                input$aki[13], aki_map_df@data[,get_tag_aki()[13]],
                input$aki[14], aki_map_df@data[,get_tag_aki()[14]],
                input$aki[15], aki_map_df@data[,get_tag_aki()[15]]
            ) %>% 
                lapply(htmltools::HTML)
        } else  {
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> AKI Value: %g </strong><br/> <hr size=2>

            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1)

            ) %>% 
                lapply(htmltools::HTML)
        }
        
        
        
        
        
        leaflet(aki_map_df) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(AKI),
                        label=labels) %>%
            addLegend(pal=pal, values=~AKI, opacity=0.7, title='AKI value', position="bottomleft")
    })
    
    
    
    
    
    
    
    
    ######################
    # Map of All SDG Indicators
    ######################

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
       wb(country="countries_only", 
                  indicator=get_tag(),
                   mrv=5) %>%
            group_by(country) %>%
            filter(!is.na(value)) %>%
            arrange(desc(as.numeric(date))) %>%
            summarise_all(~first(.)) %>% #group by country to create one observation per country containing whether or not data point existed
            mutate(ISO_A3_EH=iso3c) 
    
    })

    
    
    output$indicator_map_sdg <- renderLeaflet({
        
        map_df_sdg<-countries
        
        map_df_sdg@data <- map_df_sdg@data %>%
            left_join(df_sdgs()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", map_df_sdg@data$value, 10, pretty = T)
        
        
        
        #create labels
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong>%s</strong><br/> <hr size=2>
            <strong> %g </strong>",
            map_df_sdg@data$NAME_EN, input$indicator, round(map_df_sdg@data$value, digits = 1)
            
        ) %>% 
            lapply(htmltools::HTML)
        
        
        leaflet(map_df_sdg) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(value),
                        popup=labels) %>%
            addLegend(pal=pal, values=~value, opacity=0.7, title=input$indicator, position="bottomright")
    })
    
    
    
    
    ######################
    # Map of All WDI Indicators
    ######################
    
    #get id tag for selected choice
    get_tag_wdis <- reactive({
        
        get_tag_wdis_df<-wdisJSON %>%
            filter(name==input$indicator_wdis)
        
        
        get_tag_wdis_df[,'id']
        
    })
    
    ###########
    # Now pull data using IDs for WDI
    ###########
    
    
    
    df_wdis <- reactive({
        wb(country="countries_only", 
           indicator=get_tag_wdis(),
           mrv=5) %>%
           group_by(country) %>%
           filter(!is.na(value)) %>%
           arrange(desc(as.numeric(date))) %>%
           summarise_all(~first(.)) %>% #group by country to create one observation per country containing whether or not data point existed
           mutate(ISO_A3_EH=iso3c) 

    })
    
    
    
    output$indicator_map_wdis <- renderLeaflet({
        
        map_df_wdi<-countries
        
        map_df_wdi@data <- map_df_wdi@data %>%
            left_join(df_wdis()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", map_df_wdi@data$value, 10, pretty = T)
        
        
        
        #create labels
        labels_wdi <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong>%s</strong><br/> <hr size=2>
            <strong> %g </strong>",
            map_df_wdi@data$NAME_EN, input$indicator_wdis, round(map_df_wdi@data$value, digits = 1)
            
        ) %>% 
            lapply(htmltools::HTML)
        
        
        leaflet(map_df_wdi) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(value),
                        popup=labels_wdi) %>%
            addLegend(pal=pal, values=~value, opacity=0.7, title=input$get_tag_wdis, position="bottomright")
    })
    
    
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
