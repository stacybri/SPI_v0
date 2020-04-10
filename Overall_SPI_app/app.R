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



#read in TopoJSON from World Bank
countries <- geojsonio::geojson_read("WB_countries_Admin0_lowres.geojson",
                                     what = "sp")



# Define UI for application that draws a histogram
ui <- navbarPage("Statistical Performance Index", id="nav",
                 
                 tabPanel("Dimension 1: Dimension 1: Methodology, Standards & Classifications (MSC) Map & Summary Statistics",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("akimap"
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
                 tabPanel("Dimension 2: Censuses and Surveys (CS) Map & Summary Statistics",
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
                 tabPanel("Dimension 3: Availability of Key Indicators (AKI) Map & Summary Statistics",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("akimap"
                                                        , width = "100%", height = "900px")),
                              
                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("indicators_choices")),
                              h3('Summary Statistics of AKI Indicators'),
                              withSpinner(DT::dataTableOutput("akisummary_stats")),
                              h3('Correlations of AKI Indicators'),
                              withSpinner(plotOutput('akicorrplot', width = "100%", height = "900px")),
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
                 tabPanel("Dimension 4: Availability of Key Indicators (AKI) Map & Summary Statistics",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("akimap"
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
    
    
    
    output$akimap <- renderLeaflet({
        
        
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
    
    ####
    # SPI AKI Summary Stats
    ###
    
    output$akisummary_stats <- DT::renderDataTable({
        
        
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
    
    ###
    # Correlation between AKI indicators
    ###
    
    
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
    
    
    
    
    
    
    output$akicorrplot <- renderPlot({
        
        corrp()
        
    })
    
    
    
    
    
    
    
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
