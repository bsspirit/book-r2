library(RCurl)
library(XML)

getWeather<-function (x){
  url<-paste('https://query.yahooapis.com/v1/public/yql',
             '?q=select%20*%20from%20weather.forecast%20where%20woeid%20%3D',
             x,
             '&format=xml',
             '&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys',sep='')
  
  xml <- getURL(url,.opts = list(ssl.verifypeer = FALSE))
  doc <- xmlTreeParse(xml,useInternal = TRUE)
  
  ans<-getNodeSet(doc, "//yweather:atmosphere",c(yweather="http://xml.weather.yahoo.com/ns/rss/1.0"))
  humidity<-as.numeric(sapply(ans, xmlGetAttr, "humidity"))
  visibility<-as.numeric(sapply(ans, xmlGetAttr, "visibility"))
  pressure<-as.numeric(sapply(ans, xmlGetAttr, "pressure"))
  rising<-as.numeric(sapply(ans, xmlGetAttr, "rising"))
  
  ans<-getNodeSet(doc, "//item/yweather:condition",c(yweather="http://xml.weather.yahoo.com/ns/rss/1.0"))
  code<-sapply(ans, xmlGetAttr, "code")
  
  ans<-getNodeSet(doc, "//item/yweather:forecast[1]",c(yweather="http://xml.weather.yahoo.com/ns/rss/1.0"))
  low<-as.numeric(sapply(ans, xmlGetAttr, "low"))
  high<-as.numeric(sapply(ans, xmlGetAttr, "high"))
  
  print(paste(x,'==>',low,high,code,humidity,visibility,pressure,rising))
  cbind(low,high,code,humidity,visibility,pressure,rising)
}
w<-getWeather(2151330);w


filename<-function(date=Sys.time()){
   paste(format(date, "%Y%m%d"),".csv",sep="")
}
loadDate<-function(date){
   print(paste('Date','==>',date))
   city<-read.csv(file="WOEID.csv",header=FALSE,fileEncoding="utf-8", encoding="utf-8")
   names(city)<-c("en","woeid","zh",'prov','long','lat')
   city<-city[-nrow(city),]
   wdata<-do.call(rbind, lapply(city$woeid,getWeather))
   w<-cbind(city,wdata)
   write.csv(w,file=filename(date),row.names=FALSE,fileEncoding="utf-8")
}
date=Sys.time();date
loadDate(date)


library(maps)
library(mapdata)
library(maptools)
map<-readShapePoly('mapdata/bou2_4p.shp')
plot(map)

class(map)
library(pryr)
otype(map)

length(map)
names(map)
str(map[1,])
map[1,]@data
plot(map[1,])
plot(map[1:100,])


library("RColorBrewer")
getColors2<-function(map,prov,ctype){
   ADCODE99<-read.csv(file="ADCODE99.csv",header=TRUE,fileEncoding="utf-8", encoding="utf-8")
   fc<-function(x){ADCODE99$ADCODE99[which(x==ADCODE99$prov)]}
   code<-sapply(prov,fc)
   f=function(x,y) ifelse(x %in% y,which(y==x),0);
   colIndex=sapply(map$ADCODE99,f,code);
   ctype[which(is.na(ctype))]=19
   return(ctype[colIndex])
}
summary<-function(data=data,output=FALSE,path=''){
   colors<-c(rev(brewer.pal(9,"Blues")),rev(c('#b80137','#8c0287','#d93c5d','#d98698','#f6b400','#c4c4a7','#d6d6cb','#d1b747','#ffeda0')))
   temp<-data$code
   title<-"中国各省天气概况"
   ofile<-paste(format(date,"%Y%m%d"),"_code.png",sep="")
   sign<-''
   colors<-rev(colors)
   code<-read.csv(file="code.csv",header=TRUE,fileEncoding="utf-8", encoding="utf-8")
   labelcode<-read.csv(file="labelcode.csv",header=TRUE,fileEncoding="utf-8", encoding="utf-8")
   ctype<-sapply(temp,function(x){code$type[which(x==code$code)]})

   if(output)png(file=paste(path,ofile,sep=''),width=600,height=600)
   layout(matrix(data=c(1,2),nrow=1,ncol=2),widths=c(8,1),heights=c(1,2))
   par(mar=c(0,0,3,12),oma=c(0.2,0.2,0.2,0.2),mex=0.3)
   plot(map,border="white",col=colors[getColors2(map,data$prov,ctype)])
   points(data$long,data$lat,pch=19,col=rgb(0,0,0,0.3),cex=0.8)

   text(100,58, title,cex=2)
   text(105,54,format(date,"%Y-%m-%d"))
   text(98,65,paste('每日中国天气','http://apps.weibo.com/chinaweatherapp'))
   text(120,-8,paste('provided by The Weather Channel',format(date, "%Y-%m-%d %H:%M")),cex=0.8)

   for(row in 1:nrow(data)){
       name<-as.character(data$zh[row])
       label<-labelcode$alias[labelcode$type==ctype[row]]
       x1<-ceiling(row/7)
       x2<-ifelse(row%%7==0,7,row%%7)
       x3<-ctype[row]
       fontCol<-'#000000'
       if(x3<=5)fontCol<-head(colors,1)
       if(x3>=12)fontCol<-tail(colors,1)
       text(68+x1*11,17-x2*3,paste(name,' ',label,sign,sep=''),col=fontCol)
   }

   par(mar = c(5, 0, 15, 10))
   image(x=1, y=1:length(colors),z=t(matrix(1:length(colors))),col=rev(colors),axes=FALSE,xlab="",ylab="",xaxt="n")
   axis(4, at = 1:(nrow(labelcode)-1), labels=rev(labelcode$alias)[-1], col = "white", las = 1)
   abline(h=c(1:(nrow(labelcode)-2)+0.5), col = "white", lwd = 2, xpd = FALSE)
   if(output)dev.off()
}
data<-read.csv(file=filename(date),header=TRUE,fileEncoding="utf-8", encoding="utf-8")
path=''
summary(data,output=TRUE,path=path)

library(devtools)
#install_github("taiyun/recharts")
#install_github('ramnathv/htmlwidgets')
#install_github('rstudio/htmltools')
#install_github('taiyun/recharts@htmlwidgets')
library(recharts)

weather_html<-function(data=data,type='high',path=''){
  if(type=='high') {
    df<-data[,c('prov','high')]
    names(df)<-c("prov","气温")
    title<-paste(format(date,"%Y-%m-%d"),"中国各省白天气温",sep="")
  }else if(type=='low'){
    df<-data[,c('prov','low')]
    names(df)<-c("prov","气温")
    title<-paste(format(date,"%Y-%m-%d"),"中国各省夜间气温",sep="")
  }
  
  df[,1]<-substr(df[,1],0,2)
  df[which(df$prov=='黑龙'),]$prov<-'黑龙江'
  df[which(df$prov=='内蒙'),]$prov<-'内蒙古'
  
  eMap(df, namevar=1, datavar = 2, title=title)
}
date<-as.Date('20141001',format='%Y%m%d')
data<-read.csv(file=filename(date),header=TRUE,fileEncoding="utf-8", encoding="utf-8")

weather_html(data,type='high')
weather_html(data,type='low')

