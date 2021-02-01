library(here)


web <- function(){
    dir <- here("app", "shinyApp.r")

    print(dir)

    source(dir)

}

web()

