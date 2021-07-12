list.files(dir_data)

indicators_wide <- import(file.path(dir_data, "indicator_framework.xlsx"))
names(indicators_wide)


indicators_long <- indicators_wide %>%
  select(Seq, 
         ind_num = `#`,
         Indicator,
         Baseline,
         Target,
         `Progress to date` = PTD,
         Progress,
         Level = LEVEL,
         `Pathway 1` = IP_1,
         `Pathway 2` = IP_2,
         `Pathway 3` = IP_3,
         `Pathway 4` = IP_4,
         ) %>%
  pivot_longer(-c(Seq, ind_num, Baseline, Target, `Progress to date`, Progress, Indicator, Level),
               names_to = "Pathway") %>%
  mutate(Progress_label = scales::percent(Progress, 2),
         Progress_left = 1- Progress) %>%
  dplyr::filter(value == TRUE,
                !is.na(Progress)) %>%
  select(-value)


export(indicators_long, file.path(dir_data, "indicator_long.csv"))
