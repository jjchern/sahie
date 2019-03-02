
# Prepareing county-level uninsured rate for age 50-64.
# All races, both sexes, and all income categories
# Available years: 2008-2016

prep = . %>%
        select(-version, -X26) %>%
        docxtractr::mcga() %>%
        mutate(fips = paste0(statefips, countyfips)) %>%
        # County-level
        filter(geocat == 50) %>%
        # age 50-64 [3]; 21 to 64 years [5]; 18 to 64 years [1]
        filter(agecat == 1) %>%
        # all races
        filter(racecat == 0) %>%
        # both sexes
        filter(sexcat == 0) %>%
        # all income level [0]; At or below 200% of poverty [1]
        # also no need for contains("elig") and contains("liic")
        filter(iprcat == 0) %>%
        select(-contains("elig"), -contains("liic")) %>%
        select(-geocat, -agecat, -racecat, -sexcat, -iprcat) %>%
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
        print() -> county_a5064

use_data(county_a5064)
