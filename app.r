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
        wait_for_user()
    }

## wait for user input function
    wait_for_user <- function(){
        cat('\n> ')
        repeat{
            user_input <- readLines("stdin",n=1);
            if(user_input != ""){
                if(user_input == "help"){
                    help()
                }
                if(user_input == "web"){
                    dir <- here("app", "shinyApp.r")
                    source(dir)
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