#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
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
library(Hmisc)
library(plotly)
#read in underlying data
load('SPI_simple.Rdata')

#label columns
var.labels=c(
    SPI.OVRL.SCR='SPI Overall Score',
    SPI.D1.MSC='Dimension 1: Methodology, Standards & Classifications (MSC)', 
    SPI.D1.1.SNAU='System of National Accounts in use', 
    SPI.D1.2.NABY='National Accounts base year ', 
    SPI.D1.3.CNIN='Classification of national industry', 
    SPI.D1.4.CPIBY='CPI base year', 
    SPI.D1.5.HOUS='Classification of household consumption', 
    SPI.D1.6.EMPL='Classification of status of employment', 
    SPI.D1.7.CGOV='Central government accounting status', 
    SPI.D1.8.FINA='Compilation of government finance statistics', 
    SPI.D1.9.MONY='Compilation of monetary and financial statistics', 
    SPI.D1.10.IDDS='SDDS/e-GDDS subscription', 
    SPI.D1.11.CRVS='CRVS', 
    SPI.D1.12.GSBP='Business process', 
    SPI.D2.CS='Dimension 2: Censuses and Surveys (CS)', 
    SPI.D2.1.POPU='Population & Housing census', 
    SPI.D2.2.AGRI='Agriculture census', 
    SPI.D2.3.BIZZ='Business/establishment census', 
    SPI.D2.4.HOUS='Household Survey on income/consumption/expenditure/budget/Integrated Survey ', 
    SPI.D2.5.AGRI='Agriculture survey', 
    SPI.D2.6.LABR='Labor Force Survey', 
    SPI.D2.7.HLTH='Health/Demographic survey', 
    SPI.D2.8.BIZZ='Business/establishment survey', 
    SPI.D3.AKI='Dimension 3: Availability of Key Indicators (AKI)', 
    SPI.D3.SI.POV.DDAY='Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)',
    SPI.D3.SH.STA.STNT.ZS='Prevalence of stunting, height for age (% of children under 5)',
    SPI.D3.SH.DYN.MORT='Mortality rate, under-5 (per 1,000 live births)', 
    SPI.D3.SE.LPV.PRIM.BMP='Pupils below minimum reading proficiency at end of primary (%). Low GAML threshold',
    SPI.D3.SH.H2O.SMDW.ZS='People using safely managed drinking water services (% of population)',
    SPI.D3.EG.ELC.ACCS.ZS='Access to electricity (% of population)',
    SPI.D3.SL.UEM.TOTL.NE.ZS='Unemployment, total (% of total labor force) (national estimate)' ,
    SPI.D3.NV.IND.MANF.ZS='Manufacturing, value added (% of GDP)',
    SPI.D3.SI.SPR.PC40.ZG='Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%)',
    SPI.D3.ER.H2O.FWST.ZS='Level of water stress: freshwater withdrawal as a proportion of available freshwater resources',
    SPI.D3.EG.FEC.RNEW.ZS='Renewable energy consumption (% of total final energy consumption)',
    SPI.D3.EN.ATM.GHGT.KT.CE='Total greenhouse gas emissions (kt of CO2 equivalent)',
    SPI.D3.ER.PTD.TOTL.ZS='Terrestrial and marine protected areas (% of total territorial area)',
    SPI.D3.NE.CON.PRVT.CN='Households and NPISHs Final consumption expenditure (current LCU)',
    SPI.D3.NY.GNP.MKTP.CN='GNI (current LCU)',
    SPI.D3.DT.TDS.DPPF.XP.ZS='Debt service (PPG and IMF only, % of exports of goods, services and primary income)', 
    SPI.D4.DPO='Dimension 4: Dissemination Practices & Openness (DPO)', 
    SPI.D4.1.CALD='NSO has an Advance Release Calendar and it is published ', 
    SPI.D4.2.NADA='NSO has a listing of surveys and microdata sets (or NADA)', 
    SPI.D4.3.PORT='NSO has a data portal', 
    SPI.D4.4.TIME='Timeseries indicators are available for download in reusable format for free', 
    SPI.D4.5.META='Metadata is available providing definition, methodology, standards or classifications for existing data series', 
    SPI.D4.6.USER='NSO has conducted a user satisfaction survey', 
    SPI.D4.7.GEOS='Geospatial data available on relevant agency website'
    )

#read in TopoJSON from World Bank
countries <- geojsonio::geojson_read("WB_countries_Admin0_lowres.geojson",
                                     what = "sp")

#country info
country_info <- wbcountries() %>%
    select(iso3c, region, income, lending)

# Define UI for application that draws a histogram
ui <- navbarPage("Statistical Performance Index", id="nav",
                 #####################################################
                 # Welcome Section
                 ####################################################
                 tabPanel("Welcome",
                          fluidPage(theme = shinytheme("cerulean"),
                                    includeMarkdown("header.md")
                                    #h3('Indicator Metadata'),
                                    #withSpinner(DT::dataTableOutput("metadata_all"))
                          )
                 ),
                 #####################################################
                 # Data Analysis Section
                 ####################################################
                 tabPanel("Overall SPI",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("spi_map_overall"
                                                        , width = "100%", height = "900px")),
                              
                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("metadata_overall")),
                              h3('Summary Statistics of Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats_overall")),
                              h3('Indicators Over Time'),
                              selectizeInput("over_time",
                                             "Choose Indicator to Plot Over Time",
                                             choices=as.character(var.labels),
                                             selected='SPI Overall Score'
                              ),
                              withSpinner(plotlyOutput('plot_time',
                                                       width = '70%')),
                              
                              h3('Correlations of Indicators'),
                              withSpinner(plotOutput('corrplot_overall', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls_overall", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 150, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                            
                                            h2("Indicator Year"),
                                            selectizeInput("year_overall",
                                                           "Reference Year",
                                                           choices=c(2016:2018),
                                                           selected=2018
                                            )
                              )
                              
                          )
                 ),
                 tabPanel("Dimension 1: Methodology, Standards & Classifications (MSC)",
                          div(class="outer",
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("spi_map_d1"
                                                        , width = "100%", height = "900px")),
                              
                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("metadata_d1")),
                              h3('Summary Statistics of Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats_d1")),
                              h3('Correlations of Indicators'),
                              withSpinner(plotOutput('corrplot_d1', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls_d1", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 150, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",
                                           
                                           h2("Indicator Year"),
                                           selectizeInput("year_d1",
                                                       "Reference Year",
                                                       choices=c(2016:2018),
                                                       selected=2018
                                           )
                              )

                          )
                 ),
                 tabPanel("Dimension 2: Censuses and Surveys (CS)",
                          div(class="outer",


                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("spi_map_d2"
                                                        , width = "100%", height = "900px")),

                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("metadata_d2")),
                              h3('Summary Statistics of Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats_d2")),
                              h3('Correlations of Indicators'),
                              withSpinner(plotOutput('corrplot_d2', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls_d2", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 150, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",

                                            h2("Indicator Year"),
                                            selectizeInput("year_d2",
                                                           "Reference Year",
                                                           choices=c(2016:2018),
                                                           selected=2018
                                            )
                              )


                          )
                 ),
                 tabPanel("Dimension 3: Availability of Key Indicators (AKI)",
                          div(class="outer",

                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("spi_map_d3"
                                                        , width = "100%", height = "900px")),

                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("metadata_d3")),
                              h3('Summary Statistics of Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats_d3")),
                              h3('Correlations of Indicators'),
                              withSpinner(plotOutput('corrplot_d3', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls_d3", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 150, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",

                                            h2("Indicator Year"),
                                            selectizeInput("year_d3",
                                                           "Reference Year",
                                                           choices=c(2016:2018),
                                                           selected=2018
                                            )
                              )

                          )
                 ),
                 tabPanel("Dimension 4: Dissemination Practices & Openness (DPO)",
                          div(class="outer",

                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              withSpinner(leafletOutput("spi_map_d4"
                                                        , width = "100%", height = "900px")),

                              h3('Indicator Metadata'),
                              withSpinner(DT::dataTableOutput("metadata_d4")),
                              h3('Summary Statistics of Indicators'),
                              withSpinner(DT::dataTableOutput("summary_stats_d4")),
                              h3('Correlations of Indicators'),
                              withSpinner(plotOutput('corrplot_d4', width = "100%", height = "900px")),
                              # Shiny versions prior to 0.11 should use class = "modal" instead.
                              absolutePanel(id = "controls_d3", class = "panel panel-default", fixed = FALSE,
                                            draggable = FALSE, top = 150, left = "auto", right = 20, bottom = "auto",
                                            width = 330, height = "auto",

                                            h2("Indicator Year"),
                                            selectizeInput("year_d4",
                                                           "Reference Year",
                                                           choices=c(2016:2018),
                                                           selected=2018
                                            )
                              )

                          )
                 )
                 
                 
                 
                 
                 
                              
                          
                 )
    

    

    
    

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    
    #######################
    # SPI Map
    #######################
    
    ###################
    # Background
    ##################
    
    # output$metadata_all <- DT::renderDataTable({
    #     
    #     metadata_a <- metadata %>%
    #         arrange(factor(Series, levels=names(var.labels)))
    #     
    #     DT::datatable(metadata_a, caption="Table of SPI Indicator Metadata",
    #                   rownames=FALSE,
    #                   colnames = c("Indicator ID", "Indicator Name", "Source", "Source Organization", "Source Note"),
    #                   class='cell-border stripe',
    #                   escape = FALSE,
    #                   extensions = c ('Buttons', 'FixedHeader'), options=list(
    #                       dom = 'Bfrtip',
    #                       buttons = c('copy', 'csv', 'excel'),
    #                       pageLength = 60,
    #                       scrollX = TRUE, 
    #                       paging=FALSE,
    #                       ordering=F)) 
    #     
    # })
    
    
    #################################################
    # Overall SPI
    #################################################
    
    ###########
    # SPI Metadata Datatable
    ###########
    
    output$metadata_overall <- DT::renderDataTable({
        
        metadata_tab_overall <- metadata %>%
            filter(Series %in% c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO'))
        
        DT::datatable(metadata_tab_overall, caption="Table of Chosen SPI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source", "Source Organization", "Source Note"),
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
    
    ############
    # Plot Over Time
    ############
    
    time_var <- reactive({
        
        names(var.labels[match(input$over_time, var.labels)])
        
    })
    
    df_time <- reactive({
        
        #produce by region
        time_df<- SPI %>%
            select(iso3c, country, date, time_var() ) %>%
            rename(y=time_var()) %>%
            left_join(country_info) %>%
            group_by(date, region) %>%
            summarise(y=100*mean(y, na.rm=T))  %>%
            ungroup()  
        

        #produce global number
        time_df_gl<- SPI %>%
            select(iso3c, country, date, time_var() ) %>%
            rename(y=time_var()) %>%
            mutate(region='Global') %>%
            group_by(date, region) %>%
            summarise(y=100*mean(y, na.rm=T)) %>%
            ungroup()
    
        #join
        time_df <- time_df %>%
            bind_rows(time_df_gl) 
        
        if (time_var() %in% c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')) {
            #fix an issue where main variables need to be rescaled
            time_df <- time_df %>%
                mutate(y=y/100)
        }
            
        time_df 
        
    
    })
    
    output$plot_time <- renderPlotly({
        
       plot_ly(data = df_time(), x = ~date, y = ~y, 
               color=~region, 
               labels=time_var(),
               type = 'scatter', mode = 'lines+markers') %>%
            layout(title = paste('Plot of SPI Indicators Over Time by Region: ',input$over_time, sep=""),
                   xaxis = list(autotick = F, dtick = 1),
                   yaxis = list(range = c(0,100)))
        

    })
    
    ###########
    # Now pull data using IDs for WDI and calculate AKI
    ###########
    
    # Availability of Key Indicator Country Score equals Weighted Score divided by Maximum Category Score time 100
    
    df_overall<- reactive({
        SPI %>%
            select(iso3c, country, date, c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')) %>%
            filter(date==input$year_overall) %>%
            mutate(ISO_A3_EH=iso3c) 
        
        
    })
    
    
    
    output$spi_map_overall <- renderLeaflet({
        
        
        spi_map_overall<-countries
        
        spi_map_overall@data <- spi_map_overall@data %>%
            left_join(df_overall()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", spi_map_overall@data$SPI.OVRL.SCR, 10, pretty = T)
        
        
        
        ##############
        #create labels
        ##############
        
        
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
            spi_map_overall@data$NAME_EN, 
            label(spi_map_overall@data$SPI.OVRL.SCR), round(spi_map_overall@data$SPI.OVRL.SCR, digits = 1),
            label(spi_map_overall@data$SPI.D1.MSC), round(spi_map_overall@data$SPI.D1.MSC, digits = 1),
            label(spi_map_overall@data$SPI.D2.CS), round(spi_map_overall@data$SPI.D2.CS, digits = 1),
            label(spi_map_overall@data$SPI.D3.AKI), round(spi_map_overall@data$SPI.D3.AKI, digits = 1),
            label(spi_map_overall@data$SPI.D4.DPO), round(spi_map_overall@data$SPI.D4.DPO, digits = 1)
            
        ) %>% 
            lapply(htmltools::HTML)
        

        
        
        leaflet(spi_map_overall) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(SPI.OVRL.SCR),
                        label=labels) %>%
            addLegend(pal=pal, values=~SPI.OVRL.SCR, opacity=0.7, title='SPI value', position="bottomleft")        
    })
    
    ####
    # SPI AKI Summary Stats
    ###
    
    output$summary_stats_overall <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
        
        
        #produce by region
        sumstats<- df_overall() %>%
            left_join(country_info) %>%
            group_by(region) %>%
            select(region, c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')) %>%
            summarise_all(~round(mean(., na.rm=T),2)) 
        
        #produce global number
        sumstats_gl<- df_overall() %>%
            mutate(region='Global') %>%
            group_by(region) %>%
            select(region, c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')) %>%
            summarise_all(~round(mean(., na.rm=T),2)) 
        
        
        #transpose data
        sumstats_df_long <-sumstats_gl %>%
            bind_rows(sumstats) 
        
        sumstats_df <- as.data.frame(t(sumstats_df_long %>% select(-region)))
        colnames(sumstats_df) = sumstats_df_long$region 
        
        
        sumstats_df <- sumstats_df %>%
            rownames_to_column() %>%
            rename(series=rowname)
        
        
        #create labels df
        metadata_tab2_overall <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')) %>%
            select(series, indicator_name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(metadata_tab2_overall) %>%
            rename(Series=series,
                   Label=indicator_name) %>%
            select(Series, Label, everything())
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
            style = 'caption-side: top; text-align: left;',
            htmltools::em("Mean of SPI Indicators by Region.  Sub-indicators scaled to be 0-100."))    ,
            extensions = 'Buttons', options=list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                pageLength = 60)) 
        
        
        
    })
    
    ###
    # Correlation between AKI indicators
    ###
    
    
    corrp_overall <- reactive({
        
        metadata_tab3_overall <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')) %>%
            select(series, indicator_name)
        
        corr_df <- df_overall()
        corr_names<-metadata_tab3_overall$series
        names(corr_names) = metadata_tab3_overall$indicator_name
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between SPI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 16)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to be between 0 and 1 based on whether they meet SPI scoring criteria." 
            )
        
        pcorr
        
    })
    
    
    
    
    
    
    output$corrplot_overall <- renderPlot({
        
        corrp_overall()
        
    })
    
    
    
    
        
 #################################################
    # Dimension 1
 #################################################
   
    ###########
    # SPI Metadata Datatable
    ###########
    
    output$metadata_d1 <- DT::renderDataTable({
        
        metadata_tab_d1 <- metadata %>%
            filter(Series %in% grep("^SPI.D1.", metadata$Series, value = TRUE))
        
        DT::datatable(metadata_tab_d1, caption="Table of Chosen SPI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source", "Source Organization", "Source Note"),
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
    
    df_d1<- reactive({
        SPI %>%
            select(iso3c, country, date, starts_with("SPI.D1")) %>%
            filter(date==input$year_d1) %>%
            mutate(ISO_A3_EH=iso3c) 
        
        
    })
    
    
    
    output$spi_map_d1 <- renderLeaflet({
        
        
        spi_map_d1<-countries
        
        spi_map_d1@data <- spi_map_d1@data %>%
            left_join(df_d1()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", spi_map_d1@data$SPI.D1.MSC, 10, pretty = T)
        
        
        
        ##############
        #create labels
        ##############
        
        
            labels <- sprintf(
                "<strong>%s</strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/> <hr size=2>
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
                spi_map_d1@data$NAME_EN, 
                label(spi_map_d1@data$SPI.D1.MSC), round(spi_map_d1@data$SPI.D1.MSC, digits = 1),
                label(spi_map_d1@data$SPI.D1.1.SNAU), round(spi_map_d1@data$SPI.D1.1.SNAU, digits = 1),
                label(spi_map_d1@data$SPI.D1.2.NABY), round(spi_map_d1@data$SPI.D1.2.NABY, digits = 1),
                label(spi_map_d1@data$SPI.D1.3.CNIN), round(spi_map_d1@data$SPI.D1.3.CNIN, digits = 1),
                label(spi_map_d1@data$SPI.D1.4.CPIBY), round(spi_map_d1@data$SPI.D1.4.CPIBY, digits = 1),
                label(spi_map_d1@data$SPI.D1.5.HOUS), round(spi_map_d1@data$SPI.D1.5.HOUS, digits = 1),
                label(spi_map_d1@data$SPI.D1.6.EMPL), round(spi_map_d1@data$SPI.D1.6.EMPL, digits = 1),
                label(spi_map_d1@data$SPI.D1.7.CGOV), round(spi_map_d1@data$SPI.D1.7.CGOV, digits = 1),
                label(spi_map_d1@data$SPI.D1.8.FINA), round(spi_map_d1@data$SPI.D1.8.FINA, digits = 1),
                label(spi_map_d1@data$SPI.D1.9.MONY), round(spi_map_d1@data$SPI.D1.9.MONY, digits = 1),
                label(spi_map_d1@data$SPI.D1.10.IDDS), round(spi_map_d1@data$SPI.D1.10.IDDS, digits = 1),
                label(spi_map_d1@data$SPI.D1.11.CRVS), round(spi_map_d1@data$SPI.D1.11.CRVS, digits = 1),
                label(spi_map_d1@data$SPI.D1.12.GSBP), round(spi_map_d1@data$SPI.D1.12.GSBP, digits = 1)
            ) %>% 
                lapply(htmltools::HTML)
        
        
        
        
        leaflet(spi_map_d1) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(SPI.D1.MSC),
                        label=labels) %>%
            addLegend(pal=pal, values=~SPI.D1.MSC, opacity=0.7, title='SPI value', position="bottomleft")        
    })
    
    ####
    # SPI AKI Summary Stats
    ###
    
    output$summary_stats_d1 <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
       

            #produce by region
            sumstats<- df_d1() %>%
                left_join(country_info) %>%
                group_by(region) %>%
                select(region, starts_with('SPI.D1.')) %>%
                summarise_all(~round(100*mean(., na.rm=T),2)) %>%
                mutate(SPI.D1.MSC=round(SPI.D1.MSC/100,2))
            
            #produce global number
            sumstats_gl<- df_d1() %>%
                mutate(region='Global') %>%
                group_by(region) %>%
                select(region, starts_with('SPI.D1.')) %>%
                summarise_all(~round(100*mean(., na.rm=T),2)) %>%
                mutate(SPI.D1.MSC=round(SPI.D1.MSC/100,2))
            
            
            #transpose data
            sumstats_df_long <-sumstats_gl %>%
                bind_rows(sumstats) 
            
            sumstats_df <- as.data.frame(t(sumstats_df_long %>% select(-region)))
            colnames(sumstats_df) = sumstats_df_long$region 
            
            
            sumstats_df <- sumstats_df %>%
                rownames_to_column() %>%
                rename(series=rowname)
        
        
        #create labels df
        metadata_tab2_d1 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D1.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(metadata_tab2_d1) %>%
            rename(Series=series,
                   Label=indicator_name) %>%
            select(Series, Label, everything())
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
                                            style = 'caption-side: top; text-align: left;',
                                            htmltools::em("Mean of SPI Indicators by Region.  Sub-indicators scaled to be 0-100."))    ,
                                            extensions = 'Buttons', options=list(
                          dom = 'Bfrtip',
                          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                          pageLength = 60)) 
        
        
    
    })
    
    ###
    # Correlation between AKI indicators
    ###
    
    
    corrp_d1 <- reactive({
        
        metadata_tab3_d1 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D1.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        corr_df <- df_d1()
        corr_names<-metadata_tab3_d1$series
        names(corr_names) = metadata_tab3_d1$indicator_name
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between SPI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 16)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to be between 0 and 1 based on whether they meet SPI scoring criteria." 
            )
        
        pcorr
        
    })
    
    
    
    
    
    
    output$corrplot_d1 <- renderPlot({
        
        corrp_d1()
        
    })
    
    
    #################################################
    # Dimension 2
    #################################################
    
    ###########
    # SPI Metadata Datatable
    ###########
    
    output$metadata_d2 <- DT::renderDataTable({
        
        metadata_tab_d2 <- metadata %>%
            filter(Series %in% grep("^SPI.D2.", metadata$Series, value = TRUE))
        
        DT::datatable(metadata_tab_d2, caption="Table of Chosen SPI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source", "Source Organization", "Source Note"),
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
    
    df_d2<- reactive({
        SPI %>%
            select(iso3c, country, date, starts_with("SPI.D2")) %>%
            filter(date==input$year_d2) %>%
            mutate(ISO_A3_EH=iso3c) 
        
        
    })
    
    
    
    output$spi_map_d2 <- renderLeaflet({
        
        
        spi_map_d2<-countries
        
        spi_map_d2@data <- spi_map_d2@data %>%
            left_join(df_d2()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", spi_map_d2@data$SPI.D2.CS, 10, pretty = T)
        
        
        
        ##############
        #create labels
        ##############
        
        
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
            spi_map_d2@data$NAME_EN, 
            label(spi_map_d2@data$SPI.D2.CS), round(spi_map_d2@data$SPI.D2.CS, digits = 1),
            label(spi_map_d2@data$SPI.D2.1.POPU), round(spi_map_d2@data$SPI.D2.1.POPU, digits = 1),
            label(spi_map_d2@data$SPI.D2.2.AGRI), round(spi_map_d2@data$SPI.D2.2.AGRI, digits = 1),
            label(spi_map_d2@data$SPI.D2.3.BIZZ), round(spi_map_d2@data$SPI.D2.3.BIZZ, digits = 1),
            label(spi_map_d2@data$SPI.D2.4.HOUS), round(spi_map_d2@data$SPI.D2.4.HOUS, digits = 1),
            label(spi_map_d2@data$SPI.D2.5.AGRI), round(spi_map_d2@data$SPI.D2.5.AGRI, digits = 1),
            label(spi_map_d2@data$SPI.D2.6.LABR), round(spi_map_d2@data$SPI.D2.6.LABR, digits = 1),
            label(spi_map_d2@data$SPI.D2.7.HLTH), round(spi_map_d2@data$SPI.D2.7.HLTH, digits = 1),
            label(spi_map_d2@data$SPI.D2.8.BIZZ), round(spi_map_d2@data$SPI.D2.8.BIZZ, digits = 1)

        ) %>% 
            lapply(htmltools::HTML)
        
        
        
        
        leaflet(spi_map_d2) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(SPI.D2.CS),
                        label=labels) %>%
            addLegend(pal=pal, values=~SPI.D2.CS, opacity=0.7, title='SPI value', position="bottomleft")        
    })
    
    ####
    # SPI AKI Summary Stats
    ###
    
    output$summary_stats_d2 <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
        
        
        #produce by region
        sumstats<- df_d2() %>%
            left_join(country_info) %>%
            group_by(region) %>%
            select(region, starts_with('SPI.D2.')) %>%
            summarise_all(~round(100*mean(., na.rm=T),2)) %>%
            mutate(SPI.D2.CS=round(SPI.D2.CS/100,2))
        
        #produce global number
        sumstats_gl<- df_d2() %>%
            mutate(region='Global') %>%
            group_by(region) %>%
            select(region, starts_with('SPI.D2.')) %>%
            summarise_all(~round(100*mean(., na.rm=T),2)) %>%
            mutate(SPI.D2.CS=round(SPI.D2.CS/100,2))
        
        
        #transpose data
        sumstats_df_long <-sumstats_gl %>%
            bind_rows(sumstats) 
        
        sumstats_df <- as.data.frame(t(sumstats_df_long %>% select(-region)))
        colnames(sumstats_df) = sumstats_df_long$region 
        
        
        sumstats_df <- sumstats_df %>%
            rownames_to_column() %>%
            rename(series=rowname)
        
        
        #create labels df
        metadata_tab2_d2 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D2.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(metadata_tab2_d2) %>%
            rename(Series=series,
                   Label=indicator_name) %>%
            select(Series, Label, everything())
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
            style = 'caption-side: top; text-align: left;',
            htmltools::em("Mean of SPI Indicators by Region.  Sub-indicators scaled to be 0-100."))    ,
            extensions = 'Buttons', options=list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                pageLength = 60)) 
        
        
        
    })
    
    ###
    # Correlation between AKI indicators
    ###
    
    
    corrp_d2 <- reactive({
        
        metadata_tab3_d2 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D2.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        corr_df <- df_d2()
        corr_names<-metadata_tab3_d2$series
        names(corr_names) = metadata_tab3_d2$indicator_name
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between SPI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 16)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to be between 0 and 1 based on whether they meet SPI scoring criteria." 
            )
        
        pcorr
        
    })
    
    
    
    
    
    
    output$corrplot_d2 <- renderPlot({
        
        corrp_d2()
        
    })
    
    #################################################
    # Dimension 3
    #################################################
    
    ###########
    # SPI Metadata Datatable
    ###########
    
    output$metadata_d3 <- DT::renderDataTable({
        
        metadata_tab_d3 <- metadata %>%
            filter(Series %in% grep("^SPI.D3.", metadata$Series, value = TRUE))
        
        DT::datatable(metadata_tab_d3, caption="Table of Chosen SPI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source", "Source Organization", "Source Note"),
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
    
    df_d3<- reactive({
        SPI %>%
            select(iso3c, country, date, starts_with("SPI.D3")) %>%
            filter(date==input$year_d3) %>%
            mutate(ISO_A3_EH=iso3c) 
        
        
    })
    
    
    
    output$spi_map_d3 <- renderLeaflet({
        
        
        spi_map_d3<-countries
        
        spi_map_d3@data <- spi_map_d3@data %>%
            left_join(df_d3()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", spi_map_d3@data$SPI.D3.AKI, 10, pretty = T)
        
        
        
        ##############
        #create labels
        ##############
        
        
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/> <hr size=2>
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
            spi_map_d3@data$NAME_EN, 
            label(spi_map_d3@data$SPI.D3.AKI), round(spi_map_d3@data$SPI.D3.AKI, digits = 1),
            label(spi_map_d3@data$SPI.D3.SI.POV.DDAY), round(spi_map_d3@data$SPI.D3.SI.POV.DDAY, digits = 1),
            label(spi_map_d3@data$SPI.D3.SH.STA.STNT.ZS), round(spi_map_d3@data$SPI.D3.SH.STA.STNT.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.SH.DYN.MORT), round(spi_map_d3@data$SPI.D3.SH.DYN.MORT, digits = 1),
            label(spi_map_d3@data$SPI.D3.SE.LPV.PRIM.BMP), round(spi_map_d3@data$SPI.D3.SE.LPV.PRIM.BMP, digits = 1),
            label(spi_map_d3@data$SPI.D3.SH.H2O.SMDW.ZS), round(spi_map_d3@data$SPI.D3.SH.H2O.SMDW.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.EG.ELC.ACCS.ZS), round(spi_map_d3@data$SPI.D3.EG.ELC.ACCS.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.SL.UEM.TOTL.NE.ZS), round(spi_map_d3@data$SPI.D3.SL.UEM.TOTL.NE.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.NV.IND.MANF.ZS), round(spi_map_d3@data$SPI.D3.NV.IND.MANF.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.SI.SPR.PC40.ZG), round(spi_map_d3@data$SPI.D3.SI.SPR.PC40.ZG, digits = 1),
            label(spi_map_d3@data$SPI.D3.ER.H2O.FWST.ZS), round(spi_map_d3@data$SPI.D3.ER.H2O.FWST.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.EG.FEC.RNEW.ZS), round(spi_map_d3@data$SPI.D3.EG.FEC.RNEW.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.EN.ATM.GHGT.KT.CE), round(spi_map_d3@data$SPI.D3.EN.ATM.GHGT.KT.CE, digits = 1),
            label(spi_map_d3@data$SPI.D3.ER.PTD.TOTL.ZS), round(spi_map_d3@data$SPI.D3.ER.PTD.TOTL.ZS, digits = 1),
            label(spi_map_d3@data$SPI.D3.NE.CON.PRVT.CN), round(spi_map_d3@data$SPI.D3.NE.CON.PRVT.CN, digits = 1),
            label(spi_map_d3@data$SPI.D3.NY.GNP.MKTP.CN), round(spi_map_d3@data$SPI.D3.NY.GNP.MKTP.CN, digits = 1)
            
        ) %>% 
            lapply(htmltools::HTML)
        
        
        
        
        leaflet(spi_map_d3) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(SPI.D3.AKI),
                        label=labels) %>%
            addLegend(pal=pal, values=~SPI.D3.AKI, opacity=0.7, title='SPI value', position="bottomleft")        
    })
    
    ####
    # SPI AKI Summary Stats
    ###
    
    output$summary_stats_d3 <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
        
        
        #produce by region
        sumstats<- df_d3() %>%
            left_join(country_info) %>%
            group_by(region) %>%
            select(region, starts_with('SPI.D3.')) %>%
            summarise_all(~round(100*mean(., na.rm=T),2)) %>%
            mutate(SPI.D3.AKI=round(SPI.D3.AKI/100,2))
        
        #produce global number
        sumstats_gl<- df_d3() %>%
            mutate(region='Global') %>%
            group_by(region) %>%
            select(region, starts_with('SPI.D3.')) %>%
            summarise_all(~round(100*mean(., na.rm=T),2)) %>%
            mutate(SPI.D3.AKI=round(SPI.D3.AKI/100,2))
        
        
        #transpose data
        sumstats_df_long <-sumstats_gl %>%
            bind_rows(sumstats) 
        
        sumstats_df <- as.data.frame(t(sumstats_df_long %>% select(-region)))
        colnames(sumstats_df) = sumstats_df_long$region 
        
        
        sumstats_df <- sumstats_df %>%
            rownames_to_column() %>%
            rename(series=rowname)
        
        
        #create labels df
        metadata_tab2_d3 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D3.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(metadata_tab2_d3) %>%
            rename(Series=series,
                   Label=indicator_name) %>%
            select(Series, Label, everything())
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
            style = 'caption-side: top; text-align: left;',
            htmltools::em("Mean of SPI Indicators by Region.  Sub-indicators scaled to be 0-100."))    ,
            extensions = 'Buttons', options=list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                pageLength = 60)) 
        
        
        
    })
    
    ###
    # Correlation between AKI indicators
    ###
    
    
    corrp_d3 <- reactive({
        
        metadata_tab3_d3 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D3.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        corr_df <- df_d3()
        corr_names<-metadata_tab3_d3$series
        names(corr_names) = metadata_tab3_d3$indicator_name
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between SPI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 16)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to be between 0 and 1 based on whether they meet SPI scoring criteria." 
            )
        
        pcorr
        
    })
    
    output$corrplot_d3 <- renderPlot({
        
        corrp_d3()
        
    })  
    #################################################
    # Dimension 4
    #################################################
    
    ###########
    # SPI Metadata Datatable
    ###########
    
    output$metadata_d4 <- DT::renderDataTable({
        
        metadata_tab_d4 <- metadata %>%
            filter(Series %in% grep("^SPI.D4.", metadata$Series, value = TRUE))
        
        DT::datatable(metadata_tab_d4, caption="Table of Chosen SPI Indicator Metadata",
                      rownames=FALSE,
                      colnames = c("Indicator ID", "Indicator Name", "Source", "Source Organization", "Source Note"),
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
    
    df_d4<- reactive({
        SPI %>%
            select(iso3c, country, date, starts_with("SPI.D4")) %>%
            filter(date==input$year_d4) %>%
            mutate(ISO_A3_EH=iso3c) 
        
        
    })
    
    
    
    output$spi_map_d4 <- renderLeaflet({
        
        
        spi_map_d4<-countries
        
        spi_map_d4@data <- spi_map_d4@data %>%
            left_join(df_d4()) 
        
        
        
        
        #create pallete
        pal <- colorBin("RdYlBu", spi_map_d4@data$SPI.D4.DPO, 10, pretty = T)
        
        
        
        ##############
        #create labels
        ##############
        
        
        labels <- sprintf(
            "<strong>%s</strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/> <hr size=2>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            <strong> %s: %g </strong><br/>
            ",
            spi_map_d4@data$NAME_EN, 
            label(spi_map_d4@data$SPI.D4.DPO), round(spi_map_d4@data$SPI.D4.DPO, digits = 1),
            label(spi_map_d4@data$SPI.D4.1.CALD), round(spi_map_d4@data$SPI.D4.1.CALD, digits = 1),
            label(spi_map_d4@data$SPI.D4.2.NADA), round(spi_map_d4@data$SPI.D4.2.NADA, digits = 1),
            label(spi_map_d4@data$SPI.D4.3.PORT), round(spi_map_d4@data$SPI.D4.3.PORT, digits = 1),
            label(spi_map_d4@data$SPI.D4.4.TIME), round(spi_map_d4@data$SPI.D4.4.TIME, digits = 1),
            label(spi_map_d4@data$SPI.D4.5.META), round(spi_map_d4@data$SPI.D4.5.META, digits = 1),
            label(spi_map_d4@data$SPI.D4.6.USER), round(spi_map_d4@data$SPI.D4.6.USER, digits = 1),
            label(spi_map_d4@data$SPI.D4.7.GEOS), round(spi_map_d4@data$SPI.D4.7.GEOS, digits = 1)
            
        ) %>% 
            lapply(htmltools::HTML)
        
        
        
        
        leaflet(spi_map_d4) %>%
            addProviderTiles(providers$Esri.WorldStreetMap) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.7,
                        fillColor = ~pal(SPI.D4.DPO),
                        label=labels) %>%
            addLegend(pal=pal, values=~SPI.D4.DPO, opacity=0.7, title='SPI value', position="bottomleft")        
    })
    
    ####
    # SPI AKI Summary Stats
    ###
    
    output$summary_stats_d4 <- DT::renderDataTable({
        
        
        #add function to produce weighted summary stats
        
        
        #produce by region
        sumstats<- df_d4() %>%
            left_join(country_info) %>%
            group_by(region) %>%
            select(region, starts_with('SPI.D4.')) %>%
            summarise_all(~round(100*mean(., na.rm=T),2)) %>%
            mutate(SPI.D4.DPO=round(SPI.D4.DPO/100,2))
        
        #produce global number
        sumstats_gl<- df_d4() %>%
            mutate(region='Global') %>%
            group_by(region) %>%
            select(region, starts_with('SPI.D4.')) %>%
            summarise_all(~round(100*mean(., na.rm=T),2)) %>%
            mutate(SPI.D4.DPO=round(SPI.D4.DPO/100,2))
        
        
        #transpose data
        sumstats_df_long <-sumstats_gl %>%
            bind_rows(sumstats) 
        
        sumstats_df <- as.data.frame(t(sumstats_df_long %>% select(-region)))
        colnames(sumstats_df) = sumstats_df_long$region 
        
        
        sumstats_df <- sumstats_df %>%
            rownames_to_column() %>%
            rename(series=rowname)
        
        
        #create labels df
        metadata_tab2_d4 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D4.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        
        #add variable label
        sumstats_df <- sumstats_df %>%
            left_join(metadata_tab2_d4) %>%
            rename(Series=series,
                   Label=indicator_name) %>%
            select(Series, Label, everything())
        
        DT::datatable(sumstats_df, caption=htmltools::tags$caption(
            style = 'caption-side: top; text-align: left;',
            htmltools::em("Mean of SPI Indicators by Region.  Sub-indicators scaled to be 0-100."))    ,
            extensions = 'Buttons', options=list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                pageLength = 60)) 
        
        
        
    })
    
    ###
    # Correlation between AKI indicators
    ###
    
    
    corrp_d4 <- reactive({
        
        metadata_tab3_d4 <- metadata %>% 
            janitor::clean_names() %>%
            filter(series %in% grep("^SPI.D4.", metadata$Series, value = TRUE)) %>%
            select(series, indicator_name)
        
        corr_df <- df_d4()
        corr_names<-metadata_tab3_d4$series
        names(corr_names) = metadata_tab3_d4$indicator_name
        
        #calculate correlations between teacher practices
        df_corr_plot <-    round(cor(select(corr_df,corr_names), use="complete.obs"), 2)
        
        #plot the correlation in a nicely formatted table
        pcorr<- ggcorrplot(df_corr_plot,
                           outline.color = "white",
                           ggtheme = theme_bw(),
                           colors = c("#F8696B", "#FFEB84", "#63BE7B"),
                           legend.title = "Correlation",
                           title = "Correlation Between SPI Indicators",
                           lab=T) + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
            scale_y_discrete(labels = function(x) str_wrap(x, width = 16)) +
            theme_bw() +
            theme(
                text = element_text(size = 12),
            ) +
            labs(caption = "Indicator values are converted to be between 0 and 1 based on whether they meet SPI scoring criteria." 
            )
        
        pcorr
        
    })
    
    
    
    
    
    
    output$corrplot_d4 <- renderPlot({
        
        corrp_d4()
        
    })
    
    
    
    

    
    
    
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
