packages <- c("shiny", "xfun", "shiny.router", "shinydashboard", "dashboardthemes", "shinyBS", "shinyjs", "htmltools", "DT")
for(p in packages){
    print(p)
    if(!require(p,character.only = TRUE))
        install.packages(p)
    library(p,character.only = TRUE)
}
