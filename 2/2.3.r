library(plyr)
library(quantmod)
library(TTR)
library(ggplot2)
library(scales)

download<-function(stock,from="2010-01-01"){
 df<-getSymbols(stock,from=from,env=environment(),auto.assign=FALSE)
 names(df)<-c("Open","High","Low","Close","Volume","Adjusted")
 write.zoo(df,file=paste(stock,".csv",sep=""),sep=",",quote=FALSE)
}

read<-function(stock){
  as.xts(read.zoo(file=paste(stock,".csv",sep=""),header = TRUE,sep=",", format="%Y-%m-%d"))
}

stock<-"IBM"
#download(stock,from='2010-01-01')
IBM<-read(stock)

class(IBM)
head(IBM)

chartSeries(IBM)
chartSeries(IBM,TA = "addVo(); addSMA(); addEnvelope();addMACD(); addROC()")   # 画带指标的蜡烛图

ma<-function(cdata,mas=c(5,20,60)){
     ldata<-cdata
     for(m in mas){
         ldata<-merge(ldata,SMA(cdata,m))
     }
     ldata<-na.locf(ldata, fromLast=TRUE)
     names(ldata)<-c('Value',paste('ma',mas,sep=''))
     return(ldata)
}

drawLine<-function(ldata,titie="Stock_MA",sDate=min(index(ldata)),eDate=max(index(ldata)),out=FALSE){  # 画出均线图
     g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
     g<-g+geom_line()
     g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
     g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
     g<-g+xlab("") + ylab("Price")+ggtitle(title)

     if(out) ggsave(g,file=paste(titie,".png",sep=""))
     else g
}

cdata<-IBM['2010/2012']$Close
title<-"Stock_IBM"
sDate<-as.Date("2010-1-1")
eDate<-as.Date("2012-1-1")
ldata<-ma(cdata,c(5,20,60))
drawLine(ldata,title,sDate,eDate)

ldata<-ma(cdata,c(20))
drawLine(ldata,title,sDate,eDate)

drawPoint<-function(ldata,pdata,titie,sDate,eDate){
   g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
   g<-g+geom_line()
   g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
   g<-g+geom_point(aes(x=Index,y=Value,colour=Series),data=fortify(pdata,melt=TRUE))
   g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
   g<-g+xlab("") + ylab("Price")+ggtitle(title)
   g
}

pdata<-merge(ldata$ma20[which(ldata$Value-ldata$ma20>0)],ldata$ma20[which(ldata$Value-ldata$ma20<0)])
names(pdata)<-c("down","up")
pdata<-fortify(pdata,melt=TRUE)
pdata<-pdata[-which(is.na(pdata$Value)),]
head(pdata)
drawPoint(ldata,pdata,title,sDate,eDate)

Signal<-function(cdata,pdata){
   tmp<-''
   tdata<-ddply(pdata[order(pdata$Index),],.(Index,Series),function(row){
       if(row$Series==tmp) return(NULL)
       tmp<<-row$Series
   })
   tdata<-data.frame(cdata[tdata$Index],op=ifelse(tdata$Series=='down','B','S'))
   names(tdata)<-c("Value","op")
   return(tdata)
}

tdata<-Signal(cdata,pdata)
tdata<-tdata[which(as.Date(row.names(tdata))<eDate),]
head(tdata)
nrow(tdata)

trade<-function(tdata,capital=100000,position=1,fee=0.00003){
   amount<-0
   cash<-capital

   ticks<-data.frame()
   for(i in 1:nrow(tdata)){
       row<-tdata[i,]
       if(row$op=='B'){
           amount<-floor(cash/row$Value)
           cash<-cash-amount*row$Value
       }

       if(row$op=='S'){
           cash<-cash+amount*row$Value
           amount<-0
       }

       row$cash<-cash
       row$amount<-amount
       row$asset<-cash+amount*row$Value
       ticks<-rbind(ticks,row)
   }

   ticks$diff<-c(0,diff(ticks$asset))

   rise<-ticks[c(which(ticks$diff>0)-1,which(ticks$diff>0)),]
   rise<-rise[order(row.names(rise)),]

   fall<-ticks[c(which(ticks$diff<0)-1,which(ticks$diff<0)),]
   fall<-fall[order(row.names(fall)),]

   return(list(
       ticks=ticks,
       rise=rise,
       fall=fall
   ))
}

result1<-trade(tdata,100000)
head(result1$ticks)
head(result1$rise)
head(result1$fall)
tail(result1$ticks,1)

drawCash<-function(ldata,adata){
   g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
   g<-g+geom_line()
   g<-g+geom_line(aes(x=as.Date(Index), y=Value,colour=Series),data=fortify(adata,melt=TRUE))
   g<-g+facet_grid(Series ~ .,scales = "free_y")
   g<-g+scale_y_continuous(labels = dollar)
   g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
   g<-g+xlab("") + ylab("Price")+ggtitle(title)
   g
}
adata<-as.xts(result1$ticks[which(result1$ticks$op=='S'),]['cash'])
drawCash(ldata,adata)




ldata<-ma(cdata,c(5,20))
drawLine(ldata,title,sDate,eDate)

pdata<-merge(ldata$ma20[which(ldata$ma5-ldata$ma20>0)],ldata$ma20[which(ldata$ma5-ldata$ma20<0)])
names(pdata)<-c("down","up")
pdata<-fortify(pdata,melt=TRUE)
pdata<-pdata[-which(is.na(pdata$Value)),]
head(pdata)
drawPoint(ldata,pdata,title,sDate,eDate)

tdata<-Signal(cdata,pdata)
tdata<-tdata[which(as.Date(row.names(tdata))<eDate),]
head(tdata)
nrow(tdata)

result2<-trade(tdata,100000)
head(result2$ticks)
head(result2$rise)
head(result2$fall)
tail(result2$ticks,1)

adata<-as.xts(result2$ticks[which(result2$ticks$op=='S'),]['cash'])
drawCash(ldata,adata)

rise<-merge(as.xts(result1$rise[1]),as.xts(result2$rise[1]))
names(rise)<-c("plan1","plan2")
rise

drawRange<-function(ldata,plan,titie="Stock_2014",sDate=min(index(ldata)),eDate=max(index(ldata)),out=FALSE){
   g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
   g<-g+geom_line()
   g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
   g<-g+geom_rect(aes(NULL, NULL,xmin=start,xmax=end,fill=plan),ymin = yrng[1], ymax = yrng[2],data=plan)
   g<-g+scale_fill_manual(values =alpha(c("blue", "red"), 0.2))
   g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
   g<-g+xlab("") + ylab("Price")+ggtitle(title)

   if(out) ggsave(g,file=paste(titie,".png",sep=""))
   else g
}

yrng <-range(ldata$Value)
plan1<-as.xts(result1$rise[c(1,2)])
plan1<-data.frame(start=as.Date(index(plan1)[which(plan1$op=='B')]),end=as.Date(index(plan1)[which(plan1$op=='S')]),plan='plan1')
plan2<-as.xts(result2$rise[c(1,2)])
plan2<-data.frame(start=as.Date(index(plan2)[which(plan2$op=='B')]),end=as.Date(index(plan2)[which(plan2$op=='S')]),plan='plan2')

plan<-rbind(plan1)
drawRange(ldata,plan,title,sDate,eDate)
plan<-rbind(plan1,plan2)
drawRange(ldata,plan,title,sDate,eDate)
