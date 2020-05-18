########################################
# Input raw data files/Excel files used in analysis
# Brian Stacy
# March 27, 2020
########################################

# Load Packages
library(tidyverse)
library(readxl)
library(rsdmx)
library(wbstats)
# Directory for SPI excel files
excel_dir <- "C:/Users/wb469649/Documents/Github/SPI_AKI/Data"

# Directory for SPI csv files that are created
csv_dir <- "C:/Users/wb469649/Documents/Github/SPI_AKI/R/01_data/011_rawdata"

###########
# Preliminary
###########

#download country metadata from wdi for merging
country_metadata <- wbcountries()


###############################
# SPI Dimension 1: Methodology, Standards and Classifications (MSC): 
###############################


#######
# Function to Read in SPI data
#######

# User inputs five parameters.  First is a numeric code for either Dimension 1, 2, 3, or 4.  Then is a secondary numeric code for sub-indicator i.e. sub-indicator 2.
# Next the user enters the name of the sub-indicator (i.e. CRVS).  Then the year of the data (i.e. 2018), finally how many rows to skip in original excel (usually 0 or 1 skips)
#####
# Example
#####

# System of National Accounts in use
#D1.1.MSC.SNAU_2016 <- spi_loader(1,1,'SNAU', 2016,1)
#####
# End Example
#####


spi_loader <- function(variable_num1, variable_num2,variable_name, year, skip) {
  read_excel(path=paste(excel_dir,"/D", variable_num1,". MSC/",year, " - D",paste(variable_num1,variable_num2,sep="."),".MSC.",variable_name," - REV.xlsx", sep=""),
             sheet=paste(year, "data", sep=" "),
             skip=skip,
             .name_repair = 'universal') 
}


##################
# This section will read in raw excels collected by SPI team, then keep just key info and convert to csv for indexing in github
##################

#########
# 1.1 System of National Accounts in use

# The national accounts data are compiled using the concepts, definitions, 
# framework, and methodology of the System of National Account 2008 (SNA2008) 
# or European System of National and Regional Accounts (ESA 2010).  The manual 
# has evolved to meet the changing economic structure, to follow systematic accounting 
# and ensure international compatibility. 
#########
D1.1.MSC.SNAU_2016 <- spi_loader(1,1,'SNAU', 2016,1) %>%
  mutate(SNAU=Sna.in.use..08.16.2019,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, SNAU)

D1.1.MSC.SNAU_2017 <- spi_loader(1,1,'SNAU', 2017,1) %>%
  mutate(SNAU=Sna.in.use,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, SNAU)

D1.1.MSC.SNAU_2018 <- spi_loader(1,1,'SNAU', 2018,1) %>%
  mutate(SNAU=Sna.in.use,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, SNAU)

D1.1.MSC.SNAU_2019 <- spi_loader(1,1,'SNAU', 2019,1) %>%
  mutate(SNAU=Sna.in.use,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, SNAU)

#save to csv
bind_rows(D1.1.MSC.SNAU_2016, D1.1.MSC.SNAU_2017, D1.1.MSC.SNAU_2018, D1.1.MSC.SNAU_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
                  path = paste(csv_dir, "D1.1.MSC.SNAU.csv", sep="/" ))



#########
# 1.2 National Accounts base year 

#National accounts base year is the year used as the base period for constant price 
# calculations in the country's national accounts.  It is recommended that the base year of 
# constant price estimates be changed periodically to reflect changes in economic structure and relative prices. 
#########
D1.2.MSC.NABY<-read_excel(path=paste(excel_dir,"/D1. MSC/","/2016, 2017, & 2018 - D1.2.MSC.NABY 20190828 5pm -REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

D1.2.MSC.NABY <- D1.2.MSC.NABY %>%
  mutate(NABY_2016=WDI.OCT2016...47,
         NABY_2017=WDI.OCT2017,
         NABY_2018=WDI.OCT2018,
         iso3c=Code,
         country=Country) %>%
  select(iso3c, NABY_2016, NABY_2017, NABY_2018) %>%
  pivot_longer(cols=contains(as.character(2016:2018)),
               names_to='date',
               names_prefix='NABY_',
               values_to='NABY') %>%
  mutate(date=as.numeric(date)) %>%
  arrange(iso3c, date) 


#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D1.2.MSC.NABY_2019<-read_excel(path=paste(excel_dir,"/D1. MSC/","/2016, 2017, 2018 & 2019 - D1.2.MSC.NABY -REV.xlsx", sep=""),
                     sheet="2016-2019 data",
                     skip=1,
                     .name_repair = 'universal')

D1.2.MSC.NABY_2019 <- D1.2.MSC.NABY_2019 %>%
  mutate(NABY_2016=WDI.OCT2016...48,
         NABY_2017=WDI.OCT2017,
         NABY_2018=WDI.OCT2018,
         NABY_2019=WDI.OCT2019,
         iso3c=Code,
         country=Country) %>%
  select(iso3c, NABY_2016, NABY_2017, NABY_2018,NABY_2019) %>%
  pivot_longer(cols=contains(as.character(2016:2019)),
               names_to='date',
               names_prefix='NABY_',
               values_to='NABY') %>%
  mutate(date=as.numeric(date)) %>%
  filter(date==2019) %>%
  arrange(iso3c, date) 
  

D1.2.MSC.NABY <- D1.2.MSC.NABY %>%
  bind_rows(D1.2.MSC.NABY_2019) %>%
  arrange(iso3c, date)  %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())


write_excel_csv(D1.2.MSC.NABY,
                path = paste(csv_dir, "D1.2.MSC.NABY.csv", sep="/" ))
#########
# 1.3 Classification of national industry

# The industrial production data are compiled using the International Standard Industrial 
# Classification of All Economic Activities (ISIC) Rev.4 and Statistical Classification of 
# Economic Activities in the European Community (NACE) Rev.2.  ISIC Rev.4 is a standard classification 
# of economic activities arranged so that entities can be classified per the activity they carry out 
# using criteria such as input, output and use of the products produced, more emphasis has been given 
# to the character of the production process in defining and delineating ISIC classes for international 
# comparability.  The manual and classification have changed to cover the complete scope of industrial 
# production, employment, and GDP and other statistical areas.
#########


for (i in 2016:2017) {
temp <- spi_loader(1,3,'CNIN', i,0) %>%
  mutate(CNIN=Classification.of.national.industry,
         iso3c=Code,
         country=Country,
         date=i) %>%
  select(iso3c,date, CNIN)
 
assign(paste("D1.3.MSC.CNIN",i,sep="_"), temp)

}

#do some customization for after 2017, where sheet slightly changes
D1.3.MSC.CNIN_2018 <- spi_loader(1,3,'CNIN', 2018,1) %>%
  mutate(CNIN=...2018...6,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, CNIN)

D1.3.MSC.CNIN_2019 <- spi_loader(1,3,'CNIN', 2019,1) %>%
  mutate(CNIN=...2019...7,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, CNIN)

#save to csv
bind_rows(D1.3.MSC.CNIN_2016, D1.3.MSC.CNIN_2017, D1.3.MSC.CNIN_2018,D1.3.MSC.CNIN_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.3.MSC.CNIN.csv", sep="/" ))

#########
# 1.4 CPI base year

#Consumer Price Index serves as indicators of inflation and reflects changes in the 
# cost of acquiring a fixed basket of goods and services by the average consumer.  
# Weights are usually derived from consumer expenditure surveys and the CPI base year 
# refers to the year the weights were derived.  It is recommended that the base year be
# changed periodically to reflect changes in expenditure structure.         
#########

D1.4.MSC.CPIBY<-read_excel(path=paste(excel_dir,"/D1. MSC/","/2016, 2017, & 2018 - D1.4.MSC.CPIBY - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

D1.4.MSC.CPIBY <- D1.4.MSC.CPIBY %>%
  mutate(CPIBY_2016=CPI.BY.OCT2016,
         CPIBY_2017=CPI.BY.OCT2017,
         CPIBY_2018=CPI.BY.OCT2018,
         iso3c=Code,
         country=Country) %>%
  select(iso3c, CPIBY_2016, CPIBY_2017, CPIBY_2018) %>%
  pivot_longer(cols=contains(as.character(2016:2018)),
               names_to='date',
               names_prefix='CPIBY_',
               values_to='CPIBY') %>%
  mutate(date=as.numeric(date)) %>%
  arrange(iso3c, date) 

#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D1.4.MSC.CPIBY_2019<-read_excel(path=paste(excel_dir,"/D1. MSC/","/2016, 2017, 2018 & 2019 - D1.4.MSC.CPIBY -REV.xlsx", sep=""),
                                sheet="2016-2019 data",
                                skip=1,
                                .name_repair = 'universal')

D1.4.MSC.CPIBY_2019 <- D1.4.MSC.CPIBY_2019 %>%
  mutate(CPIBY_2016=CPI.BY.OCT2016,
         CPIBY_2017=CPI.BY.OCT2017,
         CPIBY_2018=CPI.BY.OCT2018,
         CPIBY_2019=CPI.BY.DEC.2019,
         iso3c=Code,
         country=Country) %>%
  select(iso3c, CPIBY_2016, CPIBY_2017, CPIBY_2018,CPIBY_2019) %>%
  pivot_longer(cols=contains(as.character(2016:2019)),
               names_to='date',
               names_prefix='CPIBY_',
               values_to='CPIBY') %>%
  mutate(date=as.numeric(date)) %>%
  filter(date==2019) %>%
  arrange(iso3c, date) 

D1.4.MSC.CPIBY <- D1.4.MSC.CPIBY %>%
  bind_rows(D1.4.MSC.CPIBY_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) 


write_excel_csv(D1.4.MSC.CPIBY,
                path = paste(csv_dir, "D1.4.MSC.CPIBY.csv", sep="/" ))


#########
# 1.5 Classification of household consumption

# Classification of Individual Consumption According to Purpose (COICOP) 
# is used in household budget surveys, consumer price indices and international 
# comparisons of gross domestic product (GDP) and its component expenditures.  
# Although COICOP is not strictly linked to any particular model of consumer 
# behavior, the classification is designed to broadly reflect differences in 
# income elasticities.  It is an integral part of the SNA1993 and more detailed 
# subdivision of the classes provide comparability between countries and between 
# statistics in these different areas.   
#########


for (i in 2016:2019) {
  temp <- spi_loader(1,5,'HOUS', i,0) %>%
    mutate(HOUS=Classification.of.household.consumption,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, HOUS)
  
  assign(paste("D1.5.MSC.HOUS",i,sep="_"), temp)
  
}



#save to csv
bind_rows(D1.5.MSC.HOUS_2016, D1.5.MSC.HOUS_2017, D1.5.MSC.HOUS_2018, D1.5.MSC.HOUS_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.5.MSC.HOUS.csv", sep="/" ))



#########
# 1.6 Classification of status of employment 

#Classification of status of employment refers to employment data that are 
# compiled using the current international standard International Classification 
# of Status in Employment (ISCE-93).  It classifies jobs with respect to the type
# of explicit or implicit contract of employment between the job holder and the 
# economic unit in which he or she is employed.  Therefore, it aims to provide the
# basis for production of internationally comparable statistics on the employment 
# relationship, including the distinction between salaried employment and self-employment.   
#########


for (i in 2016:2019) {
  temp <- spi_loader(1,6,'EMPL', i,0) %>%
    mutate(EMPL=Classification.of.status.of.employment,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, EMPL)
  
  assign(paste("D1.6.MSC.EMPL",i,sep="_"), temp)
  
}




#save to csv
bind_rows(D1.6.MSC.EMPL_2016, D1.6.MSC.EMPL_2017, D1.6.MSC.EMPL_2018, D1.6.MSC.EMPL_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.6.MSC.EMPL.csv", sep="/" ))


#########
# 1.7 Central government accounting status

# Government finance accounting status refers to the accounting basis for 
# reporting central government financial data.  For many countries' government 
# finance data, have been consolidated into one set of accounts capturing all 
# the central government's fiscal activities and following noncash recording basis.  
# Budgetary central government accounts do not necessarily include all central government 
# units, the picture they provide of central government activities is usually incomplete.  
#########

for (i in 2016:2019) {
  temp <- spi_loader(1,7,'CGOV', i,0) %>%
    mutate(CGOV=Central.government.accounting.status,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, CGOV)
  
  assign(paste("D1.7.MSC.CGOV",i,sep="_"), temp)
  
}


#save to csv
bind_rows(D1.7.MSC.CGOV_2016, D1.7.MSC.CGOV_2017, D1.7.MSC.CGOV_2018, D1.7.MSC.CGOV_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.7.MSC.CGOV.csv", sep="/" ))



#########
# 1.8 Compilation of government finance statistics

# (GFSM) in use for compiling the data.  It provides guidelines on the institutional 
# structure of governments and the presentation of fiscal data in a format similar to 
# business accounting with a balance sheet and income statement plus guidelines on the 
# treatment of exchange rate and other valuation adjustments.  The latest manual GFSM2014 
# is harmonized with the SNA2008. 
#########

for (i in 2016:2019) {
  temp <- spi_loader(1,8,'FINA', i,0) %>%
    mutate(FINA=Compilation.of.government.finance.statistics,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, FINA)
  
  assign(paste("D1.8.MSC.FINA",i,sep="_"), temp)
  
}



#save to csv
bind_rows(D1.8.MSC.FINA_2016, D1.8.MSC.FINA_2017, D1.8.MSC.FINA_2018, D1.8.MSC.FINA_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.8.MSC.FINA.csv", sep="/" ))


#########
# 1.9 Compilation of monetary and financial statistics

# Compilation of monetary and financial statistics refers to the Monetary and Financial Statistics Manual 
# (MFSM) in use.  It covers concepts, definitions, classifications of financial instruments and sectors, and 
# accounting rules, and provides a comprehensive analytic framework for monetary and financial planning and policy 
# determination.  The Monetary and Finance Statistics: Compilation Guide (2008) provides detailed guidelines for 
# the compilation of monetary and financial statistics in addition to MFSM. 
#########

for (i in 2016:2019) {
  temp <- spi_loader(1,9,'MONY', i,1) %>%
    mutate(MONY=compilation.of.monetary.and.financial.statistics,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, MONY)
  
  assign(paste("D1.9.MSC.MONY",i,sep="_"), temp)
  
}



#save to csv
bind_rows(D1.9.MSC.MONY_2016, D1.9.MSC.MONY_2017, D1.9.MSC.MONY_2018, D1.9.MSC.MONY_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.9.MSC.MONY.csv", sep="/" ))


#########
# 1.10 SDDS/e-GDDS subscription

#Data Dissemination Standard (SDDS) and electronic General Data Dissemination Standard (e-GDDS) were 
#established by the International Monetary Fund (IMF) for member countries that have or that might seek 
#access to international capital markets, to guide them in providing their economic and financial data to the public.
#Although subscription is voluntary, the subscribing member needs to be committed to observing the standard and provide
#information about its data and data dissemination practices (metadata).  The metadata are posted on the IMF's SDDS and 
#e-GDDS websites.       
#########

for (i in 2016:2019) {
  temp <- spi_loader(1,10,'IDDS', i,1) %>%
    mutate(IDDS=SDDS.subsciption,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, IDDS)
  
  assign(paste("D1.10.MSC.IDDS",i,sep="_"), temp)
  
}



#save to csv
bind_rows(D1.10.MSC.IDDS_2016, D1.10.MSC.IDDS_2017, D1.10.MSC.IDDS_2018, D1.10.MSC.IDDS_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.10.MSC.IDDS.csv", sep="/" ))


#########
# 1.11 CRVS 

# Civil registration and vital statistics record the occurrence and characteristics of 
# vital events (births, deaths, marriage and divorce etc.) pertaining to the population and 
# serve as a main source of vital statistics. This identifies countries that report at least 
# 90 percent complete registries of vital (birth and death) statistics to the United Nations 
# Statistics Division and are reported in its Population and Vital Statistics Reports. 
# Countries with complete vital statistics registries may have more accurate and timely demographic indicators.      
#########

for (i in 2016:2019) {
  temp <- spi_loader(1,11,'CRVS', i,1) %>%
    mutate(CRVS=CRVS,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, CRVS)
  
  assign(paste("D1.11.MSC.CRVS",i,sep="_"), temp)
  
}


#save to csv
bind_rows(D1.11.MSC.CRVS_2016, D1.11.MSC.CRVS_2017, D1.11.MSC.CRVS_2018, D1.11.MSC.CRVS_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.11.MSC.CRVS.csv", sep="/" ))

#########
# 1.12 Business process

# The Generic Statistical Business Process Model (GSBPM) aims to describe 
# statistics production in a general and process-oriented way.  It is used 
# both within and between statistical offices as a common basis for work with 
# statistics production in different ways, such as quality, efficiency, standardization, 
# and process-orientation.  It is used for all types of surveys, and "business" is not 
# related to "business statistics" but refers to the statistical office, simply expressed.  
#########

for (i in 2016:2019) {
  temp <- spi_loader(1,12,'GSBP', i,1) %>%
    mutate(GSBP=Business.Process..GSBPM.,
           iso3c=Code,
           country=Country,
           date=i) %>%
    select(iso3c,date, GSBP)
  
  assign(paste("D1.12.MSC.GSBP",i,sep="_"), temp)
  
}



#save to csv
bind_rows(D1.12.MSC.GSBP_2016, D1.12.MSC.GSBP_2017, D1.12.MSC.GSBP_2018,D1.12.MSC.GSBP_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.12.MSC.GSBP.csv", sep="/" ))

###############################
# SPI Dimension 2: Censuses and Surveys (CS): 
###############################

 

#########
# 2.1 Population & Housing census
# Population censuses collect data on the size, distribution and composition of population and 
# information on a broad range of social and economic characteristics of the population.  It also 
# provides sampling frames for household and other surveys.  Housing censuses provide information 
# on the supply of housing units, the structural characteristics and facilities, and health and the 
# development of normal family living conditions.  Data obtained as part of the population census, 
# including data on homeless persons, are often used in the presentation and analysis of the results 
# of the housing census.  It is recommended that population and housing censuses be conducted at least every 10 years. 
#########



#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.1.CEN.POPU<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.1.CEN.POPU - REV.xlsx", sep=""),
                          sheet="2019 Data Template",
                          skip=2,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.1.CEN.POPU <- D2.1.CEN.POPU %>%
  mutate(POPU.CENSUS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T)) %>%
  mutate(POPU.CENSUS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T),
         iso3c=Code,
         country=Country...3,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, POPU.CENSUS) %>%
  filter(!is.na(iso3c))

#bind 2019 data to 2018 and previous
D2.1.CEN.POPU <- D2.1.CEN.POPU %>%
  group_by(iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())

write_excel_csv(D2.1.CEN.POPU,
                path = paste(csv_dir, "D2.1.CEN.POPU.csv", sep="/" ))



#########
# 2.2 Agriculture census

#Agriculture censuses collect information on agricultural activities, such as
#size of holding, land tenure, land use, employment and production, and provide
#basic structural data and sampling frames for agricultural surveys.  Censuses
#of agriculture normally involves collecting key structural data by complete
#enumeration of all agricultural holdings, in combination with more detailed
#structural data using sampling methods.  It is recommended that agricultural
#censuses be conducted at least every 10 years.
#########




#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.2.CEN.AGRI<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.2.CEN.AGRI2 - REV.xlsx", sep=""),
                          sheet="2019 Data",
                          skip=2,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.2.CEN.AGRI <- D2.2.CEN.AGRI %>%
  mutate(AGRI.CENSUS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T), 
         iso3c=Code,
         country=Country...3,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, AGRI.CENSUS) %>%
  filter(!is.na(iso3c))

#bind 2019 data to 2018 and previous
D2.2.CEN.AGRI <- D2.2.CEN.AGRI %>%
  group_by(iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())


write_excel_csv(D2.2.CEN.AGRI,
                path = paste(csv_dir, "D2.2.CEN.AGRI.csv", sep="/" ))

#########
# 2.3 Business/establishment census

# Business/establishment censuses provide valuable information on all economic
# activities, number of employed and size of establishments in the economy.
# Business Register information is establishment-based and includes business
# location, organization type (e.g. subsidiary or parent), industry
# classification, and operating data (e.g., receipts and employment).
#########


#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.3.CEN.BIZZ<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.3.CEN.BIZZ - REV.xlsx", sep=""),
                               sheet="2019 Data",
                               skip=2,
                               .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.3.CEN.BIZZ <- D2.3.CEN.BIZZ %>%
  mutate(BIZZ.CENSUS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, BIZZ.CENSUS) %>%
  filter(!is.na(iso3c))

#bind 2019 data to 2018 and previous
D2.3.CEN.BIZZ <- D2.3.CEN.BIZZ %>%
  group_by(iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())



write_excel_csv(D2.3.CEN.BIZZ,
                path = paste(csv_dir, "D2.3.CEN.BIZZ.csv", sep="/" ))


#########
# 2.4 Household Survey on income/consumption/expenditure/budget/Integrated Survey 

# These surveys collect data on household income (including income in kind),
# consumption and expenditure.  They typically include income, expenditure, and
# consumption surveys, household budget surveys, integrated surveys.  It is
# recommended that surveys on income and expenditure be conducted at least every
# 3 to 5 years.
#########

#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.4.SVY.HOUS<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.4.SVY.HOUS - REV.xlsx", sep=""),
                               sheet="2019 Data",
                               skip=2,
                               .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.4.SVY.HOUS <- D2.4.SVY.HOUS %>%
  mutate(HOUS.SURVEYS=gsub("^,*|(?<=,),|,*$", "", Houseshold.survey.on.income..consumption..expenditure..budget..Integrated.Survey, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, HOUS.SURVEYS)  %>%
  filter(!is.na(iso3c))

#bind 2019 data to 2018 and previous
D2.4.SVY.HOUS <- D2.4.SVY.HOUS %>%
  group_by( iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  arrange(iso3c) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())

write_excel_csv(D2.4.SVY.HOUS,
                path = paste(csv_dir, "D2.4.SVY.HOUS.csv", sep="/" ))

#########
# 2.5 Agriculture survey

# Agricultural surveys refer to surveys of agricultural holdings based on the
# sampling frames established by the agricultural census.  These are surveys on
# agricultural land, production, crops and livestock, aquaculture, labor and
# cost, and time use.  Some issues, such as gender and food security, are of
# interest to most agriculture surveys.
#########



#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.5.SVY.AGRI<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.5.SVY.AGRI - REV.xlsx", sep=""),
                               sheet="2019 Data",
                               skip=2,
                               .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.5.SVY.AGRI <- D2.5.SVY.AGRI %>%
  mutate(AGRI.SURVEYS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, AGRI.SURVEYS)  %>%
  filter(!is.na(iso3c))
#bind 2019 data to 2018 and previous
D2.5.SVY.AGRI <- D2.5.SVY.AGRI %>%
  group_by( iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  arrange( iso3c) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())


write_excel_csv(D2.5.SVY.AGRI,
                path = paste(csv_dir, "D2.5.SVY.AGRI.csv", sep="/" ))


#########
# 2.6 Labor Force Survey 

# Labor force survey is a standard household-based survey of work-related
# statistics at the national and sub-national employment or unemployment levels,
# rates or trends.  The surveys also provide the characteristics of the employed
# or unemployed, including labor force status by age or gender, breakdowns
# between employees and the self-employed, public versus private sector
# employment, multiple job-holding, hiring, job creation, and duration of
# unemployment.
#########


#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.6.SVY.LABR<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.6.SVY.LABR - REV.xlsx", sep=""),
                               sheet="2019 data",
                               skip=2,
                               .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.6.SVY.LABR <- D2.6.SVY.LABR %>%
  mutate(LABR.SURVEYS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, LABR.SURVEYS)  %>%
  filter(!is.na(iso3c))

#bind 2019 data to 2018 and previous
D2.6.SVY.LABR <- D2.6.SVY.LABR %>%
  group_by( iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  arrange( iso3c) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())



write_excel_csv(D2.6.SVY.LABR,
                path = paste(csv_dir, "D2.6.SVY.LABR.csv", sep="/" ))


#########
# 2.7 Health/Demographic survey

# Health surveys collect information on various aspects of health of
# populations, such as health expenditure, access, utilization, and outcomes.
# They typically include Demographic and Health Surveys.  It is recommended that
# health surveys be conducted at least every 3 to 5 years.
#########



#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.7.SVY.HLTH<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019 - D2.7.SVY.HLTH - REV.xlsx", sep=""),
                               sheet="2016-19 DCS DHS,MICS-formulas",
                               skip=1,
                               .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes


D2.7.SVY.HLTH <- D2.7.SVY.HLTH %>% #do some reshaping of this df to match previous version
  mutate_at(vars(starts_with('YR')), 
    funs(ifelse(. == 1, deparse(substitute(.)), NA)) # replace value with column name (year)
  ) %>%
  mutate_at(vars(starts_with('YR')), funs(gsub("YR", "", ., perl=T))) %>% #remove the leading "YR" from values
  unite(Years, starts_with('YR'), na.rm=T, sep=", ") %>%
  #create a string to match original
  mutate(HLTH.SURVEYS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T), 
         iso3c=Country,
         country=country.name,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, HLTH.SURVEYS)  %>%
  filter(!is.na(iso3c))

#bind 2019 data to 2018 and previous
D2.7.SVY.HLTH <- D2.7.SVY.HLTH %>%
  group_by( iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  arrange( iso3c) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())



write_excel_csv(D2.7.SVY.HLTH,
                path = paste(csv_dir, "D2.7.SVY.HLTH.csv", sep="/" ))

#########
# 2.8 Business/establishment survey

# The business/establishment survey provides information on employment, hours,
# and earnings of employees from a sample of business establishments including
# private and public, entities that are classified based on an establishment's
# principal activity from the business or establishment census.  Establishment
# surveys include surveys of businesses, farms, and institutions.  They may ask
# for information about the establishment itself and/or employee characteristics
# and demographics.
#########


#add in 2019 data.  Because the data doesn't include HIC countries, we append this to the original database
D2.8.SVY.BIZZ<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, 2018 & 2019- D2.8.SVY.BIZZ - REV.xlsx", sep=""),
                               sheet="2019 data",
                               skip=2,
                               .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.8.SVY.BIZZ <- D2.8.SVY.BIZZ %>%
  mutate(BIZZ.SURVEYS=gsub("^,*|(?<=,),|,*$", "", Years, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2019) %>% #remove leading and trailing commas
  select(iso3c,database_last_updated, BIZZ.SURVEYS)  %>%
  filter(!is.na(iso3c))
#bind 2019 data to 2018 and previous
D2.8.SVY.BIZZ <- D2.8.SVY.BIZZ %>%
  group_by( iso3c) %>% #keep latest year for each country
  filter(database_last_updated==max(database_last_updated)) %>%
  ungroup() %>%
  arrange( iso3c) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything())


write_excel_csv(D2.8.SVY.BIZZ,
                path = paste(csv_dir, "D2.8.SVY.BIZZ.csv", sep="/" ))

###############################
# SPI Dimension 3: Availability of Key Indicators (AKI):
###############################

##############
# Indicator 2: Hunger
##############
#read in data from FAO (http://www.fao.org/faostat/en/#data/FS), then link to FAO country codes database
aki_2_df <- read_csv(file=paste(excel_dir,"D3.AKI","FAOSTAT_data_5-1-2020.csv", sep="/"))
aki_2_df_ccodes <- read_csv(file=paste(excel_dir,"D3.AKI","FAOSTAT_data_5-1-2020_country_codes.csv", sep="/")) %>%
  mutate(Area=Country)

aki_2_df <- aki_2_df %>%
  left_join(aki_2_df_ccodes)


write_excel_csv(aki_2_df,
                path = paste(csv_dir, "D3.2.FIES.csv", sep="/" ))
##############
# Indicator 5: Maternal Mortality
##############
# Pull WHO data on Maternal Mortality country

#now make request using API
aki_5_df <- read_csv(file="https://apps.who.int/gho/athena/api/GHO/MDG_0000000026?format=csv")
write_excel_csv(aki_5_df,
                path = paste(csv_dir, "D3.5.MMR.csv", sep="/" ))



##############
# Indicator 3: Child Mortality
##############
#call the api for mortality under 5 data from unicef
#now make request using API

unicef_url = "https://api.data.unicef.org/sdmx/Rest/data/UNICEF,CME_DF,1.0/.MRY0T4._T../?startPeriod=2000&endPeriod=2019"
dataset <- readSDMX(unicef_url)
MORT <- as.data.frame(dataset) %>%
  filter(OBS_STATUS=="IN")

###############
# Indicator 6: Water Data
###############

aki_6_df <- read_excel(path=paste(excel_dir,"D3.AKI","JMP_2019_WLD (1).xlsx", sep="/"),
                       sheet="Water", 
                       skip=2)
###############
# Indicator 7: Electricity Data
###############
aki_7_df <- read_excel(path=paste(excel_dir,"D3.AKI","WB electrification database - Surveys + Access rates.xlsx", sep="/"),
                       sheet="Collected Surveys")

write_excel_csv(aki_7_df,
                path = paste(csv_dir, "D3.7.ELEC.csv", sep="/" ))

###############
# Indicator 17: Quarterly GDP
###############

#written by Yasmina Hmamouchi




#######################################
#Define path and url sections
########################################

urlCompactData <- "http://dataservices.imf.org/REST/SDMX_XML.svc/CompactData/IFS/Q."
urlDateRange <- "?startPeriod=2009Q1&endPeriod=2019Q4"
indicator <- ".NGDP_XDC"

#CountriesCodes
AFtoKM <- "AF+AL+DZ+AO+AI+AG+AR+AM+AW+AU+AT+AZ+BS+BH+BD+BB+BY+BE+BZ+BJ+BM+BT+BO+BA+BW+BR+BN+BG+BF+BI+CV+KH+CM+CA+KY+CF+TD+CL+HK+MO+CN+CO+KM"
KMtoGW <- "KM+CD+CG+CR+CI+HR+CU+CW+CY+CZ+DK+DJ+DM+DO+EC+EG+SV+GQ+ER+EE+SZ+ET+FO+FJ+FI+FR+PF+GA+GM+GE+DE+GH+GI+GR+GL+GD+GP+GU+GT+GG+GF+GN+GW"
GYtoFM <- "GY+HT+HN+HU+IS+IN+ID+IR+IQ+IE+IM+IL+IT+JM+JP+JE+JO+KZ+KE+KI+KR+XK+KW+KG+LA+LV+LB+LS+LR+LY+LT+LU+MG+MW+MY+MV+ML+MT+MH+MQ+MR+MU+MX+FM"
MDtoSG <- "MD+MN+ME+MS+MA+MZ+MM+NA+NR+NP+AN+NL+NC+NZ+NI+NE+NG+MK+NO+OM+PK+PW+PA+PG+PY+PE+PH+PL+PT+QA+RE+RO+RU+RW+PM+WS+SM+ST+SA+SN+RS+SC+SL+SG"
SXtoZW <- "SX+SK+SI+SB+SO+ZA+SS+ES+LK+KN+LC+VC+SD+SR+SE+CH+SY+TW+TJ+TZ+TH+TL+TG+TO+TT+TN+TR+TM+TC+TV+UG+UA+AE+GB+US+UY+UZ+VU+VE+VN+PS+YE+ZM+ZW"


########################################
#Load countries data into 5 different files 
########################################

apiDataUrl <- paste(urlCompactData,AFtoKM,indicator,urlDateRange,sep="") 
dataset <- readSDMX(apiDataUrl)
GDPAFtoCN <- as.data.frame(dataset)

apiDataUrl <- paste(urlCompactData,KMtoGW,indicator,urlDateRange,sep="") 
dataset <- readSDMX(apiDataUrl)
GDPKMtoGW <- as.data.frame(dataset)

apiDataUrl <- paste(urlCompactData,GYtoFM,indicator,urlDateRange,sep="") 
dataset <- readSDMX(apiDataUrl)
GDPGYtoFM <- as.data.frame(dataset)

apiDataUrl <- paste(urlCompactData,MDtoSG,indicator,urlDateRange,sep="") 
dataset <- readSDMX(apiDataUrl)
GDPMDtoSG <- as.data.frame(dataset)

apiDataUrl <- paste(urlCompactData,SXtoZW,indicator,urlDateRange,sep="") 
dataset <- readSDMX(apiDataUrl)
GDPSXtoZW <- as.data.frame(dataset)


#Merge Files to one
D3.17.QUART.GDP <- bind_rows(GDPAFtoCN, GDPKMtoGW, GDPGYtoFM, GDPMDtoSG, GDPSXtoZW)
write_excel_csv(D3.17.QUART.GDP,
                path = paste(csv_dir, "D3.17.QUART.GDP.csv", sep="/" ))



###############################
# SPI Dimension 4: Dissemination Practices and Openness (DPO):
###############################


#TWEAK SPI LOADER USED ABOVE FOR DIMENSION 4

spi_loader_4 <- function(variable_num1, variable_num2,variable_name, year, skip) {
  read_excel(path=paste(excel_dir,"/D", variable_num1,". DPO/",year, " - D",paste(variable_num1,variable_num2,sep="."),".SC.DPO.",variable_name,".BN - REV.xlsx", sep=""),
             sheet=paste(year, "data", sep=" "),
             skip=skip,
             .name_repair = 'universal') 
}



#########
# 4.1 NSO has an Advance Release Calendar and it is published 

# This indicator refers to a dissemination practice for relevant statistical
# data in accordance to the published advance release calendar.  Its presence
# provides information on upcoming releases in advance and creates public
# awareness; this will lead to more discipline and accountability from the
# statistical office.
#########




D4.1.SC.DPO.CALD_2016 <- spi_loader_4(4,1,'CALD', 2016,2) %>%
  mutate(CALD=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, CALD)

D4.1.SC.DPO.CALD_2017 <- spi_loader_4(4,1,'CALD', 2017,2) %>%
  mutate(CALD=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, CALD)

D4.1.SC.DPO.CALD_2018 <- spi_loader_4(4,1,'CALD', 2018,2) %>%
  mutate(CALD=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, CALD)

D4.1.SC.DPO.CALD_2019 <- spi_loader_4(4,1,'CALD', 2019,0) %>%
  mutate(CALD=NSO.Advance.Release.Calendar,
         CALD_text=...4,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, CALD, CALD_text)

#save to csv
bind_rows(D4.1.SC.DPO.CALD_2016, D4.1.SC.DPO.CALD_2017, D4.1.SC.DPO.CALD_2018, D4.1.SC.DPO.CALD_2019) %>%
  arrange(iso3c, date) %>% 
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.1.SC.DPO.CALD.csv", sep="/" ))


#########
#  4.2 NSO has a listing of surveys and microdata sets (or NADA)

#NSO has a listing of surveys and microdata sets that can provide the necessary
#data and reference for follow-up.  Upon well-defined request and procedure per
#the national law and practice, users and practitioners can obtain the data
#collected from the households and businesses when needed.
#########


D4.2.SC.DPO.NADA_2016 <- spi_loader_4(4,2,'NADA', 2016,2) %>%
  mutate(NADA=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, NADA)

D4.2.SC.DPO.NADA_2017 <- spi_loader_4(4,2,'NADA', 2017,2) %>%
  mutate(NADA=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, NADA)

D4.2.SC.DPO.NADA_2018 <- spi_loader_4(4,2,'NADA', 2018,2) %>%
  mutate(NADA=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, NADA)

D4.2.SC.DPO.NADA_2019 <- spi_loader_4(4,2,'NADA', 2019,0) %>%
  mutate(NADA=NSO.listing.of.surveys.and.microdata.sets.or.NADA.,
         NADA_text=...4,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, NADA, NADA_text)

#save to csv
bind_rows(D4.2.SC.DPO.NADA_2016, D4.2.SC.DPO.NADA_2017, D4.2.SC.DPO.NADA_2018, D4.2.SC.DPO.NADA_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.2.SC.DPO.NADA.csv", sep="/" ))


#########
# 4.3 NSO has a data portal

# This indicator refers to a web-based or stand-alone platform or tools that is
# maintained by the NSO and provides access to the indicators and related
# metadata in systematic way.
#########


D4.3.SC.DPO.PORT_2016 <- spi_loader_4(4,3,'PORT', 2016,2) %>%
  mutate(PORT=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, PORT)

D4.3.SC.DPO.PORT_2017 <- spi_loader_4(4,3,'PORT', 2017,2) %>%
  mutate(PORT=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, PORT)

D4.3.SC.DPO.PORT_2018 <- spi_loader_4(4,3,'PORT', 2018,2) %>%
  mutate(PORT=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, PORT)

D4.3.SC.DPO.PORT_2019 <- spi_loader_4(4,3,'PORT', 2019,0) %>%
  mutate(PORT=NSO.data.portal,
         PORT_text=...5,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, PORT, PORT_text)

#save to csv
bind_rows(D4.3.SC.DPO.PORT_2016, D4.3.SC.DPO.PORT_2017, D4.3.SC.DPO.PORT_2018, D4.3.SC.DPO.PORT_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.3.SC.DPO.PORT.csv", sep="/" ))


#########
# 4.4 Timeseries indicators are available for download in reusable format for free

# This indicator will promote usage among the users and bring accountability to
# the NSO.  There are several different formats in which a user can access the
# data, such as Excel, CSV, and API etc.
#########

D4.4.SC.DPO.TIME_2016 <- spi_loader_4(4,4,'TIME', 2016,2) %>%
  mutate(TIME=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, TIME)

D4.4.SC.DPO.TIME_2017 <- spi_loader_4(4,4,'TIME', 2017,2) %>%
  mutate(TIME=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, TIME)

D4.4.SC.DPO.TIME_2018 <- spi_loader_4(4,4,'TIME', 2018,2) %>%
  mutate(TIME=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, TIME)

D4.4.SC.DPO.TIME_2019 <- spi_loader_4(4,4,'TIME', 2019,0) %>%
  mutate(TIME=Timeseries.indicators.available.for.download.in.reusable.format.for.free,
         TIME_text=...5,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, TIME, TIME_text)

#save to csv
bind_rows(D4.4.SC.DPO.TIME_2016, D4.4.SC.DPO.TIME_2017, D4.4.SC.DPO.TIME_2018,D4.4.SC.DPO.TIME_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.4.SC.DPO.TIME.csv", sep="/" ))


#########
# 4.5 Metadata is available providing definition, methodology, standards or classifications for existing data series

# Statistical systems must be open and transparent about their methods and
# procedures and provide access to adequate metadata - detailed descriptions of
# the methods and procedures used to produce the data.
#########

D4.5.SC.DPO.META_2016 <- spi_loader_4(4,5,'META', 2016,2) %>%
  mutate(META=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, META)

D4.5.SC.DPO.META_2017 <- spi_loader_4(4,5,'META', 2017,2) %>%
  mutate(META=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, META)

D4.5.SC.DPO.META_2018 <- spi_loader_4(4,5,'META', 2018,2) %>%
  mutate(META=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, META)

D4.5.SC.DPO.META_2019 <- spi_loader_4(4,5,'META', 2019,0) %>%
  mutate(META=Metadata.available..definition..methodology..standards..classifications.,
         META_text=...5,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, META,META_text)

#save to csv
bind_rows(D4.5.SC.DPO.META_2016, D4.5.SC.DPO.META_2017, D4.5.SC.DPO.META_2018,D4.5.SC.DPO.META_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.5.SC.DPO.META.csv", sep="/" ))



#########
# 4.6 NSO has conducted a user satisfaction survey

# Through this indicator a NSO can improve its engagement and dissemination
# practice by seeking regular feedback from users and then making necessary
# adjustments.  It is also a good practice to continually monitor the changing
# data landscape and user needs as well as evolving technologies.
#########


D4.6.SC.DPO.USER_2016 <- spi_loader_4(4,6,'USER', 2016,2) %>%
  mutate(USER=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, USER)

D4.6.SC.DPO.USER_2017 <- spi_loader_4(4,6,'USER', 2017,2) %>%
  mutate(USER=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, USER)

D4.6.SC.DPO.USER_2018 <- spi_loader_4(4,6,'USER', 2018,2) %>%
  mutate(USER=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, USER)

D4.6.SC.DPO.USER_2019 <- spi_loader_4(4,6,'USER', 2019,0) %>%
  mutate(USER=NSO.user.satisfaction.survey,
         USER_text=...5,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, USER,USER_text)

#save to csv
bind_rows(D4.6.SC.DPO.USER_2016, D4.6.SC.DPO.USER_2017, D4.6.SC.DPO.USER_2018,D4.6.SC.DPO.USER_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.6.SC.DPO.USER.csv", sep="/" ))


#########
# 4.7 Geospatial data available on relevant agency website

# Geospatial data available on relevant agency website refers to geo-referenced,
# location-based disaggregated data from satellite.  Geospatial data are often
# used in combination with administrative level national and sub-national units.
#########


D4.7.SC.DPO.GEOS_2016 <- spi_loader_4(4,7,'GEOS', 2016,2) %>%
  mutate(GEOS=...2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c,date, GEOS)

D4.7.SC.DPO.GEOS_2017 <- spi_loader_4(4,7,'GEOS', 2017,2) %>%
  mutate(GEOS=...2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c,date, GEOS)

D4.7.SC.DPO.GEOS_2018 <- spi_loader_4(4,7,'GEOS', 2018,2) %>%
  mutate(GEOS=...2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c,date, GEOS)

D4.7.SC.DPO.GEOS_2019 <- spi_loader_4(4,7,'GEOS', 2019,0) %>%
  mutate(GEOS=Geospatial.data.available.on.NSO.website,
         GEOS_text=...5,
         iso3c=Code,
         country=Country,
         date=2019) %>%
  select(iso3c,date, GEOS, GEOS_text)

#save to csv
bind_rows(D4.7.SC.DPO.GEOS_2016, D4.7.SC.DPO.GEOS_2017, D4.7.SC.DPO.GEOS_2018,D4.7.SC.DPO.GEOS_2019) %>%
  arrange(iso3c, date) %>%
  left_join(country_metadata) %>%
  select(colnames(country_metadata), everything()) %>%
  write_excel_csv(
    path = paste(csv_dir, "D4.7.SC.DPO.GEOS.csv", sep="/" ))

