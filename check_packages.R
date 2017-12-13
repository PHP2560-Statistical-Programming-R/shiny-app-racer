pkgs <- c("shiny","tidyverse","racecar", "shinythemes")

pkgTest <- function(pkgs)
{ for (i in pkgs){
  if (!require(i,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(i,character.only = TRUE)) stop("Package not found")
    }
  }
}
