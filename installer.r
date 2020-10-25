packages <- c("shiny", "shinydashboard", "dashboardthemes", "shinyBS", "shinyjs", "htmltools", "DT")
for(p in packages){
  if(!require(p,character.only = TRUE))
    install.packages(p)
  library(p,character.only = TRUE)
}