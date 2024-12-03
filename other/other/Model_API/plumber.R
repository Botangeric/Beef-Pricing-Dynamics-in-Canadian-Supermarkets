library(plumber)
library(tidyverse)

model <- readRDS("beef_product_model.rds")

version_number <- "0.0.1"

variables <-
  list(
    old_price = "product's previous price,numeric variables",
    vendor = "seller or distributor of the product,TandT and Loblaws.",
    month = "the month of the year,numeric variable (1 - 12),"
  )

#* @param old_price
#* @param vendor
#* @param month
#* @get /predict_price
predict_price <- function(old_price = 10, vendor = "TandT", month = 8) {
  old_price <- as.numeric(old_price)
  vendor <- as.character(vendor)
  month <- as.integer(month)
  
  payload <- data.frame(old_price = old_price,
                        vendor = vendor,
                        month = month)
  
  posterior_samples <- as.matrix(model)
  
  beta_1 <- posterior_samples[, "old_price"]
  beta_2 <- posterior_samples[, "vendorTandT"]
  beta_3 <- posterior_samples[, "month"]
  intercept <- posterior_samples[, "(Intercept)"]
  
  predicted_price <- intercept + 
    beta_1 * payload$old_price +
    beta_2 * ifelse(payload$vendor == "TandT", 1, 0) +
    beta_3 * payload$month
  
  mean_predicted_price <- mean(predicted_price)
   
  result <- list("price" = mean_predicted_price)
  
  return(result)
}