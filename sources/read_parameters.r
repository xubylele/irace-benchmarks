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