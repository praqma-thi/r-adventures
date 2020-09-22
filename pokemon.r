## DEPENDENCIES

# Tidyverse
#install.packages("tidyverse")
library(tidyverse)
library(magrittr)

# Rokémon
#install.packages("devtools")
#devtools::install_github("schochastics/Rokemon")
library(Rokemon)

## PALETTES

pokemon_type_pal <- c(
  `normal`= "#A8A77A",`fire`= "#EE8130",`water`= "#6390F0",
  `electric`= "#F7D02C",`grass`= "#7AC74C",`ice`= "#96D9D6",
  `fighting`= "#C22E28",`poison`= "#A33EA1",`ground`= "#E2BF65",
  `flying`= "#A98FF3",`psychic`= "#F95587",`bug`= "#A6B91A",
  `rock`= "#B6A136",`ghost`= "#735797",`dragon`= "#6F35FC",
  `dark`= "#705746",`steel`= "#B7B7CE",`fairy`= "#D685AD"
)

## SCRIPT

# load data
data(pokemon)

# select typings subset
pokemon_typings <- pokemon %>% select(name, type1, type2)

# count pokemon by type
type1_count <- pokemon_typings %>% count(type1) %>% rename(type = type1)
type2_count <- pokemon_typings %>% filter(type2 != "") %>% count(type2) %>% rename(type = type2)
type_count <- bind_rows(type1_count, type2_count) %>% group_by(type) %>% summarise_all(list(~ sum(.)))

# plot it out
type_count_plot <- ggplot(type_count) +
  aes(x = n, y = reorder(type, n), fill = type) +
  scale_fill_manual(values = pokemon_type_pal) +
  labs(title = "Pokémon count by type") +
  xlab("Count") +
  ylab("Type") +
  geom_bar(stat = "identity") +
  guides(fill=FALSE)

type_count_plot
