library(shiny)
library(shiny.router)
library(here)

source(here("sources", "read_scenarios.r"))
source(here("sources", "read_benchmarks.r"))
source(here("sources", "read_instances.r"))
source(here("sources", "read_parameters.r"))
source(here("sources", "read_targets.r"))
source(here("sources", "functions.r"))

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

## server
  server <- shinyServer(function(input, output, session) {
    
    router$server(input, output, session)

    change_page('about')

    ## benchmark dataframe
      benchmark_dt <- data.frame(
        Name = getBenchmarksNames(),
        Description = getBenchmarksDescriptions(),
        Sizes = getBenchmarksSizes(),
        Scenarios = getBenchmarksScenarios(),
        Descriptors = getBenchmarksDescriptors(),
        Options = shinyInput(actionButton, length(getBenchmarksDescriptors()), 'button#', getBenchmarksNames(),label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' ),
        stringsAsFactors = FALSE
      )

    ## scenario dataframe
      scenario_dt <- data.frame(
        Name = getScenariosNames(),
        Descriptors = getScenariosDescriptors(),
        Options = shinyInput(actionButton, length(getScenariosNames()), 'button#', getScenariosNames(),label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' )
      )

    ## isntances dataframe
      instances_dt <- data.frame()
      instances_descriptors <- getInstancesDescriptors()
      if(length(instances_descriptors) > 0){
        instances_dt <- data.frame(
          Descriptor = instances_descriptors,
          Options = shinyInput(actionButton, length(instances_descriptors), 'button#', instances_descriptors, label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' )
        )
      }

    ## parameters dataframe
      parameters_dt <- data.frame(
        File = get_parameter_sets()
      )

    ## targets dataframe
      targets_dt <- data.frame(
        Name = get_targets()
      )
    ## output table benchmark
      output$benchmark_list <- DT::renderDataTable(benchmark_dt,
        style = 'bootstrap',
        class = 'display table-bordered table-striped table-hover',
        server = FALSE, 
        escape = FALSE, 
        selection = 'none',
        extensions = 'Buttons',
        options = list(
          autoWidth = FALSE,
          columnDefs = list(list(className = 'dt-center', targets = 0:6)),
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'pdf'),
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
            "}"
          )
        )
      )

    ## output table scenarios
      output$scenarios_list <- DT::renderDataTable(scenario_dt,
        style = 'bootstrap',
        class = 'display table-bordered table-striped table-hover',
        server = FALSE, 
        escape = FALSE, 
        selection = 'none',
        extensions = 'Buttons',
        options = list(
          autoWidth = FALSE,
          columnDefs = list(list(className = 'dt-center', targets = 0:3)),
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'pdf'),
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
            "}"
          )
        )
      )

    ## output table instances
      output$instances_list <- DT::renderDataTable(instances_dt,
        style = 'bootstrap',
        class = 'display table-bordered table-striped table-hover',
        server = FALSE, 
        escape = FALSE, 
        selection = 'none',
        extensions = 'Buttons',
        options = list(
          autoWidth = FALSE,
          columnDefs = list(list(className = 'dt-center', targets = 0:2)),
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'pdf'),
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
            "}"
          )
        )
      )

    ## output instances resume
      output$instances_resume <- renderUI({
        div(
          h4(paste('Count of instances descriptors: ', length(instances_descriptors))),
          h4(paste('Count of instances sets: ', countInstancesSets()))
        )
      })

    ## output table parameters
      output$parameters_list <- DT::renderDataTable(parameters_dt,
        style = 'bootstrap',
        class = 'display table-bordered table-striped table-hover',
        server = FALSE, 
        escape = FALSE, 
        selection = 'none',
        extensions = 'Buttons',
        options = list(
          autoWidth = FALSE,
          columnDefs = list(list(className = 'dt-center', targets = 0:1)),
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'pdf'),
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
            "}"
          )
        )
      )

    ## output table targets
      output$targets_list <- DT::renderDataTable(targets_dt,
        style = 'bootstrap',
        class = 'display table-bordered table-striped table-hover',
        server = FALSE, 
        escape = FALSE, 
        selection = 'none',
        extensions = 'Buttons',
        options = list(
          autoWidth = FALSE,
          columnDefs = list(list(className = 'dt-center', targets = 0:1)),
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'pdf'),
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
            "}"
          )
        )
      )

    ## evenet handle
      observeEvent(input$select_button, {
        if (is_page("benchmarks")) {

          change_page("benchmarks_details")
          loadBenchmarkDetails(strsplit(input$select_button, "#")[[1]][2])

        }else if(is_page("scenarios") || is_page("benchmarks_details")){

          change_page("scenario_details")
          loadScenarioDetails(strsplit(input$select_button, "#")[[1]][2])

        }else if(is_page("instances")){

          change_page("instances_descriptor_details")
          loadInstancesDescriptorDetails(strsplit(input$select_button, "#")[[1]][2])

        } else {
          showModal(modalDialog(
            title = "DETAILS",
            paste("This gonna be a details page for ", input$select_button),
            easyClose = TRUE
          ))
        }
      })

    

  

    

    ## load benchmarks details function
      loadBenchmarkDetails <- function(benchmark_name){
        benchmark <- searchBenchmark(benchmark_name)
        scenarios_list <- strsplit(benchmark[4], ", ")[[1]]
        scenarioList_dt <- data.frame(
          Scenario = scenarios_list,
          Options = shinyInput(actionButton, length(scenarios_list), 'button#', scenarios_list,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' ),
          stringsAsFactors = FALSE
        )
        benchmark_descriptors <- strsplit(benchmark[5], ", ")[[1]]
        output$benchmarks_details <- renderUI({
          div(
            h3(paste('Name: ', benchmark[1])),
            h4(paste('Description: ', benchmark[2])),
            h4(paste('Size: ', benchmark[3])),
            div(class = 'row',
              div(class = 'col-xs-6 col-sm-3',
                h4('Descriptors: ')
              ),
              div(class = 'col',
                div(
                  class = 'button-group',
                  lapply(1:length(benchmark_descriptors), function(i) {
                    actionButton("button", benchmark_descriptors[i])
                  })
                )
              )
            )
          )
        })
        output$benchmarks_details_scenarios_list <- DT::renderDataTable(scenarioList_dt,
            style = 'bootstrap',
          class = 'display table-bordered table-striped table-hover',
          server = FALSE, 
          escape = FALSE, 
          selection = 'none',
          extensions = 'Buttons',
          options = list(
            autoWidth = FALSE,
            columnDefs = list(list(className = 'dt-center', targets = 0:2)),
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'pdf'),
            initComplete = JS(
              "function(settings, json) {",
              "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
              "}"
            )
          )
        )
      }

    ## load scenario details
      loadScenarioDetails <- function(scenario_name) {
        scenario <- searchScenario(scenario_name)
        scenario_descriptors <- strsplit(scenario[5], ", ")[[1]]
        output$scenario_details <- renderUI({
          div(
            h3(paste('Name: ', scenario[1])),
            h4(paste('File: ', scenario[2])),
            h4(paste('Target: ', scenario[3])),
            div(class = 'row',
              div(class = 'col-xs-6 col-sm-3',
                h4('Descriptors: ')
              ),
              div(class = 'col',
                div(
                  class = 'button-group',
                  lapply(1:length(scenario_descriptors), function(i) {
                    actionButton("button", scenario_descriptors[i])
                  })
                )
              )
            ),
            h2('Scenario configurations:'),
            div(
              class = 'mt-2',
              pre(includeText(paste('../benchmarks/', scenario[2], sep = '')))
            )
          )
        })
      }

    ## load instances descriptor Details
      loadInstancesDescriptorDetails <- function(name){
        instancesSets <- searchInstanceDescriptorSets(name)
        output$instances_descriptor_details <- renderUI({
          DT::dataTableOutput("instances_sets_list")
        })

        instances_sets_dt <- data.frame(
          Filename = instancesSets,
          Descriptor = name,
          Options = shinyInput(actionButton, length(instancesSets), 'button#', instancesSets,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' ),
          stringsAsFactors = FALSE
        )

        output$instances_sets_list <- DT::renderDataTable(instances_sets_dt,
          style = 'bootstrap',
          class = 'display table-bordered table-striped table-hover',
          server = FALSE, 
          escape = FALSE, 
          selection = 'none',
          extensions = 'Buttons',
          options = list(
            autoWidth = FALSE,
            columnDefs = list(list(className = 'dt-center', targets = 0:3)),
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'pdf'),
            initComplete = JS(
              "function(settings, json) {",
              "$(this.api().table().header()).css({'background-color': '#444444', 'color': '#fff'});",
              "}"
            )
          )
        )
      }
  
  })