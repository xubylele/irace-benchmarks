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