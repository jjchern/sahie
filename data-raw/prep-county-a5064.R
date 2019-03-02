
# Prepareing county-level estimates for HI coverage for
# specific age groups and income levels.
# All races, both sexes
# Available years: 2008-2016

prep = . %>%
        select(-version, -X26) %>%
        docxtractr::mcga() %>%
        mutate(fips = paste0(statefips, countyfips)) %>%
        # County-level
        filter(geocat == 50) %>% select(-geocat) %>%
        # all races
        filter(racecat == 0) %>% select(-racecat) %>%
        # both sexes
        filter(sexcat == 0) %>% select(-sexcat) %>%
        # no need for contains("elig") and contains("liic")
        select(-contains("elig"), -contains("liic")) %>%
        select(-statefips, -countyfips) %>%
        select(fips, year, state = state_name, county = county_name, everything())

bind_rows(
        read_csv("data-raw/sahie_2016.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2015.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2014.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2013.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2012.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2011.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2010.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2009.csv", skip = 79) %>% prep() %>% print(),
        read_csv("data-raw/sahie_2008.csv", skip = 79) %>% prep() %>% print()
) %>%
        arrange(fips, year) %>%
        print() -> county_raw

# Save county-leve files by available age categories ----------------------

county_raw %>% filter(iprcat == 0) %>% count(year, agecat) %>% spread(agecat, n)
#' agecat: Age category
#' 0 - Under 65 years
#' 1 - 18 to 64 years
#' 2 - 40 to 64 years
#' 3 - 50 to 64 years
#' 4 - Under 19 years
#' 5 - 21 to 64 years

county_raw %>% filter(iprcat == 0, agecat == 0) %>% print() -> county_yr0816_ag0064
county_raw %>% filter(iprcat == 0, agecat == 1) %>% print() -> county_yr0816_ag1864
county_raw %>% filter(iprcat == 0, agecat == 2) %>% print() -> county_yr0816_ag4064
county_raw %>% filter(iprcat == 0, agecat == 3) %>% print() -> county_yr1016_ag5064
county_raw %>% filter(iprcat == 0, agecat == 4) %>% print() -> county_yr0816_ag0018
county_raw %>% filter(iprcat == 0, agecat == 5) %>% print() -> county_yr1416_ag2164

use_data(county_yr0816_ag0064,
         county_yr0816_ag1864,
         county_yr0816_ag4064,
         county_yr1016_ag5064,
         county_yr0816_ag0018,
         county_yr1416_ag2164, overwrite = TRUE)

# Save county-leve files by available age and income categories ---------------

county_raw %>%
        count(year, iprcat, agecat) %>%
        spread(agecat, n) %>%
        arrange(iprcat, year) %>%
        print(n = 50)
#' iprcat: 1 Income category
#' 0 - All income levels
#' 1 - At or below 200% of poverty
#' 2 - At or below 250% of poverty
#' 3 - At or below 138% of poverty
#' 4 - At or below 400% of poverty
#' 5 - Between 138% - 400%  of poverty

county_raw %>% filter(iprcat == 1, agecat == 0) %>% print() -> county_yr0816_ag0064_pv000200
county_raw %>% filter(iprcat == 1, agecat == 1) %>% print() -> county_yr0816_ag1864_pv000200
county_raw %>% filter(iprcat == 1, agecat == 2) %>% print() -> county_yr0816_ag4064_pv000200
county_raw %>% filter(iprcat == 1, agecat == 3) %>% print() -> county_yr1016_ag5064_pv000200
county_raw %>% filter(iprcat == 1, agecat == 4) %>% print() -> county_yr0816_ag0018_pv000200
county_raw %>% filter(iprcat == 1, agecat == 5) %>% print() -> county_yr1416_ag2164_pv000200

use_data(county_yr0816_ag0064_pv000200,
         county_yr0816_ag1864_pv000200,
         county_yr0816_ag4064_pv000200,
         county_yr1016_ag5064_pv000200,
         county_yr0816_ag0018_pv000200,
         county_yr1416_ag2164_pv000200, overwrite = TRUE)
