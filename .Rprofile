message("NDC")

library(rio)
library(ggplot2)
library(stringr)
library(tidyr)
library(dplyr)





#library(extrafont)
loadfonts(device = "win")
fonts()

main_font <- "Monterrat"


dropbox <- "C:/Users/andre/Dropbox/NDC"
dropbox_ds <- file.path(dropbox, "1. Data collection design")



dir_functions <- 'functions'
dir_charts <- 'charts'

load_functions <- function(dir){
  
  funciones = list.files(dir, full.names = T, pattern = ".R")
  
  for(funcion in funciones){
    
    message(stringr::str_remove(funcion, dir))
    source(funcion, encoding = 'utf-8')
  }
  
  
}


load_functions(dir_functions)

list.files()
