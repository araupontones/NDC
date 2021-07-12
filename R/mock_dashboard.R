#Mock data for dashboard
library(wbstats)

countries_raw <- wb(indicator = "NY.GDP.MKTP.CD", startdate = 2000, enddate = 2016)
                    
                    
countries_clean <- countries_raw %>%
  group_by(country) %>%
  slice(1) %>%
  ungroup()

countries_indicators <- countries_clean %>%
 arrange(desc(value)) %>%
  dplyr::filter(!str_detect(country, "Late|European|World|OECD|High|Post|IDA|Low|Middle|IBRD|Asia|North America|Upper|area|Latin|Early|Sub|conflict|Europe|Pre|developed|Africa|poor|small")) %>%
  dplyr::filter(row_number() < 51) %>%
 mutate(used_data = sample(0:1, n(), replace = TRUE),
        have_aligned = sample(0:1, n(), replace = TRUE),
        advisors = sample(0:10, n(), replace = TRUE),
        investment_projects = sample(0:38, n(), replace = TRUE),
        investment_usd = sample(10e2:10e4, n(), replace = TRUE)
 )

  

export(countries_indicators, file.path('data', "dashboard_mock.csv"))
  