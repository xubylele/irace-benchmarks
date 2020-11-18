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
  
## shiny inputs, to add action buttons to datatables
  shinyInput <- function(FUN, len, id, strings_id,...) {
    inputs <- character(len)
    for (i in seq_len(len)) {
      inputs[i] <- as.character(FUN(paste0(id, strings_id[[i]]), ...))
    }
    inputs
  }

## print buttons functions
  print_buttons <- function(type, len){
    sprintf(paste('<button>', type,'</button>'))
  }

## get non alphanumeric characters
  searchFile <- function(fileName, folderName){
    files <- list.files(folderName, fileName, recursive=TRUE, full.names= TRUE, include.dirs=TRUE)
    return(files)
  }

## replace file line
  replaceFileLinesInstances <- function(fileName, fileLine){
        
    conn <- file(fileName,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- strsplit(linn[j], ": ")
      #print(paste(line[[1]][1], fileLine))
    }

    
    close(conn)
    return(object)
  }