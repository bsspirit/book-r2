sessionInfo()

WOEID<-read.csv(file="metadata/WOEID.csv",header=FALSE,fileEncoding="utf-8", encoding="utf-8")
names(WOEID)<-c("en","woeid","zh",'prov','long','lat')
adcode99<-read.csv(file="metadata/ADCODE99.csv",header=TRUE,fileEncoding="utf-8", encoding="utf-8")
fc<-function(row){
    code<-adcode99$ADCODE99[which(row[4]==as.character(adcode99$prov))]
    if(length(code)==0)code=0
    code
}
WOEID<-cbind(WOEID,adcode99=unlist(apply(WOEID,1,fc)))
save(WOEID,file="data/WOEID.rda")
WOEID

# install.packages("stringi")
library("stringi")
WOEID$prov<-stri_escape_unicode(WOEID$prov)
WOEID$zh<-stri_escape_unicode(WOEID$zh)
save(WOEID,file="data/WOEID.rda",compress=TRUE)
head(WOEID)
head(stri_unescape_unicode(WOEID$prov))
head(stri_unescape_unicode(WOEID$zh))

library(maps)
library(mapdata)
library(maptools)
chinaMap<-readShapePoly('metadata/mapdata/bou2_4p.shp')
head(chinaMap$NAME)
iconv(head(chinaMap$NAME),"gbk","UTF-8")
chinaMap<-chinaMap[,c(1:6)]
save(chinaMap,file="data/chinaMap.rda",compress='xz')

props<-data.frame(
    key=c('high','low'),
    zh=c('中国各省白天气温','中国各省夜间气温'),
    en=c('Daytime Temperature','Nighttime Temperature')
)
props$zh<-stri_escape_unicode(props$zh)
save(props,file="data/props.rda",compress=TRUE)

weather20141001<-read.csv(file="metadata/20141001.csv",header=TRUE,fileEncoding="utf-8", encoding="utf-8")
weather20141001$prov<-stri_escape_unicode(weather20141001$prov)
weather20141001$zh<-stri_escape_unicode(weather20141001$zh)
save(weather20141001,file="data/weather20141001.rda",compress=TRUE)
dir('data')

library(devtools)
load_all("/home/conan/R/chinaWeather")
data(package="chinaWeather")
date<-as.Date(as.character(20141001), format = "%Y%m%d")
drawTemperature(weather20141001,date=date)
drawTemperature(weather20141001,type='low',date=date,lang='en')

library(roxygen2)
roxygenize("/home/conan/R/chinaWeather")

build("/home/conan/R/chinaWeather",path="dist")

library(chinaWeather)
data<-getWeather(lang='zh')
drawTemperature(data,date=Sys.Date())

check("/home/conan/R/chinaWeather")

library(devtools)
install_github("bsspirit/chinaWeatherDemo",ref="app")











