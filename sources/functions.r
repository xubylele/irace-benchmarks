## function to read lines of txt files
  readFileLinesSeparatedByColon <- function(filename){
    
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

## function to read lines isntances files
  readFileLines <- function(filename){
        
    conn <- file(filename,open="r")
    linn <-readLines(conn)
    object = c()

    for (j in 1:length(linn)){
      line <- linn[j]
      object[[j]] = list(line[[1]][1])
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

## search file
  searchFile <- function(filename, folderName){
    files <- list.files(folderName, filename, recursive=TRUE, full.names= TRUE, include.dirs=TRUE)
    return(files)
  }


## search file
  searchFileNotComplete <- function(filename, folderName){
    files <- list.files(folderName, filename, recursive=TRUE, full.names= FALSE, include.dirs=TRUE)
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
      filename_split <- strsplit(fileline, 'instances')[[1]]
      
      if(length(line) > 1){
        if(tail(line, 1) == tail(filename_split, 1)){
          
          linn[j] <- fileline
        }
      }
    }

    writeLines(linn, filename)

    
    close(conn)
    return(object)
  }

## get clear filename
  getClearFilename <- function(instance_name_separated){

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
          filename <- instances_filename
      }
      else{
          clean_filename <- paste0(instances_filename, '.', extension_clean)
          filename <- clean_filename
      }

      print(filename)
      return(filename)
    }
    return(NULL)
  }