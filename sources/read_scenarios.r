library(here)

scenarios_dir <- here('benchmarks', 'scenarios')
scenarios_filenames <- list.files(scenarios_dir, pattern = '*.txt', full.names = TRUE)

functions <- here("sources", "functions.r")

source(functions)


getScenariosNames <- function(){
    scenarios_names <- c()
    scenarios <- getScenariosList()

    for(i in 1:length(scenarios)){
        scenarios_names[i] = scenarios[[i]][[1]][[2]]
    }

    return(scenarios_names)
}

getScenariosFiles <- function(){
    scenarios_file <- c()
    scenarios <- getScenariosList()

    for(i in 1:length(scenarios)){
        scenarios_file[i] = scenarios[[i]][[2]][[2]]
    }

    return(scenarios_file)
}

getScenariosTargets <- function(){
    scenarios_target <- c()
    scenarios <- getScenariosList()

    for(i in 1:length(scenarios)){
        scenarios_target[i] = scenarios[[i]][[3]][[2]]
    }

    return(scenarios_target)
}

getScenariosParameters <- function(){
    scenarios_parameters <- c()
    scenarios <- getScenariosList()

    for(i in 1:length(scenarios)){
        scenarios_parameters[i] = scenarios[[i]][[4]][[2]]
    }

    return(scenarios_parameters)
}

getScenariosInstances <- function(){
    scenarios_instances <- c()
    scenarios <- getScenariosList()

    for(i in 1:length(scenarios)){
        scenarios_instances[i] = scenarios[[i]][[5]][[2]]
    }

    return(scenarios_instances)
}

getScenariosDescriptors <- function(){
    scenarios <- getScenariosList()
    scenarios_descriptors <- c()

    for(i in 1:length(scenarios)){
        scenarios_descriptors[i] = scenarios[[i]][[6]][[2]]
    }

    return(scenarios_descriptors)
}

getScenariosList <- function(){
    scenarios <- c()
    
    for(i in 1:length(scenarios_filenames))
    {
        fileName <- scenarios_filenames[i]


        scenarios[[i]] <- c(readFileLinesSeparatedByColon(fileName))
    }
    return(scenarios)
}

searchScenario <- function(scenario_name){
    scenarios_names <- getScenariosNames()
    for(i in 1:length(scenarios_names)){
        if(scenarios_names[i] == scenario_name){
            scenario <- c(scenarios_names[i], getScenariosFiles()[i], getScenariosTargets()[i], getScenariosParameters()[i], getScenariosDescriptors()[i])
            return(scenario)
        }
    }
}

list_scenarios <- function(){
    cat('\n')
    cli_ol()
    scenarios <- getScenariosList()
    for(i in 1:length(scenarios)){
        cli_li(paste0('Scenario ', i, ':'))
        ulid <- cli_ul()
        cli_li(paste('Name:', scenarios[[i]][[1]][[2]]))
        cli_li(paste('Files:', scenarios[[i]][[2]][[2]]))
        cli_li(paste('Targets:', scenarios[[i]][[3]][[2]]))
        cli_li(paste('Parameters:', scenarios[[i]][[4]][[2]]))
        cli_li(paste('Instances:', scenarios[[i]][[5]][[2]]))
        cli_li(paste('Descriptors:', scenarios[[i]][[6]][[2]]))
        cli_end(ulid)
        cat('\n')
    }
    cli_end()
}

user_write_scenario_name <- function(){

    mise()


    cli_h2('Actual scenarios list')


    list_scenarios_by_name()

    new_scenario <- c()
    
    cli_alert('Please enter the name of the new scenario enter "return" to get back to main menu (All changes would be deleted)')


    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                return()
            }

            scenario <- searchScenario(user_input)
            if(length(scenario) > 0){
                cli_alert_danger(paste(user_input, 'already exists'))
            }else{
                new_scenario <- user_input
                cat('\n')
                return(new_scenario)
            }
        }else{
            cli_alert_danger("Please, write a scenario name")
        }
    }

}

list_scenarios_dirnames <- function(){

    dirs <- list.dirs(scenarios_dir, recursive = FALSE)

    new_scenario <- c()

    scenario_name <- user_write_scenario_name()
    
    print(scenario_name)


    if(length(scenario_name) == 0){
        return()
    }else{
        new_scenario[1] <- paste0('name: ', scenario_name)
    }

    cli_alert('Please enter the number of the folder')
    cat('\n')
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
                    
                    file <- list_files_folder(dirs[user_input])

                    str_split <- strsplit(file, '/')[[1]]

                    file <- ''

                    for(i in (length(str_split)-2):length(str_split)){
                        file <- paste0(file, '/', str_split[i])
                    }

                    new_scenario[2] <- paste0('file: ', file)
                    new_scenario[3] <- paste0('target: ', get_targets_file())
                    new_scenario[4] <- paste0('parameters: ', get_parameters_file())
                    new_scenario[5] <- paste0('instances: ',get_instances_file())

                    print(new_scenario)

                    return(new_scenario)

                    if(length(file) == 0){
                        return()
                    }
                    break
                
                }

            }else{
                cli_alert_danger("Please, write a number")
            }
            
        }else{
            cli_alert_danger("Please, write a number")
        }
    }

}

get_targets_file <- function(){

    targets <- here("sources", "read_targets.r")

    source(targets)

    return(selet_targets())

}

get_parameters_file <- function(){

    parameters <- here("sources", "read_parameters.r")

    source(parameters)

    return(selet_parameters())

}

get_instances_file <- function(){

    isntances <- here("sources", "read_instances.r")

    source(isntances)

    return(selet_instances())

}

list_files_folder <- function(dirname){

    cat('\n')
    files <- list.files(dirname, pattern = '*.txt', recursive = FALSE, full.names = TRUE)

    cli_alert('Please select the number of the scenario file')
    cat('\n')
    cli_ol()
    for(i in 1:length(files)){
        cli_li(paste0('Filename: ', files[i]))
    }

    cli_end()


    repeat{

        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                return()
            }

            user_input <- strtoi(user_input)

            if(!is.na(user_input)){
                if(user_input > length(files) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of folder")

                }else{
                    
                    return(files[user_input])
                
                }

            }else{
                cli_alert_danger("Please, write a number")
            }
            
        }else{
            cli_alert_danger("Please, write a number")
        }
    }

}

list_scenarios_by_name <- function(){
    cat('\n')
    cli_ol()
    scenarios <- getScenariosNames()
    for(i in 1:length(scenarios)){
        cli_li(paste0('Scenario ', i, ': ', scenarios[i]))
    }
    cli_end()
    cat('\n')
}

read_user_descriptors <- function(){

    mise()

    descriptors <- c()
    
    cli_alert('Please enter a descriptor of the new scenario or enter "return" to get back to main menu (All changes would be deleted)')


    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                return()
            }else if(user_input == 'end'){
                
                return(descriptors)

            }else{
                if(length(descriptors) == 0)
                    descriptors <- paste0(descriptors, user_input)
                else
                    descriptors <- paste0(descriptors, ', ', user_input)

                cli_alert('If you finished adding descriptors, enter "end"')
            }
        }else{
            cli_alert_danger("Please, write a scenario name")
        }
    }

}



add_scenarios <- function(){

    cli_alert('List of currect scenarios')
    list_scenarios_by_name()

    scenarios <- getScenariosList()
    scenarios_to_add <- c()

    cli_alert('Please enter the number of the scenario to add it to the benchmark, enter -1 to add new scenario enter "return" to get back to main menu')
    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            user_input <- strtoi(user_input)

            if(user_input == -1){

                cli_alert('Please select the folder of the scenary file')
                scenario <- list_scenarios_dirnames()

                #scenario[6] <- paste0('descriptors: ', read_user_descriptors())

                break


            }else if(!is.na(user_input)){
                if(user_input > length(scenarios) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of scenario")

                }else{
                    
                    print(scenarios[[user_input]][[1]][[2]])
                    scenario <- searchScenario(scenarios[[user_input]][[1]][[2]])
                    cli_alert(scenario[1])
                    cat('\n')
                    break
                
                }

            }else{
                cli_alert_danger("Please, write a number")
            }
            
        }else{
            cli_alert_danger("Please, write a number")
        }
    }

}

search_scenario_console <- function(){
    mise()
    cli_alert('Please enter the name of the scenario enter "return" to get back to main menu')
    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                print('return')
                break
            }

            scenario <- searchScenario(user_input)
            if(length(scenario) == 0){
                cli_alert_danger("Please, write a valid scenario name")
            }else{
                ulid <- cli_ul()
                cli_li(paste('Name:', scenario[1]))
                cli_li(paste('Files:', scenario[2]))
                cli_li(paste('Targets:', scenario[3]))
                cli_li(paste('Parameters:', scenario[4]))
                cli_li(paste('Instances:', scenario[5]))
                cli_li(paste('Descriptors:', scenario[6]))
                cli_end(ulid)
                cat('\n')
                break
            }
        }else{
            cli_alert_danger("Please, write a scenario name")
        }
    }
}