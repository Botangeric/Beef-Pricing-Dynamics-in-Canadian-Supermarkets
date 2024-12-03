# Beef Pricing Dynamics in Canadian Supermarkets

## Overview

This study examines beef pricing trends in two Canadian supermarkets, T&T and Loblaws, using data from June to November 2024. We found that prices were stable overall, with seasonal increases in winter and significant differences between the supermarkets' pricing strategies. These findings reveal how cultural and operational factors, alongside seasonality, influence consumer pricing. This contributes to a better understanding of market dynamics and economic behavior in Canada.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated data of beef price.
-   `data/01-raw_data` The original dataset is too large to upload to GitHub. You need to download the CSV file from https://jacobfilipp.com/hammer/ and place it in the data/01-raw-data directory to proceed with the next steps.
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains a series of fitted models. 
-   `other` contains relevant details about LLM chat histories, and sketches for the figures demonstrated in the paper.And a Api for our model
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contain the R scripts used to simulate, download, and clean data.

## Data Retrieval

Our data source, Jacob Filipp, comes from the website https://jacobfilipp.com/hammer/.

## Statement on LLM usage

Aspects of the code were written with the help of Chatgpt4.0, the entire chat history is available at other/llm_usage/usage.txt.

