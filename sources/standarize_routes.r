standarize_routes <- function(){
    instances_read <- here("sources", "read_instances.r")
    source(instances_read)

    instancesDescriptors <- getInstancesDescriptors()
    for(i in 1:length(instancesDescriptors)){
        trainingFiles <- getTrainingInstances(instancesDescriptors[i])
        testingFiles <- getTestingInstances(instancesDescriptors[i])
        instancesFiles <- getNonTrainingAndTestingFiles(instancesDescriptors[i])

        instances_filenames <- c()
        for(i in 1:length(trainingFiles)){
            if(length(trainingFiles[i]) > 0 && !is.na(trainingFiles[i])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(trainingFiles[i]))
            }
        }

        print(instances_filenames)
    }

    return(TRUE)
}