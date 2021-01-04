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


## about tab
        
  about_tab <- tabItem(tabName = "about_tab",
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
  )

## benchmarks tab
  benchmarks_tab <- tabItem(tabName = "benchmarks_tab",
    htmltools::withTags(
      div(
        class = 'center-block ',
        h1('Benchmarks'),
        div(
          class = 'table-responsive',
          DT::dataTableOutput("benchmark_list")
        )
      )
    )
  , uiOutput('current_page'))

## scenarios tab
  scenarios_tab <- tabItem(tabName = "scenarios_tab",
    htmltools::withTags(
      div(
        class = 'center-block ',
        h1('Scenarios'),
        div(
          class = 'table-responsive',
          DT::dataTableOutput("scenarios_list")
        )
      )
    )
  )

## instances tab
  instances_tab <- tabItem(tabName = "instances_tab",
    htmltools::withTags(
      div(
        class = 'center-block',
        div(
          class = 'row center-block',
          div(
            class = 'col',
            h1('Instances')
          ),
          div(
            class = 'col',
            uiOutput('instances_resume')
          )
        ),
        div(
          class = 'table-responsive',
          DT::dataTableOutput("instances_list")
        )
      )
    )
  )

## parameters tab
  parameters_tab <- tabItem(tabName = "parameters_tab",
    htmltools::withTags(
      div(
        class = 'center-block',
        h1('Parameters'),
        div(
          class = 'table-responsive',
          DT::dataTableOutput("parameters_list")
        )
      )
    )
  )

## targets tab
  targets_tab <- tabItem(tabName = "targets_tab",
    htmltools::withTags(
      div(
        class = 'center-block',
        h1('Targets'),
        div(
          class = 'table-responsive',
          DT::dataTableOutput("targets_list")
        )
      )
    )
  )

## benchmark details
  benchmarks_details <- div(
    h1('Benchmarks'),
    uiOutput('benchmarks_details'),
    h2('Scenarios:'),
    div(
      class = 'table-responsive',
      DT::dataTableOutput("benchmarks_details_scenarios_list")
    )
  )

## scenario details
  scenario_details <- div(
    h1('Scenarios'),
    uiOutput('scenario_details')
  )

## instances descriptor details
  instances_descriptor_details <- div(
    h1('Instances'),
    uiOutput('instances_descriptor_details')
  )

## router
  router <- make_router(
    route("about", about_tab),
    route("benchmarks", benchmarks_tab, NA),
    route("benchmarks_details", benchmarks_details, NA),
    route("scenarios", scenarios_tab, NA),
    route("scenario_details", scenario_details, NA),
    route("instances", instances_tab, NA),
    route("instances_descriptor_details", instances_descriptor_details, NA),
    route("parameters", parameters_tab, NA),
    route("targets", targets_tab, NA)
  )

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
        router$ui
      )
    )
  )