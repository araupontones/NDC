#' chart alluvial

chart_alluvial <- function(by,
                           pal_by =c(ndc_colors("green"),
                                     ndc_colors("blue_navy"),
                                     ndc_colors("purple"),
                                     ndc_colors("yellow"),
                                     'grey')){
  
  #name of the argument pass by
  nm <-deparse(substitute(by))

  ggplot(data = indicators_alluvial,
         aes(y = freq, 
             axis1 = MOV, 
             axis2 = framework)
  ) +
    #create lines that connect axis----------------------
  geom_alluvium(aes(fill = {{by}}), 
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
  scale_fill_manual(values = pal_by, 
                    name = ""
  ) +
    #title and captions ---------------------------------------------------------
  labs(title = "MOVs and M&E framework.",
       subtitle = glue("By data {nm}."),
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
        plot.title = element_text(size = 24, color = ndc_colors("blue_navy"), margin = margin(b =2)),
        plot.subtitle = element_text(size = 18, color = ndc_colors("blue_grey"), margin = margin(b =10))
  )
  
  
  
  exfile <- file.path(dir_charts,glue("alluvial_MOVs_{nm}.png"))
  
  ggsave(exfile,
         last_plot(),
         width = 15.11,
         height = 13.5,
         units = 'cm')
  
  
}
