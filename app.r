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
        cli_alert("Generate web interface: web")
        cli_alert("Compress intances files: compress_files")
        cli_alert("Standarize intances files: standarize_files")
        cli_alert("List benchmarks: list_benchmarks")
        cli_alert("Clear screen: cls")
        cli_alert("Exit: exit")
        wait_for_user()
    }

## wait for user input function
    wait_for_user <- function(){
        repeat{
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
                        cli_alert_success("Instances compressed successfully.")
                        wait_for_user()
                    }

                }else if(user_input == "standarize_files"){

                    source(standarize_routes_dir)
                    if(standarize_routes()){
                        cli_alert_success("Instances filenames standarized successfully.")
                        wait_for_user()
                    }

                }else if(user_input == "list_benchmarks"){

                    source(here("sources", "read_benchmarks.r"))
                    list_benchmarks()
                    wait_for_user()

                }else if(user_input == "cls"){

                    mise()
                    cli_alert("Read the command list typing help")
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
        mise(vars = FALSE, figs = FALSE)
        
        if(length(args) > 0)
            readCommands(args)

        cli_h1("Welcome to IRACE benchmarks library")
        cli_alert("Read the command list typing help")

        wait_for_user()

    }

## call to main function
    main()