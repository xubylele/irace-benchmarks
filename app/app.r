library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyjs)
library(htmltools)
library()

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
                              class = 'container',
                              h1('Benchmarks')
                            )
                          )
                        )
                      )
                    )
)

server <- function(input, output) {
  
  #read benchmark data
  
  
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)