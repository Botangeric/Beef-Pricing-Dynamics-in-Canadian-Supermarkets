#### Preamble ####
# Purpose: Simulates a dataset 
# Author: Bo Tang
# Date: 29 November 2024
# Contact: qinghe.tang@mail.utoronto.ca
# License: UofT
# Pre-requisites: The `tidyverse` package must be installed



#### Workspace setup ####
library(tidyverse)
set.seed(682)


#### Simulate data ####
# vendors names
vendors <- c("TandT","Loblaws")

simulated_data <- tibble(
  vendor = sample(vendors, size = 1500, replace = TRUE),
  current_price = round(runif(1500, 1, 70), 3),
  old_price=round(runif(1500, 1, 70), 3),
  month = sample(1:12, size = 1500, replace = TRUE)
)
#### Save data ####
write_parquet(simulated_data, "data/00-simulated_data/simulated_data.parquet")
