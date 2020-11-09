## function to read lines of txt files
  readFileLines <- function(fileName){
    
    conn <- file(fileName,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- strsplit(linn[j], ": ")
      object[[j]] = list(line[[1]][1], line[[1]][2])
    }

    
    close(conn)
    return(object)
  }

## function to read lines isntances files
  readFileLinesInstances <- function(fileName){
        
    conn <- file(fileName,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- strsplit(linn[j], ": ")
      object[[j]] = list(line[[1]][1], fileName)
    }

    
    close(conn)
    return(object)
  }