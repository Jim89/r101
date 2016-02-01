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

# Step 1 - Data structures and assignment --------------------------------------
# Create a simple vector
x <- c(1, 2, 3, 4, 5, 6)

# Create a simple list
y <- list(1, 2, "jim", 4, "leach")
z <- list(x, y)

# Create a simple data frame
df <- data.frame(x = c(1, 2, 3), # column one
                 y = c("a", "b", "c")) # column 2

# Create a simple matrix
row_mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
col_mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2,  byrow = FALSE)

# Step 2 - data from .csv files ------------------------------------------------
# REMEMBER TO SET THE FILE PATH IN STEP 0 CORRECTLY
# Read in the Oyster card data
oyster <- read_csv(oyster_data_path, col_names = TRUE, skip = 0, col_types = NULL)

# Take a look at the data
head(oyster)

# Take a look at a bit less (just the first 3 rows)
head(oyster, 3)

# Take a look at a bit more (the first 10 rows)
head(oyster, 10)

# Open the RStudio viewer
View(oyster)

# Set all the names to lower case
colnames(oyster) <- tolower(colnames(oyster))

# Step 3 - sizing and summarising data -----------------------------------------
# Get the overall dimensions of the data
dim(oyster)

# Number of rows
nrow(oyster)

# Number of columns
ncol(oyster)

# Get an overall structural summary
str(oyster)

# Get an overall data-oriented summary
summary(oyster)

# Step 4 - selecting data ------------------------------------------------------
# Select just one column
dates <- oyster$date
journeys <- oyster$journey.action

# Select using data[row(s), column(s)] syntax
# Get the first 10 rows, and all columns
oyster[1:10, ]

# Get all rows, but just the first 3 columns
oyster[ , 1:3]

# Get a very specific section of data (rows 10 to 20, and row 30; columns 1, 2,
# 3, 4 and 7)
oyster[c(10:20, 30), c(1, 2, 3, 4, 7)]

# Negative selection - get everything except the first 10 rows
oyster[-(1:10), ]

# Get a specific column with names
oyster[ , "journey.action"]

# Save the subset to a new object (save the first 10 rows to a new object named
# "subset"
subset <- oyster[1:10, ]

# Step 5 - changing data types -------------------------------------------------
# Force values to be characters (text)
as.character(oyster$credit)

# Force values to be numbers
as.numeric(oyster$credit)

# Change a data type in place
oyster$credit <- as.character(oyster$credit)

# And change it back
oyster$credit <- as.numeric(oyster$credit)

# Step 6 - computing summaries and dealing with NA -----------------------------
# Computing a summary WITH missing values - returns missing values!
mean(oyster$charge)

# Add the na.rm argument to ignore missing values
mean(oyster$charge, na.rm = TRUE)

# Some other example summaries
min(oyster$charge, na.rm = TRUE)    # Gives the minimum
mean(oyster$charge, na.rm = TRUE)   # Gives the mean
max(oyster$charge, na.rm = TRUE)    # Gives the maximum
range(oyster$charge, na.rm = TRUE)  # Gives the min and max
unique(oyster$journey.action)       # Gives unique values
table(oyster$journey.action)        # Gives a frequency table
