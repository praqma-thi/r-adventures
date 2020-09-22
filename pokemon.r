install.packages("tidyverse")
library(tidyverse)

pokemon_db_file <- file.choose()
pokemon_dt <- read.csv(pokemon_db_file)
