## install dependencies
    packages <- c("shiny", "xfun", "shiny.router", "shinydashboard", "dashboardthemes", "shinyBS", "shinyjs", "htmltools", "DT", "irace", "cli", "mise", "here")
    for(p in packages){
        print(p)
        if(!require(p,character.only = TRUE))
            install.packages(p, repos = "http://cran.us.r-project.org")
        library(p,character.only = TRUE)
    }

library(cli)
library(mise)
library(here)

zip_instances_dir <- here("sources", "zip_instances.r")
source(zip_instances_dir)

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
        cli_alert("Zip intances files: zip_instances")
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
                }
                if(user_input == "web"){
                    dir <- here("app", "shinyApp.r")
                    source(dir)
                    wait_for_user()
                }
                if(user_input == "zip_instances"){
                    if(zip_instances()){
                        wait_for_user()
                    }
                }
                break
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