library(tidyverse)
library(rmarkdown)
library(palmerpenguins)
library(multireport) # https://dgkeyes.github.io/multireport/

render(input = "report.Rmd")

penguins_params <- penguins %>% 
  distinct(island)

multireport(
  rmarkdown_file = "report.Rmd",
  params_data_frame = penguins_params,
  report_title_param = "island",
  report_suffix = "-report",
  report_title_to_lower = TRUE,
  report_output_directory = "reports"
)

