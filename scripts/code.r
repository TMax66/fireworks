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
plot_bar(df)### seleziono solo le variabili "discriminanti"...elimino quelle in cui c'è poca variabilità nelle risposte alle diverse categorie della variabile####

d_MCA <- df %>% 
  #filter(Country=="US") %>% 
  select(2, 6:9, 10:14,  16:17, 20, 25, 26, 28:30, 36:38, 40:41, 43:44) %>% 
  mutate(across(where(is.character), as.factor)) %>% 
  na.omit()

##non utilizzabili le colonne 18,19,22, 23, 24, 27, 28(?-verificare se usarla o meno), 33 (da usare come variabile di raggruppamento), 
##45:50--------------------

#create_report(d_MCA)



 

res.mca = MCA(d_MCA[, -1], graph = FALSE)

eig.val <- get_eigenvalue(res.mca)

fviz_screeplot(res.mca, addlabels = TRUE, ylim = c(0, 45))

fviz_mca_biplot(res.mca, 
                repel = TRUE, # Avoid text overlapping (slow if many point)
                ggtheme = theme_minimal())

##Low variance explained means that the items you have are not sufficient to explain your model. 
##You should have additional items, since the once you have produce not enough variance just your dependent variable.
