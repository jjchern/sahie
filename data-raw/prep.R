
# install.packages("devtools")
# devtools::install_github("jjchern/sahieAPI")
library(dplyr, warn.conflicts = FALSE)

sahie_county = sahieAPI::sahie_county(year = 2006:2014)
devtools::use_data(sahie_county, overwrite = TRUE)
