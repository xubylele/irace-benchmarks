library(shiny)
library(shinydashboard)
library(shinyjs)
library(htmltools)
library(DT)
xfun::session_info('DT')

#read benchmark data
benchmark_filenames <- list.files('../benchmarks/benchmarks', pattern = '*.txt', full.names = TRUE)

benchmarks <- c()

for(i in 1:length(benchmark_filenames))
  benchmarks[i] <- read.delim(benchmark_filenames[i])

print(benchmarks)



#shiny options
options(shiny.port = 4200)
options(shiny.autoreload = TRUE)

ui <- dashboardPage(skin = "purple",
                    dashboardHeader(title = 'BENCHMARKS'),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("About", tabName = "about_tab", icon = icon("info")),
                        menuItem("Benchmarks", tabName = "benchmarks_tab", icon = icon("tachometer")),
                        menuItem("Scenarios", tabName = "scenarios_tab", icon = icon("folder")),
                        menuItem("Instances", tabName = "instances_tab", icon = icon("cubes")),
                        menuItem("Parameters", tabName = "parameters_tab", icon = icon("wrench")),
                        menuItem("Targets", tabName = "targets_tab", icon = icon("terminal"))
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        
                        #about tab
                        
                        tabItem(tabName = "about_tab",
                          htmltools::withTags(
                            div(
                              class = 'conteiner',
                              div(
                                class = 'card',
                                div(
                                  class = 'card-body',
                                  h3(class = 'card-title', 'Repository'),
                                  'IRACE benchmarks repository:',
                                  a("GitHub Benchmarks", href = 'https://github.com/xubylele/irace-benchmarks')
                                )
                              )
                            )
                          )
                        ),
                        
                        
                        
                        tabItem(tabName = "benchmarks_tab",
                          htmltools::withTags(
                            div(
                              class = 'container ',
                              h1('Benchmarks'),
                              DT::dataTableOutput("benchmark_list")
                            )
                          )
                        )
                      )
                    )
)

server <- function(input, output, session) {
  
  output$benchmark_list <- DT::renderDataTable(
      data.frame(
        Title = 'lala',
        Description = 'lolo',
        stringsAsFactors = TRUE
      ),
      
  )
  
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)