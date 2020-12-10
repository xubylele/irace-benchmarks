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
        cli_alert('List of available scenarios')
        list_scenarios_by_name()
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


                if(length(scenario) == 0)
                    cli_alert_danger("Please, write a valid scenario name")
                else{
                    library("irace", lib.loc=filelines)

                    scenario[2] <- changue_scenario_routes(scenario[2])
                    
                    scenario <- irace::readScenario(scenario[2])

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

changue_scenario_routes <- function(scenario_file){

    split_by_dot <- strsplit(scenario_file, '[.]')[[1]]

    temp <- paste0(split_by_dot[1], '_temp.', split_by_dot[2])

    temp <- here('benchmarks', temp)

    scenario_file <- here('benchmarks', scenario_file)

    lines <- read.table(scenario_file, sep = " ", quote = "\"'", comment.char = "",
                       col.names = c("conf", "sep", "file"),
                       colClasses = c("character", "character", "character")
                       , encoding = "utf8",
                       fill = TRUE, na.strings = TRUE)

    lines <- lines[complete.cases(lines[,c("conf", "sep", "file")]),]

    for(i in 1:length(lines$file)){

        if(dir.exists(paste0(here('benchmarks'), '/', lines$file[i]))){
            lines$file[i] <- paste0('"', lines$file[i], '"')
        }

        split_by_slash <- strsplit(lines$file[i], '/')[[1]]
        file_to_replace <- c()
        if(length(split_by_slash) > 1){
            array_strings <- split_by_slash
            string <- tail(array_strings, 1)
            
            array_files_strings <- list.files(here('benchmarks'), pattern = string, full.names = TRUE, recursive = TRUE)

            

            for(file in array_files_strings){
                string2 <- tail(strsplit(file, '/')[[1]], 1)
                if(string == string2){
                    file_to_replace <- file
                    lines$file[i] <- paste0('"',file_to_replace,'"')
                }
            }


            
        }else if(length(lines$file[i]) > 0){
            if(is.na(strtoi(lines$file[i]))){
                lines$file[i] <- paste0('"', lines$file[i], '"')
            }
            
        }else if(lines$file[i] == ""){ 
            lines$file[i] <- paste0('"', lines$file[i], '"')
        }
    }

    write.table(lines, temp, na = "NA", append = FALSE, quote = FALSE, row.names = FALSE, col.names = FALSE, sep = " ")

    return(temp)
}