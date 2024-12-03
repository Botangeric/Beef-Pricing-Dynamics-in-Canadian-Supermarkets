#### Preamble ####
# Purpose: Models
# Author: Bo Tang
# Date: 27 November 2024
# Contact: qinghe.tang@mail.utoronto.ca 
# License: UofT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - The `rstanarm` package must be installed and loaded
# - The `arrow` package must be installed and loaded
# - The `bayesplot` package must be installed and loaded



#### Workspace setup ####
if (!requireNamespace("rstanarm", quietly = TRUE)) install.packages("rstanarm")


library(tidyverse)
library(rstanarm)
library(bayesplot)
library(arrow)
#### Read data ####
cleaned_data <- read_parquet("data/02-analysis_data/cleaned_data.parquet")

### Model data ####
# Data preprocessing
cleaned_data$vendor <- as.factor(cleaned_data$vendor)  # Convert vendor to categorical
cleaned_data$month <- as.integer(cleaned_data$month)    # Convert month to categorical

# Standardize old_price for better scaling
cleaned_data$old_price <- as.numeric(cleaned_data$old_price)

# Build the Bayesian linear regression model
model <- stan_glm(
  current_price ~ old_price + vendor + month,
  data = cleaned_data,
  family = gaussian(),
  prior = normal(0, 2.5),        # Set prior for coefficients
  prior_intercept = normal(0, 10), # Set prior for intercept
  chains = 4,                    # Number of chains
  iter = 2000,                   # Number of iterations per chain
  seed = 123                     # Set random seed for reproducibility
)



#### Save model ####
saveRDS(
  model,
  file = "models/beef_product_model.rds"
)


