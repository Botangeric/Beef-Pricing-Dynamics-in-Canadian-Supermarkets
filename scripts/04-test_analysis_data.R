#### Preamble ####
# Purpose: Tests cleaned_data
# Author: Bo Tang
# Date: 26 November 2024 
# Contact: qinghe.tang@mail.utoronto.ca 
# License: UofT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - The `testthat` package must be installed and loaded
  # - The `arrow` package must be installed and loaded
  # - 03-clean_data.R must have been run



#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

cleaned_data <- read_parquet("data/02-analysis_data/cleaned_data.parquet")


#### Test data ####

# Test: Ensure `vendor` column contains only "Loblaws" and "TandT"
test_that("Vendor column contains only specified vendors", {
  valid_vendors <- c("Loblaws", "TandT")
  expect_true(all(cleaned_data$vendor %in% valid_vendors))
})

# Test: Ensure `vendor` column is a character vector
test_that("Vendor column is a character vector", {
  expect_type(cleaned_data$vendor, "character")
})

# Test: Ensure `current_price` and `old_price` are numeric and all values are positive
test_that("Current price and old price are numeric and positive", {
  expect_type(cleaned_data$current_price, "double")
  expect_type(cleaned_data$old_price, "double")
  expect_true(all(cleaned_data$current_price > 0))
  expect_true(all(cleaned_data$old_price > 0))
})

# Test: Ensure `month` column is numeric and values are between 1 and 12
test_that("Month column is double and in valid range", {
  expect_type(cleaned_data$month, "double")
  expect_true(all(cleaned_data$month >= 1 & cleaned_data$month <= 12))
})

# Test: Ensure `product_name` column is a character vector
test_that("Product name column is a character vector", {
  expect_type(cleaned_data$product_name, "character")
})

# Test: Ensure there are no missing values in the dataset
test_that("No missing values in the dataset", {
  expect_true(all(complete.cases(cleaned_data)))
})


# Test: Ensure `current_price` values are within a reasonable range
test_that("Summary statistics are within expected range", {
  price_summary <- summary(cleaned_data$current_price)
  expect_true(price_summary["Min."] >= 0)
  expect_true(price_summary["Max."] <= 1000)  # Adjust this maximum as needed
})
