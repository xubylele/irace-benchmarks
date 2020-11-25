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

list_scenarios_by_name <- function(){
    cat('\n')
    cli_ol()
    scenarios <- getScenariosNames()
    for(i in 1:length(scenarios)){
        cli_li(paste0('Scenario ', i, ': ', scenarios[i]))
    }
    cli_end()
}

add_scenarios <- function(){

    cli_alert('List of currect scenarios')
    list_scenarios_by_name()

    scenarios <- c()

    

}

search_scenario_console <- function(){
    mise()
    cli_alert('Please enter the name of the scenario or "return" to get back to main menu')
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