library(here)

targets_dir <- here('benchmarks', 'target')


functions <- here("sources", "functions.r")

source(functions)

### read parameters data
get_targets <- function(){
    targets_foldernames <- unique(dirname(list.files(targets_dir,rec=T)))
    return (targets_foldernames)
}