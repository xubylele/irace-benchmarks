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
        
        cli_li(targets[i])
        
    }
    cli_end()

}