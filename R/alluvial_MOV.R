#ralluial of MOV by M&E framework

#read data -------------------------------------------------------------------
indicators_raw <- read_raw("Indicators")
tools_raw <- read_raw("Tools")


#create alluvial tool ----------------------------------------------------------
indicators_alluvial <- indicators_raw %>%
  rename(framework = `ME framework`) %>%
  mutate(framework = str_remove_all(framework,'[0-9]|\\.'),
         framework = str_trim(framework)) %>%
  group_by(framework,MOV) %>%
  summarise(freq = n(), .groups = 'drop') %>%
  #to bring the frequency of the tool
  left_join(select(tools_raw, TOOL,`Frequency of update`), by=c("MOV"="TOOL")) %>%
  rename(frequency = `Frequency of update`) %>%
  mutate(framework = str_replace(framework, "Intermediary", "Int."),
         MOV = case_when(MOV == "OPM is reviewing global best practice" ~ "OPM reviewing",
                         MOV == "Online partership plan" ~ "Online P.P",
                         MOV == "Needs clarify reporting tool" ~ "Clarifying",
                         MOV == "Annual member surveys" ~ "Annual surveys",
                         T ~ MOV),
         frequency = factor(frequency,
                            levels = c("Monthy",
                                       "Quarterly",
                                       "Bi-annually",
                                       "Yearly",
                                       "Uknown"
                            ),
                            ordered = T)
  )

unique(indicators_alluvial$frequency)
#create alluvial -------------------------------------------------------------------

ggplot(data = indicators_alluvial,
       aes(y = freq, 
           axis1 = MOV, 
           axis2 = framework)
) +
  #create lines that connect axis----------------------
geom_alluvium(aes(fill = frequency), 
              width = 1/4
)+
  #boxes that containt titles of axis ------------------
geom_stratum(width = 1/4, 
             color = "white", 
             fill = ndc_colors("blue_light"),
             size =.5 ) +
  #name of axis ----------------------------------------
geom_text(stat = "stratum", 
          aes(label = after_stat(stratum)), 
          angle = 0, 
          size = 4, 
          hjust = .5,
          color = "white",
          family = "Montserrat"
) +
  #x axis -----------------------------------------------------------------
scale_x_discrete(limits = c("MOV", "M&E framework"), 
                 expand = c(0,0), 
                 position = 'top'
) +
  #color of legend -------------------------------------------------------------
scale_fill_manual(values = c(ndc_colors("green"),
                             ndc_colors("blue_navy"),
                             ndc_colors("purple"),
                             ndc_colors("yellow"),
                             'grey'), 
                  name = "Frequency"
) +
  #title and captions ---------------------------------------------------------
labs(title = "MOVs by M&E framework",
     caption = "Based on OPM's analysis"
) +
  #tema -----------------------------------------------------------------------
theme(text = element_text(family = "Montserrat"),
      legend.position = 'top',
      axis.text.y =  element_blank(),
      axis.text.x = element_text(size = 12),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      panel.background = element_rect(fill = "white"),
      plot.background = element_rect(fill = "white"),
      plot.title = element_text(size = 24, color = ndc_colors("blue_navy"), margin = margin(b =15))
)


exfile <- file.path(dir_charts,"alluvial_MOVs.png")

ggsave(exfile,
       last_plot())
