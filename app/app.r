library(shiny)
library(shinydashboard)
library(shinyjs)
library(htmltools)
library(DT)
xfun::session_info('DT')

#read benchmark data
benchmark_filenames <- list.files('../benchmarks/benchmarks', pattern = '*.txt', full.names = TRUE)

benchmarks <- list()

for(i in 1:length(benchmark_filenames))
{
  fileName <- benchmark_filenames[i]
  conn <- file(fileName,open="r")
  linn <-readLines(conn)
  benchmark = c()
  for (j in 1:length(linn)){
    line <- strsplit(linn[j], ": ")
    benchmark[[j]] = list(line[[1]][1], line[[1]][2])
  }

  benchmarks[[i]] <- benchmark
  
  close(conn)
}

benchmarks_names <- list()
benchmarks_descriptions <- list()
benchmarks_sizes <- list()
benchmarks_scenarios <- list()
benchmarks_descriptors <- list()

for(i in 1:length(benchmarks)){
  benchmarks_names[i] = benchmarks[[i]][[1]][2]
  benchmarks_descriptions[i] = benchmarks[[i]][[2]][2]
  benchmarks_sizes[i] = benchmarks[[i]][[3]][2]
  benchmarks_scenarios[i] = benchmarks[[i]][[4]][2]
  benchmarks_descriptors[i] = benchmarks[[i]][[5]][2]
}

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