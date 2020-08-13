# Chi Zhang
# 08/12/2020
# Daily-exercise-07

library(tidyverse)

homes = read.csv('data/landdata-states.csv')

covid = read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')

pop = readxl:::read_excel("data/populationEstimates.xls", skip = 2) %>%
  select(pop2019 = POP_ESTIMATE_2019, State = State, fips = FIPStxt)

areadata = inner_join(pop, homes, by = "State") %>%
  select(region, fips)

Regioncases = inner_join(covid, areadata, by = "fips")%>%
  select(date, region,cases, deaths)

REGION = Regioncases %>%
  group_by(date, region) %>%
  summarise(cases = sum(cases), deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) %>%
  ungroup()

REGION %>%
  ggplot(aes(x = date, y = value)) +
  geom_line(aes(color = region)) +
  labs(title = "Cumulative Cases and Deaths: Region",
       x = "Date",
       y = "Daily Cumulative count",
       caption = "based on https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv",
       subtitle = 'Data Source: NY-Times',
       color = "") +
  facet_grid(name~region, scales = "free_y") +
  theme_gray()

