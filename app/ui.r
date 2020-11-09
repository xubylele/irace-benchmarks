## Used libraries
  library(shiny)
  library(shiny.router)
  library(shinydashboard)
  library(dashboardthemes)
  library(shinyBS)
  library(shinyjs)
  library(htmltools)
  library(DT)
  xfun::session_info('DT')

## sources files
  source('ui/customTheme.r')


## shiny ui
  ui <- shinyUI(
    dashboardPage(
    
      dashboardHeader(
        title = 'BENCHMARKS'
      ),
      dashboardSidebar(
        sidebarMenu(
          menuItem("About", icon = icon("info"), href = route_link('about'), newtab = FALSE),
          menuItem("Benchmarks", icon = icon("tachometer"), href = route_link('benchmarks'), newtab = FALSE),
          menuItem("Scenarios", icon = icon("folder"), href = route_link('scenarios'), newtab = FALSE),
          menuItem("Instances", icon = icon("cubes"), href = route_link('instances'), newtab = FALSE),
          menuItem("Parameters", icon = icon("wrench"), href = route_link('parameters'), newtab = FALSE),
          menuItem("Targets", icon = icon("terminal"), href = route_link('targets'), newtab = FALSE)
        )
      ),
      dashboardBody(

        customTheme,
        router_ui()
      )
    )
  )