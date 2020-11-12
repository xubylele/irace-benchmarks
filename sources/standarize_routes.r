standarize_routes <- function(){
    instances_read <- here("sources", "read_instances.r")
    source(instances_read)

    instances_filenames <- c()
    
    instancesDescriptors <- getInstancesDescriptors()
    for(i in 1:length(instancesDescriptors)){
        trainingFiles <- getTrainingInstances(instancesDescriptors[i])
        testingFiles <- getTestingInstances(instancesDescriptors[i])
        instancesFiles <- getNonTrainingAndTestingFiles(instancesDescriptors[i])

        for(i in 1:length(trainingFiles)){
            if(length(trainingFiles[i]) > 0 && !is.na(trainingFiles[i])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(trainingFiles[i]))
            }
        }

        for(i in 1:length(testingFiles)){
            if(length(testingFiles[i]) > 0 && !is.na(testingFiles[i])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(testingFiles[i]))
            }
        }

        for(i in 1:length(instancesFiles)){
            if(length(instancesFiles[i]) > 0 && !is.na(instancesFiles[i])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(instancesFiles[i]))
            }
        }

    }
    
    print(instances_filenames)

    return(TRUE)
}