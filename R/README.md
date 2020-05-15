# Introduction to Code and Data in this Repo

This repository contains the main code and data to calculate all four dimensions of the SPI.

In order to successfully run some programs, it will be necessary to modify the file paths at the beginning of some of the files.  Once the paths are modified, the code should run sucessfully.

This section has the following folders: 
1. 01_data  
2. 02_analysis  
3. 03_replication

Within each of the folders are a rawdata folder, a programs folder, and an outputs folder.  

The rawdata folder contains input datasets needed for the analysis.

The programs folder contains scripts to run to reproduce the results

The outputs folder contains final output from these exercises.

# 01_data folder

This folder contains the main cleaning code to produce the SPI indicators.  Within the 012_programs folder there are two R scripts.  

The 01_data_import.R file can be ignored if desired. This file converts several .xlsx files produced by the SPI team into csv files which are stored in the 011_rawdata folder.  This mainly just converts these .xlsx files into a country by year format and keeps only the relevant columns.  Minimal cleaning is done at this stage, as most cleaning takes place in the 02_data_cleaning.Rmd.

The 02_data_cleaning.Rmd is an R script in R Markdown format that cleans these csv files further and produces the indicators.  It is written in Rmd format, so as to also produce standalone technical documenation with a description of how the indicators are calculated.

# 02_analysis

This file takes the cleaned data files in the 01_data folder and produces tables of summary statistics and other analysis

# 03_replication

The files in this folder contains code to replicate results originally produced in DCS by the SPI team.  This folder is for internal use and quality checks only.
