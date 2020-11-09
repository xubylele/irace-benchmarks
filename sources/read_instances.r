### read instances data
    library(here)

    instances_dir <- here('benchmarks', 'instances')
    instances_foldernames <- list.files(instances_dir, pattern = '', full.names = TRUE)

    functions <- here("sources", "functions.r")

    source(functions)

getInstancesDescriptors <- function(){
    instances_descriptors <- c()
    for(i in 1:length(instances_foldernames))
    {
        descriptor <- tail(strsplit(instances_foldernames[i], '/')[[1]], 1)
        instances_descriptors <- c(instances_descriptors, descriptor[1])
    }
    return(instances_descriptors)
}

## search instances descriptor sets function
searchInstanceDescriptorSets <- function(descriptor_name){
    instancesSets <- c()
    for(i in 1:length(instances_foldernames)){
        if(strsplit(instances_foldernames[i], '/')[[1]][4] == descriptor_name){
            trainingFiles <- list.files(instances_foldernames[i], pattern = '*training*', full.names = TRUE)
            testingFiles <- list.files(instances_foldernames[i], pattern = '*testing', full.names = TRUE)
            if(length(trainingFiles) == 0 && length(testingFiles) == 0){
                subfolders <- list.files(instances_foldernames[i], pattern = '', full.names = TRUE)
                for(j in 1:length(subfolders)){
                    instancesSets <- c(instancesSets, strsplit(subfolders[j], '/')[[1]][5])
                }
            }else{
                if(length(trainingFiles) > 1){

                }
                instancesSets <- c(instancesSets, strsplit(instances_foldernames[i], '/')[[1]][4])
            }
            return(instancesSets)
        }
    }
}