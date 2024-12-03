#### Preamble ####
# Purpose: Graph may used in paper
# Author: Bo Tang
# Date: 27 November 2024
# Contact: qinghe.tang@mail.utoronto.ca 
# License: UofT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - The `rstanarm` package must be installed and loaded
# - The `arrow` package must be installed and loaded
# - The `ggplot2` package must be installed and loaded
# - The `dplyr` package must be installed and loaded

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(dplyr)
library(ggplot2)
#### Read data ####
cleaned_data <- read_parquet("data/02-analysis_data/cleaned_data.parquet")

### graph ####

# Load dplyr package
library(dplyr)

# Group by month and calculate the overall average price
monthly_price_trend <- cleaned_data %>%
  group_by(month) %>%
  summarize(average_price = mean(current_price, na.rm = TRUE), .groups = "drop")

# Load ggplot2 package
library(ggplot2)

# Plot the overall price trend
ggplot(monthly_price_trend, aes(x = month, y = average_price)) +
  geom_line(color = "blue", size = 1.2) +
  geom_point(color = "blue", size = 3) +
  labs(
    title = "Overall Monthly Price Trend",
    x = "Month",
    y = "Average Current Price"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )


# Plot the box plot for price comparison between vendors
ggplot(cleaned_data, aes(x = vendor, y = current_price, fill = vendor)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 2) +
  labs(
    title = "Price Distribution of Beef Products by Vendor",
    x = "Vendor",
    y = "Current Price"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    legend.position = "none"
  ) +
  scale_fill_manual(values = c("Loblaws" = "blue", "TandT" = "green"))  # Customize colors

# Create the box plot
ggplot(cleaned_data, aes(x = factor(month), y = current_price, fill = factor(month))) +
  geom_boxplot(outlier.colour = "red", outlier.size = 2) +
  labs(
    title = "Current Price Distribution Across Months",
    x = "Month",
    y = "Current Price",
    fill = "Month"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  ) +
  scale_fill_brewer(palette = "Set3")  # Use a predefined color palette

# Create the scatter plot
ggplot(cleaned_data, aes(x = old_price, y = current_price)) +
  geom_point(alpha = 0.6, color = "blue", size = 2) +
  labs(
    title = "Comparison of Current Price vs Old Price",
    x = "Old Price",
    y = "Current Price"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  ) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") # Add a reference line

#### Save model ####


