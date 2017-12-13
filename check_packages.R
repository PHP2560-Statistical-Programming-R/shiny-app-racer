pkgs <- c("shiny","tidyverse","racecar", "shinythemes")

pkgTest <- function(pkgs){ 
  for (i in pkgs){
    if (!require(i,character.only = TRUE)){
      install.packages(i,dep=TRUE)
    }
  }
}