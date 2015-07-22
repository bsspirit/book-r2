#' Get weather data from Yahoo openAPI.
#'
#' @importFrom RCurl getURL
#' @importFrom XML xmlTreeParse getNodeSet xmlGetAttr
#' @param woeid input a yahoo woeid
#' @return data.frame weather data
#' @keywords weather 
#' @export
#' @examples
#' \dontrun{
#'  getWeatherFromYahoo()
#'  getWeatherFromYahoo(2151330)
#' }
getWeatherFromYahoo<-function(woeid=2151330){
  url<-paste('http://weather.yahooapis.com/forecastrss?w=',woeid,'&u=c',sep="")
  doc = xmlTreeParse(getURL(url),useInternalNodes=TRUE)
  
  ans<-getNodeSet(doc, "//yweather:atmosphere")
  humidity<-as.numeric(sapply(ans, xmlGetAttr, "humidity"))
  visibility<-as.numeric(sapply(ans, xmlGetAttr, "visibility"))
  pressure<-as.numeric(sapply(ans, xmlGetAttr, "pressure"))
  rising<-as.numeric(sapply(ans, xmlGetAttr, "rising"))
  
  ans<-getNodeSet(doc, "//item/yweather:condition")
  code<-as.numeric(sapply(ans, xmlGetAttr, "code"))
  
  ans<-getNodeSet(doc, "//item/yweather:forecast[1]")
  low<-as.numeric(sapply(ans, xmlGetAttr, "low"))
  high<-as.numeric(sapply(ans, xmlGetAttr, "high"))
  
  print(paste(woeid,'==>',low,high,code,humidity,visibility,pressure,rising))
  return(as.data.frame(cbind(low,high,code,humidity,visibility,pressure,rising)))
}

#' Get one city weather Data.
#'
#' @param en input a English city name
#' @param src input data source
#' @return data.frame weather data
#' @keywords weather 
#' @export
#' @examples
#' \dontrun{
#'  getWeatherByCity()
#'  getWeatherByCity(en="beijing")
#' }
getWeatherByCity<-function(en="beijing",src="yahoo"){
  woeid<-getWOEIDByCity(en)
  if(src=="yahoo"){
    return(getWeatherFromYahoo(woeid))
  }else{
    return(NULL)
  }
}

#' Get all of city weather Data.
#'
#' @param lang input a language
#' @param src input data source
#' @return data.frame weather data
#' @keywords weather 
#' @export
#' @examples
#' \dontrun{
#'  getWeather()
#' }
getWeather<-function(lang="en",src="yahoo"){
  cities<-getCityInfo(lang)
  wdata<-do.call(rbind, lapply(cities$woeid,getWeatherFromYahoo))
  return(cbind(cities,wdata))
}
