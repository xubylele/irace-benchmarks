### read instances data
    library(here)

    instances_dir <- here('benchmarks', 'instances')
    instances_foldernames <- list.files(instances_dir, pattern = '', full.names = TRUE)

    functions <- here("sources", "functions.r")

    source(functions)

## get intances descriptors function
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
        print(paste('search', descriptor_name))
        instancesSets <- c()
        for(i in 1:length(instances_foldernames)){
            if(tail(strsplit(instances_foldernames[i], '/')[[1]], 1) == descriptor_name){


                trainingFiles <- list.files(instances_foldernames[i], pattern = '.*training.*\\.txt$', full.names = TRUE)
                testingFiles <- list.files(instances_foldernames[i], pattern = '.*testing.*\\.txt$', full.names = TRUE)

                if(length(trainingFiles) == 0 && length(testingFiles) == 0){

                    subfolders <- list.dirs(instances_foldernames[i], full.names = TRUE)

                    if(length(subfolders) == 1){

                        instancesFiles <- list.files(instances_foldernames[i], pattern = '', full.names = TRUE)
                        

                        for(j in 1:length(instancesFiles)){
                            if(length(tail(strsplit(instancesFiles[j], '-')[[1]], 1)) > 0)
                                instancesSets <- c(instancesSets, tail(strsplit(instancesFiles[j], '-')[[1]], 1))
                        }

                    }else{
                        for(j in 1:length(subfolders)){
                            trainingFiles <- list.files(subfolders[j], pattern = '.*training.*\\.txt$', full.names = TRUE)
                            
                            if(length(trainingFiles) != 0){

                                for(k in 1:length(trainingFiles)){
                                    if(length(tail(strsplit(trainingFiles[k], '-')[[1]], 1)) > 0)
                                        instancesSets <- c(instancesSets, tail(strsplit(trainingFiles[k], '-')[[1]], 1))
                                }
                            }
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

## get training instances from descriptor
    getTrainingInstances <- function(descriptor_name){
        trainingFiles <- c()
        for(i in 1:length(instances_foldernames)){
            if(tail(strsplit(instances_foldernames[i], '/')[[1]], 1) == descriptor_name){

                trainingFiles <- list.files(instances_foldernames[i], pattern = '.*training.*\\.txt$', full.names = TRUE)
                testingFiles <- list.files(instances_foldernames[i], pattern = '.*testing.*\\.txt$', full.names = TRUE)

                if(length(trainingFiles) == 0 && length(testingFiles) == 0){

                    subfolders <- list.files(instances_foldernames[i], pattern = '', full.names = TRUE)
                    for(j in 1:length(subfolders)){
                        trainingFiles <- c(trainingFiles, list.files(subfolders[j], pattern = '.*training.*\\.txt$', full.names = TRUE))
                    }

                }
                return(trainingFiles)
            }
        }
    }

# get testing instances from descriptor
    getTestingInstances <- function(descriptor_name){
        testingFiles <- c()
        for(i in 1:length(instances_foldernames)){
            if(tail(strsplit(instances_foldernames[i], '/')[[1]], 1) == descriptor_name){

                trainingFiles <- list.files(instances_foldernames[i], pattern = '.*training.*\\.txt$', full.names = TRUE)
                testingFiles <- list.files(instances_foldernames[i], pattern = '.*testing.*\\.txt$', full.names = TRUE)

                if(length(trainingFiles) == 0 && length(testingFiles) == 0){

                    subfolders <- list.files(instances_foldernames[i], pattern = '', full.names = TRUE)
                    for(j in 1:length(instances_foldernames[i])){
                        testingFiles <- c(testingFiles, list.files(subfolders[j], pattern = '.*testing.*\\.txt$', full.names = TRUE))
                    }

                }
                return(testingFiles)
            }
        }
    }

# get instances files from descriptor
    getNonTrainingAndTestingFiles <- function(descriptor_name){
        for(i in 1:length(instances_foldernames)){
            if(tail(strsplit(instances_foldernames[i], '/')[[1]], 1) == descriptor_name){

                instances_files <- list.files(instances_foldernames[i], pattern = '*.txt', full.names = TRUE)

                if(length(instances_files) == 0){

                    subfolders <- list.files(instances_foldernames[i], pattern = '', full.names = TRUE)
                    for(j in 1:length(instances_foldernames[i])){
                        instances_files <- c(instances_files, list.files(subfolders[j], pattern = '*.txt', full.names = TRUE))
                    }

                }
                instances_files <- instances_files[ !grepl("training", instances_files) ]
                instances_files <- instances_files[ !grepl("testing", instances_files) ]
                return(instances_files)
            }
        }
    }

##count instances sets function
    countInstancesSets <- function(){
        descriptors <- getInstancesDescriptors()
        count <- 0
        for(i in 1:length(descriptors)){
            count = count + length(searchInstanceDescriptorSets(descriptors[i]))
        }
        return(count)
    }


list_instances <- function(){
    cat('\n')
    cli_ol()
    descriptors <- getInstancesDescriptors()
    for(i in 1:length(descriptors)){
        cli_li(descriptors[i])
    }
    cli_end()
    cat('\n')

    cli_alert('Please enter the number of the descriptor to inspect the instances sets enter "return" to get back to main menu')
    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            user_input <- strtoi(user_input)
            if(!is.na(user_input)){
                if(user_input > length(descriptors) || user_input == 0 || user_input < 1){
                    cli_alert_danger("Please, write a valid number of descriptors")
                }else{
                    descriptor_sets <- searchInstanceDescriptorSets(descriptors[user_input])
                    cli_ol()
                    for(i in 1:length(descriptor_sets)){
                        cli_li(descriptor_sets[i])
                    }
                    cli_end()
                    cat('\n')
                    break
                }

            }else{
                cli_alert_danger("Please, write a number")
            }
            
        }else{
            cli_alert_danger("Please, write a number")
        }
    }
}

search_descriptor_instance <- function(){

    mise()
    cli_alert('Please enter the name of the descriptor enter "return" to get back to main menu')
    repeat{
        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            descriptor_instaces <- searchDescriptor(user_input)
            if(length(descriptor_instaces) == 0){
                cli_alert_danger("Please, write a valid descriptor name")
            }else{
                cli_ol()
                for(i in 1:length(descriptor_instaces)){
                    cli_li(descriptor_instaces[i])
                }
                cli_end()
                cat('\n')
                break
            }
        }else{
            cli_alert_danger("Please, write a benchmark name")
        }
    }

}


searchDescriptor <- function(descriptor){

    descriptors <- getInstancesDescriptors()

    for(i in 1:length(descriptors)){

        if(descriptors[i] == descriptor){
            return(searchInstanceDescriptorSets(descriptors))
        }

    }

}

selet_instances <- function(){

    print(instances_foldernames)

    str_to_return <- ''

    cli_alert('Please select the folder of the instances files')

    cli_ol()
    
    for(i in 1:length(instances_foldernames)){
        cli_li(paste0('Dir name: ', instances_foldernames[i]))
    }

    cli_end()


    repeat{

        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            user_input <- strtoi(user_input)

            if(!is.na(user_input)){
                if(user_input > length(instances_foldernames) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of folder")

                }else{
                    
                    folder <- instances_foldernames[user_input]

                    print(folder)



                    files <- list.files(folder, pattern = '', full.names = TRUE)

                    str_to_return <- paste0(str_to_return, '[(file/url),')

                    
                    str_to_return <- paste0(str_to_return, selectFiles(files))
                    
                    str_to_return <- paste0(str_to_return, ']')
                    print(str_to_return)

                    return(str_to_return)
                
                }

            }else{
                cli_alert_danger("Please, write a number")
            }
            
        }else{
            cli_alert_danger("Please, write a number")
        }
    }

}


selectFiles <- function(files){

    str_to_return <- ''

    cli_alert('Please select the trainning file')

    cli_ol()
    
    for(i in 1:length(files)){
        cli_li(paste0('Filename: ', files[i]))
    }

    cli_end()


    repeat{

        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            user_input <- strtoi(user_input)

            if(!is.na(user_input)){
                if(user_input > length(files) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of folder")

                }else{
                    file <- files[user_input]

                    str_split <- strsplit(file, '/')[[1]]

                    file <- ''


                    for(i in (length(str_split)-2):length(str_split)){
                        file <- paste0(file, '/', str_split[i])
                    }

                    str_to_return <- paste0(str_to_return, file, ', ')

                    print(str_to_return)
                    break
                }
            }
        }
    }

    cli_alert('Please select the testing file')

    cli_ol()
    
    for(i in 1:length(files)){
        cli_li(paste0('Filename: ', files[i]))
    }

    cli_end()


    repeat{

        cat('\n> ')
        user_input <- readLines("stdin",n=1)
        

        if(user_input != ""){

            if(user_input == 'return'){
                break
            }

            user_input <- strtoi(user_input)

            if(!is.na(user_input)){
                if(user_input > length(files) || user_input < 1){

                    cli_alert_danger("Please, write a valid number of folder")

                }else{

                    file <- files[user_input]

                    str_split <- strsplit(file, '/')[[1]]

                    file <- ''


                    for(i in (length(str_split)-2):length(str_split)){
                        file <- paste0(file, '/', str_split[i])
                    }

                    str_to_return <- paste0(str_to_return, file)
                    break
                }
            }
        }
    }

    return(str_to_return)

}