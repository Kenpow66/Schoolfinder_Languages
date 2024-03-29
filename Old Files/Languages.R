---
title: "School_Finder_Languages"
author: "Ken Powers"
date: "`r Sys.Date()`"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


```{r Languages}

##Load tidyverse**

library(tidyverse)

##Load csv and create a dataframe and add leading zeros to campus number

Languages <- read.csv('Languages_Native.csv', stringsAsFactors = FALSE, header = TRUE) %>%
  mutate(campus_number = sprintf("%03d", campus_number))
### Rename Columns to specific Languag

names(Languages)[1] <- "entity_id"
names(Languages)[2] <- "American Sign Language"
names(Languages)[3] <- "Arabic"
names(Languages)[4] <- "Chinese"
names(Languages)[5] <- "French"
names(Languages)[6] <- "German"
names(Languages)[7] <- "Hebrew"
names(Languages)[8] <- "Hindi"
names(Languages)[9] <- "Italian"
names(Languages)[10] <- "Japanese"
names(Languages)[11] <- "Korean"
names(Languages)[12] <- "Latin"
names(Languages)[13] <- "Russian"
names(Languages)[14] <- "Spanish"
names(Languages)[15] <- "Vietnamese"

Languages <- na.omit(Languages)
#Pivot longer but keeping the campus ID
languages_long <- pivot_longer(Languages, 
                  cols = -entity_id, names_to = "value", values_to = "Offered" ) 
  
#Create structure to include all campuses regardless of programmed offered
  all_campuses <- languages_long %>% distinct(entity_id)
  
  #Filter by programs offered then join with all_campuses to create final list
  languages_long <- filter(languages_long, Offered == 1)
  languages_final <- left_join(all_campuses, languages_long, by = "entity_id")
  
    #Clean CampusID add type column, fix NA responses, rename columns, and rearrange
  languages_final <- languages_final %>% 
    mutate(type = "languages",
           value = ifelse(is.na(value), "Languages Not Offered", value)) %>% 
    select(entity_id, type, value) %>% 
    arrange(entity_id)
  
languages_final[, "id"] <-""

install.packages('writexl')
library(writexl)

write_xlsx(languages_final, 'R:\\Specialists Transfer\\Ken\\GitHub\\Schoolfinder_Languages\\Languages_final.xlsx')

write.csv(languages_final, "R:\\Specialists Transfer\\Ken\\GitHub\\Schoolfinder_Languages\\Languages_final_id.csv", row.names=FALSE)
```






```
