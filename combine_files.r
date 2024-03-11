library(tidyverse)
library(lubridate)

data_path <- "data"   # path to the data
files <- dir(data_path, pattern = "\\.csv$", full.names = TRUE)

READ <- function(FILE) {
  read_csv(FILE,
           trim_ws = TRUE,
           guess_max = nrow(read_csv(FILE)) -12,
           n_max = nrow(read_csv(FILE)) -12,
           col_types = cols(
             ISIN = col_character(),
             `Strategic Beta Group` = col_character(),
             `Index Selection` = col_character(),
             `Index Weighting` = col_character()
           )) %>% 
    mutate(., filename = FILE)
  }

data <- files %>%
  map(READ) %>%    # read in all the files individually, using
  # the function READ from above
  reduce(full_join) # reduce with full_join into one dataframe



write_csv(data, "data_combined.csv")

