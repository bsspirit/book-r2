source(file="game.r")
Snake<-setRefClass("Snake",contains="Game",
   methods=list(
     initialize = function(name,width,height,debug) {
       callSuper(name,width,height,debug)
       name<<-"Snake Game"
     },
     init = function(){
       callSuper()
       e$step<<-1/width
       e$dir<<-e$lastd<<-'up'
       e$head<<-c(2,2)
       e$lastx<<-e$lasty<<-2
       e$tail<<-data.frame(x=c(),y=c())

       e$col_furit<<-2
       e$col_head<<-4
       e$col_tail<<-8
       e$col_path<<-0
       e$col_barrier<<-1
     },
     lose=function(){
       if(length(which(e$head<1))>0 | length(which(e$head>width))>0){
         fail("Out of ledge.")
         return(NULL)
       }
       if(m[e$head[1],e$head[2]]==e$col_tail){
         fail("head hit tail.")
         return(NULL)
       }
     },
     furit=function(){
       if(length(index(e$col_furit))<=0){
         idx<-sample(index(e$col_path),1)
         fx<-ifelse(idx%%width==0,10,idx%%width)
         fy<-ceiling(idx/height)
         m[fx,fy]<<-e$col_furit
         if(debug){
           print(paste("furit idx",idx))
           print(paste("furit axis:",fx,fy))
         }
       }
     },
     head=function(){
       e$lastx<<-e$head[1]
       e$lasty<<-e$head[2]
       if(e$dir=='up') e$head[2]<<-e$head[2]+1
       if(e$dir=='down') e$head[2]<<-e$head[2]-1
       if(e$dir=='left') e$head[1]<<-e$head[1]-1
       if(e$dir=='right') e$head[1]<<-e$head[1]+1
     },
     body=function(){
       if(isFail) return(NULL)
       m[e$lastx,e$lasty]<<-e$col_path
       m[e$head[1],e$head[2]]<<-e$col_head
       if(length(index(e$col_furit))<=0){
         e$tail<<-rbind(e$tail,data.frame(x=e$lastx,y=e$lasty))
       }
       if(nrow(e$tail)>0) {
         e$tail<<-rbind(e$tail,data.frame(x=e$lastx,y=e$lasty))
         m[e$tail[1,]$x,e$tail[1,]$y]<<-e$col_path
         e$tail<<-e$tail[-1,]
         m[e$lastx,e$lasty]<<-e$col_tail
       }
       if(debug){
         print(paste("snake idx",index(e$col_head)))
         print(paste("snake axis:",e$head[1],e$head[2]))
       }
     },
     drawTable=function(){
       if(isFail) return(NULL)
       plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
       if(debug){
         abline(h=seq(0,1,e$step),col="gray60")
         abline(v=seq(0,1,e$step),col="gray60")
         df<-data.frame(x=rep(seq(0,0.95,e$step),width),y=rep(seq(0,0.95,e$step),each=height),lab=seq(1,width*height))
         text(df$x+e$step/2,df$y+e$step/2,label=df$lab)
       }
     },
     drawMatrix=function(){
       if(isFail) return(NULL)
       idx<-which(m>0)
       px<- (ifelse(idx%%width==0,width,idx%%width)-1)/width+e$step/2
       py<- (ceiling(idx/height)-1)/height+e$step/2
       pxy<-data.frame(x=px,y=py,col=m[idx])
       points(pxy$x,pxy$y,col=pxy$col,pch=15,cex=4.4)
     },
     stage1=function(){
       callSuper()
       furit()
       head()
       lose()
       body()
       drawTable()
       drawMatrix()
     },
     stage0=function(){
       callSuper()
       plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
       text(0.5,0.7,label=name,cex=5)
       text(0.5,0.4,label="Any keyboard to start",cex=2,col=4)
       text(0.5,0.3,label="Up,Down,Left,Rigth to control direction",cex=2,col=2)
       text(0.2,0.05,label="Author:DanZhang",cex=1)
       text(0.5,0.05,label="http://blog.fens.me",cex=1)
     },
     stage2=function(){
       callSuper()
       info<-paste("Congratulations! You have eat",nrow(e$tail),"fruits!")
       print(info)
       plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
       text(0.5,0.7,label="Game Over",cex=5)
       text(0.5,0.4,label="Space to restart, q to quit.",cex=2,col=4)
       text(0.5,0.3,label=info,cex=2,col=2)
       text(0.2,0.05,label="Author:DanZhang",cex=1)
       text(0.5,0.05,label="http://blog.fens.me",cex=1)
     },
     keydown=function(K){
       callSuper(K)
       if(stage==1){
         if(K == "q") stage2()
         else {
           if(tolower(K) %in% c("up","down","left","right")){
             e$lastd<<-e$dir
             e$dir<<-tolower(K)
             stage1()
           }
         }
         return(NULL)
       }
       return(NULL)
     }
   )
)

snake<-function(){
  game<-Snake$new()
  game$initFields(debug=FALSE)
  game$run()
}

snake()