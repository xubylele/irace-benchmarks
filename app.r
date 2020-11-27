## install dependencies
    packages <- c("shiny", "xfun", "shiny.router", "shinydashboard", "dashboardthemes", "shinyBS", "shinyjs", "htmltools", "DT", "irace", "cli", "mise", "here", 'zip', 'R.utils')
    for(p in packages){
        print(p)
        if(!require(p,character.only = TRUE))
            install.packages(p, repos = "http://cran.us.r-project.org")
        library(p,character.only = TRUE)
    }

library(cli)
library(mise)
library(here)

compress_instances_dir <- here("sources", "compress_instances.r")
standarize_routes_dir <- here("sources", "standarize_routes.r")


## read commands function
    readCommands <- function(args){
        if(length(args) > 0){
            help <- switch('--help', args)
            print(help)
        }else{
            
        }
    }

## help display function
    help <- function(){
        mise()
        cli_h2("Command List")
        
        cli_h3("General Commands")
        cli_alert("Generate web interface: web")
        cli_alert("Set IRACE folder: irace_folder")
        cli_alert("Clear screen: cls")
        cli_alert("Exit: exit")


        cli_h3("Benchmarks Commands")
        cli_alert("List benchmarks: list_benchmarks")
        cli_alert("Search benchmarks: search_benchmarks")
        cli_alert("Add new benchmark: add_benchmark")

        cli_h3("Scenario Commnands")
        cli_alert("List scenarios: list_scenarios")
        cli_alert("Search scenario: search_scenario")
        cli_alert("Run scenario on IRACE: run_scenario")
        cli_alert("Add scenario to benchmark: add_scenario")
        
        cli_h3("Instances Commands")
        cli_alert("List instances: list_instances")
        cli_alert("Search descriptor: search_descriptor_instance")
        cli_alert("Compress intances files: compress_files")
        cli_alert("Standarize intances files: standarize_files")

        cli_h3("Parameters Commands")
        cli_alert("List parameters: list_parameters")
        cli_alert("Search parameters: search_parameters")

        cli_h3("Targets Commands")
        cli_alert("List targets: list_targets")
        cli_alert("Search targets: search_targets")
        
        wait_for_user()
    }

## wait for user input function
    wait_for_user <- function(){
        repeat{
            cat('\n')
            cat('\n')
            cli_h1("Main Menu")
            cli_alert("Read the command list typing help")
            cat('\n> ')
            user_input <- readLines("stdin",n=1);
            if(user_input != ""){
                if(user_input == "help"){

                    help()

                }else if(user_input == "web"){

                    dir <- here("app", "shinyApp.r")
                    source(dir)
                    wait_for_user()

                }else if(user_input == "compress_files"){
                    source(compress_instances_dir)
                    if(compress_instances()){
                        
                        mise()
                        cli_alert_success("Instances compressed successfully.")
                        wait_for_user()

                    }

                }else if(user_input == "standarize_files"){

                    source(standarize_routes_dir)
                    if(standarize_routes()){
                        
                        mise()
                        cli_alert_success("Instances filenames standarized successfully.")
                        wait_for_user()

                    }

                }else if(user_input == "list_benchmarks"){

                    mise()
                    source(here("sources", "read_benchmarks.r"))
                    list_benchmarks()
                    wait_for_user()

                }else if(user_input == "search_benchmark"){

                    mise()
                    source(here("sources", "read_benchmarks.r"))
                    search_benchmark_console()
                    wait_for_user()

                }else if(user_input == "search_scenario"){

                    mise()
                    source(here("sources", "read_scenarios.r"))
                    search_scenario_console()
                    wait_for_user()

                }else if(user_input == "list_scenarios"){
                    
                    mise()
                    source(here("sources", "read_scenarios.r"))
                    list_scenarios()
                    wait_for_user()
                
                }else if(user_input == 'add_benchmark'){

                    mise()
                    source(here("sources", "read_benchmarks.r"))
                    addBenchmark()
                    wait_for_user()

                }else if(user_input == 'add_scenario'){



                }else if(user_input == "list_instances"){

                    mise()
                    source(here("sources", "read_instances.r"))
                    list_instances()
                    wait_for_user()
                
                }else if(user_input == "run_scenario"){

                    mise()
                    source(here("sources","irace_run.r"))
                    run_scenario()
                    wait_for_user()



                }else if(user_input == "cls"){

                    mise()
                    wait_for_user()
                
                
                }else if(user_input == "irace_folder"){

                    mise()
                    source(here("sources","irace_run.r"))
                    set_irace_folder()
                    wait_for_user()

                }else if(user_input == "search_descriptor_instance"){

                    mise()
                    source(here("sources", "read_instances.r"))
                    search_descriptor_instance()
                    wait_for_user()

                }else if(user_input == "list_parameters"){

                    mise()
                    source(here("sources", "read_parameters.r"))
                    list_parameters()
                    wait_for_user()

                }else if(user_input == 'list_targets'){

                    mise()
                    source(here("sources", "read_targets.r"))
                    listTargets()
                    wait_for_user()

                }else if(user_input == "exit"){

                    quit()

                }
            }
            cli_alert_danger("Please, write an instruction")
        }
    }

## main function
    main <- function(){
        args<-commandArgs(TRUE)
        
        if(length(args) > 0)
            readCommands(args)
        
        mise()

        cli_h1("Welcome to IRACE benchmarks library")

        filename <- here('sources', 'irace_folder.txt')
        if(!file.exists(filename)){
            cli_alert_warning('Please set the irace folder instalation')
        }

        wait_for_user()

    }

## call to main function
    main()