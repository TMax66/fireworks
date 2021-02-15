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
  filter(Country=="US") %>% 
  select(6:17, 20, 21, 25, 26, 28:30,35, 36:44) %>% 
  mutate(across(where(is.character), as.factor))
  na.omit()  

##non utilizzabili le colonne 18,19,22, 23, 24, 27, 28(?-verificare se usarla o meno), 33 (da usare come variabile di raggruppamento), 
##45:50--------------------

#create_report(d_MCA)

summary(d_MCA)[, 1:31]

for (i in 1:31) {
  plot(d_MCA[,i], main=colnames(d_MCA)[i],
       ylab = "Count", col="steelblue", las = 2)
}

res.mca = MCA(d_MCA, graph = FALSE)

eig.val <- get_eigenvalue(res.mca)

fviz_screeplot(res.mca, addlabels = TRUE, ylim = c(0, 45))

fviz_mca_biplot(res.mca, 
                repel = TRUE, # Avoid text overlapping (slow if many point)
                ggtheme = theme_minimal())

##Low variance explained means that the items you have are not sufficient to explain your model. 
##You should have additional items, since the once you have produce not enough variance just your dependent variable.
