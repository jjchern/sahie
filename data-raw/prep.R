
library(tidyverse)
library(tidylog)

# Download raw data -------------------------------------------------------
# https://www.census.gov/data/datasets/time-series/demo/sahie/estimates-acs.html

glue::glue("https://www2.census.gov/programs-surveys/sahie/datasets/time-series/estimates-acs/sahie-{2008:2016}-csv.zip") %>% print() -> zip_urls

glue::glue("data-raw/sahie_{2008:2016}.csv") %>% print() -> fils

map2(.x = fils,
     .y = zip_urls,
     ~ if (!file.exists(.x)) {
            temp = tempfile(fileext = ".zip")
            download.file(.y, temp)
            unzip(temp, exdir = "data-raw", junkpaths = TRUE)
     })

# 2013 doesn't have 21 to 64 years [5]
# usethis::use_data(sahie_county, overwrite = TRUE)

#' From 2016
#' geocat: 2 Geography category
#' 40 - State geographic identifier
#' 50 - County geographic identifier
#'
#' agecat: 1 Age category
#' 0 - Under 65 years
#' 1 - 18 to 64 years
#' 2 - 40 to 64 years
#' 3 - 50 to 64 years
#' 4 - Under 19 years
#' 5 - 21 to 64 years
#'
#' racecat: 1 Race category
#' 0 - All races
#' Only state estimates have racecat=1
#' 1 - White alone
#' 2 - Black alone
#' 3 - Hispanic (any race)
#'
#' sexcat: 1 Sex category
#' 0 - Both sexes
#' 1 - Male
#' 2 - Female
#'
#' iprcat: 1 Income category
#' 0 - All income levels
#' 1 - At or below 200% of poverty
#' 2 - At or below 250% of poverty
#' 3 - At or below 138% of poverty
#' 4 - At or below 400% of poverty
#' 5 - Between 138% - 400%  of poverty
#'
#' nipr        : Number in demographic group for <income category>
#' nipr_moe    : MOE for nipr
#' nui         : Number uninsured
#' nui_moe     : MOE for nui
#' niu         : Number insured
#' nic_moe     : MOE for niu
#' pctui       : Percent uninsured in demographic group for <income category>
#' pctui_moe   : MOE for pctui
#' pctic       : Percent insured in demographic group for <income category>
#' pctic_moe   : MOE for pctic
#' pctelig     : Percent uninsured in demographic group for all income levels
#' pctelig_moe : MOE for pctelig
#' pctliic     : Percent insured in demographic group for all income levels
#' pctliic_moe : MOE for pctliic
#' state_name  : State Name
#' county_name : County Name
