library(here)

targets_dir <- here('benchmarks', 'target')


functions <- here("sources", "functions.r")

source(functions)

### read parameters data
get_targets <- function(){
    targets_foldernames <- unique(dirname(list.files(targets_dir,rec=T)))

    targets <- c()

    for(i in 1:length(targets_foldernames)){
        split_by_slash <- strsplit(targets_foldernames[i], '/')[[1]]

        if(length(split_by_slash) == 1){
            targets <- c(targets, targets_foldernames[i])
        }
    }
    return (targets)
}

listTargets <- function(){

    cat('\n')
    cli_ol()
    targets <- get_targets()
    for(i in 1:length(targets)){
        
        cli <- cli_li(targets[i])
        
    }
    cli_end(cli)

}

selet_targets <- function(){

    dirs <- list.dirs(targets_dir, recursive = FALSE)

    cli_alert('Please select the folder of the target file')

    cli_ol()
    
    for(i in 1:length(dirs)){
        cli_li(paste0('Dir name: ', dirs[i]))
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
                if(user_input > length(dirs) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of folder")

                }else{

                    str_to_return <- ''
                    
                    folder <- dirs[user_input]

                    files <- list.files(folder)

                    str_split <- strsplit(folder, '/')[[1]]

                    folder_to_return <- ''

                    for(i in (length(str_split)-2):length(str_split)){
                        folder_to_return <- paste0(folder_to_return, '/', str_split[i])
                    }

                    str_to_return <- paste0(str_to_return, folder_to_return, ' ')

                    dirs <- list.dirs(folder)

                    if(length(dirs) > 1){
                        str_to_return <- paste(str_to_return, '(source + target runner')
                    }else{
                        str_to_return <- paste(str_to_return, '(target runner')
                    }

                    for(i in 1:length(files)){
                        if(grepl("evaluator", files[i], fixed=TRUE) || grepl("evaluate", files[i], fixed=TRUE)){
                            str_to_return <- paste(str_to_return, ' + target evaluator')
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