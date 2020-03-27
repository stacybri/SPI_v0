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

###############################
# SPI Dimension 1: Methodology, Standards and Classifications (MSC): 
###############################




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


