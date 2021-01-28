library(here)

benchmarks_dir <- here('benchmarks', 'benchmarks')
benchmarks_filenames <- list.files(benchmarks_dir, pattern = '*.txt', full.names = TRUE)

functions <- here("sources", "functions.r")

source(functions)

getBenchmarksNames <- function(){
    benchmarks_names <- c()
    benchmarks <- getBenchmarksList()
    for(i in 1:length(benchmarks)){
        benchmarks_names[i] = benchmarks[[i]][[1]][[2]]
    }

    return(benchmarks_names)
}

getBenchmarksDescriptions <- function(){
    benchmarks_descriptions <- c()
    benchmarks <- getBenchmarksList()
    for(i in 1:length(benchmarks)){
        benchmarks_descriptions[i] = benchmarks[[i]][[2]][[2]]
    }

    return(benchmarks_descriptions)
}

getBenchmarksSizes <- function(){
    benchmarks_sizes <- c()
    benchmarks <- getBenchmarksList()
    for(i in 1:length(benchmarks)){
        benchmarks_sizes[i] = benchmarks[[i]][[3]][[2]]
    }

    return(benchmarks_sizes)
}

getBenchmarksScenarios <- function(){
    benchmarks_scenarios <- c()
    benchmarks <- getBenchmarksList()
    for(i in 1:length(benchmarks)){
        benchmarks_scenarios[i] = benchmarks[[i]][[4]][[2]]
    }

    return(benchmarks_scenarios)
}

getBenchmarksDescriptors <- function(){
    benchmarks_descriptors <- c()
    benchmarks <- getBenchmarksList()
    for(i in 1:length(benchmarks)){
        benchmarks_descriptors[i] = benchmarks[[i]][[5]][[2]]
    }

    return(benchmarks_descriptors)
}

getBenchmarksList <- function(){
    benchmarks_list <- c()
    
    for(i in 1:length(benchmarks_filenames))
    {
        fileName <- benchmarks_filenames[i]


        benchmarks_list[[i]] <- c(readFileLinesSeparatedByColon(fileName))
    }
    return(benchmarks_list)
}

searchBenchmark <- function(benchmark_name){
    for(i in 1:length(getBenchmarksNames())){
        if(getBenchmarksNames()[i] == benchmark_name){
            benchmark <- c(getBenchmarksNames()[i], getBenchmarksDescriptions()[i], getBenchmarksSizes()[i], getBenchmarksScenarios()[i], getBenchmarksDescriptors()[i])
            return(benchmark)
        }
    }
    return(NULL)
}

list_benchmarks <- function(){
    cat('\n')
    cli_ol()
    benchmarks <- getBenchmarksList()
    for(i in 1:length(benchmarks)){
        cli_li(paste0('Benchmark ', i, ':'))
        ulid <- cli_ul()
        cli_li(paste('Name:', benchmarks[[i]][[1]][[2]]))
        cli_li(paste('Description:', benchmarks[[i]][[2]][[2]]))
        cli_li(paste('Size:', benchmarks[[i]][[3]][[2]]))
        cli_li(paste('Scenarios:', benchmarks[[i]][[4]][[2]]))
        cli_li(paste('Descriptors:', benchmarks[[i]][[5]][[2]]))
        cli_end(ulid)
        cat('\n')
    }
    cli_end()
}

search_benchmark_console <- function(){
    mise()
    cli_alert('Please enter the name of the benchmark enter "return" to get back to main menu')
    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            benchmark <- searchBenchmark(user_input)
            if(length(benchmark) == 0){
                cli_alert_danger("Please, write a valid benchmark name")
            }else{
                ulid <- cli_ul()
                cli_li(paste('Name:', benchmark[1]))
                cli_li(paste('Description:', benchmark[2]))
                cli_li(paste('Size:', benchmark[3]))
                cli_li(paste('Scenarios:', benchmark[4]))
                cli_li(paste('Descriptors:', benchmark[5]))
                cli_end(ulid)
                cat('\n')
                break
            }
        }else{
            cli_alert_danger("Please, write a benchmark name")
        }
    }
}

addBenchmark <- function(){

    mise()

    


    cli_h2('Actual benchmark list')
    
    cli_alert('Please verificate all the new files')


    list_benchmarks()

    new_benchmark <- c()
    
    cli_alert('Please enter the name of the new benchmark enter "return" to get back to main menu (All changes would be deleted)')


    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                return()
            }

            benchmark <- searchBenchmark(user_input)
            if(length(benchmark) > 0){
                cli_alert_danger(paste(user_input, 'benchmark already exists'))
            }else{
                new_benchmark[1] <- paste0('name: ', user_input)
                cat('\n')
                break
            }
        }else{
            cli_alert_danger("Please, write a benchmark name")
        }
    }


    cli_alert('Please enter the description of the new benchmark enter "return" to get back to main menu (All changes would be deleted)')


    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                return()
            }

            
            new_benchmark[2] <- paste0('description: ', user_input)
            cat('\n')
            break
        
        }else{
            cli_alert_danger("Please, write a benchmark description")
        }
    }


    cli_alert('Please select the scenarios you would like to add to this benchmark enter "return" to get back to main menu (All changes would be deleted)')
    cli_alert("Current scenarios")


    new_benchmark[4] <- paste0('scenarios: ', read_user_scenarios())
    new_benchmark[3] <- paste0('size: ', length(strsplit(new_benchmark[4], ', ')[[1]]))
    new_benchmark[5] <- paste0('descriptors: ', read_user_descriptors())

    str_to_return <- strsplit(new_benchmark, ': ')[[1]]
    
    fileName <- paste0(benchmarks_dir, '/', str_to_return[2], '.txt')


    file.create(fileName)

    fileConn<-file(fileName)
    writeLines(new_benchmark, fileConn)
    close(fileConn)
    
    

    

}

read_user_scenarios <- function(){

    source(here("sources", "read_scenarios.r"))
    mise()

    
    cli_alert('Please enter "add" to enter a new benchmark or "return" to get back to main menu')

    scenarios = c()

    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                return()
            }else if(user_input == 'end'){
                
                return(scenarios)

            }else{
                scenario <- add_scenarios()
                if(length(scenarios) == 0){

                    scenarios <- paste0(scenarios, scenario)

                }
                else{

                    scenarios <- paste0(scenarios, ', ', scenario)

                }

                cli_alert('Scenario added successfully, if you want to add another scenario to this benchmark, type add')
                cli_alert('if you finished adding scenarios, enter "end"')
            }

        
        }else{
            cli_alert_danger("Please, write a instruction")
        }
    }

}

read_user_descriptors <- function(){

    mise()

    descriptors <- c()
    
    cli_alert('Please enter a descriptor of the new benchmark or enter "return" to get back to main menu')


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
            cli_alert_danger("Please, write a benchmark name")
        }
    }

}