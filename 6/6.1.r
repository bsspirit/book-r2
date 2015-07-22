letter<-function(){
  draw<-function(label='',x=0,y=0){
    plot(x,y,type='n')
    text(x,y,label=label,cex=5)
  }
  keydown<-function(K){
    if (K == "ctrl-C") return(invisible(1))
    print(K)
    draw(K)
  }
  draw()
  getGraphicsEvent(prompt="Letter Tool",onKeybd = keydown)
}

letter()

mouse <- function() {
    par(mai=rep(0,4),oma=rep(0,4))
    ps<-data.frame(x=c(0.5),y=c(0.5),col=c(2),pch=c(15))
    draw<-function(x=0,y=0){
        plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
        abline(h=0.5,col="gray60")
        abline(v=0.5,col="gray60")
        points(ps$x,ps$y,pch=ps$pch,cex=2,col=ps$col)
        points(x,y,pch=15,cex=2,col=colors()[ps$col])
        text(0.25,0.015,label=paste(x,y,sep=","))
    }
    mouseDown <- function(buttons, x, y) {
        print(paste("down",buttons,x,y))
        shape<-15
        if(buttons==1) shape<-16
        if(buttons==2) shape<-17
        ps<<-rbind(ps,data.frame(x=c(x),y=c(y),pch=c(shape),col=round(runif(1,2,500))))
        draw(x,y)
    }
    mouseMove <- function(buttons, x, y) {
        print(paste("move",buttons,x,y))
        draw(x,y)
    }
    mouseup <- function(buttons, x, y) {
        print(paste("up",buttons,x,y))
        draw(x,y)
    }
    keydown <- function(key) {
        if (key == "q") return(invisible(1))
    }
    draw()
    getGraphicsEvent(prompt="mouse",onMouseDown=mouseDown,onMouseMove=mouseMove,onMouseUp=mouseup,onKeybd=keydown)
}
mouse()
