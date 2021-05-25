#'@param titulo title of the box
#'@param label label of the box
#'@param background A string of ndc color
#'@param caption A string to refer to the analysis


chart_box <- function(titulo = "Data sources",
                      label = 5,
                      background = "blue_navy",
                      caption = "Based on OPM's analysis"){
  
  ggplot()+
    geom_text(aes(label = label,
                  x = .5,
                  y = .5),
              size = 80,
              color = 'white'
    ) +
    geom_text(aes(label = titulo,
                  y = Inf,
                  x = .5),
              size = 20,
              vjust = 1,
              color = "white")+
    labs(caption= "Based on OPM's analysis")+
    theme(text = element_text(family = "Montserrat"),
          plot.background = element_rect(fill = ndc_colors(background)),
          panel.background = element_rect(fill = ndc_colors(background)),
          panel.grid = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank(),
          plot.caption = element_text(color = "white")
    )
  
  exfile <- file.path(dir_charts, paste0("Box_", titulo, ".png"))
  
  ggsave(exfile, 
         last_plot())
  
  
}



