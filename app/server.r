library(shiny)
library(shiny.router)

## function to read lines of txt files
  readFileLines <- function(fileName){
    
    conn <- file(fileName,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- strsplit(linn[j], ": ")
      object[[j]] = list(line[[1]][1], line[[1]][2])
    }

    
    close(conn)
    return(object)
  }

## function to read lines isntances files
  readFileLinesInstances <- function(fileName){
        
    conn <- file(fileName,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- strsplit(linn[j], ": ")
      object[[j]] = list(line[[1]][1], fileName)
    }

    
    close(conn)
    return(object)
  }

## shiny inputs, to add action buttons to datatables
  shinyInput <- function(FUN, len, id, strings_id,...) {
    inputs <- character(len)
    for (i in seq_len(len)) {
      inputs[i] <- as.character(FUN(paste0(id, strings_id[[i]]), ...))
    }
    inputs
  }

## print buttons functions
  print_buttons <- function(type, len){
    sprintf(paste('<button>', type,'</button>'))
  }

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
        h1('Instances'),
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

## router
  router <- make_router(
    route("about", about_tab),
    route("benchmarks", benchmarks_tab, NA),
    route("benchmarks_details", benchmarks_details, NA),
    route("scenarios", scenarios_tab, NA),
    route("scenario_details", scenario_details, NA),
    route("instances", instances_tab, NA),
    route("parameters", parameters_tab, NA),
    route("targets", targets_tab, NA)
  )

## server
  server <- shinyServer(function(input, output, session) {
    
    
    router(input, output, session)

    change_page('about')

    ### read benchmark data
      benchmark_filenames <- list.files('../benchmarks/benchmarks', pattern = '*.txt', full.names = TRUE)

      benchmarks <- list()

      for(i in 1:length(benchmark_filenames))
      {
        fileName <- benchmark_filenames[i]
        if(!is.na(fileName) && !length(fileName) == 0){
          benchmarks[[i]] <- readFileLines(fileName)
        }
      }

      benchmarks_names <- c()
      benchmarks_descriptions <- c()
      benchmarks_sizes <- c()
      benchmarks_scenarios <- c()
      benchmarks_descriptors <- c()

      for(i in 1:length(benchmarks)){
        benchmarks_names[i] = benchmarks[[i]][[1]][[2]]
        benchmarks_descriptions[i] = benchmarks[[i]][[2]][[2]]
        benchmarks_sizes[i] = benchmarks[[i]][[3]][[2]]
        benchmarks_scenarios[i] = benchmarks[[i]][[4]][[2]]
        benchmarks_descriptors[i] = benchmarks[[i]][[5]][[2]]
      }

    ### read scenario data
      scenarios_filenames <- list.files('../benchmarks/scenarios', pattern = '*.txt', full.names = TRUE)

      scenarios <- list()

      for(i in 1:length(scenarios_filenames))
      {
        fileName <- scenarios_filenames[i]
        

        scenarios[[i]] <- readFileLines(fileName)
      }

      scenarios_names <- c()
      scenarios_file <- c()
      scenarios_target <- c()
      scenarios_parameters <- c()
      scenarios_instances <- c()
      scenarios_descriptors <- c()

      for(i in 1:length(scenarios)){
        scenarios_names[i] = scenarios[[i]][[1]][[2]]
        scenarios_file[i] = scenarios[[i]][[2]][[2]]
        scenarios_target[i] = scenarios[[i]][[3]][[2]]
        scenarios_parameters[i] = scenarios[[i]][[4]][[2]]
        scenarios_instances[i] = scenarios[[i]][[5]][[2]]
        scenarios_descriptors[i] = scenarios[[i]][[6]][[2]]
      }

    ### read instances data
      instances_foldernames <- list.files('../benchmarks/instances', pattern = '', full.names = TRUE)

      instances <- list()

      for(i in 1:length(instances_foldernames))
      {
        folderName <- instances_foldernames[i]
        instances_fileNames <- list.files(folderName, pattern = '*.txt', full.names = TRUE)
        if(length(instances_fileNames) == 0){
          sub_foldernames <- list.files(folderName, pattern = '', full.names = TRUE)
          for(j in 1:length(sub_foldernames)){
            instances_fileNames <- list.files(sub_foldernames[j], pattern = '*.txt', full.names = TRUE)
            for(k in 1:length(instances_fileNames))
            {
              fileName <- instances_fileNames[j]
              if(!is.na(fileName) && !length(fileName) == 0){
                if(!grepl("readme", fileName)){
                  instances[[i]] <- readFileLinesInstances(fileName)
                }
              }
            }
          }
        }
        else{
          for(j in 1:length(instances_fileNames)){
            fileName <- instances_fileNames[j]
            if(!grepl("scenarios", fileName)){
              instances[[i]] <- readFileLinesInstances(fileName)
            }
          }
        }

        
      }

      instances_file <- c()
      instances_filenames <- c()

      for(i in 1:length(instances)){
        if(length(instances[[i]]) != 0){
          for(j in 1:length(instances[[i]])){
            instances_file[j] = instances[[i]][[j]][[1]]
            instances_filenames[j] = instances[[i]][[j]][[2]]
          }
        }
      }

    ### read parameters data
      parameters_foldernames <- list.files('../benchmarks/target', pattern = '', full.names = TRUE)

      parameters <- list()

      for(i in 1:length(parameters_foldernames))
      {
        folderName <- parameters_foldernames[i]
        scenarios_foldernames <- list.files(folderName, pattern = '', full.names = TRUE)
        for(j in 1:length(scenarios_foldernames)){
          scenarios_filenames <- list.files(scenarios_foldernames[j], pattern = '*.txt', full.names = TRUE)
          parameter_per_folder = list()
          for(k in 1:length(scenarios_filenames)){
            fileName <- scenarios_filenames[k]
            if(!is.na(fileName) && !length(fileName) == 0){
              if(grepl("parameters", fileName)){
                parameter_per_folder[k] = fileName
              }
            }
          }
          if(length(parameter_per_folder) > 0){
            parameters <- c(parameters, parameter_per_folder)
          }
        }
      }

    ## read targets data
      targets_foldernames <- list.files('../benchmarks/target', pattern = '', full.names = TRUE)
      targets <- list()

      for(i in 1:length(targets_foldernames)){
        targets <- c(targets, strsplit(targets_foldernames[i], '/')[[1]][4])
      }

    ## benchmark dataframe
      benchmark_dt <- data.frame(
        Name = benchmarks_names,
        Description = benchmarks_descriptions,
        Sizes = benchmarks_sizes,
        Scenarios = benchmarks_scenarios,
        Descriptors = benchmarks_descriptors,
        Options = shinyInput(actionButton, length(benchmarks_descriptors), 'button#', benchmarks_names,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' ),
        stringsAsFactors = FALSE
      )

    ## scenario dataframe
      scenario_dt <- data.frame(
        Name = scenarios_names,
        Descriptors = scenarios_descriptors,
        Options = shinyInput(actionButton, length(scenarios_names), 'button#', scenarios_names,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' )
      )

    ## isntances dataframe
      instances_dt <- data.frame(
        File = instances_file,
        File_Name = instances_filenames,
        Options = shinyInput(actionButton, length(instances_file), 'button#', instances_file,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' )
      )

    ## parameters dataframe
      parameters_dt <- data.frame(
        File = parameters[[1]],
        Options = shinyInput(actionButton, length(parameters), 'button#', parameters,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)')
      )

    ## targets dataframe
      targets_dt <- data.frame(
        Name = targets,
        Options = shinyInput(actionButton, length(targets), 'button#', targets,label = "Details", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)')
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

    ## evenet handle
      observeEvent(input$select_button, {
        if (is_page("benchmarks")) {
          print(strsplit(input$select_button, "#")[[1]][2])
          change_page("benchmarks_details")
          loadBenchmarkDetails(strsplit(input$select_button, "#")[[1]][2])

        }else if(is_page("scenarios") || is_page("benchmarks_details")){
          change_page("scenario_details")
          loadScenarioDetails(strsplit(input$select_button, "#")[[1]][2])
        } else {
          showModal(modalDialog(
            title = "DETAILS",
            paste("This gonna be a details page for ", input$select_button),
            easyClose = TRUE
          ))
        }
      })

    ## search benchmark function
      searchBenchmark <- function(benchmark_name){
        for(i in 1:length(benchmarks_names)){
          if(benchmarks_names[i] == benchmark_name){
            benchmark <- c(benchmarks_names[i], benchmarks_descriptions[i], benchmarks_sizes[i], benchmarks_scenarios[i], benchmarks_descriptors[i])
            return(benchmark)
          }
        }
      }

    ## search scenario function
      searchScenario <- function(scenario_name){
        for(i in 1:length(scenarios_names)){
          if(scenarios_names[i] == scenario_name){
            scenario <- c(scenarios_names[i], scenarios_file[i], scenarios_target[i], scenarios_parameters[i], scenarios_descriptors[i])
            return(scenario)
          }
        }
      }

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
                  lapply(1:length(benchmarks_descriptors), function(i) {
                    actionButton("button", benchmarks_descriptors[i])
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

  })