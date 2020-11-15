functions <- here("sources", "functions.r")

source(functions)

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
    
    for(i in 8001:length(instances_filenames)){
        head_filename <- instances_filenames[i][[1]][[2]]

        print(head_filename)
        print(i)

        instance_name_separated <- strsplit(instances_filenames[i][[1]][[1]], '[.]')[[1]]

        instance_name_separated_by_slash <- strsplit(instance_name_separated, '/')[[1]]

        instance_name_separated_by_space <- strsplit(instance_name_separated, ' ')[[1]]

        print(instance_name_separated_by_space)

        instances_filename <- c()
        index <- c()

        if(length(instance_name_separated_by_slash) > 0){
            instances_filename <- tail(instance_name_separated_by_slash,1)
            print(instances_filename)            
        }else if(length(instance_name_separated_by_space) > 0){
            instances_filename <- tail(instance_name_separated_by_space,1)
            print(instances_filename)   
        }else{
            instances_filename <- instance_name_separated[1]
        }


        split_by_colon <- strsplit(instance_name_separated[2], ':')[[1]]
        extension <- c()

        if(length(split_by_colon) > 0){
            extension <- split_by_colon[1]
        }else{
            extension <- split_by_colon
        }
        
        print('filename')
        print(paste0(instances_filename, '.', extension))
        files <- searchFile(paste0(instances_filename, '.', extension), here('benchmarks', 'instances'))
        necesary_file <- c()

        print('for///////////////////////////////////////////')
        for(j in 1:length(files)){
            if(length(grep('training', files[j])) > 0){
                if(length(grep('training', head_filename)) > 0){
                    necesary_file <- files[j]
                }
            }else if(length(grep('testing', files[j]) > 0)){
                if(length(grep('testing', head_filename))){
                    necesary_file <- files[j]
                }
            }else{
                if(length(grep('trainning', head_filename)) == 0 && length(grep('testing', head_filename)) == 0){
                    necesary_file <- files[j]
                }
            }
        }
        print(necesary_file)
        if(length(necesary_file) == 0 || is.null(necesary_file) || is.na(necesary_file) || length(necesary_file) > 1){
            break
        }
    }

    return(TRUE)
}