## function to read lines of txt files
  readFileLines <- function(filename){
    
    conn <- file(filename,open="r")
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
  readFileLinesInstances <- function(filename){
        
    conn <- file(filename,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- strsplit(linn[j], ": ")
      object[[j]] = list(line[[1]][1], filename)
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
  searchFile <- function(filename, folderName){
    files <- list.files(folderName, filename, recursive=TRUE, full.names= TRUE, include.dirs=TRUE)
    return(files)
  }

## replace file line
  replaceFileLinesInstances <- function(filename, fileline){
        
    conn <- file(filename,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      if(linn[j] == fileline)
        break
        
      line <- strsplit(linn[j], "instances")[[1]]
      if(length(line) > 1){
        if(tail(line, 1) == fileline){
          linn[j] <- fileline
        }
      }
    }

    writeLines(linn, filename)

    
    close(conn)
    return(object)
  }