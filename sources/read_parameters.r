library(here)

targets_dir <- here('benchmarks', 'target')


functions <- here("sources", "functions.r")

source(functions)

### read parameters data
get_parameter_sets <- function(){
    targets_foldernames <- list.dirs(targets_dir, full.names = FALSE)
    targets_foldernames <- targets_foldernames[ grepl('parameters', targets_foldernames) ]
    return (targets_foldernames)
}

list_parameters <- function(){

    cat('\n')
    cli_ol()
    parameters <- get_parameter_sets()
    for(i in 1:length(parameters)){
        
        cli_li(parameters[i])
        
    }
    cli_end()

}

selet_parameters <- function(){

    targets_foldernames <- list.dirs(targets_dir, full.names = TRUE)
    targets_foldernames <- targets_foldernames[ grepl('parameters', targets_foldernames) ]

    cli_alert('Please select the folder of the parameters files')

    cli_ol()
    
    for(i in 1:length(targets_foldernames)){
        cli_li(paste0('Dir name: ', targets_foldernames[i]))
    }

    cli_end()


    repeat{

        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            user_input <- strtoi(user_input)

            if(!is.na(user_input)){
                if(user_input > length(targets_foldernames) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of folder")

                }else{
                    
                    str_to_return <- ''
                    folder <- targets_foldernames[user_input]

                    str_split <- strsplit(folder, '/')[[1]]

                    folder_to_return <- ''

                    for(i in (length(str_split)-2):length(str_split)){
                        folder_to_return <- paste0(folder_to_return, '/', str_split[i])
                    }

                    str_to_return <- paste0(str_to_return, folder_to_return, ', ')


                    files <- list.files(folder, full.names = FALSE)

                    dirs <- list.files(folder, full.names = FALSE)

                    str_to_return <- paste(str_to_return, '(parameters')
                    
                    for(i in 1:length(files)){
                        if(grepl("default", files[i], fixed=TRUE)){
                            str_to_return <- paste(str_to_return, ' + initial configuration')
                        }
                    }
                    
                    str_to_return <- paste0(str_to_return, ')')
                    print(str_to_return)

                    return(str_to_return)
                
                }

            }else{
                cli_alert_danger("Please, write a number")
            }
            
        }else{
            cli_alert_danger("Please, write a number")
        }
    }

}