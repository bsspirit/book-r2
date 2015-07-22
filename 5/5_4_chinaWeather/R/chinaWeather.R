#' Define a filename from current date.
#'
#' @param date input a date type
#' @return character a file name
#' @keywords filename
#' @export
#' @examples
#' \dontrun{
#'  filename()
#'  filename(as.Date("20110701",format="%Y%m%d"))
#' }
filename<-function(date=Sys.time()){
  paste(format(date, "%Y%m%d"),".csv",sep="")
}

#' Get WOEID of Yahoo By City Name
#'
#' @param en input a English city name
#' @return integer WOEID
#' @keywords WOEID
#' @export
#' @examples
#' \dontrun{
#'  getWOEIDByCity()
#'  getWOEIDByCity(en="beijing")
#' }
getWOEIDByCity<-function(en="beijing"){
  return(WOEID$woeid[which(WOEID$en==en)])
}

#' Get all of city info
#'
#' @param lang input a language
#' @return data.frame city info
#' @keywords language
#' @export
#' @examples
#' \dontrun{
#'  getCityInfo()
#'  getCityInfo(lang="en")
#'  getCityInfo(lang="zh")
#' }
getCityInfo<-function(lang="en"){
  if(lang=="en")return(WOEID[-c(3,4)])
  if(lang=="zh")return(WOEID[-c(4)])
}
