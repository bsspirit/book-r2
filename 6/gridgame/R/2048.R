#' Snake game class
#' @include game.R
G2048<-setRefClass("G2048",contains="Game",
                   
   methods=list(
     initialize = function(name,debug) {
       callSuper(name,debug) 
       
       name<<-"2048 Game"
       width<<-height<<-4
     },
     
     init = function(){
       callSuper()
       
       e$step<<-1/width
       e$dir<<-'up'
       e$colors<<-rainbow(14)
       e$stop<<-FALSE
       
       create()
     },
     
     create=function(){
       if(length(index(0))>0 & !e$stop){
         e$stop<<-TRUE
         
         one<-sample(c(2,4),1)
         idx<-ifelse(length(index(0))==1,index(0),sample(index(0),1))
         m[idx]<<-one
         
         if(debug){
          print(paste("POINT:(",idx,",",one,")"))     
          print(m)
         }
       }
      
     },
     
     lose=function(){
       
       near<-function(x){
         length(which(diff(x)==0))
       }

       if(length(index(0))==0){
         h<-apply(m,1,near)  # Horizontal 
         v<-apply(m,2,near) # Vertical
         
         if(length(which(h>0))==0 & length(which(v>0))==0){
           fail("No free grid.")
           return(NULL)
         }
       }
     },
     
     move=function(){
       
       moveFun=function(x){
         if(e$dir %in% c('right','down')) x<-rev(x)
         
         len0<-length(which(x==0)) 
         x1<-x[which(x>0)] 
         pos1<-which(diff(x1)==0)
         
         if(length(pos1)==3){ 
           pos1<-pos1[c(1,3)]
         }else if(length(pos1)==2 && diff(pos1)==1){
           pos1<-pos1[1]
         }
         
         x1[pos1]<-x1[pos1]*2
         x1[pos1+1]<-0
         
         x1<-x1[which(x1>0)]
         x1<-c(x1,rep(0,4))[1:4] 
         
         if(e$dir %in% c('right','down')) x1<-rev(x1)
         return(x1)
       }
       
       if(debug){
        print("MOVE================")
        print(m)
       }
       
       last_m<-m
       if(e$dir=='left')  m<<-t(apply(m,1,moveFun))
       if(e$dir=='right') m<<-t(apply(m,1,moveFun))
       if(e$dir=='up')    m<<-apply(m,2,moveFun)
       if(e$dir=='down')  m<<-apply(m,2,moveFun)
       
       e$stop<<-ifelse(length(which(m != last_m))==0,TRUE,FALSE)
     },
     
     drawTable=function(){
       if(isFail) return(NULL)
       
       par(mai=rep(0,4),oma=rep(0,4))
       plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
       abline(h=seq(0,1,e$step),col="gray60") # Horizontal 
       abline(v=seq(0,1,e$step),col="gray60") # Vertical
     },
     
     drawMatrix=function(){
       if(isFail) return(NULL)
       a<-c(t(m))
       lab<-c(a[13:16],a[9:12],a[5:8],a[1:4])
       
       d<-data.frame(x=rep(seq(0,0.95,e$step),width),y=rep(seq(0,0.95,e$step),each=height),lab=lab)
       df<-d[which(d$lab>0),]
       points(df$x+e$step/2,df$y+e$step/2,col=e$colors[log(df$lab,2)],pch=15,cex=23)
       text(df$x+e$step/2,df$y+e$step/2,label=df$lab,cex=2)
     },
     
     stage1=function(){
       callSuper()
       
       move()
       lose()
       create()
       
       drawTable()
       drawMatrix()  
       
       drawTable()
       drawMatrix()  
     },
     
     stage0=function(){
       callSuper()
       
       par(mai=rep(0,4),oma=rep(0,4))
       plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
       text(0.5,0.7,label=name,cex=5)
       text(0.5,0.4,label="Any keyboard to start",cex=2,col=4)
       text(0.5,0.3,label="Up,Down,Left,Rigth to control direction",cex=2,col=2)
       text(0.2,0.05,label="Author:DanZhang",cex=1)
       text(0.5,0.05,label="http://blog.fens.me",cex=1)
     },
     
     stage2=function(){
       callSuper()
       info<-paste("Congratulations! You have max number",max(m),"!")
       print(info)
       
       par(mai=rep(0,4),oma=rep(0,4))
       plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
       text(0.5,0.7,label="Game Over",cex=5)
       text(0.5,0.4,label="Space to restart, q to quit.",cex=2,col=4)
       text(0.5,0.3,label=info,cex=2,col=2)
       text(0.2,0.05,label="Author:DanZhang",cex=1)
       text(0.5,0.05,label="http://blog.fens.me",cex=1)
     },
     
     keydown=function(K){
       callSuper(K)
       
       if(stage==1){ #playing
         if(K == "q") stage2()
         else {
           if(tolower(K) %in% c("up","down","left","right")){
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

#' 2048 game function
#'
#' @export
g2048<-function(){
  game<-G2048$new()
  game$initFields()
  game$run()
}

#g2048()



