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


        scenarios[[i]] <- c(readFileLines(fileName))
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