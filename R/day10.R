# Chi Zhang
### 8/18/2020
# Daily-exercise-10


library(sf)
library(tidyverse)

us = USAboundaries::us_states() %>%
  filter(!name %in% c("Alaska", "Hawaii", "Puerto Rico"))

us_geom = us$geometry %>%
  st_sfc()

us_c_ml = st_combine(us_geom) %>%
  st_cast("MULTILINESTRING") %>%
  plot()

us_u_ml = st_union(us_geom) %>%
  st_cast("MULTILINESTRING") %>%
  plot()
