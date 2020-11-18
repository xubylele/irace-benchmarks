library(R.utils)

functions <- here("sources", "functions.r")

source(functions)

standarize_routes <- function(){
    instances_read <- here("sources", "read_instances.r")
    source(instances_read)

    instances_filenames <- c()
    
    instancesDescriptors <- getInstancesDescriptors()
    print(instancesDescriptors)
    for(i in 1:length(instancesDescriptors)){
        trainingFiles <- getTrainingInstances(instancesDescriptors[i])
        print(trainingFiles)
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

    files_not_found <- c()

    pb <- txtProgressBar(min = 0, max = length(instances_filenames), style = 3)
    
    for(i in 1:length(instances_filenames)){

        head_filename <- instances_filenames[i][[1]][[2]]

        if(!(is.na(head_filename) || head_filename == '')){

            instance_name_separated <- strsplit(instances_filenames[i][[1]][[1]], '[.]')[[1]]

            if(!(is.na(instance_name_separated) || instance_name_separated == '' || instance_name_separated == "  ")){
                instance_name_separated_by_slash <- strsplit(instance_name_separated, '/')[[1]]

                instances_filename <- c()
                index <- c()

                if(length(instance_name_separated_by_slash) > 0){
                    instances_filename <- tail(instance_name_separated_by_slash,1)   
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

                extension_separated_by_space <- strsplit(extension, " ")[[1]]

                if(length(extension_separated_by_space) > 0){
                    extension <- extension_separated_by_space[1]
                }
                
                filename <- c()
                if(is.na(extension)){
                    filename <- instances_filename
                    files <- searchFile(filename, here('benchmarks', 'instances'))
                }
                else{
                    filename <- paste0(instances_filename, '.', extension)
                    files <- searchFile(filename, here('benchmarks', 'instances'))
                }

                necesary_file <- c()
                
                for(j in 1:length(files)){
                    if(length(grep('training', head_filename)) > 0){
                        necesary_file <- files[j]
                    
                    }else if(length(grep('testing', head_filename))){
                        necesary_file <- files[j]                
                    }else{
                        if(length(grep('trainning', head_filename)) == 0 && length(grep('testing', head_filename)) == 0){
                            necesary_file <- files[j]
                        }
                    }
                }
            }

            if(length(necesary_file) == 0 || is.null(necesary_file) || is.na(necesary_file)){
                files_not_found <- c(files_not_found, filename)
            }else if(length(necesary_file) > 1){
                print('many')
            }else{
                necesary_file <- strsplit(necesary_file, 'instances')[[1]][2]
                print(necesary_file)
                replaceFileLinesInstances(head_filename, necesary_file)
            }
        }

        
        setTxtProgressBar(pb, i)
    }

    print(files_not_found)

    return(TRUE)
}