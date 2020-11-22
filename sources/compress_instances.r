library(here)
library(zip)
functions <- here("sources", "functions.r")

source(functions)

instances_dir <- 'benchmarks/instances'

compress_instances <- function(){
    instances_read <- here("sources", "read_instances.r")
    source(instances_read)
    print('It may take a while...')

    instancesDescriptors <- getInstancesDescriptors()
    for(i in 1:length(instancesDescriptors)){
        trainingFiles <- getTrainingInstances(instancesDescriptors[i])
        testingFiles <- getTestingInstances(instancesDescriptors[i])
        instancesFiles <- getNonTrainingAndTestingFiles(instancesDescriptors[i])

        instances_filenames <- c()

        for(j in 1:length(trainingFiles)){
            if(length(trainingFiles[j]) > 0 && !is.na(trainingFiles[j])){
                instances_filenames <- c(instances_filenames, trainingFiles[j])
            }
        }

        for(j in 1:length(testingFiles)){
            if(length(testingFiles[j]) > 0 && !is.na(testingFiles[j])){
                instances_filenames <- c(instances_filenames, testingFiles[j])
            }
        }

        for(j in 1:length(instancesFiles)){
            if(length(instancesFiles[j]) > 0 && !is.na(instancesFiles[j])){
                instances_filenames <- c(instances_filenames, instancesFiles[j])
            }
        }

        
    }
    compress_files(instances_filenames)

    return(TRUE)
}

compress_files <- function(filenames){
    #pb <- txtProgressBar(min = 0, max = length(filenames), style = 3)
    for(i in 1:1){
        files_to_compress <- readFileLines(filenames[i])
        tar_name <- head(strsplit(filenames[i][[1]][[1]], '[.]')[[1]], 1)
        tar_name <- tail(strsplit(tar_name, '/')[[1]], 1)
        tar_name <- paste0(tar_name, '.zip')
        dir <- dirname(filenames[i])
        pattern <- c()
        
        for(j in 1:length(files_to_compress)){
            
            split_by_slash <- strsplit(files_to_compress[j][[1]][[1]], '[.]')[[1]]

            filename <- getClearFilename(split_by_slash)

            if(length(filename) > 0){
                files <- searchFile(filename, here('benchmarks', 'instances'))
                necesary_file <- c()
                
                for(k in 1:length(files)){
                    if(length(grep('training', filenames[i])) > 0){
                        necesary_file <- files[k]                    
                    }else if(length(grep('testing', filenames[i]))){
                        necesary_file <- files[k]
                    }else{
                        if(length(grep('trainning', filenames[i])) == 0 && length(grep('testing', head_filename)) == 0){
                            necesary_file <- files[k]
                        }
                    }
                }
                if(length(necesary_file) == 1){
                    pattern <- c(pattern, necesary_file)
                    if(j == 1){
                        print(dirname(necesary_file))
                        setwd(dirname(necesary_file))
                    }
                }
            }

            

        }

        print(tar_name)
        print(pattern)
        zip(tar_name, files = pattern)
        #setTxtProgressBar(pb, i)
    }    
}
