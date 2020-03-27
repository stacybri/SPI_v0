########################################
# Input raw data files/Excel files used in analysis
# Brian Stacy
# March 27, 2020
########################################

# Load Packages
library(tidyverse)
library(readxl)


# Directory for SPI excel files
dir <- "C:/Users/wb469649/OneDrive - WBG/DECIS/SPI_AKI/Data"

# year of data collection
year <- 2018

###############################
# SPI Dimension 1: Methodology, Standards and Classifications (MSC): 
###############################

# System of National Accounts in use
D1.1.MSC.SNAU<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.1.MSC.SNAU - REV.xlsx", sep=""),
                     sheet=paste(year, "data", sep=" "),
                     skip=1)


# National Accounts base year 
D1.1.MSC.SNAU<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.1.MSC.SNAU - REV.xlsx", sep=""),
                     sheet=paste(year, "data", sep=" "),
                     skip=1)

# Classification of national industry
D1.3.MSC.CNIN<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.3.MSC.CNIN - REV.xlsx", sep=""),
                     sheet=paste(year, "data", sep=" "),
                     skip=1)

# CPI base year

# Classification of household consumption
D1.5.MSC.HOUS<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.5.MSC.HOUS - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# Classification of status of employment 
D1.6.MSC.EMPL<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.6.MSC.EMPL - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# Central government accounting status
D1.7.MSC.CGOV<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.7.MSC.CGOV - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# Compilation of government finance statistics
D1.8.MSC.FINA<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.8.MSC.FINA - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# Compilation of monetary and financial statistics
D1.9.MSC.MONY<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.9.MSC.MONY - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# SDDS/e-GDDS subscription
D1.10.MSC.IDDS<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.10.MSC.IDDS - REV.xlsx", sep=""),
                      sheet=paste(year, "data", sep=" "),
                      skip=1)
# CRVS 
D1.11.MSC.CRVS<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.11.MSC.CRVS - REV.xlsx", sep=""),
                           sheet=paste(year, "data", sep=" "),
                           skip=1)
# Business process
D1.12.MSC.GSBP<-read_excel(path=paste(dir,"/D1. MSC/",year, " - D1.12.MSC.GSBP - REV.xlsx", sep=""),
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

aki_7_df <- read_excel(path=paste(dir,"JMP_2019_WLD (1).xlsx", sep="/"),
                       sheet="Water", 
                       skip=2)


###############################
# SPI Dimension 4: Dissemination Practices and Openness (DPO):
###############################


