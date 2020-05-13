#compare new SPI data with 2019 to original SPI
# In this script, we will check for differences between an original SPI file with data from 2016-18 and a new file that also includes data from 2019.
# We will run correlations between the files
library(tidyverse)
library(purrr)


#directories
dir_spi_new <- "C:/Users/wb469649/Documents/Github/SPI_AKI/R/01_data/013_outputs"
dir_spi_old <-   "C:/Users/wb469649/Documents/Github/SPI_AKI/R/03_replication/033_outputs"

#load SPI data
load(paste(dir_spi_new, 'SPI.Rdata', sep="/"))
load(paste(dir_spi_old, 'SPI_replication_data.Rdata', sep="/"))


#make dataframes long with id = countryxyearxindicator
SPI_compare_new <- SPI %>%
  pivot_longer(cols=starts_with("SPI"),
               names_to='indicator',
               values_to='new')

SPI_compare_old <- SPI_replication %>%
  pivot_longer(cols=starts_with("SPI"),
               names_to='indicator',
               values_to='old')

#Create a dataframe with both joined
SPI_compare <- SPI_compare_new %>%
  left_join(SPI_compare_old)

# Now map the comparison data and produce table of correlations
SPI_correlations <- SPI_compare %>%
  select(indicator, country, iso3c, date, new, old ) %>%
  group_by(indicator, date) %>%
  nest(data=one_of('country', 'iso3c','new','old')) %>%
  mutate(correlations = map(data, ~cor(.$new, .$old, use='na.or.complete')))