library(R.utils)

functions <- here("sources", "functions.r")

source(functions)

standarize_routes <- function(){
    print('It may take a while...')
    instances_read <- here("sources", "read_instances.r")
    source(instances_read)

    instances_filenames <- c()
    
    instancesDescriptors <- getInstancesDescriptors()
    for(i in 1:length(instancesDescriptors)){
        trainingFiles <- getTrainingInstances(instancesDescriptors[i])
        testingFiles <- getTestingInstances(instancesDescriptors[i])
        instancesFiles <- getNonTrainingAndTestingFiles(instancesDescriptors[i])

        for(j in 1:length(trainingFiles)){
            if(length(trainingFiles[j]) > 0 && !is.na(trainingFiles[j])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(trainingFiles[j]))
            }
        }

        for(j in 1:length(testingFiles)){
            if(length(testingFiles[j]) > 0 && !is.na(testingFiles[j])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(testingFiles[j]))
            }
        }

        for(j in 1:length(instancesFiles)){
            if(length(instancesFiles[j]) > 0 && !is.na(instancesFiles[j])){
                instances_filenames <- c(instances_filenames, readFileLinesInstances(instancesFiles[j]))
            }
        }

    }

    files_not_found <- c()

    pb <- txtProgressBar(min = 0, max = length(instances_filenames), style = 3)
    
    for(i in 1:length(instances_filenames)){

        files_to_change <- c()
        
        head_filename <- instances_filenames[i][[1]][[2]]
        filename <- instances_filenames[i][[1]][[1]]

        file_dir <- dirname(head_filename)

        split_by_dot <- strsplit(filename, '[.]')[[1]]

        extension <- tail(split_by_dot, 1)

        split_by_dot <- head(split_by_dot, n = length(split_by_dot) - 1)

        if(length(split_by_dot) > 0)
        {
            

            split_by_slash <- strsplit(split_by_dot[1], '/')[[1]]

            if(length(split_by_slash) > 0){

                split_by_dot[1] <- tail(split_by_slash, 1)
                
            }


            files <- list.files(file_dir, pattern=split_by_dot[1], recursive = T, full.names = T)

            if(!is.na(files[1])){

                split_by_dot_2 <- strsplit(files[1], '[.]')[[1]]

                split_by_dot_2 <- paste0(split_by_dot_2[1], '.')

                filename <- paste0(split_by_dot_2, extension)
            }

            
        }

        

        

        
        replaceFileLinesInstances(head_filename, filename)

        
        setTxtProgressBar(pb, i)
    }

    return(TRUE)
}