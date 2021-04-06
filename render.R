library(tidyverse)
library(rmarkdown)
library(palmerpenguins)


# Render a single report --------------------------------------------------

render(input = "report.Rmd")

# By hand -----------------------------------------------------------------

# https://urban-institute.medium.com/iterated-fact-sheets-with-r-markdown-d685eb4eafce

island <- penguins %>% 
  mutate(island = as.character(island)) %>% 
  distinct(island) %>% 
  pull(island)


reports <- tibble(
  input = "report.Rmd",
  output_file = str_c("reports/", island, "-report.html"),
  params = map(island, ~list(island = .))
)

render(input = "report.Rmd",
       output_file = "test.html")

reports %>%
  pwalk(render)


# multireport -------------------------------------------------------------

library(multireport) # https://dgkeyes.github.io/multireport/

penguins_params <- penguins %>% 
  distinct(island)

multireport(
  rmarkdown_file = "report.Rmd",
  params_data_frame = penguins_params,
  report_title_param = "island",
  report_suffix = "-report",
  report_title_to_lower = TRUE,
  report_output_directory = "multireport"
)

