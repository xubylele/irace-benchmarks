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
        if(tail(strsplit(instances_foldernames[i], '/')[[1]], 1) == descriptor_name){

            trainingFiles <- list.files(instances_foldernames[i], pattern = '.*training.*\\.txt$', full.names = TRUE)
            testingFiles <- list.files(instances_foldernames[i], pattern = '.*testing.*\\.txt$', full.names = TRUE)

            if(length(trainingFiles) == 0 && length(testingFiles) == 0){

                subfolders <- list.files(instances_foldernames[i], pattern = '', full.names = TRUE)

                for(j in 1:length(subfolders)){
                    trainingFiles <- list.files(subfolders[j], pattern = '.*training.*\\.txt$', full.names = TRUE)
                    
                    for(k in 1:length(trainingFiles)){
                        if(length(tail(strsplit(trainingFiles[k], '-')[[1]], 1)) > 0)
                            instancesSets <- c(instancesSets, tail(strsplit(trainingFiles[k], '-')[[1]], 1))
                    }
                }

            }else{
                if(length(trainingFiles) > 1){
                    for(j in 1:length(trainingFiles)){
                        instancesSets <- c(instancesSets, tail(strsplit(trainingFiles[j], '-')[[1]], 1))
                    }
                }else{
                    instancesSets <- c(instancesSets, tail(strsplit(instances_foldernames[i], '/')[[1]], 1))
                }
            }
            return(instancesSets)
        }
    }
}

countInstancesSets <- function(){
    descriptors <- getInstancesDescriptors()
    count <- 0
    for(i in 1:length(descriptors)){
        count = count + length(searchInstanceDescriptorSets(descriptors[i]))
    }
    return(count)
}