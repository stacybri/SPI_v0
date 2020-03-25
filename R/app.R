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
library(DT)
library(skimr)
library(ggcorrplot)
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
                 
                 tabPanel("Original SPI AKI Map & Summary Statistics",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("aki_map"
                                                        , width = "100%", height = "900px")),
                              
                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("indicators_choices")),
                              h3('Summary Statistics of AKI Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats")),
                              h3('Correlations of AKI Indicators'),
                              withSpinner(plotOutput('corrplot', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "aki_controls", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 60, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                           
                                           h2("AKI Indicator Selection"),
                                           h4("Change the indicators to recalcuate the Availability of Key Indicators metric on the fly to see how country values change.  
                                              In the interactive map popup, indicators with a value of '1' are available while indicators with a value of '0' are not available.
                                              The criteria for availability is whether the value exists within a 3 year window of 2018."),
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
                 tabPanel("Updated Indicators - SPI AKI map",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("aki_map_updated"
                                                        , width = "100%", height = "900px")),
                              
                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("indicators_choices_updated")),
                              h3('Summary Statistics of AKI Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats_updated")),
                              h3('Correlations of AKI Indicators'),
                              withSpinner(plotOutput('corrplot_updated', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "aki_controls_updated", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 60, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                            
                                            h2("AKI Indicator Selection"),
                                            h4("Change the indicators to recalcuate the Availability of Key Indicators metric on the fly to see how country values change.  
                                              In the interactive map popup, indicators with a value of '1' are available while indicators with a value of '0' are not available.
                                              The criteria for availability is whether the value exists within a 3 year window of 2018."),
                                            selectizeInput("aki_updated",
                                                           "AKI Indicator Choices",
                                                           choices=wdisJSON$name,
                                                           selected=c('Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)',
                                                                      'Prevalence of undernourishment (% of population)',
                                                                      'Mortality rate, under-5 (per 1,000 live births)',
                                                                      'Primary completion rate, total (% of relevant age group)',
                                                                      'Female share of employment in senior and middle management (%) ',
                                                                      'People using safely managed drinking water services (% of population)',
                                                                      'Access to electricity (% of population)',
                                                                      'GDP per capita growth (annual %)',
                                                                      'Research and development expenditure (% of GDP)',
                                                                      'Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%)',
                                                                      'Level of water stress: freshwater withdrawal as a proportion of available freshwater resources',
                                                                      'Renewable electricity output (% of total electricity output)',
                                                                      'Debt service (PPG and IMF only, % of exports of goods, services and primary income)',
                                                                      'Completeness of birth registration (%)',
                                                                      'Manufacturing, value added (% of GDP)'
                                                           ),
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
            arrange(factor(name, levels = input$aki)) %>%
            select(id, name, sourceNote, sourceOrganization)
        
        
        get_tag_aki_df[,'id']
        
    })
    
    
    ###########
    # SPI AKI Datatable
    ###########
    
    output$indicators_choices <- DT::renderDataTable({
        
        get_tag_aki_tab<-wdisJSON %>%
            filter(name %in% input$aki) %>%
            arrange(factor(name, levels = input$aki)) %>%
            select(id, name, sourceNote, sourceOrganization)
        
        
        
        DT::datatable(get_tag_aki_tab, caption="Table of Chosen SPI AKI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source Note", "Source Organization"),
                      class='cell-border stripe',
                      escape = FALSE,
                      extensions = c ('Buttons', 'FixedHeader'), options=list(
                          dom = 'Bfrtip',
                          buttons = c('copy', 'csv', 'excel'),
                          pageLength = 60,
                          scrollX = TRUE, 
                          paging=FALSE,
                          ordering=F)) 
        
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
    
    ###########
    # SPI AKI Summary Stats
    ###########
    
    output$summary_stats <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
        my_skim<-    skim_with( numeric = sfl( mean = ~ mean(.,   na.rm=TRUE),
                                               sd = ~ sqrt(var(.,   na.rm=TRUE)),
                                               p25 = ~ (quantile(., probs=c(0.25),   na.rm=TRUE)),
                                               p50 = ~ (quantile(., probs=c(0.5),  na.rm=TRUE)),
                                               p75 = ~ (quantile(., probs=c(0.75),  na.rm=TRUE)),
                                               complete = ~ sum(!is.na(.)))) 
        sumstats <- df_aki() %>%
            select(get_tag_aki()) 
        
        #produce summary stats
        sumstats_df<-my_skim(sumstats) %>%
            yank("numeric") %>%
            mutate(id=skim_variable) %>%
            select(id, mean, sd, p0, p25, p50, p75, p100, complete,  hist) 
        
        #create labels df
        get_tag_aki_labs<-wdisJSON %>%
            filter(name %in% input$aki) %>%
            arrange(factor(name, levels = input$aki)) %>%
            select(id, name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(get_tag_aki_labs) %>%
            select(id, name,  mean, sd, p0, p25, p50, p75, p100, complete, hist)
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
                                            style = 'caption-side: bottom; text-align: left;',
                                            htmltools::em("Indicator values are converted to 0 or 1 based on whether they are available in the three year time window."))    ,
                      colnames=c("Indicator", "Label", "Mean", "Std Dev","Min", "25th Percentile", "Median", "75th Percentile", "Max", "# Complete Cases",  "Histogram"),
                      extensions = 'Buttons', options=list(
                          dom = 'Bfrtip',
                          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                          pageLength = 60)) %>%
            formatRound(columns = c('mean', 'sd', 'p0', 
                                    'p25', 'p50', 'p75', 'p100'),
                        digits=2)
        
        
    
    })
    
    #######################
    # Correlation between AKI indicators
    ######################
    
    
    corrp <- reactive({
        
        
        corr_df <- df_aki()
        corr_names<-get_tag_aki()
        names(corr_names) = input$aki
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between AKI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 16)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to 0 or 1 based on whether they are available in the three year time window." 
            )
        
        pcorr
        
    })
    
    
    
    
    
    
    output$corrplot <- renderPlot({
        
        corrp()
        
    })
    
    
    
    
    #######################
    # SPI AKI Map w/ Updated Indicators
    #######################
    
    
    #get id tag for selected choice
    get_tag_aki_updated <- reactive({
        
        get_tag_aki_df<-wdisJSON %>%
            filter(name %in% input$aki_updated) %>%
            arrange(factor(name, levels = input$aki_updated)) %>%
            select(id, name, sourceNote, sourceOrganization)
        
        
        get_tag_aki_df[,'id']
        
    })
    
    
    ###########
    # SPI AKI Datatable
    ###########
    
    output$indicators_choices_updated <- DT::renderDataTable({
        
        get_tag_aki_tab<-wdisJSON %>%
            filter(name %in% input$aki_updated) %>%
            arrange(factor(name, levels = input$aki_updated)) %>%
            select(id, name, sourceNote, sourceOrganization)
        
        
        
        DT::datatable(get_tag_aki_tab, caption="Table of Chosen SPI AKI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source Note", "Source Organization"),
                      class='cell-border stripe',
                      escape = FALSE,
                      extensions = c ('Buttons', 'FixedHeader'), options=list(
                          dom = 'Bfrtip',
                          buttons = c('copy', 'csv', 'excel'),
                          pageLength = 60,
                          scrollX = TRUE, 
                          paging=FALSE,
                          ordering=F)) 
        
    })
    ###########
    # Now pull data using IDs for WDI and calculate AKI
    ###########
    
    # Availability of Key Indicator Country Score equals Weighted Score divided by Maximum Category Score time 100
    
    df_aki_updated<- reactive({
        
        wb(country="countries_only", 
           indicator=get_tag_aki_updated(),
           startdate=reference_year-4,
           enddate=reference_year,
           return_wide = T) %>%
            mutate_at(.vars=get_tag_aki_updated(), ~if_else(is.na(.),0,1)) %>% #create 0,1 variable for whether data point exists for country
            group_by(country) %>%
            summarise_all((~(if(is.numeric(.)) sum(., na.rm = TRUE)/5 else first(.)))) %>% #group by country to create one observation per country containing whether or not data point existed
            mutate(AKI=100*rowMeans(.[get_tag_aki_updated()], na.rm=T)) %>%
            mutate(ISO_A3_EH=iso3c) 
        
        # wb(country="countries_only", #pull country data
        #    indicator=get_tag_aki_updated(),
        #    mrv=5,
        #    return_wide = T) %>%
        #     filter((reference_year-as.numeric(date))<=3) %>% #filter out years outside reference window of 3 years
        #     mutate_at(.vars=get_tag_aki_updated(), ~if_else(is.na(.),0,1)) %>% #create 0,1 variable for whether data point exists for country
        #     group_by(country) %>%
        #     summarise_all((~(if(is.numeric(.)) max(., na.rm = TRUE) else first(.)))) %>% #group by country to create one observation per country containing whether or not data point existed
        #     mutate(AKI=100*rowMeans(.[get_tag_aki_updated()], na.rm=T)) %>%
        #     mutate(ISO_A3_EH=iso3c) 
        
    })
    
    
    
    output$aki_map_updated <- renderLeaflet({
        
        
        aki_map_df<-countries
        
        aki_map_df@data <- aki_map_df@data %>%
            left_join(df_aki_updated()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", aki_map_df@data$AKI, 10, pretty = T)
        
        
        
        ##############
        #create labels
        ##############
        
        if (length(input$aki_updated)==12) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]],
                input$aki_updated[12], aki_map_df@data[,get_tag_aki_updated()[12]]
            ) %>% 
                lapply(htmltools::HTML)
        }  else if (length(input$aki_updated)==11) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==10) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==9) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==13) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]],
                input$aki_updated[12], aki_map_df@data[,get_tag_aki_updated()[12]],
                input$aki_updated[13], aki_map_df@data[,get_tag_aki_updated()[13]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==14) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]],
                input$aki_updated[12], aki_map_df@data[,get_tag_aki_updated()[12]],
                input$aki_updated[13], aki_map_df@data[,get_tag_aki_updated()[13]],
                input$aki_updated[14], aki_map_df@data[,get_tag_aki_updated()[14]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==15) {
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
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]],
                input$aki_updated[12], aki_map_df@data[,get_tag_aki_updated()[12]],
                input$aki_updated[13], aki_map_df@data[,get_tag_aki_updated()[13]],
                input$aki_updated[14], aki_map_df@data[,get_tag_aki_updated()[14]],
                input$aki_updated[15], aki_map_df@data[,get_tag_aki_updated()[15]]
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==16) {
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
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]],
                input$aki_updated[12], aki_map_df@data[,get_tag_aki_updated()[12]],
                input$aki_updated[13], aki_map_df@data[,get_tag_aki_updated()[13]],
                input$aki_updated[14], aki_map_df@data[,get_tag_aki_updated()[14]],
                input$aki_updated[15], aki_map_df@data[,get_tag_aki_updated()[15]],
                input$aki_updated[16], aki_map_df@data[,get_tag_aki_updated()[16]]
                
            ) %>% 
                lapply(htmltools::HTML)
        } else if (length(input$aki_updated)==17) {
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
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
                aki_map_df@data$NAME_EN, 
                round(aki_map_df@data$AKI, digits = 1),
                input$aki_updated[1],  aki_map_df@data[,get_tag_aki_updated()[1]],
                input$aki_updated[2],  aki_map_df@data[,get_tag_aki_updated()[2]],
                input$aki_updated[3],  aki_map_df@data[,get_tag_aki_updated()[3]],
                input$aki_updated[4],  aki_map_df@data[,get_tag_aki_updated()[4]],
                input$aki_updated[5],  aki_map_df@data[,get_tag_aki_updated()[5]],
                input$aki_updated[6],  aki_map_df@data[,get_tag_aki_updated()[6]],
                input$aki_updated[7],  aki_map_df@data[,get_tag_aki_updated()[7]],
                input$aki_updated[8],  aki_map_df@data[,get_tag_aki_updated()[8]],
                input$aki_updated[9],  aki_map_df@data[,get_tag_aki_updated()[9]],
                input$aki_updated[10], aki_map_df@data[,get_tag_aki_updated()[10]],
                input$aki_updated[11], aki_map_df@data[,get_tag_aki_updated()[11]],
                input$aki_updated[12], aki_map_df@data[,get_tag_aki_updated()[12]],
                input$aki_updated[13], aki_map_df@data[,get_tag_aki_updated()[13]],
                input$aki_updated[14], aki_map_df@data[,get_tag_aki_updated()[14]],
                input$aki_updated[15], aki_map_df@data[,get_tag_aki_updated()[15]],
                input$aki_updated[16], aki_map_df@data[,get_tag_aki_updated()[16]],
                input$aki_updated[17], aki_map_df@data[,get_tag_aki_updated()[17]]
                
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
    
    
    ###########
    # SPI AKI Summary Stats
    ###########
    
    output$summary_stats_updated <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
        my_skim<-    skim_with( numeric = sfl( mean = ~ mean(.,   na.rm=TRUE),
                                               sd = ~ sqrt(var(.,   na.rm=TRUE)),
                                               p25 = ~ (quantile(., probs=c(0.25),   na.rm=TRUE)),
                                               p50 = ~ (quantile(., probs=c(0.5),  na.rm=TRUE)),
                                               p75 = ~ (quantile(., probs=c(0.75),  na.rm=TRUE)),
                                               complete = ~ sum(!is.na(.)))) 
        sumstats <- df_aki_updated() %>%
            select(get_tag_aki_updated()) 
        
        #produce summary stats
        sumstats_df<-my_skim(sumstats) %>%
            yank("numeric") %>%
            mutate(id=skim_variable) %>%
            select(id, mean, sd, p0, p25, p50, p75, p100, complete,  hist) 
        
        #create labels df
        get_tag_aki_labs<-wdisJSON %>%
            filter(name %in% input$aki_updated) %>%
            arrange(factor(name, levels = input$aki_updated)) %>%
            select(id, name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(get_tag_aki_labs) %>%
            select(id, name,  mean, sd, p0, p25, p50, p75, p100, complete, hist)
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
            style = 'caption-side: bottom; text-align: left;',
            htmltools::em("Indicator values are converted to 0 or 1 based on whether they are available in the three year time window."))    ,
            colnames=c("Indicator", "Label", "Mean", "Std Dev","Min", "25th Percentile", "Median", "75th Percentile", "Max", "# Complete Cases",  "Histogram"),
            extensions = 'Buttons', options=list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                pageLength = 60)) %>%
            formatRound(columns = c('mean', 'sd', 'p0', 
                                    'p25', 'p50', 'p75', 'p100'),
                        digits=2)
        
        
        
    })
    
    #######################
    # Correlation between AKI indicators
    ######################
    
    
    corrp_updated <- reactive({
        
        
        corr_df <- df_aki_updated()
        corr_names<-get_tag_aki_updated()
        names(corr_names) = input$aki_updated
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between AKI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 20)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to 0 or 1 based on whether they are available in the three year time window." 
            )
        
        pcorr
        
    })
    
    
    
    
    
    
    output$corrplot_updated <- renderPlot({
        
        corrp_updated()
        
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
