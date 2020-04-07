########################################
# Input raw data files/Excel files used in analysis
# Brian Stacy
# March 27, 2020
########################################

# Load Packages
library(tidyverse)
library(readxl)


# Directory for SPI excel files
excel_dir <- "C:/Users/wb469649/Documents/Github/SPI_AKI/Data"

# Directory for SPI csv files that are created
csv_dir <- "C:/Users/wb469649/Documents/Github/SPI_AKI/R/01_data/011_rawdata"

# year of data collection
year <- 2018

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
# System of National Accounts in use
#########
D1.1.MSC.SNAU_2016 <- spi_loader(1,1,'SNAU', 2016,1) %>%
  mutate(SNAU=SNA.in.use..2016,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, SNAU)

D1.1.MSC.SNAU_2017 <- spi_loader(1,1,'SNAU', 2017,1) %>%
  mutate(SNAU=SNA.in.use..2017,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, SNAU)

D1.1.MSC.SNAU_2018 <- spi_loader(1,1,'SNAU', 2018,1) %>%
  mutate(SNAU=SNA.in.use..2018,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, SNAU)

#save to csv
bind_rows(D1.1.MSC.SNAU_2016, D1.1.MSC.SNAU_2017, D1.1.MSC.SNAU_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
                  path = paste(csv_dir, "D1.1.MSC.SNAU.csv", sep="/" ))



#########
# National Accounts base year 
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
  select(iso3c, country, NABY_2016, NABY_2017, NABY_2018) %>%
  pivot_longer(cols=contains(as.character(2016:2018)),
               names_to='date',
               names_prefix='NABY_',
               values_to='NABY') %>%
  mutate(date=as.numeric(date)) %>%
  arrange(iso3c, date) 
  
  

write_excel_csv(D1.2.MSC.NABY,
                path = paste(csv_dir, "D1.2.MSC.NABY.csv", sep="/" ))
#########
# Classification of national industry
#########
D1.3.MSC.CNIN_2016 <- spi_loader(1,3,'CNIN', 2016,0) %>%
  mutate(CNIN=Classification.of.national.industry,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, CNIN)

D1.3.MSC.CNIN_2017 <- spi_loader(1,3,'CNIN', 2017,0) %>%
  mutate(CNIN=Classification.of.national.industry,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, CNIN)

D1.3.MSC.CNIN_2018 <- spi_loader(1,3,'CNIN', 2018,1) %>%
  mutate(CNIN=...2018...6,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, CNIN)


#save to csv
bind_rows(D1.3.MSC.CNIN_2016, D1.3.MSC.CNIN_2017, D1.3.MSC.CNIN_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.3.MSC.CNIN.csv", sep="/" ))

#########
# CPI base year
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
  select(iso3c, country, CPIBY_2016, CPIBY_2017, CPIBY_2018) %>%
  pivot_longer(cols=contains(as.character(2016:2018)),
               names_to='date',
               names_prefix='CPIBY_',
               values_to='CPIBY') %>%
  mutate(date=as.numeric(date)) %>%
  arrange(iso3c, date) 



write_excel_csv(D1.4.MSC.CPIBY,
                path = paste(csv_dir, "D1.4.MSC.CPIBY.csv", sep="/" ))


#########
# Classification of household consumption
#########

D1.5.MSC.HOUS_2016 <- spi_loader(1,5,'HOUS', 2016,0) %>%
  mutate(HOUS=Classification.of.household.consumption,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, HOUS)

D1.5.MSC.HOUS_2017 <- spi_loader(1,5,'HOUS', 2017,0) %>%
  mutate(HOUS=Classification.of.household.consumption,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, HOUS)

D1.5.MSC.HOUS_2018 <- spi_loader(1,5,'HOUS', 2018,0) %>%
  mutate(HOUS=Classification.of.household.consumption,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, HOUS)


#save to csv
bind_rows(D1.5.MSC.HOUS_2016, D1.5.MSC.HOUS_2017, D1.5.MSC.HOUS_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.5.MSC.HOUS.csv", sep="/" ))



#########
# Classification of status of employment 
#########

D1.6.MSC.EMPL_2016 <- spi_loader(1,6,'EMPL', 2016,0) %>%
  mutate(EMPL=Classification.of.status.of.employment,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, EMPL)

D1.6.MSC.EMPL_2017 <- spi_loader(1,6,'EMPL', 2017,0) %>%
  mutate(EMPL=Classification.of.status.of.employment,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, EMPL)

D1.6.MSC.EMPL_2018 <- spi_loader(1,6,'EMPL', 2018,0) %>%
  mutate(EMPL=Classification.of.status.of.employment,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, EMPL)


#save to csv
bind_rows(D1.6.MSC.EMPL_2016, D1.6.MSC.EMPL_2017, D1.6.MSC.EMPL_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.6.MSC.EMPL.csv", sep="/" ))


#########
# Central government accounting status
#########

D1.7.MSC.CGOV_2016 <- spi_loader(1,7,'CGOV', 2016,0) %>%
  mutate(CGOV=Central.government.accounting.status,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, CGOV)

D1.7.MSC.CGOV_2017 <- spi_loader(1,7,'CGOV', 2017,0) %>%
  mutate(CGOV=Central.government.accounting.status,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, CGOV)

D1.7.MSC.CGOV_2018 <- spi_loader(1,7,'CGOV', 2018,0) %>%
  mutate(CGOV=Central.government.accounting.status,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, CGOV)


#save to csv
bind_rows(D1.7.MSC.CGOV_2016, D1.7.MSC.CGOV_2017, D1.7.MSC.CGOV_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.7.MSC.CGOV.csv", sep="/" ))



#########
# Compilation of government finance statistics
#########


D1.8.MSC.FINA_2016 <- spi_loader(1,8,'FINA', 2016,0) %>%
  mutate(FINA=Compilation.of.government.finance.statistics,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, FINA)

D1.8.MSC.FINA_2017 <- spi_loader(1,8,'FINA', 2017,0) %>%
  mutate(FINA=Compilation.of.government.finance.statistics,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, FINA)

D1.8.MSC.FINA_2018 <- spi_loader(1,8,'FINA', 2018,0) %>%
  mutate(FINA=Compilation.of.government.finance.statistics,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, FINA)


#save to csv
bind_rows(D1.8.MSC.FINA_2016, D1.8.MSC.FINA_2017, D1.8.MSC.FINA_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.8.MSC.FINA.csv", sep="/" ))


#########
# Compilation of monetary and financial statistics
#########
D1.9.MSC.MONY_2016 <- spi_loader(1,9,'MONY', 2016,1) %>%
  mutate(MONY=compilation.of.monetary.and.financial.statistics,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, MONY)

D1.9.MSC.MONY_2017 <- spi_loader(1,9,'MONY', 2017,1) %>%
  mutate(MONY=compilation.of.monetary.and.financial.statistics,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, MONY)

D1.9.MSC.MONY_2018 <- spi_loader(1,9,'MONY', 2018,1) %>%
  mutate(MONY=compilation.of.monetary.and.financial.statistics,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, MONY)


#save to csv
bind_rows(D1.9.MSC.MONY_2016, D1.9.MSC.MONY_2017, D1.9.MSC.MONY_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.9.MSC.MONY.csv", sep="/" ))


#########
# SDDS/e-GDDS subscription
#########


D1.10.MSC.IDDS_2016 <- spi_loader(1,10,'IDDS', 2016,1) %>%
  mutate(IDDS=SDDS.subsciption,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, IDDS)

D1.10.MSC.IDDS_2017 <- spi_loader(1,10,'IDDS', 2017,1) %>%
  mutate(IDDS=SDDS.subsciption,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, IDDS)

D1.10.MSC.IDDS_2018 <- spi_loader(1,10,'IDDS', 2018,1) %>%
  mutate(IDDS=SDDS.subsciption,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, IDDS)


#save to csv
bind_rows(D1.10.MSC.IDDS_2016, D1.10.MSC.IDDS_2017, D1.10.MSC.IDDS_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.10.MSC.IDDS.csv", sep="/" ))


#########
# CRVS 
#########

D1.11.MSC.CRVS_2016 <- spi_loader(1,11,'CRVS', 2016,1) %>%
  mutate(CRVS=CRVS,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, CRVS)

D1.11.MSC.CRVS_2017 <- spi_loader(1,11,'CRVS', 2017,1) %>%
  mutate(CRVS=CRVS,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, CRVS)

D1.11.MSC.CRVS_2018 <- spi_loader(1,11,'CRVS', 2018,1) %>%
  mutate(CRVS=CRVS,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, CRVS)


#save to csv
bind_rows(D1.11.MSC.CRVS_2016, D1.11.MSC.CRVS_2017, D1.11.MSC.CRVS_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.11.MSC.CRVS.csv", sep="/" ))

#########
# Business process
#########

D1.12.MSC.GSBP_2016 <- spi_loader(1,12,'GSBP', 2016,1) %>%
  mutate(GSBP=Business.Process..GSBPM.,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, GSBP)

D1.12.MSC.GSBP_2017 <- spi_loader(1,12,'GSBP', 2017,1) %>%
  mutate(GSBP=Business.Process..GSBPM.,
         iso3c=Code,
         country=Country,
         date=2017) %>%
  select(iso3c, country,date, GSBP)

D1.12.MSC.GSBP_2018 <- spi_loader(1,12,'GSBP', 2018,1) %>%
  mutate(GSBP=Business.Process..GSBPM.,
         iso3c=Code,
         country=Country,
         date=2018) %>%
  select(iso3c, country,date, GSBP)


#save to csv
bind_rows(D1.12.MSC.GSBP_2016, D1.12.MSC.GSBP_2017, D1.12.MSC.GSBP_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.12.MSC.GSBP.csv", sep="/" ))

###############################
# SPI Dimension 2: Censuses and Surveys (CS): 
###############################



#########
# Population & Housing census
#########

D2.1.CEN.POPU<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.1.CEN.POPU - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.1.CEN.POPU <- D2.1.CEN.POPU %>%
  mutate(POPU.CENSUS=gsub("^,*|(?<=,),|,*$", "", ..2018..Population...Housing.census, perl=T)) %>%
  mutate(POPU.CENSUS=gsub("^,*|(?<=,),|,*$", "", ..2018..Population...Housing.census, perl=T),
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, POPU.CENSUS) %>%
  filter(!is.na(country))

 

write_excel_csv(D2.1.CEN.POPU,
                path = paste(csv_dir, "D2.1.CEN.POPU", sep="/" ))



#########
# Agriculture census
#########


D2.2.CEN.AGRI<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.2.CEN.AGRI - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.2.CEN.AGRI <- D2.2.CEN.AGRI %>%
  mutate(AGRI.CENSUS=gsub("^,*|(?<=,),|,*$", "", AGRI.CENSUS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, AGRI.CENSUS) %>%
  filter(!is.na(country))



write_excel_csv(D2.2.CEN.AGRI,
                path = paste(csv_dir, "D2.2.CEN.AGRI.csv", sep="/" ))

#########
# Business/establishment census
#########

D2.3.CEN.BIZZ<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.3.CEN.BIZZ - REV.xlsx", sep=""),
                          sheet="2016 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.3.CEN.BIZZ <- D2.3.CEN.BIZZ %>%
  mutate(BIZZ.CENSUS=gsub("^,*|(?<=,),|,*$", "", BIZZ.CENSUS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, BIZZ.CENSUS) %>%
  filter(!is.na(country))



write_excel_csv(D2.3.CEN.BIZZ,
                path = paste(csv_dir, "D2.3.CEN.BIZZ.csv", sep="/" ))


#########
# Household Survey on income/consumption/expenditure/budget/Integrated Survey 
#########

D2.4.SVY.HOUS<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.4.SVY.HOUS - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.4.SVY.HOUS <- D2.4.SVY.HOUS %>%
  mutate(HOUS.SURVEYS=gsub("^,*|(?<=,),|,*$", "", HOUS.SURVEYS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, HOUS.SURVEYS)  %>%
  filter(!is.na(country))



write_excel_csv(D2.4.SVY.HOUS,
                path = paste(csv_dir, "D2.4.SVY.HOUS.csv", sep="/" ))

#########
# Agriculture survey
#########

D2.5.SVY.AGRI<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.5.SVY.AGRI - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.5.SVY.AGRI <- D2.5.SVY.AGRI %>%
  mutate(AGRI.SURVEYS=gsub("^,*|(?<=,),|,*$", "", AGRI.SURVEYS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, AGRI.SURVEYS)  %>%
  filter(!is.na(country))



write_excel_csv(D2.5.SVY.AGRI,
                path = paste(csv_dir, "D2.5.SVY.AGRI.csv", sep="/" ))


#########
# Labor Force Survey 
#########

D2.6.SVY.LABR<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.6.SVY.LABR - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.6.SVY.LABR <- D2.6.SVY.LABR %>%
  mutate(LABR.SURVEYS=gsub("^,*|(?<=,),|,*$", "", LABR.SURVEYS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, LABR.SURVEYS)  %>%
  filter(!is.na(country))



write_excel_csv(D2.6.SVY.LABR,
                path = paste(csv_dir, "D2.6.SVY.LABR.csv", sep="/" ))


#########
# Health/Demographic survey
#########

D2.7.SVY.HLTH<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.7.SVY.HLTH - REV.xlsx", sep=""),
                          sheet="2016 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.7.SVY.HLTH <- D2.7.SVY.HLTH %>%
  mutate(HLTH.SURVEYS=gsub("^,*|(?<=,),|,*$", "", HLTH.SURVEYS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, HLTH.SURVEYS)  %>%
  filter(!is.na(country))



write_excel_csv(D2.7.SVY.HLTH,
                path = paste(csv_dir, "D2.7.SVY.HLTH.csv", sep="/" ))

#########
# Business/establishment survey
#########

D2.8.SVY.BIZZ<-read_excel(path=paste(excel_dir,"/D2. CS/","/2016, 2017, & 2018 - D2.8.SVY.BIZZ - REV.xlsx", sep=""),
                          sheet="2016-2018 data",
                          skip=1,
                          .name_repair = 'universal')

#data contains values of past census years, (i.e. ,1987, 1997, etc), need to clean these for our purposes
D2.8.SVY.BIZZ <- D2.8.SVY.BIZZ %>%
  mutate(BIZZ.SURVEYS=gsub("^,*|(?<=,),|,*$", "", BIZZ.SURVEYS, perl=T), 
         iso3c=Code,
         country=Country,
         database_last_updated=2018) %>% #remove leading and trailing commas
  select(iso3c, country,database_last_updated, BIZZ.SURVEYS)  %>%
  filter(!is.na(country))



write_excel_csv(D2.8.SVY.BIZZ,
                path = paste(csv_dir, "D2.8.SVY.BIZZ.csv", sep="/" ))

###############################
# SPI Dimension 3: Availability of Key Indicators (AKI):
###############################

###############
# Indicator 7: Water Data
###############

aki_7_df <- read_excel(path=paste(excel_dir,"JMP_2019_WLD (1).xlsx", sep="/"),
                       sheet="Water", 
                       skip=2)


###############################
# SPI Dimension 4: Dissemination Practices and Openness (DPO):
###############################


