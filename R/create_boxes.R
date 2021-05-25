#Create boxes of elements of the systems

#read data ------------------------------------------------------------------



tools_raw <- read_raw("Tools")
users_raw <- read_raw("Users")
indicators_raw <- read_raw("Indicators")


#count elements ---------------------------------------------------------------
number_tools <- tools_raw %>% filter(!str_detect(TOOL, "OPM|needs")) %>% count()
number_users <- nrow(users_raw)
number_indicators <- nrow(indicators_raw)
number_software <- length(unique(tools_raw$Software[!is.na(tools_raw$Software)]))



#create and export boxes ----------------------------------------------------
titulos <- c("Data sources", "Indicators", "Users", "Software")
labels <- c(number_tools, number_indicators, number_users, number_software)
colors <- c("blue_navy", "green", "yellow", "blue_light")



for(i in 1:length(titulos)){
  #see functions
  chart_box(titulo = titulos[i],
            label = labels[i],
            background = colors[i]) 
  
}
