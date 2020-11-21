library("here")
library("tidyverse")
library("readxl")
library("FactoMineR")
library("factoextra")
library("DataExplorer")

# df <- read_excel(sheet = "Sheet1", here("data", "raw", "Equine anxiety_dataset.xlsx"))
# df <- filter(df, df$`Unusual behavior`== "Yes")
# 
# saveRDS(df, here("data", "processed",  file = "dati.rds"))

df <- readRDS(here("data", "processed",  "dati.rds"))

d_MCA <- df %>% 
  select(6:12, 21, 25, 26) %>% 
  na.omit()

#create_report(d_MCA)


res.mca = MCA(d_MCA, graph = FALSE)

eig.val <- get_eigenvalue(res.mca)

fviz_screeplot(res.mca, addlabels = TRUE, ylim = c(0, 45))

fviz_mca_biplot(res.mca, 
                repel = TRUE, # Avoid text overlapping (slow if many point)
                ggtheme = theme_minimal())
