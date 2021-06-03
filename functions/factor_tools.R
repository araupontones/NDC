#clean factors of tools table



factors_tools <- function(db){
  
  
  db %>%
    mutate(framework = str_replace(framework, "Intermediary", "Int."),
           MOV = case_when(MOV == "OPM is reviewing global best practice" ~ "OPM rev.",
                           MOV == "Online partership plan" ~ "Online P.P",
                           MOV == "Needs clarify reporting tool" ~ "Clarifying",
                           MOV == "Annual member surveys" ~ "Annual srvy.",
                           T ~ MOV),
           framework = factor(framework,
                              levels = rev(c("Output",
                                             "Int.Outcome",
                                             "Outcome",
                                             "Impact")),
                              ordered = T
           ),
           
           frequency = factor(frequency,
                              levels = c("Monthy",
                                         "Quarterly",
                                         "Bi-annually",
                                         "Yearly",
                                         "Uknown"
                              ),
                              ordered = T),
           
           frequency = forcats::fct_recode(frequency, `Yearly +` = "Yearly"),
           
           type = factor(type,
                         levels = c("Secondary",
                                    "Primary",
                                    "Uknown"),
                         ordered = T),
           MOV = factor(MOV,
                              levels = c("OPM rev.",
                                         "Annual srvy.",
                                         "Online P.P",
                                         "Monday",
                                         "KNOOK",
                                         "Clarifying"),
                              ordered = T)
    )
  
}
