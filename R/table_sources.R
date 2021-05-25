#ralluial of MOV by M&E framework

#read data -------------------------------------------------------------------
indicators_raw <- read_raw("Indicators") %>%
  group_by(MOV) %>%
  select(MOV, Indicator) %>%
  slice(1)

tools_raw <- read_raw("Tools")



tools_clean <- tools_raw %>%
  rename(Source = TOOL,
         Type = Type,
         Frequency = `Frequency of update`,
         Objective = `Objective of tool`,
         `Enters data` = `Who logs data MAIN`) %>%
  left_join(indicators_raw, by = c("Source"= "MOV")) %>%
  mutate(`Map in M&E` = !is.na(Indicator)) %>%
  select(Source, Type, Frequency, Objective, `Enters data`, `Map in M&E`) %>%
  filter(!str_detect(Source, "OPM|needs")) %>%
  mutate(Type = factor(Type,
                       levels = c("Primary", "Secondary"),
                       ordered = T
                       )
         )


names(indicators_raw)

View(tools_clean)

table_sources <-tools_clean %>%
  gt( groupname_col = "Type") %>%
  
  tab_style(
    style = list(
      cell_fill(color = ndc_colors("blue_light")),
      cell_text(weight = "bold",
                color = "white")
    ),
    locations = cells_row_groups()
    
  ) %>%
 
  tab_header(
    
    title = md("**Sources of information**")
    
  ) %>%
  opt_table_font(
    font = c(
      "Montserrat"
    )
  ) %>%
  
  tab_options(

    heading.align = "center",
    heading.background.color = ndc_colors("blue_navy"),
    source_notes.font.size = 12,
    column_labels.background.color = ndc_colors("blue_navy"),


  )

table_sources

exfile <- file.path(dir_charts,"table_sources.png")
?gtsave
gtsave(table_sources, filename = exfile)
  