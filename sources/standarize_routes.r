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
    
    for(i in 4000:length(instances_filenames)){

        head_filename <- instances_filenames[i][[1]][[2]]
        print(paste(i, head_filename))

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
                extension <- instance_name_separated[2]
                extension_clean <- c()

                if(length(split_by_colon) > 0){
                    extension_clean <- split_by_colon[1]
                }else{
                    extension_clean <- split_by_colon
                }

                extension_separated_by_space <- strsplit(extension_clean, " ")[[1]]

                if(length(extension_separated_by_space) > 0){
                    extension_clean <- extension_separated_by_space[1]
                }
                
                filename <- c()
                clean_filename <- c()
                if(is.na(extension_clean)){
                    clean_filename <- instances_filename
                    files <- searchFile(clean_filename, here('benchmarks', 'instances'))
                }
                else{
                    clean_filename <- paste0(instances_filename, '.', extension_clean)
                    filename <- paste0(instances_filename, '.', extension)
                    files <- searchFile(clean_filename, here('benchmarks', 'instances'))
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
            }else if(!(length(necesary_file) == 0 || is.null(necesary_file) || is.na(necesary_file))){
                necesary_file <- strsplit(necesary_file, 'instances')[[1]][2]
                necesary_file_split <- strsplit(necesary_file, '/')[[1]]
                final_file <- c()
                for(k in 1:length(necesary_file_split)){
                    if(k == length(necesary_file_split)){
                        final_file <- c(paste0(final_file, filename))
                    }else{
                        final_file <- c(paste0(final_file, necesary_file_split[k], '/'))
                    }
                }
                replaceFileLinesInstances(head_filename, final_file)
            }
        }

        
        setTxtProgressBar(pb, i)
    }

    print(files_not_found)

    return(TRUE)
}