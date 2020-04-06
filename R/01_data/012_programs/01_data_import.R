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
         date=2016) %>%
  select(iso3c, country,date, CNIN)

D1.3.MSC.CNIN_2018 <- spi_loader(1,3,'CNIN', 2018,1) %>%
  mutate(CNIN=...2018...6,
         iso3c=Code,
         country=Country,
         date=2016) %>%
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
         date=2016) %>%
  select(iso3c, country,date, HOUS)

D1.5.MSC.HOUS_2018 <- spi_loader(1,5,'HOUS', 2018,0) %>%
  mutate(HOUS=Classification.of.household.consumption,
         iso3c=Code,
         country=Country,
         date=2016) %>%
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
         date=2016) %>%
  select(iso3c, country,date, EMPL)

D1.6.MSC.EMPL_2018 <- spi_loader(1,6,'EMPL', 2018,0) %>%
  mutate(EMPL=Classification.of.status.of.employment,
         iso3c=Code,
         country=Country,
         date=2016) %>%
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
         date=2016) %>%
  select(iso3c, country,date, CGOV)

D1.7.MSC.CGOV_2018 <- spi_loader(1,7,'CGOV', 2018,0) %>%
  mutate(CGOV=Central.government.accounting.status,
         iso3c=Code,
         country=Country,
         date=2016) %>%
  select(iso3c, country,date, CGOV)


#save to csv
bind_rows(D1.7.MSC.CGOV_2016, D1.7.MSC.CGOV_2017, D1.7.MSC.CGOV_2018) %>%
  arrange(iso3c, date) %>%
  write_excel_csv(
    path = paste(csv_dir, "D1.7.MSC.CGOV.csv", sep="/" ))



#########
# Compilation of government finance statistics
#########
D1.8.MSC.FINA<-read_excel(path=paste(excel_dir,"/D1. MSC/",year, " - D1.8.MSC.FINA - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# Compilation of monetary and financial statistics
D1.9.MSC.MONY<-read_excel(path=paste(excel_dir,"/D1. MSC/",year, " - D1.9.MSC.MONY - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
#########
# SDDS/e-GDDS subscription
#########
D1.10.MSC.IDDS<-read_excel(path=paste(excel_dir,"/D1. MSC/",year, " - D1.10.MSC.IDDS - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
#########
# CRVS 
#########
D1.11.MSC.CRVS<-read_excel(path=paste(excel_dir,"/D1. MSC/",year, " - D1.11.MSC.CRVS - REV.xlsx", sep=""),
                           sheet=paste(year, "data", sep=" "),
                           skip=1)
#########
# Business process
#########
D1.12.MSC.GSBP<-read_excel(path=paste(excel_dir,"/D1. MSC/",year, " - D1.12.MSC.GSBP - REV.xlsx", sep=""),
                           sheet=paste(year, "data", sep=" "),
                           skip=1)
###############################
# SPI Dimension 2: Censuses and Surveys (CS): 
###############################


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


