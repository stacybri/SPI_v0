---
title: "SPI Data Documentation"
author: "Brian Stacy"
date: "2020-05-19"
output: 
  html_document: 
    fig_height: 6
    fig_width: 8
    keep_md: yes
    toc: yes
---



# Introduction

This file will clean the raw SPI data and form the SPI indicators.  From the original technical report on the SPI:

Once the dimensions have been specified, attention turns to identifying the variables and selecting an appropriate aggregation method. The criteria suggest that the variables in an index should be coherent with the concept being measured; they should be publicly available (i.e., drawn from NSSs, rather than from experts or other sources). The aggregation method should be selected with rigor in mind, including the axioms or properties that the method satisfies. At the same time, it should aim for simplicity to maximize general understanding and impact.

A variable is typically derived from a simple “yes-no” question concerning a normative guideline that a country’s NSS should meet.  Each of these “yes-no” questions generate a dichotomous variable having a 0-1 representation.  In the case of SPI, in Dimensions 1 and a part of Dimension 2 the yes-no questions generate three variables with 0-0.5-1 representation, while in the second half of Dimension 2 it has a 0-0.3-0.6-1 representation, and in dimensions 3 and 4 it generates a variable having a 0-1 representation.

Dimension  Score=Weighted Score÷Maximum Dimension Score×100

The indicator selection process is guided by conventions of international agencies, expert opinions on statistical performance and the principles of SDGs. However, given the cost and time constraints and the accuracy concerns of assessment, trade-offs have to be made to build an actionable, cost-effective and internationally comparable index. 

One such trade-off is the equal weighting of each dimension and individual indicator, even though some of them may be more important than others or countries may assign higher priority to some than others. The equal weighting selection may be, to some extent subjective, partly failing to address the relative importance of the dimensions and indicators. This could be checked by simulations that will show the sensitivity of SPI scores and rankings in relation to alternative weights. 

When variables are dichotomous (or can be dichotomized), a measurement approach called a “counting method” is applicable and, indeed, has become standard for many types of measurement exercises. This method is used here to aggregate the scores of four dimensions into an overall SPI score and to create the composite index. Hence:

Total SPI Score =(MSC+CS+DPO+AKI)/4

Each of the four dimensions has a scale of 1-100 and are aggregated into a total score which also ranges from 1 to 100.  More information on the theoretical aspects of the SPI can be found in Cameron et al (2019).


# Data

Raw data can be found in 011_rawdata folder of this directory.  Below is documentation.


| SPI Concept                                                                                                        | File Name            | Variable Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------ | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.1 System of National Accounts in use                                                                             | D1.1.MSC.SNAU.csv    | SNAU - The national accounts data are compiled using the concepts, definitions, framework, and methodology of the System of National Account 2008 (SNA2008) or European System of National and Regional Accounts (ESA 2010).  The manual has evolved to meet the changing economic structure, to follow systematic accounting and ensure international compatibility.                                                                                                                                                                                                                                                                                                                                                                                                |
| 1.2 National Accounts base year                                                                                    | D1.2.MSC.NABY.csv    | NABY - National accounts base year is the year used as the base period for constant price calculations in the country’s national accounts.  It is recommended that the base year of constant price estimates be changed periodically to reflect changes in economic structure and relative prices.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 1.3 Classification of national industry                                                                            | D1.3.MSC.CNIN.csv    | The industrial production data are compiled using the International Standard Industrial Classification of All Economic Activities (ISIC) Rev.4 and Statistical Classification of Economic Activities in the European Community (NACE) Rev.2.  ISIC Rev.4 is a standard classification of economic activities arranged so that entities can be classified per the activity they carry out using criteria such as input, output and use of the products produced, more emphasis has been given to the character of the production process in defining and delineating ISIC classes for international comparability.  The manual and classification have changed to cover the complete scope of industrial production, employment, and GDP and other statistical areas. |
| 1.4 CPI base year                                                                                                  | D1.4.MSC.CPIBY.csv   | Consumer Price Index serves as indicators of inflation and reflects changes in the cost of acquiring a fixed basket of goods and services by the average consumer.  Weights are usually derived from consumer expenditure surveys and the CPI base year refers to the year the weights were derived.  It is recommended that the base year be changed periodically to reflect changes in expenditure structure.                                                                                                                                                                                                                                                                                                                                                      |
| 1.5. Classification of household consumption.                                                                      | D1.5.MSC.HOUS.csv    | Classification of Individual Consumption According to Purpose (COICOP) is used in household budget surveys, consumer price indices and international comparisons of gross domestic product (GDP) and its component expenditures.  Although COICOP is not strictly linked to any particular model of consumer behavior, the classification is designed to broadly reflect differences in income elasticities.  It is an integral part of the SNA1993 and more detailed subdivision of the classes provide comparability between countries and between statistics in these different areas.                                                                                                                                                                            |
| 1.6 Classification of status of employment                                                                         | D1.6.MSC.EMPL.csv    | Classification of status of employment refers to employment data that are compiled using the current international standard International Classification of Status in Employment (ISCE-93).  It classifies jobs with respect to the type of explicit or implicit contract of employment between the job holder and the economic unit in which he or she is employed.  Therefore, it aims to provide the basis for production of internationally comparable statistics on the employment relationship, including the distinction between salaried employment and self-employment.                                                                                                                                                                                     |
| 1.7 Central government accounting status                                                                           | D1.7.MSC.CGOV.csv    | Government finance accounting status refers to the accounting basis for reporting central government financial data.  For many countries’ government finance data, have been consolidated into one set of accounts capturing all the central government’s fiscal activities and following noncash recording basis.  Budgetary central government accounts do not necessarily include all central government units, the picture they provide of central government activities is usually incomplete.                                                                                                                                                                                                                                                                  |
| 1.8. Compilation of government finance statistics.                                                                 | D1.8.MSC.FINA.csv    | (GFSM) in use for compiling the data.  It provides guidelines on the institutional structure of governments and the presentation of fiscal data in a format similar to business accounting with a balance sheet and income statement plus guidelines on the treatment of exchange rate and other valuation adjustments.  The latest manual GFSM2014 is harmonized with the SNA2008.                                                                                                                                                                                                                                                                                                                                                                                  |
| 1.9 Compilation of monetary and financial statistics                                                               | D1.9.MSC.MONY.csv    | Compilation of monetary and financial statistics refers to the Monetary and Financial Statistics Manual (MFSM) in use.  It covers concepts, definitions, classifications of financial instruments and sectors, and accounting rules, and provides a comprehensive analytic framework for monetary and financial planning and policy determination.  The Monetary and Finance Statistics: Compilation Guide (2008) provides detailed guidelines for the compilation of monetary and financial statistics in addition to MFSM.                                                                                                                                                                                                                                         |
| 1.10. SDDS/e-GDDS subscription.                                                                                    | D1.10.MSC.IDDS.csv   | The Special Data Dissemination Standard (SDDS) and electronic General Data Dissemination Standard (e-GDDS) were established by the International Monetary Fund (IMF) for member countries that have or that might seek access to international capital markets, to guide them in providing their economic and financial data to the public.  Although subscription is voluntary, the subscribing member needs to be committed to observing the standard and provide information about its data and data dissemination practices (metadata).  The metadata are posted on the IMF’s SDDS and e-GDDS websites.                                                                                                                                                          |
| 1.11 CRVS                                                                                                          | D1.11.MSC.CRVS.csv   | Civil registration and vital statistics record the occurrence and characteristics of vital events (births, deaths, marriage and divorce etc.) pertaining to the population and serve as a main source of vital statistics. This identifies countries that report at least 90 percent complete registries of vital (birth and death) statistics to the United Nations Statistics Division and are reported in its Population and Vital Statistics Reports. Countries with complete vital statistics registries may have more accurate and timely demographic indicators.                                                                                                                                                                                              |
| 1.12 Business process                                                                                              | D1.12.MSC.GSBP.csv   | GSBP The Generic Statistical Business Process Model (GSBPM) aims to describe statistics production in a general and process-oriented way.  It is used both within and between statistical offices as a common basis for work with statistics production in different ways, such as quality, efficiency, standardization, and process-orientation.  It is used for all types of surveys, and "business" is not related to "business statistics" but refers to the statistical office, simply expressed.                                                                                                                                                                                                                                                               |
| 2.1 Population & Housing census                                                                                    | D2.1.CEN.POPU.csv    | Population censuses collect data on the size, distribution and composition of population and information on a broad range of social and economic characteristics of the population.  It also provides sampling frames for household and other surveys.  Housing censuses provide information on the supply of housing units, the structural characteristics and facilities, and health and the development of normal family living conditions.  Data obtained as part of the population census, including data on homeless persons, are often used in the presentation and analysis of the results of the housing census.  It is recommended that population and housing censuses be conducted at least every 10 years.                                              |
| 2.2 Agriculture census                                                                                             | D2.2.CEN.AGRI.csv    | Agriculture censuses collect information on agricultural activities, such as size of holding, land tenure, land use, employment and production, and provide basic structural data and sampling frames for agricultural surveys.  Censuses of agriculture normally involves collecting key structural data by complete enumeration of all agricultural holdings, in combination with more detailed structural data using sampling methods.  It is recommended that agricultural censuses be conducted at least every 10 years.                                                                                                                                                                                                                                        |
| 2.3 Business/establishment census                                                                                  | D2.3.CEN.BIZZ.csv    | Business/establishment censuses provide valuable information on all economic activities, number of employed and size of establishments in the economy.  Business Register information is establishment-based and includes business location, organization type (e.g. subsidiary or parent), industry classification, and operating data (e.g., receipts and employment).                                                                                                                                                                                                                                                                                                                                                                                             |
| 2.4 Household survey on income/consumption/expenditure/budget/integrated survey.                                   | D2.4.SVY.HOUS.csv    | These surveys collect data on household income (including income in kind), consumption and expenditure.  They typically include income, expenditure, and consumption surveys, household budget surveys, integrated surveys.  It is recommended that surveys on income and expenditure be conducted at least every 3 to 5 years.                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| 2.5 Agriculture survey.                                                                                            |                      | Agricultural surveys refer to surveys of agricultural holdings based on the sampling frames established by the agricultural census.  These are surveys on agricultural land, production, crops and livestock, aquaculture, labor and cost, and time use.  Some issues, such as gender and food security, are of interest to most agriculture surveys.                                                                                                                                                                                                                                                                                                                                                                                                                |
| 2.6 Labor Force Survey                                                                                             | D2.6.SVY.LABR.csv    | Labor force survey is a standard household-based survey of work-related statistics at the national and sub-national employment or unemployment levels, rates or trends.  The surveys also provide the characteristics of the employed or unemployed, including labor force status by age or gender, breakdowns between employees and the self-employed, public versus private sector employment, multiple job-holding, hiring, job creation, and duration of unemployment.                                                                                                                                                                                                                                                                                           |
| 2.7 Health/demographic survey                                                                                      | D2.7.SVY.HLTH.csv    | Health surveys collect information on various aspects of health of populations, such as health expenditure, access, utilization, and outcomes.  They typically include Demographic and Health Surveys.  It is recommended that health surveys be conducted at least every 3 to 5 years.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 2.8 Business/establishment survey                                                                                  | D2.8.SVY.BIZZ.csv    | The business/establishment survey provides information on employment, hours, and earnings of employees from a sample of business establishments including private and public, entities that are classified based on an establishment's principal activity from the business or establishment census.  Establishment surveys include surveys of businesses, farms, and institutions.  They may ask for information about the establishment itself and/or employee characteristics and demographics.                                                                                                                                                                                                                                                                   |
| 4.1 NSO has an Advance Release Calendar and it is published                                                        | D4.1.SC.DPO.CALD.csv | This indicator refers to a dissemination practice for relevant statistical data in accordance to the published advance release calendar.  Its presence provides information on upcoming releases in advance and creates public awareness; this will lead to more discipline and accountability from the statistical office.                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| 4.2 NSO has a listing of surveys and/ or microdata sets (or NADA) available upon request.                          | D4.2.SC.DPO.NADA.csv | NSO has a listing of surveys and microdata sets that can provide the necessary data and reference for follow-up.  Upon well-defined request and procedure per the national law and practice, users and practitioners can obtain the data collected from the households and businesses when needed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 4.3 NSO has a data portal                                                                                          | D4.3.SC.DPO.PORT.csv | This indicator refers to a web-based or stand-alone platform or tools that is maintained by the NSO and provides access to the indicators and related metadata in systematic way.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 4.4 Timeseries indicators are available for download in reusable format for free                                   | D4.4.SC.DPO.TIME.csv | This indicator will promote usage among the users and bring accountability to the NSO.  There are several different formats in which a user can access the data, such as Excel, CSV, and API etc.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 4.5 Metadata is available providing definition, methodology, standards or classifications for existing data series | D4.5.SC.DPO.META.csv | Statistical systems must be open and transparent about their methods and procedures and provide access to adequate metadata – detailed descriptions of the methods and procedures used to produce the data.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| 4.6 NSO has conducted a user satisfaction survey                                                                   | D4.6.SC.DPO.USER.csv | Through this indicator a NSO can improve its engagement and dissemination practice by seeking regular feedback from users and then making necessary adjustments.  It is also a good practice to continually monitor the changing data landscape and user needs as well as evolving technologies.                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| 4.7 Geospatial data available on relevant agency website.                                                                                                                   |  D4.7.SC.DPO.GEOS.csv                    |    Geospatial data available on relevant agency website refers to geo-referenced, location-based disaggregated data from satellite.  Geospatial data are often used in combination with administrative level national and sub-national units.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
# Indicator Cleaning

## SPI Dimension 1: Methodology, Standards and Classifications (MSC): 


### 1.1 System of National Accounts in use

 The national accounts data are compiled using the concepts, definitions, 
 framework, and methodology of the System of National Account 2008 (SNA2008) 
 or European System of National and Regional Accounts (ESA 2010).  The manual 
 has evolved to meet the changing economic structure, to follow systematic accounting 
 and ensure international compatibility. 
 
 Scoring: 1 point for using SNA2008 or ESA 2010, 0.5 points for using SNA 1993 or ESA 1995, 0 points otherwise
 

```r
#read in csv file.
D1.1.MSC.SNAU <- read_csv(file = paste(csv_dir, "D1.1.MSC.SNAU.csv", sep="/" )) %>%
  mutate(SPI.D1.1.SNAU=case_when(
    SNAU=="SNA 2008" ~ 1, 
    SNAU=="SNA 1993" ~ 0.5,
    TRUE ~ 0 
  )) %>%
  arrange(date, country) %>%
  select(iso3c, country, date,SNAU, SPI.D1.1.SNAU  ) 


D1.1.MSC.SNAU_wide <- D1.1.MSC.SNAU %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('SNAU', 'SPI.D1.1.SNAU')
              )

write_excel_csv(D1.1.MSC.SNAU_wide,
                path = paste(csv_output, "D1.1.MSC.SNAU_indicator.csv", sep="/" ))
```
 

### 1.2 National Accounts base year 

National accounts base year is the year used as the base period for constant price 
calculations in the country's national accounts.  It is recommended that the base year of 
constant price estimates be changed periodically to reflect changes in economic structure and relative prices. 

1 point for chained price, 0.5 for reference period within past 10 years, 0 points otherwise.


```r
#read in csv file.
D1.2.MSC.NABY <- read_csv(file = paste(csv_dir, "D1.2.MSC.NABY.csv", sep="/" )) %>%
  mutate(SPI.D1.2.NABY=case_when(
    NABY=="Original chained constant price data are rescaled." ~ 1, 
    (date-as.numeric(NABY))<=10 ~ 0.5, #within 10 years of reference period
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, NABY, SPI.D1.2.NABY  ) %>%
  arrange(date, country)

D1.2.MSC.NABY_wide <- D1.2.MSC.NABY %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('NABY', 'SPI.D1.2.NABY')
              )

write_excel_csv(D1.2.MSC.NABY_wide,
                path = paste(csv_output, "D1.2.MSC.NABY_indicator.csv", sep="/" ))
```

### 1.3 Classification of national industry

 The industrial production data are compiled using the International Standard Industrial 
 Classification of All Economic Activities (ISIC) Rev.4 and Statistical Classification of 
 Economic Activities in the European Community (NACE) Rev.2.  ISIC Rev.4 is a standard classification 
 of economic activities arranged so that entities can be classified per the activity they carry out 
 using criteria such as input, output and use of the products produced, more emphasis has been given 
 to the character of the production process in defining and delineating ISIC classes for international 
 comparability.  The manual and classification have changed to cover the complete scope of industrial 
 production, employment, and GDP and other statistical areas.

1 Point. Latest version is adopted (ISIC Rev 4, NACE Rev 2 or a compatible classification)  

0.5 Points.  Previous version is used (ISIC Rev 3, NACE Rev 1 or a compatible classification)

0 Points. Otherwise


```r
#read in csv file.
D1.3.MSC.CNIN <- read_csv(file = paste(csv_dir, "D1.3.MSC.CNIN.csv", sep="/" )) %>%
  mutate(SPI.D1.3.CNIN=case_when(
    str_to_lower(CNIN)=="nace rev2" | str_to_lower(CNIN)=="rev4" ~ 1, 
    str_to_lower(CNIN)=="nace rev1" | str_to_lower(CNIN)=="rev3" ~ 0.5, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, CNIN, SPI.D1.3.CNIN  ) %>%
  arrange(date, country)

D1.3.MSC.CNIN_wide <- D1.3.MSC.CNIN %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('CNIN', 'SPI.D1.3.CNIN')
              )
write_excel_csv(D1.3.MSC.CNIN_wide,
                path = paste(csv_output, "D1.3.MSC.CNIN_indicator.csv", sep="/" ))
```

### 1.4 CPI base year

Consumer Price Index serves as indicators of inflation and reflects changes in the 
 cost of acquiring a fixed basket of goods and services by the average consumer.  
 Weights are usually derived from consumer expenditure surveys and the CPI base year 
 refers to the year the weights were derived.  It is recommended that the base year be
 changed periodically to reflect changes in expenditure structure.  
 
 1 Point. Annual chain linking. 0.5 Points. Base year in last 10 years. 0 points. Otherwise
 

```r
#read in csv file.
D1.4.MSC.CPIBY <- read_csv(file = paste(csv_dir, "D1.4.MSC.CPIBY.csv", sep="/" )) %>%
  mutate(SPI.D1.4.CPIBY=case_when(
    CPIBY=="annual chained" ~ 1, 
    (date-as.numeric(CPIBY))<=10 ~ 0.5, #within 10 years of reference period
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, CPIBY, SPI.D1.4.CPIBY  ) %>%
  arrange(date, country)

D1.4.MSC.CPIBY_wide <- D1.4.MSC.CPIBY %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('CPIBY', 'SPI.D1.4.CPIBY')
              )

write_excel_csv(D1.4.MSC.CPIBY_wide,
                path = paste(csv_output, "D1.4.MSC.CPIBY_indicator.csv", sep="/" ))
```



 
### 1.5 Classification of household consumption

Classification of Individual Consumption According to Purpose (COICOP) 
is used in household budget surveys, consumer price indices and international 
comparisons of gross domestic product (GDP) and its component expenditures.  
Although COICOP is not strictly linked to any particular model of consumer 
behavior, the classification is designed to broadly reflect differences in 
income elasticities.  It is an integral part of the SNA1993 and more detailed 
subdivision of the classes provide comparability between countries and between 
statistics in these different areas.    

1 Point. Follow Classification of Individual Consumption by Purpose (COICOP)	0 Points.	Otherwise


```r
#read in csv file.
D1.5.MSC.HOUS <- read_csv(file = paste(csv_dir, "D1.5.MSC.HOUS.csv", sep="/" )) %>%
  mutate(SPI.D1.5.HOUS=case_when(
    HOUS=="COICOP" ~ 1, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, HOUS, SPI.D1.5.HOUS  ) %>%
  arrange(date, country)

D1.5.MSC.HOUS_wide <- D1.5.MSC.HOUS %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('HOUS', 'SPI.D1.5.HOUS')
              )

write_excel_csv(D1.5.MSC.HOUS_wide,
                path = paste(csv_output, "D1.5.MSC.HOUS_indicator.csv", sep="/" ))
```




### 1.6 Classification of status of employment 

Classification of status of employment refers to employment data that are 
 compiled using the current international standard International Classification 
 of Status in Employment (ISCE-93).  It classifies jobs with respect to the type
 of explicit or implicit contract of employment between the job holder and the 
 economic unit in which he or she is employed.  Therefore, it aims to provide the
 basis for production of internationally comparable statistics on the employment 
 relationship, including the distinction between salaried employment and self-employment.  
 
1 Point. Follow International Labour Organization, International Classification of Status in Employment (ICSE-93) or 2012 North American Industry Classification System (NAICS). 0 Points Otherwise. 
 

```r
#read in csv file.
D1.6.MSC.EMPL <- read_csv(file = paste(csv_dir, "D1.6.MSC.EMPL.csv", sep="/" )) %>%
  mutate(SPI.D1.6.EMPL=case_when(
    EMPL=="ICSE-93" | EMPL=="NAICS" ~ 1, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, EMPL, SPI.D1.6.EMPL  ) %>%
  arrange(date, country)

D1.6.MSC.EMPL_wide <- D1.6.MSC.EMPL %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('EMPL', 'SPI.D1.6.EMPL')
              )

write_excel_csv(D1.6.MSC.EMPL_wide,
                path = paste(csv_output, "D1.6.MSC.EMPL_indicator.csv", sep="/" ))
```



### 1.7 Central government accounting status

Government finance accounting status refers to the accounting basis for 
reporting central government financial data.  For many countries' government 
finance data, have been consolidated into one set of accounts capturing all 
the central government's fiscal activities and following noncash recording basis.  
Budgetary central government accounts do not necessarily include all central government 
units, the picture they provide of central government activities is usually incomplete.  

1 Point. Consolidated central government accounting follows noncash recording basis	 
0.5 Points. Consolidated central government accounting follows cash recording basis	 
0 Points. Otherwise 


```r
#read in csv file.
D1.7.MSC.CGOV <- read_csv(file = paste(csv_dir, "D1.7.MSC.CGOV.csv", sep="/" )) %>%
  mutate(SPI.D1.7.CGOV=case_when(
    CGOV=="AC" ~ 1, 
    CGOV=="CA" ~ 0.5,
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, CGOV, SPI.D1.7.CGOV  ) %>%
  arrange(date, country)

D1.7.MSC.CGOV_wide <- D1.7.MSC.CGOV %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('CGOV', 'SPI.D1.7.CGOV')
              )

write_excel_csv(D1.7.MSC.CGOV_wide,
                path = paste(csv_output, "D1.7.MSC.CGOV_indicator.csv", sep="/" ))
```

### 1.8 Compilation of government finance statistics

(GFSM) in use for compiling the data.  It provides guidelines on the institutional 
structure of governments and the presentation of fiscal data in a format similar to 
business accounting with a balance sheet and income statement plus guidelines on the 
treatment of exchange rate and other valuation adjustments.  The latest manual GFSM2014 
is harmonized with the SNA2008. 

1 Point. Follow the latest Government Finance Statistical Manual (2014)/ ESA2010	
0.5 Points. Previous version is used (GFSM 2001)	
0 Points. Otherwise



```r
#read in csv file.
D1.8.MSC.FINA <- read_csv(file = paste(csv_dir, "D1.8.MSC.FINA.csv", sep="/" )) %>%
  mutate(SPI.D1.8.FINA=case_when(
    FINA=="2014" | FINA=="ESA 2010"~ 1, 
    FINA=="2001" ~ 0.5,
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, FINA, SPI.D1.8.FINA  ) %>%
  arrange(date, country)

D1.8.MSC.FINA_wide <- D1.8.MSC.FINA %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('FINA', 'SPI.D1.8.FINA')
              )

write_excel_csv(D1.8.MSC.FINA_wide,
                path = paste(csv_output, "D1.8.MSC.FINA_indicator.csv", sep="/" ))
```



### 1.9 Compilation of monetary and financial statistics

Compilation of monetary and financial statistics refers to the Monetary and Financial Statistics Manual 
(MFSM) in use.  It covers concepts, definitions, classifications of financial instruments and sectors, and 
accounting rules, and provides a comprehensive analytic framework for monetary and financial planning and policy 
determination.  The Monetary and Finance Statistics: Compilation Guide (2008) provides detailed guidelines for 
the compilation of monetary and financial statistics in addition to MFSM. 

1 Point. Follow the latest Monetary and Finance Statistics Manual (2000) or Monetary and Finance Statistics: Compilation Guide (2008/2016)
0 Points. Otherwise


```r
#read in csv file.
D1.9.MSC.MONY <- read_csv(file = paste(csv_dir, "D1.9.MSC.MONY.csv", sep="/" )) %>%
  mutate(SPI.D1.9.MONY=case_when(
    MONY=="MFSM 2000" | MONY=="MFSMCG 2016"~ 1, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, MONY, SPI.D1.9.MONY  ) %>%
  arrange(date, country)

D1.9.MSC.MONY_wide <- D1.9.MSC.MONY %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('MONY', 'SPI.D1.9.MONY')
              )

write_excel_csv(D1.9.MSC.MONY_wide,
                path = paste(csv_output, "D1.9.MSC.MONY_indicator.csv", sep="/" ))
```



### 1.10 SDDS/e-GDDS subscription

Data Dissemination Standard (SDDS) and electronic General Data Dissemination Standard (e-GDDS) were 
established by the International Monetary Fund (IMF) for member countries that have or that might seek 
access to international capital markets, to guide them in providing their economic and financial data to the public.
Although subscription is voluntary, the subscribing member needs to be committed to observing the standard and provide
information about its data and data dissemination practices (metadata).  The metadata are posted on the IMF's SDDS and 
e-GDDS websites.       

1 Point. Subscribing to IMF SDDS+ or SDDS standards	
0.5 Points. Subscribing to IMF e-GDDS standards	
0 Points. Otherwise


```r
#read in csv file.
D1.10.MSC.IDDS <- read_csv(file = paste(csv_dir, "D1.10.MSC.IDDS.csv", sep="/" )) %>%
  mutate(SPI.D1.10.IDDS=case_when(
    IDDS=="SDDS Plus" | IDDS=="SDDS"~ 1, 
    IDDS=="e-GDDS"~ 0.5,
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, IDDS, SPI.D1.10.IDDS  ) %>%
  arrange(date, country)

D1.10.MSC.IDDS_wide <- D1.10.MSC.IDDS %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('IDDS', 'SPI.D1.10.IDDS')
              )

write_excel_csv(D1.10.MSC.IDDS_wide,
                path = paste(csv_output, "D1.10.MSC.IDDS_indicator.csv", sep="/" ))
```



### 1.11 CRVS 

Civil registration and vital statistics record the occurrence and characteristics of 
vital events (births, deaths, marriage and divorce etc.) pertaining to the population and 
serve as a main source of vital statistics. This identifies countries that report at least 
90 percent complete registries of vital (birth and death) statistics to the United Nations 
Statistics Division and are reported in its Population and Vital Statistics Reports. 
Countries with complete vital statistics registries may have more accurate and timely demographic indicators. 

1 Point. Vital registration complete	
0 Points. Otherwise

```r
#read in csv file.
D1.11.MSC.CRVS <- read_csv(file = paste(csv_dir, "D1.11.MSC.CRVS.csv", sep="/" )) %>%
  mutate(SPI.D1.11.CRVS=case_when(
    str_to_lower(CRVS)=="yes" ~ 1, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, CRVS, SPI.D1.11.CRVS  ) %>%
  arrange(date, country)

D1.11.MSC.CRVS_wide <- D1.11.MSC.CRVS %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('CRVS', 'SPI.D1.11.CRVS')
              )

write_excel_csv(D1.11.MSC.CRVS_wide,
                path = paste(csv_output, "D1.11.MSC.CRVS_indicator.csv", sep="/" ))
```



### 1.12 Business process

The Generic Statistical Business Process Model (GSBPM) aims to describe 
statistics production in a general and process-oriented way.  It is used 
both within and between statistical offices as a common basis for work with 
statistics production in different ways, such as quality, efficiency, standardization, 
and process-orientation.  It is used for all types of surveys, and "business" is not 
related to "business statistics" but refers to the statistical office, simply expressed.  

1 Point. GSBPM is in use
0 Points. Otherwise


```r
#read in csv file.
D1.12.MSC.GSBP <- read_csv(file = paste(csv_dir, "D1.12.MSC.GSBP.csv", sep="/" )) %>%
  mutate(SPI.D1.12.GSBP=case_when(
    str_to_lower(GSBP)=="yes" ~ 1, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, GSBP, SPI.D1.12.GSBP  ) %>%
  arrange(date, country)

D1.12.MSC.GSBP_wide <- D1.12.MSC.GSBP %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('GSBP', 'SPI.D1.12.GSBP')
              )

write_excel_csv(D1.12.MSC.GSBP_wide,
                path = paste(csv_output, "D1.12.MSC.GSBP_indicator.csv", sep="/" ))
```

### MSC Score

MSC Country  Score=Weighted Score÷Maximum Category Score×100


```r
# join datasets together based on country and date
D1.MSC <- D1.1.MSC.SNAU %>%
  left_join(D1.2.MSC.NABY) %>%
  left_join(D1.3.MSC.CNIN) %>%
  left_join(D1.4.MSC.CPIBY) %>%
  left_join(D1.5.MSC.HOUS) %>%
  left_join(D1.6.MSC.EMPL) %>%
  left_join(D1.7.MSC.CGOV) %>%
  left_join(D1.8.MSC.FINA) %>%
  left_join(D1.9.MSC.MONY) %>%
  left_join(D1.10.MSC.IDDS) %>%
  left_join(D1.11.MSC.CRVS) %>%
  left_join(D1.12.MSC.GSBP) %>%
  select(iso3c, country, date, starts_with("SPI.D1")) 
#Now calculate MSC score which is the average across the 12 indicators
D1.MSC <- D1.MSC %>%
  mutate(SPI.D1.MSC=100*rowMeans(.[grep(x=colnames(D1.MSC), 
                                              pattern="SPI.D1")], na.rm=TRUE)) %>%
  arrange(date, iso3c) %>%
  select(iso3c, country, date,SPI.D1.MSC, starts_with("SPI.D1"))


D1.MSC_wide <- D1.MSC %>%
  select(iso3c, country, date,SPI.D1.MSC) %>%
  pivot_wider(names_from=date,
              names_prefix = "SPI.D1.MSC_",
              values_from=c('SPI.D1.MSC')
              )

write_excel_csv(D1.MSC_wide,
                path = paste(csv_output, "D1.MSC_indicator.csv", sep="/" ))
```

Produce summary statistics of our indicators.


```r
msc_sumstats <- D1.MSC %>%
  group_by(date) %>%
  select(SPI.D1.MSC, starts_with("SPI.D1")) %>%
  skim() %>%
  select(c("skim_variable",
           "date", "complete_rate", "numeric.mean",  "numeric.sd",    "numeric.p0",    "numeric.p25",   "numeric.p50",
           "numeric.p75",   "numeric.p100",  "numeric.hist"))

kable(msc_sumstats, caption="Summary Statistics of Methodology, Standards and Classifications Indicator Variables" , col.names = c("Indicator", "Date", "Completion Rate", "Mean",  "Std Dev","Min", "25th Percentile", "Median", "75th Percentile", "Max",  "Histogram"), digits = 2 ) %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>Summary Statistics of Methodology, Standards and Classifications Indicator Variables</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Indicator </th>
   <th style="text-align:right;"> Date </th>
   <th style="text-align:right;"> Completion Rate </th>
   <th style="text-align:right;"> Mean </th>
   <th style="text-align:right;"> Std Dev </th>
   <th style="text-align:right;"> Min </th>
   <th style="text-align:right;"> 25th Percentile </th>
   <th style="text-align:right;"> Median </th>
   <th style="text-align:right;"> 75th Percentile </th>
   <th style="text-align:right;"> Max </th>
   <th style="text-align:left;"> Histogram </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SPI.D1.MSC </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 46.89 </td>
   <td style="text-align:right;"> 25.64 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 25.00 </td>
   <td style="text-align:right;"> 37.50 </td>
   <td style="text-align:right;"> 66.67 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▂▇▃▃▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.MSC </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 48.20 </td>
   <td style="text-align:right;"> 26.04 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 29.17 </td>
   <td style="text-align:right;"> 37.50 </td>
   <td style="text-align:right;"> 70.83 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▂▇▃▃▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.MSC </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 49.36 </td>
   <td style="text-align:right;"> 26.26 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 29.17 </td>
   <td style="text-align:right;"> 41.67 </td>
   <td style="text-align:right;"> 75.00 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▂▇▃▃▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.MSC </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 43.05 </td>
   <td style="text-align:right;"> 22.22 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 25.00 </td>
   <td style="text-align:right;"> 37.50 </td>
   <td style="text-align:right;"> 54.17 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▂▇▅▂▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.1.SNAU </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.55 </td>
   <td style="text-align:right;"> 0.32 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.1.SNAU </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.56 </td>
   <td style="text-align:right;"> 0.32 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.1.SNAU </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▇▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.1.SNAU </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.67 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▇▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.2.NABY </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.39 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▇▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.2.NABY </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▆▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.2.NABY </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▅▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.2.NABY </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.39 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▆▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.3.CNIN </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.63 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▆▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.3.CNIN </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▆▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.3.CNIN </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▆▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.3.CNIN </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.59 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▇▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.4.CPIBY </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.4.CPIBY </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.4.CPIBY </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.4.CPIBY </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▅▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.5.HOUS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.64 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.5.HOUS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.47 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.5.HOUS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.47 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.5.HOUS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.63 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.6.EMPL </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.11 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.6.EMPL </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.6.EMPL </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.6.EMPL </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.12 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.7.CGOV </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.45 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▂▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.7.CGOV </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▃▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.7.CGOV </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▃▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.7.CGOV </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▂▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.8.FINA </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▃▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.8.FINA </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▃▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.8.FINA </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▃▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.8.FINA </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.23 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▃▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.9.MONY </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.73 </td>
   <td style="text-align:right;"> 0.45 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.9.MONY </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.83 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.9.MONY </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.84 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.9.MONY </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.90 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.10.IDDS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.67 </td>
   <td style="text-align:right;"> 0.28 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▇▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.10.IDDS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▇▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.10.IDDS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▇▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.10.IDDS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.62 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▁▁▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.11.CRVS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.11.CRVS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.11.CRVS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.11.CRVS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.12.GSBP </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.12.GSBP </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.12.GSBP </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D1.12.GSBP </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
</tbody>
</table>


## SPI Dimension 2: Censuses and Surveys (CS): 

### 2.1 Population & Housing census

Population censuses collect data on the size, distribution and composition of population and 
information on a broad range of social and economic characteristics of the population.  It also 
provides sampling frames for household and other surveys.  Housing censuses provide information 
on the supply of housing units, the structural characteristics and facilities, and health and the 
development of normal family living conditions.  Data obtained as part of the population census, 
including data on homeless persons, are often used in the presentation and analysis of the results 
of the housing census.  It is recommended that population and housing censuses be conducted at least every 10 years. 

1 Point. Population census done within last 10 years	
0.5 Points. Population census done within last 20 years	
0 Points. Otherwise

```r
#read in csv file.
D2.1.CEN.POPU_df <- read_csv(file = paste(csv_dir, "D2.1.CEN.POPU.csv", sep="/" )) %>%
  group_by(iso3c, country) %>% 
  nest() %>% # The next chunk of code will split our string with the years of the census (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$POPU.CENSUS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>% 
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(census_date=as.numeric(value)) 



# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.1.CEN.POPU_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date>census_date)) ) %>% #restrict to censuses that do not occur after reference date
  mutate(census_date=if_else(recency_indicator==TRUE, census_date, as.numeric(NA))) %>%
  group_by(iso3c, country, date, database_last_updated, POPU.CENSUS ) %>%   
  summarise(last_census=max(census_date, na.rm=T)) %>%
  mutate(SPI.D2.1.POPU=case_when(
    (date-last_census<=10) & (date-last_census>0) ~ 1, 
    (date-last_census<=20) & (date-last_census>0) ~ 0.5, 
    TRUE ~ 0 )
  )  %>%
   ungroup() %>%
  select(iso3c, country, date, POPU.CENSUS, SPI.D2.1.POPU  ) %>%
  arrange(date, country)

  
  assign(paste("D2.1.CEN.POPU",i,sep="_"), temp)
}


D2.1.CEN.POPU<- bind_rows(D2.1.CEN.POPU_2016, D2.1.CEN.POPU_2017, D2.1.CEN.POPU_2018, D2.1.CEN.POPU_2019)

D2.1.CEN.POPU_wide <- D2.1.CEN.POPU %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('POPU.CENSUS', 'SPI.D2.1.POPU')
              )

write_excel_csv(D2.1.CEN.POPU_wide,
                path = paste(csv_output, "D2.1.CEN.POPU_indicator.csv", sep="/" ))
```


### 2.2 Agriculture census

Agriculture censuses collect information on agricultural activities, such as
size of holding, land tenure, land use, employment and production, and provide
basic structural data and sampling frames for agricultural surveys.  Censuses
of agriculture normally involves collecting key structural data by complete
enumeration of all agricultural holdings, in combination with more detailed
structural data using sampling methods.  It is recommended that agricultural
censuses be conducted at least every 10 years.

1 Point.  census done within last 10 years	
0.5 Points.  census done within last 20 years	
0 Points. Otherwise


```r
#read in csv file.
D2.2.CEN.AGRI_df <- read_csv(file = paste(csv_dir, "D2.2.CEN.AGRI.csv", sep="/" )) %>%
  group_by(iso3c, country) %>% 
  nest() %>% # The next chunk of code will split our string with the years of the census (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$AGRI.CENSUS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>% 
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(census_date=as.numeric(value)) 


# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.2.CEN.AGRI_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date>census_date)) ) %>% #restrict to censuses that do not occur after reference date
  mutate(census_date=if_else(recency_indicator==TRUE, census_date, as.numeric(NA))) %>%
  group_by(iso3c, country, date, database_last_updated, AGRI.CENSUS ) %>%   
  summarise(last_census=max(census_date, na.rm=T)) %>%
  mutate(SPI.D2.2.AGRI=case_when(
    (date-last_census<=10) & (date-last_census>0) ~ 1, 
    (date-last_census<=20) & (date-last_census>0) ~ 0.5, 
    TRUE ~ 0 )
  )  %>%
   ungroup() %>%
  select(iso3c, country, date, AGRI.CENSUS, SPI.D2.2.AGRI  ) %>%
  arrange(date, country)

  
  assign(paste("D2.2.CEN.AGRI",i,sep="_"), temp)
}


D2.2.CEN.AGRI<- bind_rows(D2.2.CEN.AGRI_2016, D2.2.CEN.AGRI_2017, D2.2.CEN.AGRI_2018, D2.2.CEN.AGRI_2019)

D2.2.CEN.AGRI_wide <- D2.2.CEN.AGRI %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('AGRI.CENSUS', 'SPI.D2.2.AGRI')
              )

write_excel_csv(D2.2.CEN.AGRI_wide,
                path = paste(csv_output, "D2.2.CEN.AGRI_indicator.csv", sep="/" ))
```

### 2.3 Business/establishment census

Business/establishment censuses provide valuable information on all economic
activities, number of employed and size of establishments in the economy.
Business Register information is establishment-based and includes business
location, organization type (e.g. subsidiary or parent), industry
classification, and operating data (e.g., receipts and employment).

1 Point.  census done within last 10 years	
0.5 Points.  census done within last 20 years	
0 Points. Otherwise



```r
#read in csv file.
D2.3.CEN.BIZZ_df <- read_csv(file = paste(csv_dir, "D2.3.CEN.BIZZ.csv", sep="/" )) %>%
  group_by(iso3c, country) %>% 
  nest() %>% # The next chunk of code will split our string with the years of the census (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$BIZZ.CENSUS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>% 
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(census_date=as.numeric(value)) 



# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.3.CEN.BIZZ_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date>census_date)) ) %>% #restrict to censuses that do not occur after reference date
  mutate(census_date=if_else(recency_indicator==TRUE, census_date, as.numeric(NA))) %>%
  group_by(iso3c, country, date, database_last_updated, BIZZ.CENSUS ) %>%   
  summarise(last_census=max(census_date, na.rm=T)) %>%
  mutate(SPI.D2.3.BIZZ=case_when(
    (date-last_census<=10) & (date-last_census>0) ~ 1, 
    (date-last_census<=20) & (date-last_census>0) ~ 0.5, 
    TRUE ~ 0 )
  )  %>%
   ungroup() %>%
  select(iso3c, country, date, BIZZ.CENSUS, SPI.D2.3.BIZZ  ) %>%
  arrange(date, country)

  
  assign(paste("D2.3.CEN.BIZZ",i,sep="_"), temp)
}


D2.3.CEN.BIZZ<- bind_rows(D2.3.CEN.BIZZ_2016, D2.3.CEN.BIZZ_2017, D2.3.CEN.BIZZ_2018, D2.3.CEN.BIZZ_2019)

D2.3.CEN.BIZZ_wide <- D2.3.CEN.BIZZ %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('BIZZ.CENSUS', 'SPI.D2.3.BIZZ')
              )

write_excel_csv(D2.3.CEN.BIZZ_wide,
                path = paste(csv_output, "D2.3.CEN.BIZZ_indicator.csv", sep="/" ))
```


### 2.4 Household Survey on income/consumption/expenditure/budget/Integrated Survey 

These surveys collect data on household income (including income in kind),
consumption and expenditure.  They typically include income, expenditure, and
consumption surveys, household budget surveys, integrated surveys.  It is
recommended that surveys on income and expenditure be conducted at least every
3 to 5 years.

1 Point. 3 or more surveys done within past 10 years	
0.6 Points. 2 surveys done within past 10 years; 	
0.3 Points. 1 survey done within past 10 years; 	
0 Points. None within past 10 years


```r
#read in csv file.
D2.4.SVY.HOUS_df <- read_csv(file = paste(csv_dir, "D2.4.SVY.HOUS.csv", sep="/" )) %>%
  group_by(iso3c, country) %>%  # The next chunk of code will split our string with the years of the survey (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  nest() %>% 
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$HOUS.SURVEYS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>%
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(survey_date=as.numeric(value)) 


# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.4.SVY.HOUS_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date-survey_date<=10) & (date-survey_date>0)) ) %>% #restrict to surveys inside 10 year period
  group_by(iso3c, country, date, HOUS.SURVEYS) %>% #group by country and create indicator for how many surveys over 10 year period
  summarise(SPI.D2.4.HOUS=case_when(
    sum(recency_indicator)>=3 ~ 1, 
    sum(recency_indicator)==2 ~ 0.6, 
    sum(recency_indicator)==1 ~ 0.3, 
    TRUE ~ 0 )
  )  %>%
  select(iso3c, country, date, HOUS.SURVEYS, SPI.D2.4.HOUS  ) %>%
  arrange(date, country)

  
  assign(paste("D2.4.SVY.HOUS",i,sep="_"), temp)
}

D2.4.SVY.HOUS<- bind_rows(D2.4.SVY.HOUS_2016, D2.4.SVY.HOUS_2017, D2.4.SVY.HOUS_2018, D2.4.SVY.HOUS_2019)


D2.4.SVY.HOUS_wide <- D2.4.SVY.HOUS %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('HOUS.SURVEYS', 'SPI.D2.4.HOUS')
              )

write_excel_csv(D2.4.SVY.HOUS_wide,
                path = paste(csv_output, "D2.4.SVY.HOUS_indicator.csv", sep="/" ))
```




### 2.5 Agriculture survey

Agricultural surveys refer to surveys of agricultural holdings based on the
sampling frames established by the agricultural census.  These are surveys on
agricultural land, production, crops and livestock, aquaculture, labor and
cost, and time use.  Some issues, such as gender and food security, are of
interest to most agriculture surveys.

1 Point. 3 or more surveys done within past 10 years	
0.6 Points. 2 surveys done within past 10 years; 	
0.3 Points. 1 survey done within past 10 years; 	
0 Points. None within past 10 years



```r
#read in csv file.
D2.5.SVY.AGRI_df <- read_csv(file = paste(csv_dir, "D2.5.SVY.AGRI.csv", sep="/" )) %>%
  group_by(iso3c, country) %>%  # The next chunk of code will split our string with the years of the survey (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  nest() %>% 
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$AGRI.SURVEYS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>%
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(survey_date=as.numeric(value)) 


# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.5.SVY.AGRI_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date-survey_date<=10) & (date-survey_date>0)) ) %>% #restrict to surveys inside 10 year period
  group_by(iso3c, country, date, AGRI.SURVEYS) %>% #group by country and create indicator for how many surveys over 10 year period
  summarise(SPI.D2.5.AGRI=case_when(
    sum(recency_indicator)>=3 ~ 1, 
    sum(recency_indicator)==2 ~ 0.6, 
    sum(recency_indicator)==1 ~ 0.3, 
    TRUE ~ 0 )
  )  %>%
  select(iso3c, country, date, AGRI.SURVEYS, SPI.D2.5.AGRI  ) %>%
  arrange(date, country)

  
  assign(paste("D2.5.SVY.AGRI",i,sep="_"), temp)
}

D2.5.SVY.AGRI<- bind_rows(D2.5.SVY.AGRI_2016, D2.5.SVY.AGRI_2017, D2.5.SVY.AGRI_2018,D2.5.SVY.AGRI_2019)

D2.5.SVY.AGRI_wide <- D2.5.SVY.AGRI %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('AGRI.SURVEYS', 'SPI.D2.5.AGRI')
              )

write_excel_csv(D2.5.SVY.AGRI_wide,
                path = paste(csv_output, "D2.5.SVY.AGRI_indicator.csv", sep="/" ))
```



### 2.6 Labor Force Survey 

Labor force survey is a standard household-based survey of work-related
statistics at the national and sub-national employment or unemployment levels,
rates or trends.  The surveys also provide the characteristics of the employed
or unemployed, including labor force status by age or gender, breakdowns
between employees and the self-employed, public versus private sector
employment, multiple job-holding, hiring, job creation, and duration of
unemployment.

1 Point. 3 or more surveys done within past 10 years	
0.6 Points. 2 surveys done within past 10 years; 	
0.3 Points. 1 survey done within past 10 years; 	
0 Points. None within past 10 years




```r
#read in csv file.
D2.6.SVY.LABR_df <- read_csv(file = paste(csv_dir, "D2.6.SVY.LABR.csv", sep="/" )) %>%
  group_by(iso3c, country) %>%  # The next chunk of code will split our string with the years of the survey (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  nest() %>% 
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$LABR.SURVEYS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>%
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(survey_date=as.numeric(value)) 

# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.6.SVY.LABR_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date-survey_date<=10) & (date-survey_date>0)) ) %>% #restrict to surveys inside 10 year period
  group_by(iso3c, country, date, LABR.SURVEYS) %>% #group by country and create indicator for how many surveys over 10 year period
  summarise(SPI.D2.6.LABR=case_when(
    sum(recency_indicator)>=3 ~ 1, 
    sum(recency_indicator)==2 ~ 0.6, 
    sum(recency_indicator)==1 ~ 0.3, 
    TRUE ~ 0 )
  )  %>%
  select(iso3c, country, date, LABR.SURVEYS, SPI.D2.6.LABR  ) %>%
  arrange(date, country)

  
  assign(paste("D2.6.SVY.LABR",i,sep="_"), temp)
}

D2.6.SVY.LABR<- bind_rows(D2.6.SVY.LABR_2016, D2.6.SVY.LABR_2017, D2.6.SVY.LABR_2018,D2.6.SVY.LABR_2019)

D2.6.SVY.LABR_wide <- D2.6.SVY.LABR %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('LABR.SURVEYS', 'SPI.D2.6.LABR')
              )

write_excel_csv(D2.6.SVY.LABR_wide,
                path = paste(csv_output, "D2.6.SVY.LABR_indicator.csv", sep="/" ))
```




### 2.7 Health/Demographic survey

Health surveys collect information on various aspects of health of
populations, such as health expenditure, access, utilization, and outcomes.
They typically include Demographic and Health Surveys.  It is recommended that
health surveys be conducted at least every 3 to 5 years.

1 Point. 3 or more surveys done within past 10 years	
0.6 Points. 2 surveys done within past 10 years; 	
0.3 Points. 1 survey done within past 10 years; 	
0 Points. None within past 10 years


```r
#read in csv file.
D2.7.SVY.HLTH_df <- read_csv(file = paste(csv_dir, "D2.7.SVY.HLTH.csv", sep="/" )) %>%
  group_by(iso3c, country) %>%  # The next chunk of code will split our string with the years of the survey (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  nest() %>% 
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$HLTH.SURVEYS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>%
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(survey_date=as.numeric(value)) 

# Now calculate our SPI score for this indicator
for (i in 2016:2019) {
 temp <- D2.7.SVY.HLTH_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date-survey_date<=10) & (date-survey_date>0)) ) %>% #restrict to surveys inside 10 year period
  group_by(iso3c, country, date, HLTH.SURVEYS) %>% #group by country and create indicator for how many surveys over 10 year period
  summarise(SPI.D2.7.HLTH=case_when(
    sum(recency_indicator)>=3 ~ 1, 
    sum(recency_indicator)==2 ~ 0.6, 
    sum(recency_indicator)==1 ~ 0.3, 
    TRUE ~ 0 )
  )  %>%
  select(iso3c, country, date, HLTH.SURVEYS, SPI.D2.7.HLTH  ) %>%
  arrange(date, country)

  
  assign(paste("D2.7.SVY.HLTH",i,sep="_"), temp)
}


D2.7.SVY.HLTH<- bind_rows(D2.7.SVY.HLTH_2016, D2.7.SVY.HLTH_2017, D2.7.SVY.HLTH_2018,D2.7.SVY.HLTH_2019)

D2.7.SVY.HLTH_wide <- D2.7.SVY.HLTH %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('HLTH.SURVEYS', 'SPI.D2.7.HLTH')
              )

write_excel_csv(D2.7.SVY.HLTH_wide,
                path = paste(csv_output, "D2.7.SVY.HLTH_indicator.csv", sep="/" ))
```



### 2.8 Business/establishment survey

The business/establishment survey provides information on employment, hours,
and earnings of employees from a sample of business establishments including
private and public, entities that are classified based on an establishment's
principal activity from the business or establishment census.  Establishment
surveys include surveys of businesses, farms, and institutions.  They may ask
for information about the establishment itself and/or employee characteristics
and demographics.

1 Point. 3 or more surveys done within past 10 years	
0.6 Points. 2 surveys done within past 10 years; 	
0.3 Points. 1 survey done within past 10 years; 	
0 Points. None within past 10 years




```r
#read in csv file.
D2.8.SVY.BIZZ_df <- read_csv(file = paste(csv_dir, "D2.8.SVY.BIZZ.csv", sep="/" )) %>%
  group_by(iso3c, country) %>%  # The next chunk of code will split our string with the years of the survey (i.e. "2000, 2010") in to separate rows.  We will then aggregate up.
  nest() %>% 
  mutate(
    temp_col = map(
      data, 
      ~ str_extract_all(.x$BIZZ.SURVEYS, "\\d{4}") %>% 
        flatten() %>% 
        map_chr(~return(.x)) %>% 
        as_tibble()
    )
  ) %>%
  unnest(keep_empty = TRUE) %>% # Now we have a database with the observations equal to Country*Census observations.  From here we can calculate latest census, etc.
  mutate(survey_date=as.numeric(value)) 

# Now calculate our SPI score for this indicator

for (i in 2016:2019) {
 temp <- D2.8.SVY.BIZZ_df %>%
  mutate(date=i) %>%
  mutate(recency_indicator=((date-survey_date<=10) & (date-survey_date>0)) ) %>% #restrict to surveys inside 10 year period
  group_by(iso3c, country, date, BIZZ.SURVEYS) %>% #group by country and create indicator for how many surveys over 10 year period
  summarise(SPI.D2.8.BIZZ=case_when(
    sum(recency_indicator)>=3 ~ 1, 
    sum(recency_indicator)==2 ~ 0.6, 
    sum(recency_indicator)==1 ~ 0.3, 
    TRUE ~ 0 )
  )  %>%
  select(iso3c, country, date, BIZZ.SURVEYS, SPI.D2.8.BIZZ  ) %>%
  arrange(date, country)


  assign(paste("D2.8.SVY.BIZZ",i,sep="_"), temp)
}


D2.8.SVY.BIZZ<- bind_rows(D2.8.SVY.BIZZ_2016, D2.8.SVY.BIZZ_2017, D2.8.SVY.BIZZ_2018,D2.8.SVY.BIZZ_2019)

D2.8.SVY.BIZZ_wide <- D2.8.SVY.BIZZ %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('BIZZ.SURVEYS', 'SPI.D2.8.BIZZ')
              )

write_excel_csv(D2.8.SVY.BIZZ_wide,
                path = paste(csv_output, "D2.8.SVY.BIZZ_indicator.csv", sep="/" ))
```



### CS Score

CS Country  Score=Weighted Score÷Maximum Category Score×100


```r
# join datasets together based on country and date
D2.CS <- D2.1.CEN.POPU %>%
  left_join(D2.2.CEN.AGRI) %>%
  left_join(D2.3.CEN.BIZZ) %>%
  left_join(D2.4.SVY.HOUS) %>%
  left_join(D2.5.SVY.AGRI) %>%
  left_join(D2.6.SVY.LABR) %>%
  left_join(D2.7.SVY.HLTH) %>%
  left_join(D2.8.SVY.BIZZ) %>%
  select(iso3c, country, date, starts_with("SPI.D2")) 

#Now calculate MSC score which is the average across the 12 indicators
D2.CS <- D2.CS %>%
  mutate(SPI.D2.CS=100*rowMeans(.[grep(x=colnames(D2.CS), 
                                              pattern="SPI.D2")], na.rm=TRUE)) %>%
  arrange(date, iso3c) %>%
  select(iso3c, country, date,SPI.D2.CS, starts_with("SPI.D2"))


D2.CS_wide <- D2.CS %>%
  select(iso3c, country, date,SPI.D2.CS) %>%
  pivot_wider(names_from=date,
              names_prefix = "SPI.D2.CS_",
              values_from=c('SPI.D2.CS')
              )

write_excel_csv(D2.CS_wide,
                path = paste(csv_output, "D2.CS_indicator.csv", sep="/" ))
```

Produce summary statistics of our indicators.


```r
msc_sumstats <- D2.CS %>%
  group_by(date) %>%
  select(SPI.D2.CS, starts_with("SPI.D2")) %>%
  skim() %>%
  select(c("skim_variable",
           "date", "complete_rate", "numeric.mean",  "numeric.sd",    "numeric.p0",    "numeric.p25",   "numeric.p50",
           "numeric.p75",   "numeric.p100",  "numeric.hist"))

kable(msc_sumstats, caption="Summary Statistics of Census and Surveys Indicator Variables" , col.names = c("Indicator", "Date", "Completion Rate", "Mean",  "Std Dev","Min", "25th Percentile", "Median", "75th Percentile", "Max",  "Histogram"), digits = 2 ) %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>Summary Statistics of Census and Surveys Indicator Variables</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Indicator </th>
   <th style="text-align:right;"> Date </th>
   <th style="text-align:right;"> Completion Rate </th>
   <th style="text-align:right;"> Mean </th>
   <th style="text-align:right;"> Std Dev </th>
   <th style="text-align:right;"> Min </th>
   <th style="text-align:right;"> 25th Percentile </th>
   <th style="text-align:right;"> Median </th>
   <th style="text-align:right;"> 75th Percentile </th>
   <th style="text-align:right;"> Max </th>
   <th style="text-align:left;"> Histogram </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SPI.D2.CS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 46.03 </td>
   <td style="text-align:right;"> 18.11 </td>
   <td style="text-align:right;"> 7.5 </td>
   <td style="text-align:right;"> 31.25 </td>
   <td style="text-align:right;"> 48.75 </td>
   <td style="text-align:right;"> 57.5 </td>
   <td style="text-align:right;"> 82.50 </td>
   <td style="text-align:left;"> ▃▇▇▇▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.CS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 45.24 </td>
   <td style="text-align:right;"> 18.48 </td>
   <td style="text-align:right;"> 10.0 </td>
   <td style="text-align:right;"> 30.00 </td>
   <td style="text-align:right;"> 45.00 </td>
   <td style="text-align:right;"> 57.5 </td>
   <td style="text-align:right;"> 87.50 </td>
   <td style="text-align:left;"> ▅▆▇▅▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.CS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 45.03 </td>
   <td style="text-align:right;"> 18.96 </td>
   <td style="text-align:right;"> 7.5 </td>
   <td style="text-align:right;"> 30.00 </td>
   <td style="text-align:right;"> 47.50 </td>
   <td style="text-align:right;"> 57.5 </td>
   <td style="text-align:right;"> 91.25 </td>
   <td style="text-align:left;"> ▃▅▇▂▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.CS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 44.66 </td>
   <td style="text-align:right;"> 18.59 </td>
   <td style="text-align:right;"> 7.5 </td>
   <td style="text-align:right;"> 28.75 </td>
   <td style="text-align:right;"> 45.00 </td>
   <td style="text-align:right;"> 57.5 </td>
   <td style="text-align:right;"> 88.75 </td>
   <td style="text-align:left;"> ▅▆▇▅▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.1.POPU </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.90 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.1.POPU </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.89 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.1.POPU </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.89 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.1.POPU </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.2.AGRI </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.63 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▅▁▂▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.2.AGRI </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.63 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▅▁▂▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.2.AGRI </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▅▁▃▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.2.AGRI </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▅▁▅▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.3.BIZZ </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.17 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.3.BIZZ </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.17 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.3.BIZZ </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.17 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.3.BIZZ </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.4.HOUS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.71 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▂▃▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.4.HOUS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.70 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▂▃▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.4.HOUS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.70 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▂▃▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.4.HOUS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.69 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▂▃▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.5.AGRI </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.5.AGRI </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.32 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.5.AGRI </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.32 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.5.AGRI </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.14 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.6.LABR </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.52 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▆▃▂▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.6.LABR </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.52 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▆▃▂▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.6.LABR </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▆▂▃▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.6.LABR </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.51 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▃▂▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.7.HLTH </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0.34 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▇▇▁▅ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.7.HLTH </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▇▇▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.7.HLTH </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▇▇▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.7.HLTH </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.39 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▇▇▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.8.BIZZ </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.18 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.3 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.8.BIZZ </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.19 </td>
   <td style="text-align:right;"> 0.34 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.3 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▂▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.8.BIZZ </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.20 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.3 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D2.8.BIZZ </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.20 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.3 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
</tbody>
</table>



## SPI Dimension 3: Availability of Key Indicators (AKI):

Below is the list of AKI indicators:

- AKI 3.1: Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)  
- AKI 3.2: Prevalence of stunting, height for age (% of children under 5)  
- AKI 3.3: Mortality rate, under-5 (per 1,000 live births)  
- AKI 3.4: Proportion of children and young people in grades 2/3 achieving at least a minimum proficiency level in
(i) reading and (ii) mathematics, by sex.  
- AKI 3.5: Maternal Mortality
- AKI 3.6: People using safely managed drinking water services (% of population)  
- AKI 3.7: Access to electricity (% of population)  
- AKI 3.8: Unemployment, total (% of total labor force)  
- AKI 3.9: Manufacturing, value added (% of GDP)  
- AKI 3.10: Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%)  
- AKI 3.11: Level of water stress: freshwater withdrawal as a proportion of available freshwater resources  
- AKI 3.12: Renewable energy consumption (% of total final energy consumption)  
- AKI 3.13: Total greenhouse gas emissions (kt of CO2 equivalent)  
- AKI 3.14: Terrestrial and marine protected areas (% of total territorial area)  
- AKI 3.15: Households and NPISHs Final consumption expenditure (current LCU)  
- AKI 3.16: GNI (current LCU)  
- AKI 3.17: Quarterly GDP
- AKI 3.18: Debt service (PPG and IMF only, % of exports of goods, services and primary income) 

### AKI 3.1, 3.2, 3.9, 3.10, 3.11, 3.12, 3.13, 3.14, 3.15, 3.16, 3.18

First we will pull data for indicators coming straight from WDI.  For some indicators, we will use alternative sources.

Indicators coming from the WDI directly are:  

- AKI 3.1: Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)  
- AKI 3.2: Prevalence of stunting, height for age (% of children under 5)  
- AKI 3.9: Manufacturing, value added (% of GDP)  
- AKI 3.10: Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%)  
- AKI 3.11: Level of water stress: freshwater withdrawal as a proportion of available freshwater resources  
- AKI 3.12: Renewable energy consumption (% of total final energy consumption)  
- AKI 3.13: Total greenhouse gas emissions (kt of CO2 equivalent)  
- AKI 3.14: Terrestrial and marine protected areas (% of total territorial area)  
- AKI 3.15: Households and NPISHs Final consumption expenditure (current LCU)  
- AKI 3.16: GNI (current LCU)  
- AKI 3.18: Debt service (PPG and IMF only, % of exports of goods, services and primary income) 

Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years


```r
##########
# Pull Tags for WDI Data
##########

# make request to World Bank API
wdiRequest <- GET(url = "http://api.worldbank.org/v2/indicator?per_page=20000&format=json&source=2")
wdiResponse <- content(wdiRequest, as = "text", encoding = "UTF-8")

# Parse the JSON content and convert it to a data frame.
wdisJSON <- jsonlite::fromJSON(wdiResponse, flatten = TRUE) %>%
    data.frame()

EdStatsRequest <- GET(url = "http://api.worldbank.org/v2/indicator?per_page=20000&format=json&source=12")
EdStatsResponse <- content(EdStatsRequest, as = "text", encoding = "UTF-8")

# Parse the JSON content and convert it to a data frame.
EdStatsJSON <- jsonlite::fromJSON(EdStatsResponse, flatten = TRUE) %>%
  data.frame()

aki<- c(#'Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)',
        'Prevalence of stunting, height for age (% of children under 5)',
        #'Mortality rate, under-5 (per 1,000 live births)', This was replaced using the following source https://childmortality.org/data 
        'Pupils below minimum reading proficiency at end of primary (%). Low GAML threshold',
        'People using safely managed drinking water services (% of population)',
        #'Access to electricity (% of population)',
        'Unemployment, total (% of total labor force) (national estimate)' ,
        'Manufacturing, value added (% of GDP)',
        'Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%)',
        'Level of water stress: freshwater withdrawal as a proportion of available freshwater resources',
        'Renewable energy consumption (% of total final energy consumption)',
        #'Total greenhouse gas emissions (kt of CO2 equivalent)',
        #'Terrestrial and marine protected areas (% of total territorial area)',
        'Households and NPISHs Final consumption expenditure (current LCU)',
        'GNI (current LCU)',
        'Debt service (PPG and IMF only, % of exports of goods, services and primary income)'  )

get_tag_aki_df<-wdisJSON %>%
  bind_rows(EdStatsJSON) %>%
  filter((name %in% aki	)) %>%
  group_by(id) %>%
  summarise_all(~first(.)) %>%
  arrange(factor(name, levels = aki)) %>%
  select(id, name,  sourceOrganization) 

#get WDI metadata infor
cache_list<-wbstats::wbcache()
country_list <- wbstats::wbcountries()

aki_list<-get_tag_aki_df[,'id']

for (reference_year in 2016:2019) {
  temp <-wbstats::wb(country="countries_only", 
              indicator=aki_list$id,
              startdate=reference_year-5,
              enddate=reference_year,
              return_wide = T,
              removeNA=FALSE) %>%
          filter(((reference_year-as.numeric(date))<=5) & (reference_year>=as.numeric(date))) %>% #filter out years outside reference window of 3 years     
          write_excel_csv(path = paste(csv_output, "/D3.AKI_data_pull_",reference_year,".csv", sep="" )) %>%
          mutate_at(.vars=aki_list$id, ~if_else(is.na(.),0,1)) %>% #create 0,1 variable for whether data point exists for country
          group_by(iso3c, country) %>%
          summarise_all((~(if(is.numeric(.)) sum(., na.rm = TRUE) else first(.)))) %>% #group by country to create one observation per country                 containing whether or not data point existed
          mutate_at(.vars=aki_list$id, ~case_when(
            .>=3 ~ 1,
            .==2 ~ 0.6,
            .==1 ~ 0.3,
            .==0 ~ 0, 
            TRUE ~ 0
          )) %>% # 1 point for at least 3 values, 0.6 for 2 values, 0.3 for 1 values, 0 otherwise
          mutate(date=reference_year) %>%
          ungroup() %>%
          select(iso3c, country, date,  aki_list$id) %>%
          rename_at(aki_list$id, ~(paste('SPI.D3.',.,sep=""))) %>% #add 'D3.' as prefix before these indicators.
          left_join(country_list) #attach country metadata


  assign(paste("D3.AKI",reference_year,sep="_"), temp)
}
```

### AKI 3.1: Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)

The data will be pulled from the WDI and combined with metadata from the Povcalnet

Scoring is as follows:
Quality (0.5 points total):
0.5 Point. Comparable data lasting at least two years within past 5 years	
0 Points. No comparable data within past 5 years

Frequency (0.5 points total):
0.5 Point. 3 or more values available within past 5 years	
0.3 Points. 2 values available within past 5 years; 	
0.15 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years



```r
library(povcalnetR) 

#the code below is based on public released code by povcalnet team:
#https://github.com/worldbank/Global_Poverty_Blogs/blob/master/bg_povcalnet_comparability/R/comparability_breaks.R

# some contants
year_range <- 1990:2020
metadata_path <- "https://development-data-hub-s3-public.s3.amazonaws.com/ddhfiles/506801/povcalnet_comparability.csv"

# Load data ---------------------------------------------------------------

metadata <- read_csv(metadata_path)
cov_lkup <- c(3, 2, 1, 4)
names(cov_lkup) <- c("N", "U", "R", "A")

dat_lkup <- c(2,1)
names(dat_lkup) <- c("income","consumption")


pcn <- povcalnet()
pcn$coveragetype <- cov_lkup[pcn$coveragetype]
pcn$datatype <- dat_lkup[pcn$datatype]

df <- pcn %>%
  inner_join(metadata, by = c("countrycode", "year", "coveragetype", "datatype"))


#Now loop from 2016 and 2019, keeping just data inside last 5 years.
for (reference_year in 2016:2019) {
  
  temp1<-df %>%
        filter(coveragetype %in% c(3,4)) %>% #keep just nationally representative samples
        mutate(frequency=((reference_year-as.numeric(year))<=5) & (reference_year>=as.numeric(year))) %>% 
        filter(frequency==TRUE) %>%
        group_by(countrycode, comparability) %>% #for each country and comparability type, get number of comparable estimates
        summarise(SPI.QUAL.D3.POV=n())  %>%
        ungroup() %>%
        group_by(countrycode) %>% #now get a total by country with the max number of comparable estimates
        summarise(SPI.QUAL.D3.POV=max(SPI.QUAL.D3.POV, na.rm=T)) %>%
        mutate(SPI.QUAL.D3.POV=if_else(SPI.QUAL.D3.POV>=2,0.5,0)) #only give point if there is at least two observations that are comparable
  
  
  temp <-df %>%
          filter(coveragetype %in% c(3,4)) %>% #keep just nationally representative samples
          mutate(frequency=((reference_year-as.numeric(year))<=5) & (reference_year>=as.numeric(year))) %>% 
          mutate(SPI.FREQ.D3.POV=if_else(frequency==TRUE,1,0)) %>% #create 0,1 variable for whether data point exists for country
          group_by(countryname,countrycode) %>%
          summarise(SPI.FREQ.D3.POV=sum(SPI.FREQ.D3.POV, na.rm=T)) %>% 
          mutate(SPI.FREQ.D3.POV=case_when(
            SPI.FREQ.D3.POV>=3 ~ 0.5,
            SPI.FREQ.D3.POV==2 ~ 0.3,
            SPI.FREQ.D3.POV==1 ~ 0.15,
            SPI.FREQ.D3.POV==0 ~ 0, 
            TRUE ~ 0
          )) %>%
          left_join(temp1) %>% #now bring in quality dimension
          mutate(SPI.QUAL.D3.POV=if_else(!is.na(SPI.QUAL.D3.POV),SPI.QUAL.D3.POV,0)) %>% #recode some missing values as zero, who had no observations in 5 year window
          mutate(SPI.D3.POV=SPI.FREQ.D3.POV+SPI.QUAL.D3.POV) %>% 
          mutate(date=reference_year,
                 country=countryname,
                 iso3c=countrycode) %>%
          select( country,iso3c, date, starts_with('SPI.D3.POV')) 


  assign(paste("D3.1.AKI",reference_year,sep="_"), temp)
}

D3.1.AKI <- bind_rows(D3.1.AKI_2016, D3.1.AKI_2017, D3.1.AKI_2018, D3.1.AKI_2019)
```

### AKI 3.2: Hunger

We examine two sources: Prevalence of stunting, height for age (% of children under 5), which can be found in the WDI, and the Food Insecurity Experience Scale from the FAO (http://www.fao.org/faostat/en/#data/FS).  Data for food insecurity was pulled on May 1, 2020.

Scoring
1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years



```r
#Read in data from UN Inter-agency Group for Child Mortality Estimation

D3.2.AKI.FIES <- read_csv(file=paste(csv_dir, 'D3.2.FIES.csv', sep="/")) %>%
  rename(year_code="Year Code",
         iso3c="ISO3 Code") %>%
  mutate(date=as.numeric(str_extract(year_code, "^.{4}")),
         SPI.D3.FIES=Value)

#Now loop from 2016 and 2019, keeping just data inside last 5 years.
for (reference_year in 2016:2019) {
  temp <-D3.2.AKI.FIES %>%
          filter(((reference_year-as.numeric(date))<=5) & (reference_year>=as.numeric(date))) %>% #filter out years outside reference window of 5 years     
          mutate(SPI.D3.FIES=if_else(is.na(SPI.D3.FIES),0,1)) %>% #create 0,1 variable for whether data point exists for country
          group_by(iso3c) %>%
          summarise_all((~(if(is.numeric(.)) sum(., na.rm = TRUE) else first(.)))) %>% #group by country to create one observation per country                 containing whether or not data point existed
          mutate(SPI.D3.FIES=case_when(
            SPI.D3.FIES>=3 ~ 1,
            SPI.D3.FIES==2 ~ 0.6,
            SPI.D3.FIES==1 ~ 0.3,
            SPI.D3.FIES==0 ~ 0, 
            TRUE ~ 0
          )) %>% # 1 point for at least 3 values, 0.6 for 2 values, 0.3 for 1 values, 0 otherwise
          mutate(date=reference_year) %>%
          select( iso3c, date, starts_with('SPI.')) 


  assign(paste("D3.2.AKI",reference_year,sep="_"), temp)
}

D3.2.AKI <- bind_rows(D3.2.AKI_2016, D3.2.AKI_2017, D3.2.AKI_2018, D3.2.AKI_2019)
```



### AKI 3.3: Mortality rate, under-5 (per 1,000 live births)  

The data in WDI is modeled, based on HHS and Vital Registration.  We use the following as a source for raw data produced by national statistical offices that is used in this modeling.  

https://childmortality.org/data 

Data was pulled on April 13, 2020.

Countries are ranked by source quality (admin data > survey > no data) and frequency.
Score on this indicator has a max of 1 point with 0.5 points for source quality and 0.5 points for frequency.  Detailed scoring for source quality and frequency components are below.

Quality (0.5 points total):
0.5 Point. Vital Registration data available within past 5 years	
0.25 Points. Survey Data availabe, but no Vital Registration data within past 5 years; 	
0 Points. None within past 5 years

Frequency (0.5 points total):
0.5 Point. 3 or more values available within past 5 years	
0.3 Points. 2 values available within past 5 years; 	
0.15 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years



```r
#Read in data from UN Inter-agency Group for Child Mortality Estimation

D3.3.AKI.MORT <- read_csv(file=paste(csv_dir, 'D3.3_child_mort_RAW_v01.csv', sep="/")) %>%
  filter(INDICATOR=='Under-five mortality rate' & SEX=='Total') %>% #keep just observations for under 5 child mortality and for both sexes 
  filter(OBS_STATUS=='Included in IGME') %>% # Also keep only surveys that met IGME criteria for inclusion as a nationally representative statistic
  mutate(date=as.numeric(str_extract(TIME_PERIOD, "^.{4}")),
         country=REF_AREA,
         D3.CHLD.MORT=OBS_VALUE)

#Now loop from 2016 and 2019, keeping just data inside last 5 years.
for (reference_year in 2016:2019) {
  temp <-D3.3.AKI.MORT %>%
          mutate(frequency=((reference_year-as.numeric(date))<=5) & (reference_year>=as.numeric(date))) %>% 
          mutate(SPI.FREQ.D3.CHLD.MORT=if_else(frequency==TRUE,1,0)) %>% #create 0,1 variable for whether data point exists for country
          mutate(SPI.QUAL.D3.CHLD.MORT=case_when(
                   reference_year-as.numeric(date)>=5 ~ 0, #outside 5 year window
                   SERIES_METHOD=='Vital Registration' ~ 0.5,
                   SERIES_METHOD!='Vital Registration' ~ 0.25,
                   TRUE ~ as.numeric(NA)
                 )) %>%
          group_by(country) %>%
          summarise(SPI.FREQ.D3.CHLD.MORT=sum(SPI.FREQ.D3.CHLD.MORT, na.rm=T),
                    SPI.QUAL.D3.CHLD.MORT=max(SPI.QUAL.D3.CHLD.MORT, na.rm=T)) %>% 
          mutate(SPI.FREQ.D3.CHLD.MORT=case_when(
            SPI.FREQ.D3.CHLD.MORT>=3 ~ 0.5,
            SPI.FREQ.D3.CHLD.MORT==2 ~ 0.3,
            SPI.FREQ.D3.CHLD.MORT==1 ~ 0.15,
            SPI.FREQ.D3.CHLD.MORT==0 ~ 0, 
            TRUE ~ 0
          )) %>%
          mutate(SPI.D3.CHLD.MORT=SPI.FREQ.D3.CHLD.MORT+SPI.QUAL.D3.CHLD.MORT) %>% 
          mutate(date=reference_year) %>%
          select( country, date, starts_with('SPI.')) 


  assign(paste("D3.3.AKI",reference_year,sep="_"), temp)
}

D3.3.AKI <- bind_rows(D3.3.AKI_2016, D3.3.AKI_2017, D3.3.AKI_2018, D3.3.AKI_2019)
```










### AKI 3.5 Maternal Mortality Ratio

The data is sourced from the the Inter-Agency Group (200 countries) to improve time and country coverages. Tne national estimates with the source information are available at https://www.who.int/reproductivehealth/publications/maternal-mortality-2000-2017/en/.  The data was accessed on April 3, 2020.  This data was used for modelling maternal mortality, which are then fed into the modelled estimates on Maternal Mortality (SH.STA.MMRT) in the WDI.

For our purposes, we will use the raw data from the country surveys as our data for the availability of key indicators, since the modelled estimates are produced out of sample, and thus not reflective of a country's national statistical system.

Countries are ranked by source quality (admin data > survey > no data) and frequency.
Score on this indicator has a max of 1 point with 0.5 points for source quality and 0.5 points for frequency.  Detailed scoring for source quality and frequency components are below.

Quality (0.5 points total):
0.5 Point. Vital Registration data available within past 5 years	
0.25 Points. Survey Data or Census Data availabe, but no Vital Registration data within past 5 years; 	
0 Points. None within past 5 years

Frequency (0.5 points total):
0.5 Point. 3 or more values available within past 5 years	
0.3 Points. 2 values available within past 5 years; 	
0.15 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years


```r
#Read in data from UN Inter-agency Group 

D3.5.AKI.MMR <- read_csv(file=paste(csv_dir, 'D3.5.BMat2019_datainputs.csv', sep="/")) %>%
  filter(modelinclude=='TRUE') %>% #keep just observations that the UN inter-agency group deemed credible for use in modelling 
  mutate(date=end,
         iso3c=iso,
         D3.MMRT=pm_obs)

#Now loop from 2016 and 2019, keeping just data inside last 5 years.
for (reference_year in 2016:2019) {
  temp <-D3.5.AKI.MMR %>%
          mutate(frequency=((reference_year-as.numeric(date))<=5) & (reference_year>=as.numeric(date))) %>% 
          mutate(SPI.FREQ.D3.MMRT=if_else(frequency==TRUE,1,0)) %>% #create 0,1 variable for whether data point exists for country
          mutate(SPI.QUAL.D3.MMRT=case_when(
                   reference_year-as.numeric(date)>=5 ~ 0, #outside 5 year window
                   type=='vr' ~ 0.5,
                   type!='vr' ~ 0.25,
                   TRUE ~ as.numeric(NA)
                 )) %>%
          group_by(iso3c) %>%
          summarise(SPI.FREQ.D3.MMRT=sum(SPI.FREQ.D3.MMRT, na.rm=T),
                    SPI.QUAL.D3.MMRT=max(SPI.QUAL.D3.MMRT, na.rm=T)) %>% 
          mutate(SPI.FREQ.D3.MMRT=case_when(
            SPI.FREQ.D3.MMRT>=3 ~ 0.5,
            SPI.FREQ.D3.MMRT==2 ~ 0.3,
            SPI.FREQ.D3.MMRT==1 ~ 0.15,
            SPI.FREQ.D3.MMRT==0 ~ 0, 
            TRUE ~ 0
          )) %>%
          mutate(SPI.D3.MMRT=SPI.FREQ.D3.MMRT+SPI.QUAL.D3.MMRT) %>% 
          mutate(date=reference_year) %>%
          select( iso3c, date, starts_with('SPI.')) 


  assign(paste("D3.5.AKI",reference_year,sep="_"), temp)
}

D3.5.AKI <- bind_rows(D3.5.AKI_2016, D3.5.AKI_2017, D3.5.AKI_2018, D3.5.AKI_2019)
```




### AKI 3.6: People using safely managed drinking water services (% of population) 

Safely managed drinking water has less coverage than basic drinking water.  The hurdle for countries is measuring water quality (test for E coli, etc).  Infrastructrure tends to be more static than other indicators, so expanding the window for the frequency of data may be needed.  May consider indicator system where we have 0 points for no data, 0.5 points for all data except water quality (this is available in a pdf report by the Bank and Unicef), and 1 point for full indicator for safely managed water.

We considered using data from the Joint Monitoring Programme for Water Supply, Sanitation and Hygiene.  However, data was only updated up to 2017, which did not meet our needs.

Rank by data availability for three components (Accessible on-premises, Available when needed, and Free from contamination)



### AKI 3.7: Access to electricity (% of population) 

Access to Electricity (% of population) has 99% coverage in the WDI database making it less useful for distinguishing between countries.  In order to improve the usefulness of this indicator, we are making use of data compiled by World Bank colleagues on surveys containing electricity items.  According to the access to electricity metadata, around 42 countries have no data and an imputed value is assigned based on the regional average.  By going to survey source data, we address this issue of imputation, which gives a misleading picture of availability for our purposes.  Below is the metadata from the WDI for methods for the access to electricity indicator.

>Data for access to electricity are collected among different sources: mostly data from nationally representative household surveys (including national censuses) were used. Survey sources include Demographic and Health Surveys (DHS) and Living Standards Measurement Surveys (LSMS), Multi-Indicator Cluster Surveys (MICS), the World Health Survey (WHS), other nationally developed and implemented surveys, and various government agencies (for example, ministries of energy and utilities). Given the low frequency and the regional distribution of some surveys, a number of countries have gaps in available data. To develop the historical evolution and starting point of electrification rates, a simple modeling approach was adopted to fill in the missing data points - around 1990, around 2000, and around 2010. Therefore, a country can have a continuum of zero to three data points. There are 42 countries with zero data point and the weighted regional average was used as an estimate for electrification in each of the data periods. 170 countries have between one and three data points and missing data are estimated by using a model with region, country, and time variables. The model keeps the original observation if data is available for any of the time periods. This modeling approach allowed the estimation of electrification rates for 212 countries over these three time periods (Indicated as "Estimate"). Notation "Assumption" refers to the assumption of universal access in countries classified as developed by the United Nations. Data begins from the year in which the first survey data is available for each country.

Scoring
1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years


```r
#read in file from rawdata folder
D3.7.ELEC <- read_csv(file = paste(csv_dir, "D3.7.ELEC.csv", sep="/" )) %>%
  rename(country=Country,
         iso3c="Country code",
         date=Time)

#Now loop from 2016 and 2019, keeping just data inside last 5 years.
for (reference_year in 2016:2019) {
  temp <-D3.7.ELEC %>%
          mutate(frequency=((reference_year-as.numeric(date))<=5) & (reference_year>=as.numeric(date))) %>% 
          mutate(SPI.D3.ELEC=if_else(frequency==TRUE,1,0)) %>% #create 0,1 variable for whether data point exists for country
          group_by(country) %>%
          summarise(SPI.D3.ELEC=sum(SPI.D3.ELEC, na.rm=T)) %>%
          mutate(SPI.D3.ELEC=case_when(
            SPI.D3.ELEC>=3 ~ 1,
            SPI.D3.ELEC==2 ~ 0.6,
            SPI.D3.ELEC==1 ~ 0.3,
            SPI.D3.ELEC==0 ~ 0, 
            TRUE ~ 0
          )) %>%
          mutate(date=reference_year) %>%
          select( country, date, starts_with('SPI.')) 


  assign(paste("D3.7.AKI",reference_year,sep="_"), temp)
}

D3.7.AKI <- bind_rows(D3.7.AKI_2016, D3.7.AKI_2017, D3.7.AKI_2018, D3.7.AKI_2019)
```



### AKI 3.17 Quarterly GDP

Quarterly GDP numbers were pulled from the IMF website.

After GDP by expenditure, quarterly GDP is probably the most important development to be made in a system of National Accounts, before the development of full sectoral accounts. IMF IFS has quarterly GDP from various sources, including governments and international agencies at https://data.imf.org/?sk=4C514D48-B6BA-49ED-8AB9-52B0C1A0179B

Scoring
1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years




```r
#read in file from rawdata folder
D3.17.QUART.GDP <- read_csv(file = paste(csv_dir, "D3.17.QUART.GDP.csv", sep="/" ))

#clean data and produce indicator for each year
#Now loop from 2016 and 2019, keeping just data inside last 5 years.
for (reference_year in 2016:2019) {
temp <-D3.17.QUART.GDP %>%
  mutate(date=as.numeric(str_sub(TIME_PERIOD,1,4))) %>%
  mutate(iso2c=REF_AREA) %>%
  mutate(frequency=((reference_year-as.numeric(date))<=5) & (reference_year>=as.numeric(date))) %>% 
  mutate(SPI.D3.QUART.GDP=if_else(frequency==TRUE,1,0)) %>% #create 0,1 variable for whether data point exists for country
  group_by(iso2c, date) %>%
  summarise(SPI.D3.QUART.GDP=max(SPI.D3.QUART.GDP, na.rm=T)) %>% 
  group_by(iso2c) %>%
  summarise(SPI.D3.QUART.GDP=sum(SPI.D3.QUART.GDP, na.rm=T)) %>% 
  mutate(SPI.D3.QUART.GDP=case_when(
    SPI.D3.QUART.GDP>=3 ~ 1,
    SPI.D3.QUART.GDP==2 ~ 0.6,
    SPI.D3.QUART.GDP==1 ~ 0.3,
    SPI.D3.QUART.GDP==0 ~ 0, 
    TRUE ~ 0
  )) %>%
  mutate(date=reference_year) %>%
  select( iso2c, date, starts_with('SPI.D3.QUART.GDP')) 


  assign(paste("D3.17.AKI",reference_year,sep="_"), temp)
}

D3.17.AKI <- bind_rows(D3.17.AKI_2016, D3.17.AKI_2017, D3.17.AKI_2018, D3.17.AKI_2019)  
```

### Combine all sources into AKI database


```r
#now combine AKI databases and write to csv
D3.AKI <- bind_rows(D3.AKI_2016, D3.AKI_2017, D3.AKI_2018, D3.AKI_2019) %>%
  left_join(D3.1.AKI) %>%
  left_join(D3.2.AKI) %>%
  left_join(D3.3.AKI) %>%
  left_join(D3.5.AKI) %>%
  left_join(D3.7.AKI) %>%
  left_join(D3.17.AKI) %>%
  mutate_at(vars(starts_with('SPI.D3.')), ~if_else(is.na(.),0,as.numeric(.))) 

#calculate overall AKI score  
D3.AKI <- D3.AKI  %>%
  mutate(SPI.D3.AKI=100*rowSums(.[grep('SPI.D3.', colnames(D3.AKI))], na.rm=T)/length(grep('SPI.D3.', colnames(D3.AKI)))) 




D3.AKI_wide <- D3.AKI %>%
  select(iso3c, country, date,SPI.D3.AKI) %>%
  pivot_wider(names_from=date,
              names_prefix = "SPI.D3.AKI_",
              values_from=c('SPI.D3.AKI')
              )

write_excel_csv(D3.AKI_wide,
                path = paste(csv_output, "D3.AKI_indicator.csv", sep="/" ))
```


Produce summary statistics of our indicators.


```r
aki_sumstats <- D3.AKI %>%
  group_by(date) %>%
  select(starts_with('SPI.D3')) %>%
  skim() %>%
  select(c("skim_variable",
           "date", "complete_rate", "numeric.mean",  "numeric.sd",    "numeric.p0",    "numeric.p25",   "numeric.p50",
           "numeric.p75",   "numeric.p100",  "numeric.hist"))

kable(aki_sumstats, caption="Summary Statistics of Availability of Key Indicator Variables" , col.names = c("Indicator", "Date", "Completion Rate", "Mean",  "Std Dev","Min", "25th Percentile", "Median", "75th Percentile", "Max",  "Histogram"), digits = 2 ) %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>Summary Statistics of Availability of Key Indicator Variables</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Indicator </th>
   <th style="text-align:right;"> Date </th>
   <th style="text-align:right;"> Completion Rate </th>
   <th style="text-align:right;"> Mean </th>
   <th style="text-align:right;"> Std Dev </th>
   <th style="text-align:right;"> Min </th>
   <th style="text-align:right;"> 25th Percentile </th>
   <th style="text-align:right;"> Median </th>
   <th style="text-align:right;"> 75th Percentile </th>
   <th style="text-align:right;"> Max </th>
   <th style="text-align:left;"> Histogram </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.STA.STNT.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▅▂▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.STA.STNT.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.24 </td>
   <td style="text-align:right;"> 0.29 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▅▂▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.STA.STNT.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.22 </td>
   <td style="text-align:right;"> 0.29 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▃▂▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.STA.STNT.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.19 </td>
   <td style="text-align:right;"> 0.28 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▃▂▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SE.LPV.PRIM.BMP </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.20 </td>
   <td style="text-align:right;"> 0.24 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▇▁▃▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SE.LPV.PRIM.BMP </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▇▁▆▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SE.LPV.PRIM.BMP </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▇▁▆▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SE.LPV.PRIM.BMP </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▇▁▃▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.H2O.SMDW.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.H2O.SMDW.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.H2O.SMDW.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SH.H2O.SMDW.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SL.UEM.TOTL.NE.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▃▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SL.UEM.TOTL.NE.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▂▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SL.UEM.TOTL.NE.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.66 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▃▂▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SL.UEM.TOTL.NE.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.63 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▃▂▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NV.IND.MANF.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> 0.32 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NV.IND.MANF.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NV.IND.MANF.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.87 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NV.IND.MANF.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.86 </td>
   <td style="text-align:right;"> 0.34 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SI.SPR.PC40.ZG </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:left;"> ▇▁▁▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SI.SPR.PC40.ZG </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.09 </td>
   <td style="text-align:right;"> 0.14 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:left;"> ▇▁▁▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SI.SPR.PC40.ZG </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.12 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.SI.SPR.PC40.ZG </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.12 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ER.H2O.FWST.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▂▁▇▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ER.H2O.FWST.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▂▁▇▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ER.H2O.FWST.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▂▁▇▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ER.H2O.FWST.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▂▁▇▁▁ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.EG.FEC.RNEW.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.98 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.EG.FEC.RNEW.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.98 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.EG.FEC.RNEW.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.98 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.EG.FEC.RNEW.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.59 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:right;"> 0.60 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NE.CON.PRVT.CN </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.84 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NE.CON.PRVT.CN </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.83 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NE.CON.PRVT.CN </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NE.CON.PRVT.CN </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.81 </td>
   <td style="text-align:right;"> 0.39 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NY.GNP.MKTP.CN </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.92 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NY.GNP.MKTP.CN </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.92 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NY.GNP.MKTP.CN </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.91 </td>
   <td style="text-align:right;"> 0.27 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.NY.GNP.MKTP.CN </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.91 </td>
   <td style="text-align:right;"> 0.28 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▁▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.DT.TDS.DPPF.XP.ZS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.DT.TDS.DPPF.XP.ZS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.DT.TDS.DPPF.XP.ZS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.DT.TDS.DPPF.XP.ZS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.POV </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.39 </td>
   <td style="text-align:right;"> 0.45 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.POV </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0.45 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.POV </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.POV </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.34 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.FIES </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.FIES </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.FIES </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.FIES </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.CHLD.MORT </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.55 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▂▁▅▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.CHLD.MORT </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.55 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▂▁▂▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.CHLD.MORT </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▂▁▂▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.CHLD.MORT </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▂▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.MMRT </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.55 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.55 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▆▅▁▂▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.MMRT </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.53 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.55 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▅▁▃▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.MMRT </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▃▁▂▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.MMRT </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▂▁▂▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ELEC </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.47 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ELEC </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.45 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ELEC </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.ELEC </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.QUART.GDP </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.QUART.GDP </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.QUART.GDP </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.QUART.GDP </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.AKI </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 52.37 </td>
   <td style="text-align:right;"> 19.64 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 41.18 </td>
   <td style="text-align:right;"> 56.47 </td>
   <td style="text-align:right;"> 68.53 </td>
   <td style="text-align:right;"> 86.18 </td>
   <td style="text-align:left;"> ▂▃▆▇▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.AKI </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 51.56 </td>
   <td style="text-align:right;"> 19.79 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 40.29 </td>
   <td style="text-align:right;"> 55.29 </td>
   <td style="text-align:right;"> 68.53 </td>
   <td style="text-align:right;"> 86.18 </td>
   <td style="text-align:left;"> ▂▃▆▇▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.AKI </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 50.75 </td>
   <td style="text-align:right;"> 20.00 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 37.94 </td>
   <td style="text-align:right;"> 54.71 </td>
   <td style="text-align:right;"> 67.94 </td>
   <td style="text-align:right;"> 85.29 </td>
   <td style="text-align:left;"> ▂▃▅▇▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D3.AKI </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 46.98 </td>
   <td style="text-align:right;"> 19.93 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 32.94 </td>
   <td style="text-align:right;"> 50.88 </td>
   <td style="text-align:right;"> 64.41 </td>
   <td style="text-align:right;"> 82.94 </td>
   <td style="text-align:left;"> ▃▃▆▇▅ </td>
  </tr>
</tbody>
</table>


## SPI Dimension 4: Dissemination Practices and Openness (DPO):


### 4.1 NSO has an Advance Release Calendar and it is published 

This indicator refers to a dissemination practice for relevant statistical
data in accordance to the published advance release calendar.  Its presence
provides information on upcoming releases in advance and creates public
awareness; this will lead to more discipline and accountability from the
statistical office.

1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.1.SC.DPO.CALD <- read_csv(file = paste(csv_dir, "D4.1.SC.DPO.CALD.csv", sep="/" )) %>%
  mutate(SPI.D4.1.CALD=case_when(
    CALD==1 ~ 1, 
    CALD==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, CALD, SPI.D4.1.CALD  ) %>%
  arrange(date, country)

D4.1.SC.DPO.CALD_wide <- D4.1.SC.DPO.CALD %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('CALD', 'SPI.D4.1.CALD')
              )

write_excel_csv(D4.1.SC.DPO.CALD_wide,
                path = paste(csv_output, "D4.1.SC.DPO.CALD_indicator.csv", sep="/" ))
```



###  4.2 NSO has a listing of surveys and microdata sets (or NADA)

NSO has a listing of surveys and microdata sets that can provide the necessary
data and reference for follow-up.  Upon well-defined request and procedure per
the national law and practice, users and practitioners can obtain the data
collected from the households and businesses when needed.

1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.2.SC.DPO.NADA <- read_csv(file = paste(csv_dir, "D4.2.SC.DPO.NADA.csv", sep="/" )) %>%
  mutate(SPI.D4.2.NADA=case_when(
    NADA==1 ~ 1, 
    NADA==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, NADA, SPI.D4.2.NADA  ) %>%
  arrange(date, country)

D4.2.SC.DPO.NADA_wide <- D4.2.SC.DPO.NADA %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('NADA', 'SPI.D4.2.NADA')
              )

write_excel_csv(D4.2.SC.DPO.NADA_wide,
                path = paste(csv_output, "D4.2.SC.DPO.NADA_indicator.csv", sep="/" ))
```

### 4.3 NSO has a data portal

This indicator refers to a web-based or stand-alone platform or tools that is
maintained by the NSO and provides access to the indicators and related
metadata in systematic way.

1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.3.SC.DPO.PORT <- read_csv(file = paste(csv_dir, "D4.3.SC.DPO.PORT.csv", sep="/" )) %>%
  mutate(SPI.D4.3.PORT=case_when(
    PORT==1 ~ 1, 
    PORT==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, PORT, SPI.D4.3.PORT  ) %>%
  arrange(date, country)

D4.3.SC.DPO.PORT_wide <- D4.3.SC.DPO.PORT %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('PORT', 'SPI.D4.3.PORT')
              )

write_excel_csv(D4.3.SC.DPO.PORT_wide,
                path = paste(csv_output, "D4.3.SC.DPO.PORT_indicator.csv", sep="/" ))
```

### 4.4 Timeseries indicators are available for download in reusable format for free

This indicator will promote usage among the users and bring accountability to
the NSO.  There are several different formats in which a user can access the
data, such as Excel, CSV, and API etc.

1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.4.SC.DPO.TIME <- read_csv(file = paste(csv_dir, "D4.4.SC.DPO.TIME.csv", sep="/" )) %>%
  mutate(SPI.D4.4.TIME=case_when(
    TIME==1 ~ 1, 
    TIME==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, TIME, SPI.D4.4.TIME  ) %>%
  arrange(date, country)

D4.4.SC.DPO.TIME_wide <- D4.4.SC.DPO.TIME %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('TIME', 'SPI.D4.4.TIME')
              )

write_excel_csv(D4.4.SC.DPO.TIME_wide,
                path = paste(csv_output, "D4.4.SC.DPO.TIME_indicator.csv", sep="/" ))
```


### 4.5 Metadata is available providing definition, methodology, standards or classifications for existing data series

Statistical systems must be open and transparent about their methods and
procedures and provide access to adequate metadata - detailed descriptions of
the methods and procedures used to produce the data.

1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.5.SC.DPO.META <- read_csv(file = paste(csv_dir, "D4.5.SC.DPO.META.csv", sep="/" )) %>%
  mutate(SPI.D4.5.META=case_when(
    META==1 ~ 1, 
    META==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, META, SPI.D4.5.META  ) %>%
  arrange(date, country)

D4.5.SC.DPO.META_wide <- D4.5.SC.DPO.META %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('META', 'SPI.D4.5.META')
              )

write_excel_csv(D4.5.SC.DPO.META_wide,
                path = paste(csv_output, "D4.5.SC.DPO.META_indicator.csv", sep="/" ))
```

### 4.6 NSO has conducted a user satisfaction survey

Through this indicator a NSO can improve its engagement and dissemination
practice by seeking regular feedback from users and then making necessary
adjustments.  It is also a good practice to continually monitor the changing
data landscape and user needs as well as evolving technologies.


1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.6.SC.DPO.USER <- read_csv(file = paste(csv_dir, "D4.6.SC.DPO.USER.csv", sep="/" )) %>%
  mutate(SPI.D4.6.USER=case_when(
    USER==1 ~ 1, 
    USER==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, USER, SPI.D4.6.USER  ) %>%
  arrange(date, country)

D4.6.SC.DPO.USER_wide <- D4.6.SC.DPO.USER %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('USER', 'SPI.D4.6.USER')
              )

write_excel_csv(D4.6.SC.DPO.USER_wide,
                path = paste(csv_output, "D4.6.SC.DPO.USER_indicator.csv", sep="/" ))
```


### 4.7 Geospatial data available on relevant agency website

Geospatial data available on relevant agency website refers to geo-referenced,
location-based disaggregated data from satellite.  Geospatial data are often
used in combination with administrative level national and sub-national units.


1 Point. Yes
0 Points. No


```r
#read in csv file.
D4.7.SC.DPO.GEOS <- read_csv(file = paste(csv_dir, "D4.7.SC.DPO.GEOS.csv", sep="/" )) %>%
  mutate(SPI.D4.7.GEOS=case_when(
    GEOS==1 ~ 1, 
    GEOS==0 ~ 0, 
    TRUE ~ 0 
  ))  %>%
  select(iso3c, country, date, GEOS, SPI.D4.7.GEOS  ) %>%
  arrange(date, country)

D4.7.SC.DPO.GEOS_wide <- D4.7.SC.DPO.GEOS %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('GEOS', 'SPI.D4.7.GEOS')
              )

write_excel_csv(D4.7.SC.DPO.GEOS_wide,
                path = paste(csv_output, "D4.7.SC.DPO.GEOS_indicator.csv", sep="/" ))
```



### DPO Score

DPO Country  Score=Weighted Score÷Maximum Category Score×100


```r
# join datasets together based on country and date
D4.DPO <- D4.1.SC.DPO.CALD %>%
  left_join(D4.2.SC.DPO.NADA) %>%
  left_join(D4.3.SC.DPO.PORT) %>%
  left_join(D4.4.SC.DPO.TIME) %>%
  left_join(D4.5.SC.DPO.META) %>%
  left_join(D4.6.SC.DPO.USER) %>%
  left_join(D4.7.SC.DPO.GEOS) %>%
  select(iso3c, country, date, starts_with("SPI.D4")) 

#Now calculate MSC score which is the average across the 12 indicators
D4.DPO <- D4.DPO %>%
  mutate(SPI.D4.DPO=100*rowMeans(.[grep(x=colnames(D4.DPO), 
                                              pattern="SPI.D4")], na.rm=TRUE)) %>%
  arrange(date, iso3c) %>%
  select(iso3c, country, date,SPI.D4.DPO, starts_with("SPI.D4"))


D4.DPO_wide <- D4.DPO %>%
  select(iso3c, country, date,SPI.D4.DPO) %>%
  pivot_wider(names_from=date,
              names_prefix = "SPI.D4.DPO_",
              values_from=c('SPI.D4.DPO')
              )

write_excel_csv(D4.DPO_wide,
                path = paste(csv_output, "D4.DPO_indicator.csv", sep="/" ))
```

Produce summary statistics of our indicators.


```r
msc_sumstats <- D4.DPO %>%
  group_by(date) %>%
  select(SPI.D4.DPO, starts_with("SPI.D4")) %>%
  skim() %>%
  select(c("skim_variable",
           "date", "complete_rate", "numeric.mean",  "numeric.sd",    "numeric.p0",    "numeric.p25",   "numeric.p50",
           "numeric.p75",   "numeric.p100",  "numeric.hist"))

kable(msc_sumstats, caption="Summary Statistics of Dissemination Practices and Openness (DPO) Indicator Variables" , col.names = c("Indicator", "Date", "Completion Rate", "Mean",  "Std Dev","Min", "25th Percentile", "Median", "75th Percentile", "Max",  "Histogram"), digits = 2 ) %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>Summary Statistics of Dissemination Practices and Openness (DPO) Indicator Variables</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Indicator </th>
   <th style="text-align:right;"> Date </th>
   <th style="text-align:right;"> Completion Rate </th>
   <th style="text-align:right;"> Mean </th>
   <th style="text-align:right;"> Std Dev </th>
   <th style="text-align:right;"> Min </th>
   <th style="text-align:right;"> 25th Percentile </th>
   <th style="text-align:right;"> Median </th>
   <th style="text-align:right;"> 75th Percentile </th>
   <th style="text-align:right;"> Max </th>
   <th style="text-align:left;"> Histogram </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SPI.D4.DPO </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 41.95 </td>
   <td style="text-align:right;"> 29.96 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 14.29 </td>
   <td style="text-align:right;"> 42.86 </td>
   <td style="text-align:right;"> 71.43 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▇▃▇▅▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.DPO </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 41.88 </td>
   <td style="text-align:right;"> 30.19 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 14.29 </td>
   <td style="text-align:right;"> 42.86 </td>
   <td style="text-align:right;"> 71.43 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▇▃▇▅▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.DPO </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 61.43 </td>
   <td style="text-align:right;"> 30.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 42.86 </td>
   <td style="text-align:right;"> 71.43 </td>
   <td style="text-align:right;"> 85.71 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▃▂▆▃▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.DPO </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 59.01 </td>
   <td style="text-align:right;"> 29.32 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 42.86 </td>
   <td style="text-align:right;"> 57.14 </td>
   <td style="text-align:right;"> 85.71 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> ▃▂▇▃▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.1.CALD </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.47 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.1.CALD </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.47 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.1.CALD </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.54 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.1.CALD </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.2.NADA </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.52 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.2.NADA </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.51 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.2.NADA </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.83 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.2.NADA </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.77 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.3.PORT </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.3.PORT </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.3.PORT </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.3.PORT </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.70 </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.4.TIME </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.58 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▆▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.4.TIME </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.58 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▆▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.4.TIME </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.84 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.4.TIME </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.81 </td>
   <td style="text-align:right;"> 0.40 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.5.META </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.61 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.5.META </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.61 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▅▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.5.META </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.73 </td>
   <td style="text-align:right;"> 0.44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▃▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.5.META </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▂▁▁▁▇ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.6.USER </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.6.USER </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.6.USER </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.29 </td>
   <td style="text-align:right;"> 0.45 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▃ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.6.USER </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.23 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.7.GEOS </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.7.GEOS </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.17 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▂ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.7.GEOS </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.42 </td>
   <td style="text-align:right;"> 0.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▆ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SPI.D4.7.GEOS </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.39 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ▇▁▁▁▅ </td>
  </tr>
</tbody>
</table>



## Overall Score

Total SPI Score =(MSC+CS+DPO+AKI)/4


```r
#bring all the databases together
SPI<-D1.MSC %>%
  left_join(D2.CS) %>%
  left_join(D3.AKI) %>%
  left_join(D4.DPO) 

#Update ISO codes
SPI <- SPI %>%
  select(-iso3c) %>%
  left_join(country_list)



#add in country population as last step
# make request to World Bank API
populationRequest <- GET(url = "https://api.worldbank.org/v2/country/all/indicator/SP.POP.TOTL?source=40&per_page=5000&date=2015:2020&format=json")
populationResponse <- content(populationRequest, as = "text", encoding = "UTF-8")

# Parse the JSON content and convert it to a data frame.
pop <- jsonlite::fromJSON(populationResponse, flatten = TRUE) %>%
  data.frame() %>%
  mutate(population=value,
         iso3c=country.id,
         country=country.value,
         date=as.numeric(date)) %>%
  select(iso3c, country, date, population)


#merge population onto SPI
SPI <- SPI %>%
  left_join(pop)

#Construct overall score
SPI <- SPI %>%
  mutate(SPI.OVRL.SCR=(SPI.D1.MSC+SPI.D2.CS+SPI.D3.AKI+SPI.D4.DPO)/4)

#create version of data in wide format
SPI_wide <- SPI %>%
  select(iso3c, country, date, SPI.OVRL.SCR, SPI.D1.MSC, SPI.D2.CS, SPI.D3.AKI, SPI.D4.DPO) %>%
  pivot_wider(names_from=date,
              names_sep = "_",
              values_from=c('SPI.OVRL.SCR', 'SPI.D1.MSC', 'SPI.D2.CS', 'SPI.D3.AKI', 'SPI.D4.DPO')
              )

#label columns
var.labels=c(iso3c='3 digit country code', 
             country='Country Name', 
             date='Date', 
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
             SPI.D3.POV='Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)',
             SPI.D3.SH.STA.STNT.ZS='Prevalence of stunting, height for age (% of children under 5)',
             SPI.D3.FIES='Food Insecurity Experience Scale',
             SPI.D3.CHLD.MORT='Mortality rate, under-5 (per 1,000 live births)', 
             SPI.D3.SE.LPV.PRIM.BMP='Pupils below minimum reading proficiency at end of primary (%). Low GAML threshold',
             SPI.D3.MMRT='Maternal Mortality',
             SPI.D3.SH.H2O.SMDW.ZS='People using safely managed drinking water services (% of population)',
             SPI.D3.ELEC='Access to electricity (% of population)',
             SPI.D3.SL.UEM.TOTL.NE.ZS='Unemployment, total (% of total labor force) (national estimate)' ,
             SPI.D3.NV.IND.MANF.ZS='Manufacturing, value added (% of GDP)',
             SPI.D3.SI.SPR.PC40.ZG='Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%)',
             SPI.D3.ER.H2O.FWST.ZS='Level of water stress: freshwater withdrawal as a proportion of available freshwater resources',
             SPI.D3.EG.FEC.RNEW.ZS='Renewable energy consumption (% of total final energy consumption)',
             SPI.D3.EN.ATM.GHGT.KT.CE='Total greenhouse gas emissions (kt of CO2 equivalent)',
             SPI.D3.ER.PTD.TOTL.ZS='Terrestrial and marine protected areas (% of total territorial area)',
             SPI.D3.NE.CON.PRVT.CN='Households and NPISHs Final consumption expenditure (current LCU)',
             SPI.D3.NY.GNP.MKTP.CN='GNI (current LCU)',
             SPI.D3.QUART.GDP='Quarterly GDP',
             SPI.D3.DT.TDS.DPPF.XP.ZS='Debt service (PPG and IMF only, % of exports of goods, services and primary income)', 
             SPI.D4.DPO='Dimension 4: Dissemination Practices & Openness (DPO)', 
             SPI.D4.1.CALD='NSO has an Advance Release Calendar and it is published ', 
             SPI.D4.2.NADA='NSO has a listing of surveys and microdata sets (or NADA)', 
             SPI.D4.3.PORT='NSO has a data portal', 
             SPI.D4.4.TIME='Timeseries indicators are available for download in reusable format for free', 
             SPI.D4.5.META='Metadata is available providing definition, methodology, standards or classifications for existing data series', 
             SPI.D4.6.USER='NSO has conducted a user satisfaction survey', 
             SPI.D4.7.GEOS='Geospatial data available on relevant agency website', 
             SPI.OVRL.SCR='SPI Overall Score')


#label data
#label(SPI) = as.list(var.labels[match(names(SPI), names(var.labels))])

#turn variable labels into data frame 
var.labels.df<-data.frame(var.labels) %>% 
  rownames_to_column() %>%
  rename(variable=rowname)

#export data
write_excel_csv(SPI,
                path = paste(csv_output, "SPI_scores_long.csv", sep="/" ))

# #save to stata with compatible names
# SPI  %>%
#   janitor::clean_names() %>%
#   write_dta(path = paste(csv_output, "SPI_scores.dta", sep="/" ))


write_excel_csv(SPI_wide,
                path = paste(csv_output, "SPI_scores_wide.csv", sep="/" ))

# SPI_wide  %>%
#   janitor::clean_names() %>%
#   write_dta(path = paste(csv_output, "SPI_scores_wide.dta", sep="/" ))
```

# Metadata


```r
#turn variable labels into data frame for metadata
metadata <- read_csv(file=paste(csv_dir, "SPI_metadata.csv", sep="/"))

kable(metadata, caption="Metadata for Statistical Performance Index Indicators" ) %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  column_spec(1:5, width_max  = "20em")
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>Metadata for Statistical Performance Index Indicators</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Series </th>
   <th style="text-align:left;"> Indicator Name </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:left;"> Source Organization </th>
   <th style="text-align:left;"> Source Note </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.1.SNAU </td>
   <td style="text-align:left;max-width: 20em; "> System of national accounts in use </td>
   <td style="text-align:left;max-width: 20em; "> http://data.worldbank.org/products/wdi </td>
   <td style="text-align:left;max-width: 20em; "> World Development Indicators Primary Data Documentation (WDI/PDD) </td>
   <td style="text-align:left;max-width: 20em; "> SNA2008/ESA 2010 </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.2.NABY </td>
   <td style="text-align:left;max-width: 20em; "> National Accounts base year </td>
   <td style="text-align:left;max-width: 20em; "> http://data.worldbank.org/products/wdi </td>
   <td style="text-align:left;max-width: 20em; "> World Development Indicators Primary Data Documentation (WDI/PDD) </td>
   <td style="text-align:left;max-width: 20em; "> Annual chain linking </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.3.CNIN </td>
   <td style="text-align:left;max-width: 20em; "> Classification of national industry </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/UNSD/mbs/app/DataSearchTable.aspx
  
 http://dsbb.imf.org/Default.aspx </td>
   <td style="text-align:left;max-width: 20em; "> - United Nations Monthly Bulletin of Statistics Database, Index of Industrial Production
 - IMF: Dissemination Standards Bulletin Board (DSBB) </td>
   <td style="text-align:left;max-width: 20em; "> Latest version is adopted (ISIC Rev 4, NACE Rev 2 or a compatible classification) </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.4.CPIBY </td>
   <td style="text-align:left;max-width: 20em; "> CPI base year </td>
   <td style="text-align:left;max-width: 20em; "> http://www.elibrary.imf.org/browse?freeFilter=false&amp;pageSize=10&amp;sort=datedescending&amp;t_7=urn%3ASeries%2F041
  
 http://dsbb.imf.org/Default.aspx </td>
   <td style="text-align:left;max-width: 20em; "> - IMF: International Financial Statistics (IFS) / Country notes
 - IMF: Dissemination Standards Bulletin Board (DSBB) </td>
   <td style="text-align:left;max-width: 20em; "> Annual chain linking. Weights used for CPI calculation sourced with Household Budget/Expenditure/Consumption Surveys </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.5.HOUS </td>
   <td style="text-align:left;max-width: 20em; "> Classification of household consumption </td>
   <td style="text-align:left;max-width: 20em; "> http://dsbb.imf.org/Default.aspx </td>
   <td style="text-align:left;max-width: 20em; "> IMF: Dissemination Standards Bulletin Board (DSBB) </td>
   <td style="text-align:left;max-width: 20em; "> Follow Classification of Individual Consumption by Purpose (COICOP) </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.6.EMPL </td>
   <td style="text-align:left;max-width: 20em; "> Classification of status of employment </td>
   <td style="text-align:left;max-width: 20em; "> http://dsbb.imf.org/Default.aspx </td>
   <td style="text-align:left;max-width: 20em; "> IMF: Dissemination Standards Bulletin Board (DSBB) </td>
   <td style="text-align:left;max-width: 20em; "> Follow International Labour Organization, International Classification of Status in Employment (ICSE-93) / 2012 North American Industry Classification System (NAICS) </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.7.CGOV </td>
   <td style="text-align:left;max-width: 20em; "> Central government accounting status </td>
   <td style="text-align:left;max-width: 20em; "> http://www.elibrary.imf.org/browse?freeFilter=false&amp;pageSize=10&amp;sort=datedescending&amp;t_7=urn%3ASeries%2F043
  
 http://www.elibrary.imf.org/browse?freeFilter=false&amp;pageSize=10&amp;sort=datedescending&amp;t_7=urn%3ASeries%2F043 </td>
   <td style="text-align:left;max-width: 20em; "> IMF: Government Finance Statistics (GFS) Yearbook/Guide to country tables / Table B: Basis of Recording for Latest Year Reported </td>
   <td style="text-align:left;max-width: 20em; "> Consolidated Central Government accounting follows noncash recording basis </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.8.FINA </td>
   <td style="text-align:left;max-width: 20em; "> Compilation of government finance statistics </td>
   <td style="text-align:left;max-width: 20em; "> http://dsbb.imf.org/Default.aspx </td>
   <td style="text-align:left;max-width: 20em; "> - IMF: Dissemination Standards Bulletin Board (DSBB) </td>
   <td style="text-align:left;max-width: 20em; "> Follow the latest Government Finance Statistical Manual (2014) </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.9.MONY </td>
   <td style="text-align:left;max-width: 20em; "> Compilation of monetary and financial statistics </td>
   <td style="text-align:left;max-width: 20em; "> http://www.elibrary.imf.org/browse?freeFilter=false&amp;pageSize=10&amp;sort=datedescending&amp;t_7=urn%3ASeries%2F043 </td>
   <td style="text-align:left;max-width: 20em; "> IMF: International Financial Statistics (IFS) / Country notes </td>
   <td style="text-align:left;max-width: 20em; "> Follow the latest Monetary and Finance Statistics Manual (2000) (MFSM) or Monetary and Finance Statistics: Compilation Guide (2008/2016) </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.10.IDDS </td>
   <td style="text-align:left;max-width: 20em; "> SDDS/e-GDDS subscription </td>
   <td style="text-align:left;max-width: 20em; "> http://dsbb.imf.org/Pages/GDDS/Home.aspx </td>
   <td style="text-align:left;max-width: 20em; "> IMF: Dissemination Standards Bulletin Board (DSBB) </td>
   <td style="text-align:left;max-width: 20em; "> Subscribing to IMF SDDS+/SDDS standards </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.11.CRVS </td>
   <td style="text-align:left;max-width: 20em; "> CRVS </td>
   <td style="text-align:left;max-width: 20em; "> http://data.worldbank.org/products/wdi </td>
   <td style="text-align:left;max-width: 20em; "> WDI book: Primary Data Documentation </td>
   <td style="text-align:left;max-width: 20em; "> Vital registration complete </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.12.GSBP </td>
   <td style="text-align:left;max-width: 20em; "> Business process </td>
   <td style="text-align:left;max-width: 20em; "> https://statswiki.unece.org/display/GSBPM/United+Nations+Industrial+Development+Organization+(UNIDO):+use+of+GSBPM
  
 https://statswiki.unece.org/display/GSBPM/Case+Studies+of+Metadata+use+with+GSBPM+and+GSIM </td>
   <td style="text-align:left;max-width: 20em; "> - United Nations Industrial Development Organization (UNIDO)
 - United Nations Economic Commission for Europe (UNECE) </td>
   <td style="text-align:left;max-width: 20em; "> GSBPM is in use </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.1.POPU </td>
   <td style="text-align:left;max-width: 20em; "> Population &amp; Housing census </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/unsd/demographic/sources/census/censusdates.htm#ASIA </td>
   <td style="text-align:left;max-width: 20em; "> United Nations Statistical Division (UNSD): 2020 World Population and Housing Census Programme </td>
   <td style="text-align:left;max-width: 20em; "> Population census done within last 10 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.2.AGRI </td>
   <td style="text-align:left;max-width: 20em; "> Agriculture census </td>
   <td style="text-align:left;max-width: 20em; "> http://www.fao.org/world-census-agriculture/countries/en/ </td>
   <td style="text-align:left;max-width: 20em; "> Food and Agriculture Organisation (FAO): World Programme for the Census of Agriculture </td>
   <td style="text-align:left;max-width: 20em; "> a) Agriculture census done within last 10 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.3.BIZZ </td>
   <td style="text-align:left;max-width: 20em; "> Business/establishment census </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> a) Business/ establishment census done within last 10 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.4.HOUS </td>
   <td style="text-align:left;max-width: 20em; "> Household Survey on income/ consumption/ expenditure/ budget/ Integrated Survey </td>
   <td style="text-align:left;max-width: 20em; "> http://microdata.worldbank.org/index.php/home
  
 http://iresearch.worldbank.org/PovcalNet/povOnDemand.aspx
  
 http://catalog.ihsn.org/index.php/catalog
  
 http://datanavigator.ihsn.org/
  
 https://surveyscorecardqa.worldbank.org/index.php/ </td>
   <td style="text-align:left;max-width: 20em; "> - Microdata library / World Bank, Development Research Group
 - PovcalNet
 - International Household Survey Network Catalog (IHSN).
 - IHSN Gender Data Navigator </td>
   <td style="text-align:left;max-width: 20em; "> a) 3 or more household surveys done within past 10 years; </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.5.AGRI </td>
   <td style="text-align:left;max-width: 20em; "> Agriculture survey </td>
   <td style="text-align:left;max-width: 20em; "> http://microdata.worldbank.org/index.php/home
  
 http://catalog.ihsn.org/index.php/catalog
  
 http://datanavigator.ihsn.org/
  
 http://iresearch.worldbank.org/PovcalNet/povOnDemand.aspx </td>
   <td style="text-align:left;max-width: 20em; "> - Microdata library / World Bank, Development Research Group
 - PovcalNet
 - International Household Survey Network Catalog (IHSN) 
 - IHSN Gender Data Navigator </td>
   <td style="text-align:left;max-width: 20em; "> a) 3 or more agriculture surveys done within past 10 years; </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.6.LABR </td>
   <td style="text-align:left;max-width: 20em; "> Labor Force Survey </td>
   <td style="text-align:left;max-width: 20em; "> http://www.ilo.org/surveydata/index.php/catalog/central#_r=&amp;collection=&amp;country=94,140&amp;dtype=&amp;from=2006&amp;page=1&amp;ps=&amp;sid=&amp;sk=&amp;sort_by=nation&amp;sort_order=&amp;to=2016&amp;topic=&amp;view=s&amp;vk=
  
 http://www.ilo.org/dyn/lfsurvey/lfsurvey.list?p_lang=en
  
 http://microdata.worldbank.org/index.php/home
  
 http://catalog.ihsn.org/index.php/catalog
  
 http://datanavigator.ihsn.org/
  
 http://iresearch.worldbank.org/PovcalNet/povOnDemand.aspx </td>
   <td style="text-align:left;max-width: 20em; "> International Labour Organisation (ILO) Microdata Repository </td>
   <td style="text-align:left;max-width: 20em; "> a) 3 or more labor force surveys done within past 10 years; </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.7.HLTH </td>
   <td style="text-align:left;max-width: 20em; "> Health/Demographic survey </td>
   <td style="text-align:left;max-width: 20em; "> https://dhsprogram.com/What-We-Do/survey-search.cfm?pgType=main&amp;SrvyTp=type
 http://mics.unicef.org/surveys </td>
   <td style="text-align:left;max-width: 20em; "> - Demographic and Health Surveys (DHS)
 - Multiple Indicator Cluster Survey (MICS) </td>
   <td style="text-align:left;max-width: 20em; "> a) 3 or more health surveys done within past 10 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.8.BIZZ </td>
   <td style="text-align:left;max-width: 20em; "> Business/establishment survey </td>
   <td style="text-align:left;max-width: 20em; "> http://microdata.worldbank.org/index.php/home
  
 http://catalog.ihsn.org/index.php/catalog
 http://datanavigator.ihsn.org/ 
 http://iresearch.worldbank.org/PovcalNet/povOnDemand.aspx </td>
   <td style="text-align:left;max-width: 20em; "> - Microdata library / World Bank, Development Research Group
 - PovcalNet
 - International Household Survey Network Catalog (IHSN) 
 - IHSN Gender Data Navigator </td>
   <td style="text-align:left;max-width: 20em; "> a) 3 or more business/establishment surveys done within past 10 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.POV </td>
   <td style="text-align:left;max-width: 20em; "> Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population) </td>
   <td style="text-align:left;max-width: 20em; "> Povcalnet, https://development-data-hub-s3-public.s3.amazonaws.com/ddhfiles/506801/povcalnet_comparability.csv </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring is as follows:
Quality (0.5 points total):
0.5 Point. Comparable data lasting at least two years within past 5 years	
0 Points. No comparable data within past 5 years

Frequency (0.5 points total):
0.5 Point. 3 or more values available within past 5 years	
0.3 Points. 2 values available within past 5 years; 	
0.15 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.SH.STA.STNT.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Prevalence of stunting, height for age (% of children under 5) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years        
0.6 Points. 2 values available within past 5 years;         
0.3 Points. 1 values available within past 5 years;         
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.FIES </td>
   <td style="text-align:left;max-width: 20em; "> Food Insecurity Experience Scale </td>
   <td style="text-align:left;max-width: 20em; "> FAO, http://www.fao.org/faostat/en/#data/FS </td>
   <td style="text-align:left;max-width: 20em; "> FAO </td>
   <td style="text-align:left;max-width: 20em; "> 0.5 Point. Comparable data lasting at least two years within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.CHLD.MORT </td>
   <td style="text-align:left;max-width: 20em; "> Mortality rate, under-5 (per 1,000 live births) </td>
   <td style="text-align:left;max-width: 20em; "> https://childmortality.org/data </td>
   <td style="text-align:left;max-width: 20em; "> Inter-Agency Group </td>
   <td style="text-align:left;max-width: 20em; "> Score on this indicator has a max of 1 point with 0.5 points for source quality and 0.5 points for frequency.  Detailed scoring for source quality and frequency components are below.

Quality (0.5 points total):
0.5 Point. Vital Registration data available within past 5 years	
0.25 Points. Survey Data availabe, but no Vital Registration data within past 5 years; 	
0 Points. None within past 5 years

Frequency (0.5 points total):
0.5 Point. 3 or more values available within past 5 years	
0.3 Points. 2 values available within past 5 years; 	
0.15 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.SE.LPV.PRIM.BMP </td>
   <td style="text-align:left;max-width: 20em; "> Pupils below minimum reading proficiency at end of primary (%). Low GAML threshold </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.MMRT </td>
   <td style="text-align:left;max-width: 20em; "> Maternal Mortality </td>
   <td style="text-align:left;max-width: 20em; "> WHO, Inter-Agency Group, https://www.who.int/reproductivehealth/publications/maternal-mortality-2000-2017/en/. </td>
   <td style="text-align:left;max-width: 20em; "> WHO, Inter-agency group </td>
   <td style="text-align:left;max-width: 20em; "> Score on this indicator has a max of 1 point with 0.5 points for source quality and 0.5 points for frequency.  Detailed scoring for source quality and frequency components are below.

Quality (0.5 points total):
0.5 Point. Vital Registration data available within past 5 years	
0.25 Points. Survey Data or Census Data availabe, but no Vital Registration data within past 5 years; 	
0 Points. None within past 5 years

Frequency (0.5 points total):
0.5 Point. 3 or more values available within past 5 years	
0.3 Points. 2 values available within past 5 years; 	
0.15 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years
1 Point. 3 or more values available within past 5 years        
0.6 Points. 2 values available within past 5 years;         
0.3 Points. 1 values available within past 5 years;         
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.SH.H2O.SMDW.ZS </td>
   <td style="text-align:left;max-width: 20em; "> People using safely managed drinking water services (% of population) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.ELEC </td>
   <td style="text-align:left;max-width: 20em; "> Access to electricity (% of population) </td>
   <td style="text-align:left;max-width: 20em; "> Data for access to electricity are collected among different sources: mostly data from nationally representative household surveys (including national censuses) were used. Survey sources include Demographic and Health Surveys (DHS) and Living Standards Measurement Surveys (LSMS), Multi-Indicator Cluster Surveys (MICS), the World Health Survey (WHS), other nationally developed and implemented surveys, and various government agencies (for example, ministries of energy and utilities) </td>
   <td style="text-align:left;max-width: 20em; "> World Bank </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.SL.UEM.TOTL.NE.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Unemployment, total (% of total labor force) (national estimate) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.NV.IND.MANF.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Manufacturing, value added (% of GDP) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.SI.SPR.PC40.ZG </td>
   <td style="text-align:left;max-width: 20em; "> Annualized average growth rate in per capita real survey mean consumption or income, bottom 40% of population (%) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.ER.H2O.FWST.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Level of water stress: freshwater withdrawal as a proportion of available freshwater resources </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.EG.FEC.RNEW.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Renewable energy consumption (% of total final energy consumption) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.EN.ATM.GHGT.KT.CE </td>
   <td style="text-align:left;max-width: 20em; "> Total greenhouse gas emissions (kt of CO2 equivalent) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.ER.PTD.TOTL.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Terrestrial and marine protected areas (% of total territorial area) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.NE.CON.PRVT.CN </td>
   <td style="text-align:left;max-width: 20em; "> Households and NPISHs Final consumption expenditure (current LCU) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.NY.GNP.MKTP.CN </td>
   <td style="text-align:left;max-width: 20em; "> GNI (current LCU) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.QUART.GDP </td>
   <td style="text-align:left;max-width: 20em; "> Quarterly GDP </td>
   <td style="text-align:left;max-width: 20em; "> IMF, https://data.imf.org/?sk=4C514D48-B6BA-49ED-8AB9-52B0C1A0179B </td>
   <td style="text-align:left;max-width: 20em; "> IMF </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.DT.TDS.DPPF.XP.ZS </td>
   <td style="text-align:left;max-width: 20em; "> Debt service (PPG and IMF only, % of exports of goods, services and primary income) </td>
   <td style="text-align:left;max-width: 20em; "> http://databank.worldbank.org/data/reports.aspx?source=world-development-indicators </td>
   <td style="text-align:left;max-width: 20em; "> WDI database </td>
   <td style="text-align:left;max-width: 20em; "> Scoring:

1 Point. 3 or more values available within past 5 years	
0.6 Points. 2 values available within past 5 years; 	
0.3 Points. 1 values available within past 5 years; 	
0 Points. None within past 5 years </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.1.CALD </td>
   <td style="text-align:left;max-width: 20em; "> NSO has an Advance Release Calendar and it is published </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.2.NADA </td>
   <td style="text-align:left;max-width: 20em; "> NSO has a listing of surveys and microdata sets (or NADA) </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ 
  
 http://www.adp.ihsn.org/country_activities </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites / Accelerated Data Program of IHSN </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.3.PORT </td>
   <td style="text-align:left;max-width: 20em; "> NSO has a data portal </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.4.TIME </td>
   <td style="text-align:left;max-width: 20em; "> Timeseries indicators are available for download in reusable format for free </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.5.META </td>
   <td style="text-align:left;max-width: 20em; "> Metadata is available providing definition, methodology, standards or classifications for existing data series </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.6.USER </td>
   <td style="text-align:left;max-width: 20em; "> NSO has conducted a user satisfaction survey </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.7.GEOS </td>
   <td style="text-align:left;max-width: 20em; "> Geospatial data available on relevant agency website </td>
   <td style="text-align:left;max-width: 20em; "> https://unstats.un.org/home/nso_sites/ </td>
   <td style="text-align:left;max-width: 20em; "> NSO websites </td>
   <td style="text-align:left;max-width: 20em; "> Yes </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D1.MSC </td>
   <td style="text-align:left;max-width: 20em; "> SPI Dimension 1: Methodology, Standards &amp; Classifications (MSC) </td>
   <td style="text-align:left;max-width: 20em; "> Average of Dimension 1 Indicators </td>
   <td style="text-align:left;max-width: 20em; "> World Bank </td>
   <td style="text-align:left;max-width: 20em; "> Internationally accepted and recommended methodology, classifications and standards provide the basis for national statistical offices (NSOs) on data integration, facilitating data exchange and providing the foundation for the preparation of relevant statistical indicators. This dimension aims to assess whether national statistical systems have the necessary capacity to adopt and comply with international statistical standards. </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D2.CS </td>
   <td style="text-align:left;max-width: 20em; "> SPI Dimension 2: Censuses and Surveys (CS) </td>
   <td style="text-align:left;max-width: 20em; "> Average of Dimension 2 Indicators </td>
   <td style="text-align:left;max-width: 20em; "> World Bank </td>
   <td style="text-align:left;max-width: 20em; "> Data collection is the key responsibility of national statistical systems where information on a nation’s population, economy, health and other aspects are recorded in an accurate and timely manner. Through censuses and surveys, sometimes together with administrative systems, the NSSs collect data and generate aggregate indicators based on the results. This dimension aims to check the availability and frequency of key censuses and inter-census surveys. The required frequencies of censuses and surveys are established based on international recommendations. In some cases, criteria are adjusted to avoid unnecessarily punishing the least developed countries where there is huge disparities among country practices. For example, with labor force survey and establishment survey, the SPI loosened the criteria compared to the international recommendation. 
This dimension covers 8 indicators on population and housing census, agricultural census, business census, income and expenditure surveys and other surveys on agriculture, health, labor force and establishments. </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D3.AKI </td>
   <td style="text-align:left;max-width: 20em; "> SPI Dimension 3: Availability of Key Indicators (AKI) </td>
   <td style="text-align:left;max-width: 20em; "> Average of Dimension 3 Indicators </td>
   <td style="text-align:left;max-width: 20em; "> World Bank </td>
   <td style="text-align:left;max-width: 20em; "> Transforming source data into statistical outputs (indicators) and releasing them on a timely basis shows that the statistical systems are utilizing their capacity in data production. Reporting relevant data to specialized international agencies on time and getting them published in their respective databases demonstrates that statistical systems meet required quality standards and timeliness. Therefore, this dimension evaluates national statistical systems by reviewing the availability of country data for the most recent year in international databases. By looking at the data availability in international databases, it also makes the assessment cost-effective. </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.D4.DPO </td>
   <td style="text-align:left;max-width: 20em; "> SPI Dimension 4: Dissemination Practices &amp; Openness (DPO) </td>
   <td style="text-align:left;max-width: 20em; "> Average of Dimension 4 Indicators </td>
   <td style="text-align:left;max-width: 20em; "> World Bank </td>
   <td style="text-align:left;max-width: 20em; "> Data users are seen as an integral part of the national statistical system, which is crucial to the improvement of collection, processing and dissemination of quality data. Therefore, dissemination practices of statistical systems reflect an important part of the overall statistical capacity. This dimension is built on the principle that quality statistics should be delivered to the public in a timely, easily accessible manner for free. It includes 10 indicators under two sub-sections: Dissemination capacity of NSO and Openness of Data. </td>
  </tr>
  <tr>
   <td style="text-align:left;max-width: 20em; "> SPI.OVRL.SCR </td>
   <td style="text-align:left;max-width: 20em; "> Statistical Performance Index: Overall Score </td>
   <td style="text-align:left;max-width: 20em; "> Average of SPI Dimension 1, 2, 3, and 4 </td>
   <td style="text-align:left;max-width: 20em; "> World Bank </td>
   <td style="text-align:left;max-width: 20em; "> The concept adopted here views the statistical capacity of an NSS in terms of its range of products, and the processes it uses to produce and disseminate them. The production process for statistical outputs has certain similarities to the traditional production model from economics, and this analogy might be useful for identifying the salient dimensions of a statistical capacity measure. The production process begins with a technology that is used in generating the statistical products, and the level of this technology is clearly a relevant component of statistical capacity. The resulting statistical outputs might be divided into two general categories. First are the intermediate products, which have direct use for specialists but require additional processing to create products suitable for general use. For example, a census can be helpful for policy analysts but must be processed to obtain useful statistics. Second are the final products, which are available in a form that can be understood by the public. The key macro statistics of a country would naturally be viewed as final products. Even after the products have been created, their existence does not imply that potential users will actually have access to them. Statistical products may be available to only a few users, or available to all. The final dimension then covers the extent to which statistical products are disseminated.
This simple framework helps to identify four coherent dimensions for a measure of statistical capacity, namely: (i) Methodology, Standards and Classifications (MSC), which provides information on the technology being used by the NSS; (ii) Census and Surveys (CS), which describes the intermediate products of the NSS; (iii) Availability of Key Indicators (AKI), which focuses on key final products needed for policy; and (iv) Dissemination Practices and Openness (DPO), which evaluates the extent to which products are publicly disseminated. It is easy to see that each of these dimensions is centrally related to the statistical capacity of an NSS. </td>
  </tr>
</tbody>
</table>



```r
save(SPI, SPI_wide, metadata,
     file = paste(csv_output, "SPI.Rdata", sep="/" ))
```

