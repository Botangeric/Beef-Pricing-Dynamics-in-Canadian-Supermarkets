#### Preamble ####
# Purpose: Tests the simulated dataset.
# Author: Bo Tang
# Date: 29 November 2024
# Contact: rohan.alexander@utoronto.ca
# License: UofT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run



#### Workspace setup ####
library(tidyverse)

analysis_data <- read_parquet("data/00-simulated_data/simulated_data.parquet")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 1500 rows
if (nrow(analysis_data) == 1500) {
  message("Test Passed: The dataset has 1500 rows.")
} else {
  stop("Test Failed: The dataset does not have 1500 rows.")
}

# Check if the dataset has 3 columns
if (ncol(analysis_data) == 4) {
  message("Test Passed: The dataset has 4 columns.")
} else {
  stop("Test Failed: The dataset does not have 4 columns.")
}

# Check unique values
unique_vendors <- unique(analysis_data$vendor)

# Test if it only contains the specified values
all_vendors_valid <- all(unique_vendors %in% c("TandT", "Loblaws"))
if (all_vendors_valid) {
  print("The 'vendor' column contains only 'TandT' and 'Loblaws'")
} else {
  print(paste("The 'vendor' column contains other values:", paste(setdiff(unique_vendors, c("TandT", "Loblaws")), collapse = ", ")))
}

# Test if the `vendor` column is character
if (is.character(analysis_data$vendor)) {
  print("The 'vendor' column is entirely character type")
} else {
  print("The 'vendor' column contains non-character types")
}

# Check numeric type
all_numeric <- is.numeric(analysis_data$current_price) & is.numeric(analysis_data$old_price)

# Check if all values are greater than 0
all_positive <- all(analysis_data$current_price > 0, na.rm = TRUE) & all(analysis_data$old_price > 0, na.rm = TRUE)

if (all_numeric & all_positive) {
  print("'current_price' and 'old_price' are numeric, and all values are greater than 0")
} else {
  print("'current_price' or 'old_price' contains non-numeric values or values less than or equal to 0")
}

# Check if `month` is numeric
if (is.numeric(analysis_data$month) & all(analysis_data$month > 0, na.rm = TRUE)) {
  print("The 'month' column is numeric, and all values are greater than 0")
} else {
  print("The 'month' column contains non-numeric values or values less than or equal to 0")
}

# Check for duplicate rows
duplicate_rows <- duplicated(analysis_data)
if (any(duplicate_rows)) {
  print(paste("There are", sum(duplicate_rows), "duplicate rows in the dataset."))
} else {
  print("No duplicate rows found in the dataset.")
}

# Check if month is within the range of 1 to 12
valid_months <- all(analysis_data$month >= 1 & analysis_data$month <= 12)
if (valid_months) {
  print("All values in the 'month' column are valid (between 1 and 12).")
} else {
  print("The 'month' column contains invalid values.")
}

