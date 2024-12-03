#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Bo Tang
# Date: 26 November 2024
# Contact: qinghe.tang@mail.utoronto.ca 
# License: UofT
# Pre-requisites: 
# 1.Down load raw data on https://jacobfilipp.com/hammer/

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(lubridate)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/hammer-4-raw.csv")
product_data <- read_csv("data/01-raw_data/hammer-4-product.csv")

combine_data <- raw_data %>% 
  inner_join(product_data, by = c("product_id" = "id")) %>%
  select(nowtime,vendor,product_id,product_name,brand,current_price,
         old_price,units,price_per_unit)

clean_data <- combine_data %>% filter(vendor %in% c("TandT","Loblaws")) %>%
  select(nowtime, vendor, current_price, old_price, product_name) %>%
  mutate(month = month(nowtime),
         current_price = parse_number(current_price),
         old_price = parse_number(old_price)) %>%
  filter(str_detect(tolower(product_name),"beef")) %>%
  select(-nowtime) %>%
  tidyr:: drop_na()

#### Save data ####
write_parquet(clean_data,"data/02-analysis_data/cleaned_data.parquet")