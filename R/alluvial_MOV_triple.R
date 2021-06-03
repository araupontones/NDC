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
  select(framework,MOV) %>%
  left_join(select(tools_raw, TOOL,`Frequency of update`, Type), by=c("MOV"="TOOL")) %>%
  group_by(framework,MOV, Type, `Frequency of update`) %>%
  summarise(freq = n(), .groups = 'drop')  %>%
  #to bring the frequency of the tool
  rename(frequency = `Frequency of update`,
         type = Type) %>%
  factors_tools(.)


#create alluvial -------------------------------------------------------------------

chart_alluvial_tripe(by = frequency,
               pal_by =c(ndc_colors("green"),
                         ndc_colors("blue_navy"),
                         ndc_colors("purple"),
                         ndc_colors("yellow"),
                         'grey')
)
