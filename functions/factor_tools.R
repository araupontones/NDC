#clean factors of tools table



factors_tools <- function(db){
  
  
  db %>%
    mutate(frequency = factor(frequency,
                              levels = c("Monthy",
                                         "Quarterly",
                                         "Bi-annually",
                                         "Yearly",
                                         "Uknown"
                              ),
                              ordered = T),
           type = factor(type,
                         levels = c("Primary",
                                    "Secondary",
                                    "Uknown"),
                         ordered = T)
    )
  
}
