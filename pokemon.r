## DEPENDENCIES

# Tidyverse
install.packages("tidyverse")
library(tidyverse)
library(magrittr)

## SCRIPT

# load data
pokemon <- file.choose() %>% read.csv() %>% as_tibble()

# select typings subset
pokemon_typings <- pokemon %>% select(name, type1, type2)

# count pokemon by type
type1_count <- pokemon_typings %>% count(type1) %>% rename(type = type1)
type2_count <- pokemon_typings %>% filter(type2 != "") %>% count(type2) %>% rename(type = type2)
type_count <- bind_rows(type1_count, type2_count) %>% group_by(type) %>% summarise_all(list(~ sum(.)))

# plot it out
type_count_plot <- ggplot(type_count) +
    aes(x = n, y = type) +
    geom_bar(stat = "identity")