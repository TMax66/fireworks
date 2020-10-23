library("here")
library("tidyverse")
library("readxl")
library("DataExplorer")

# df <- read_excel(sheet = "Sheet1", here("data", "raw", "Equine anxiety_dataset.xlsx"))
# df <- filter(df, df$`Unusual behavior`== "Yes")
# 
# saveRDS(df, here("data", "processed",  file = "dati.rds"))

df <- readRDS(here("data", "processed",  "dati.rds"))

create_report(df)
