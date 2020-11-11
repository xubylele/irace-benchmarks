library(here)

instances_dir <- 'benchmarks/instances'

compress_instances <- function(){
    instances_read <- here("sources", "read_instances.r")
    source(instances_read)

    instancesDescriptors <- getInstancesDescriptors()
    for(i in 1:length(instancesDescriptors)){
        trainingFiles <- getTrainingInstances(instancesDescriptors[i])
        testingFiles <- getTestingInstances(instancesDescriptors[i])
        instancesFiles <- getNonTrainingAndTestingFiles(instancesDescriptors[i])
        compress_files(trainingFiles)
        #compress_files(testingFiles)
        #compress_files(instancesFiles)
    }

    return(TRUE)
}

compress_files <- function(files){
    for(i in length(files)){
        print(files[i])
        if(length(files[i]) > 0){
            conn <- file(files[i],open="r")
            linn <-readLines(conn)
            object = c()

            for (j in 1:length(linn)){
                line <- linn[j]
                if(length(grep('lperez', line)) > 0){
                    line <- strsplit(line, '/lperez/')
                    line <- strsplit(line[[1]][2], '/instances/')
                    line <- line[[1]][2]
                }
                object <- c(object, line)

            }
            close(conn)
            print(object)
        }
    }
}
