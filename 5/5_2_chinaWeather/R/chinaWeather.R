#' Define a filename from current date.
#'
#' @param date input a date type
#' @return character a file name
#' @keywords filename
#' @export
#' @examples
#' filename()
#' filename(as.Date("20110701",format="%Y%m%d"))
filename<-function(date=Sys.time()){
  paste(format(date, "%Y%m%d"),".csv",sep="")
}
