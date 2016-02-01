# Step 0 - Set up working environment and load packages ------------------------
# helper function to get packages
# credit Drew Conway, "Machine Learning for Hackers" (O'Reilly 2012)
# https://github.com/johnmyleswhite/ML_for_Hackers/blob/master/package_installer.R
# set list of packages
pckgs <- c("readr", "dplyr", "magrittr", "readxl", "tidyr", "lubridate",
           "stringr", "leaflet", "networkD3", "ggplot2")

# install packages if they're not installed
for(p in pckgs) {
  if(!suppressWarnings(require(p, character.only = TRUE, quietly = TRUE))) {
    cat(paste(p, "missing, will attempt to install\n"))
    install.packages(p, dependencies = TRUE, type = "source")
  }
  else {
    cat(paste(p, "installed OK\n"))
  }
}
print("### All required packages installed ###")

# load necessary packages
library(readr)
library(dplyr)
library(magrittr)
library(readxl)
library(tidyr)
library(lubridate)
library(stringr)

# SET THE FILE PATH TO WHERE YOU HAVE SAVED THE DATA, E.G.
# C:/USERS/JIM/DESKTOP/oyster_all_raw_20160125.csv
oyster_data_path <- "PATH/TO/DATA/LOCATION/OF/oyster_all_raw_20160125.csv"

# Step 1 - read in the data ----------------------------------------------------
oyster <- read_csv(oyster_data_path)
colnames(oyster) <- tolower(colnames(oyster))

# Step 2 - selection examples --------------------------------------------------
# Select columns with names
oyster %>% select(Date, journey.action, charge)

# Select columns with positions (e.g. column 1, 2, and 3; 5 and 7)
oyster %>% select(1:3, 5, 7)

# "Negative selection" with names
oyster %>% select(-journey.action, -charge)

# "Negative selection" with numbers
oyster %>% select(-c(4, 6, 7))

# Step 3 - filtering examples --------------------------------------------------
# Numeric conditions
oyster %>% filter(charge != 0)

# Text conditions
oyster %>% filter(note != "")

# Multiple conditions, with assignment
whoops <- oyster %>% filter(balance < 0) # filtering with assignment
noteworthy <- oyster %>% filter(note != "" & charge >= 2) # multiple conditions

# Step 4 - grouping and summarising --------------------------------------------
# Compute a single summary
oyster %>% summarise(avg_charge = mean(charge, na.rm = TRUE)) # average charge

# Compute multiple summaries
oyster %>% summarise(avg_charge = mean(charge, na.rm = TRUE), # average charge
                     sd_charge = sd(charge, na.rm = TRUE)) # charge std. deviation

# Aggregate and summarise
oyster %>% 
  group_by(journey.action) %>% 
  summarise(avg_cost = mean(charge, na.rm = TRUE))

# Summarisation chain to answer question 1
oyster_summary <- oyster %>% 
                  group_by(journey.action) %>% 
                  summarise(journeys = n()) %>%
                  ungroup() %>%     
                  arrange(-journeys) %>% 
                  head(5)
