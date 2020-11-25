functions <- here("sources", "functions.r")

source(functions)
source(here("sources", "read_scenarios.r"))

set_irace_folder <- function(){
    cat("\n")
    filename <- here('sources', 'irace_folder.txt')
    if(file.exists(filename)){
        filelines <- readFileLines(filename)[[1]][[1]]
        cli_alert(paste('Foldername:', filelines))
        cli_alert('Write a new irace foldername or "return" to get back to main menu.')
        repeat{
            cat('\n> ')
            user_input <- readLines("stdin",n=1)
            if(user_input != ""){

                if(user_input == 'return'){
                    break
                }
                file.remove(filename)
                file.create(filename)
                fileConn<-file(filename)
                writeLines(user_input, fileConn)
                close(fileConn)
                cli_alert_success('Irace folder set successfully')
                break
            }else{
                cli_alert_danger("Please, write a valid filename")
            }
        }
    }else{
        file.create(filename)
        cli_alert('Please write the irace instalation folder or "return" to get back to main menu.')
        repeat{
            cat('\n> ')
            user_input <- readLines("stdin",n=1)
            if(user_input != ""){

                if(user_input == 'return'){
                    break
                }

                fileConn<-file(filename)
                writeLines(user_input, fileConn)
                close(fileConn)
                cli_alert_success('Irace folder set successfully')
                break
            }else{
                cli_alert_danger("Please, write a valid filename")
            }
        }
    }
}

run_scenario <- function(){

    cat("\n")
    filename <- here('sources', 'irace_folder.txt')
    if(file.exists(filename)){
        filelines <- readFileLines(filename)[[1]][[1]]
        cli_alert('Enter a scenario name')
        repeat{
            cat('\n> ')
            user_input <- readLines("stdin",n=1)
            if(user_input != ""){

                if(user_input == 'return'){
                    break
                }
                
                scenario <- searchScenario(user_input)
                print(scenario)


                if(length(scenario) == 0)
                    cli_alert_danger("Please, write a valid scenario name")
                else{
                    library("irace", lib.loc=filelines)

                    scenario <- irace::readScenario(here('benchmarks', scenario[2]))

                    irace::irace.main(scenario = scenario)

                    break
                }
            }else{
                cli_alert_danger("Please, write a valid scenario name")
            }
        }
    }else{
        file.create(filename)
        cli_alert_danger('Please first set the irace instalation folder name.')
        
    }

}