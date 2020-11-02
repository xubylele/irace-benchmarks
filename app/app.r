## module used
  library(shiny)
  library(shiny.router)
  library(shinydashboard)
  library(dashboardthemes)
  library(shinyBS)
  library(shinyjs)
  library(htmltools)
  library(DT)
  xfun::session_info('DT')

## creating custom theme object
  customTheme <- shinyDashboardThemeDIY(

    ### general
    appFontFamily = "Arial"
    ,appFontColor = "rgb(0,0,0)"
    ,primaryFontColor = "rgb(0,0,0)"
    ,infoFontColor = "rgb(0,0,0)"
    ,successFontColor = "rgb(0,0,0)"
    ,warningFontColor = "rgb(0,0,0)"
    ,dangerFontColor = "rgb(0,0,0)"
    ,bodyBackColor = "rgb(250,250,250)"

    ### header
    ,logoBackColor = "rgb(35, 35, 35)"

    ,headerButtonBackColor = "rgb(68, 68, 68)"
    ,headerButtonIconColor = "rgb(255,255,255)"
    ,headerButtonBackColorHover = "rgb(210,210,210)"
    ,headerButtonIconColorHover = "rgb(0,0,0)"

    ,headerBackColor = "rgb(68, 68, 68)"
    ,headerBoxShadowColor = "#aaaaaa"
    ,headerBoxShadowSize = "2px 2px 2px"

    ### sidebar
    ,sidebarBackColor = cssGradientThreeColors(
      direction = "down"
      ,colorStart = "rgb(68, 68, 68)"
      ,colorMiddle = "rgb(68, 68, 68)"
      ,colorEnd = "rgb(68, 68, 68)"
      ,colorStartPos = 0
      ,colorMiddlePos = 50
      ,colorEndPos = 100
    )
    ,sidebarPadding = 0

    ,sidebarMenuBackColor = "transparent"
    ,sidebarMenuPadding = 0
    ,sidebarMenuBorderRadius = 0

    ,sidebarShadowRadius = "3px 5px 5px"
    ,sidebarShadowColor = "#aaaaaa"

    ,sidebarUserTextColor = "rgb(255,255,255)"

    ,sidebarSearchBackColor = "rgb(55,72,80)"
    ,sidebarSearchIconColor = "rgb(153,153,153)"
    ,sidebarSearchBorderColor = "rgb(55,72,80)"

    ,sidebarTabTextColor = "rgb(255,255,255)"
    ,sidebarTabTextSize = 13
    ,sidebarTabBorderStyle = "none none solid none"
    ,sidebarTabBorderColor = "rgb(0, 0, 0)"
    ,sidebarTabBorderWidth = 1

    ,sidebarTabBackColorSelected = cssGradientThreeColors(
      direction = "right"
      ,colorStart = "rgb(96, 96, 96)"
      ,colorMiddle = "rgb(96, 96, 96)"
      ,colorEnd = "rgb(96, 96, 96)"
      ,colorStartPos = 0
      ,colorMiddlePos = 30
      ,colorEndPos = 100
    )
    ,sidebarTabTextColorSelected = "rgb(255,255,255)"
    ,sidebarTabRadiusSelected = "0px 0px 0px 0px"

    ,sidebarTabBackColorHover = cssGradientThreeColors(
      direction = "right"
      ,colorStart = "rgb(96, 96, 96)"
      ,colorMiddle = "rgb(96, 96, 96)"
      ,colorEnd = "rgb(96, 96, 96)"
      ,colorStartPos = 0
      ,colorMiddlePos = 30
      ,colorEndPos = 100
    )
    ,sidebarTabTextColorHover = "rgb(255, 255, 255)"
    ,sidebarTabBorderStyleHover = "none none solid none"
    ,sidebarTabBorderColorHover = "rgb(0, 0, 0)"
    ,sidebarTabBorderWidthHover = 1
    ,sidebarTabRadiusHover = "0px 15px 15px 0px"

    ### boxes
    ,boxBackColor = "rgb(255,255,255)"
    ,boxBorderRadius = 5
    ,boxShadowSize = "0px 1px 1px"
    ,boxShadowColor = "rgba(0,0,0,.1)"
    ,boxTitleSize = 16
    ,boxDefaultColor = "rgb(210,214,220)"
    ,boxPrimaryColor = "rgba(44,222,235,1)"
    ,boxInfoColor = "rgb(210,214,220)"
    ,boxSuccessColor = "rgba(0,255,213,1)"
    ,boxWarningColor = "rgb(244,156,104)"
    ,boxDangerColor = "rgb(255,88,55)"

    ,tabBoxTabColor = "rgb(255,255,255)"
    ,tabBoxTabTextSize = 14
    ,tabBoxTabTextColor = "rgb(0,0,0)"
    ,tabBoxTabTextColorSelected = "rgb(0,0,0)"
    ,tabBoxBackColor = "rgb(255,255,255)"
    ,tabBoxHighlightColor = "rgba(44,222,235,1)"
    ,tabBoxBorderRadius = 5

    ### inputs
    ,buttonBackColor = "rgb(12,89,207)"
    ,buttonTextColor = "rgb(250,250,250)"
    ,buttonBorderColor = "rgb(0,0,0)"
    ,buttonBorderRadius = 5

    ,buttonBackColorHover = "rgb(0,150,255)"
    ,buttonTextColorHover = "rgb(250,250,250)"
    ,buttonBorderColorHover = "rgb(0,0,0)"

    ,textboxBackColor = "rgb(255,255,255)"
    ,textboxBorderColor = "rgb(200,200,200)"
    ,textboxBorderRadius = 5
    ,textboxBackColorSelect = "rgb(245,245,245)"
    ,textboxBorderColorSelect = "rgb(200,200,200)"

    ### tables
    ,tableBackColor = "rgb(255, 255, 255)"
    ,tableBorderColor = "rgb(240, 240, 240)"
    ,tableBorderTopSize = 2
    ,tableBorderRowSize = 2

  )

## shiny options
  options(shiny.port = 4200)
  options(shiny.autoreload = TRUE)



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
## router
  router <- make_router(
    route("about", about_tab),
    route("benchmarks", benchmarks_tab, NA),
    route("benchmarks_details", benchmarks_details, NA),
    route("scenarios", scenarios_tab, NA),
    route("scenario_details", scenario_details, NA),
    route("instances", instances_tab, NA),
    route("parameters", parameters_tab, NA)
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

      router_ui()
    )
  )
  )

## server 
  server <- shinyServer(function(input, output, session) {
    router(input, output, session)

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

    ## evenet handle
      observeEvent(input$select_button, {
        if (is_page("benchmarks")) {
          change_page("benchmarks_details")
          loadBenchmarkDetails(strsplit(input$select_button, "#")[[1]][2])

        }else if(is_page("scenarios")){
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
              div(class = 'col-xs-6 col-sm-3',
                lapply(1:length(benchmark_descriptors), function(i) {
                  p(paste0(benchmark_descriptors[i]))
                })
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
        print(scenario[2])
        print(paste('../benchmarks/', scenario[2], sep = ''))
        output$scenario_details <- renderUI({
          div(
            h3(paste('Name: ', scenario[1])),
            h4(paste('File: ', scenario[2])),
            h4(paste('Target: ', scenario[3])),
            div(class = 'row',
              div(class = 'col-xs-6 col-sm-3',
                h4('Descriptors: ')
              ),
              div(class = 'col-xs-6 col-sm-3',
                lapply(1:length(scenario_descriptors), function(i) {
                  p(paste0(scenario_descriptors[i]))
                })
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

### Create Shiny object
  shinyApp(ui, server)