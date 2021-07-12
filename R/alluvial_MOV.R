#ralluial of MOV by M&E framework

#read data -------------------------------------------------------------------
indicators_raw <- read_raw("Indicators")
tools_raw <- read_raw("Tools")




#create alluvial tool ----------------------------------------------------------
indicators_alluvial <- indicators_raw %>%
  rename(framework = `ME framework`) %>%
  mutate(framework = str_remove_all(framework,'[0-9]|\\.'),
         framework = str_trim(framework),
         framework = str_replace(framework, " ", "")) %>%
  group_by(framework,MOV) %>%
  summarise(freq = n(), .groups = 'drop') %>%
  #to bring the frequency of the tool
  left_join(select(tools_raw, TOOL,`Frequency of update`, Type), by=c("MOV"="TOOL")) %>%
  rename(frequency = `Frequency of update`,
         type = Type)  %>%
  factors_tools(.)


#create alluvial -------------------------------------------------------------------

chart_alluvial(by = type,
               pal_by = c(ndc_colors("yellow"), "grey", ndc_colors("green")))

chart_alluvial(by = frequency,
               pal_by =c(ndc_colors("green"),
                         ndc_colors("blue_navy"),
                         ndc_colors("purple"),
                         ndc_colors("yellow"),
                         'grey')
                 )


