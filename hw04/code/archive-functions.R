library(XML)
library(stringr)
library(ggplot2)

#' @title read archive
#' @description takes the name of a packages and returns he data frame from reading its HTML data
#' @param package String packagename
#' @return corresponding data frame
read_archive <- function(package) {
  readHTMLTable(paste("http://cran.r-project.org/src/contrib/Archive/",package, sep=""),
                stringsAsFactors = F, 
                which = c(1),
                skip.rows = c(1,2))
}


#' @title clean archive
#' @description takes the output of read_archive() and returns a “tidy” table
#' @param package Data frame
#' @return corresponding data frame
clean_archive <- function(package) {
  package <- na.omit(package)
  Name <- str_split(package$Name, "_")
  name <- unlist(lapply(Name, function (x) x[1]))
  version <- unlist(lapply(Name, function (x) str_sub(x[2],1,-8)))
  date <- as.Date(package$`Last modified`)
  Size = package$Size
  size = 1:length(Size)
  for (i in size) {
    if (str_sub(Size[i],-1,-1) == 'M') {
      size[i] = as.numeric(str_sub(Size[i],1,-2)) * 1024
    } else {
      size[i] = as.numeric(str_sub(Size[i],1,-2))
    }
  }

  data.frame(name, version, date, size)
}


#' @title plot archive
#' @description visualizethe timeline with the version sizes of a package
#' @param tbl clean archive table
#' @return nothing
plot_archive <- function(tbl) {
  ggplot(data = tbl, aes(x = date, y = size)) +
  ggtitle(paste0(tbl$name[1],": timeline of version sizes")) +
  geom_point() + 
  geom_step() + 
  labs(y = 'Size (KB)')
}






