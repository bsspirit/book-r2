init<-function(){
    e<<-new.env()
    e$stage<-0
    e$width<-e$height<-20
    e$step<-1/e$width
    e$m<-matrix(rep(0,e$width*e$height),nrow=e$width)
    e$dir<-e$lastd<-'up'
    e$head<-c(2,2)
    e$lastx<-e$lasty<-2
    e$tail<-data.frame(x=c(),y=c())
    e$col_furit<-2
    e$col_head<-4
    e$col_tail<-8
    e$col_path<-0
}
index<-function(col) which(e$m==col)

stage1<-function(){
    e$stage<-1
    furit<-function(){
        if(length(index(e$col_furit))<=0){
            idx<-sample(index(e$col_path),1)
            fx<-ifelse(idx%%e$width==0,10,idx%%e$width)
            fy<-ceiling(idx/e$height)
            e$m[fx,fy]<-e$col_furit
            print(paste("furit idx",idx))
            print(paste("furit axis:",fx,fy))
        }
    }
    fail<-function(){
        if(length(which(e$head<1))>0 | length(which(e$head>e$width))>0){
            print("game over: Out of ledge.")
            keydown('q')
            return(TRUE)
        }
        if(e$m[e$head[1],e$head[2]]==e$col_tail){
            print("game over: head hit tail")
            keydown('q')
            return(TRUE)
        }
        return(FALSE)
    }
    head<-function(){
        e$lastx<-e$head[1]
        e$lasty<-e$head[2]
        if(e$dir=='up') e$head[2]<-e$head[2]+1
        if(e$dir=='down') e$head[2]<-e$head[2]-1
        if(e$dir=='left') e$head[1]<-e$head[1]-1
        if(e$dir=='right') e$head[1]<-e$head[1]+1

    }
    body<-function(){
        e$m[e$lastx,e$lasty]<-0
        e$m[e$head[1],e$head[2]]<-e$col_head
        if(length(index(e$col_furit))<=0){
            e$tail<-rbind(e$tail,data.frame(x=e$lastx,y=e$lasty))
        }
        if(nrow(e$tail)>0) {
            e$tail<-rbind(e$tail,data.frame(x=e$lastx,y=e$lasty))
            e$m[e$tail[1,]$x,e$tail[1,]$y]<-e$col_path
            e$tail<-e$tail[-1,]
            e$m[e$lastx,e$lasty]<-e$col_tail
        }
        print(paste("snake idx",index(e$col_head)))
        print(paste("snake axis:",e$head[1],e$head[2]))
    }
    drawTable<-function(){
        plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
    }
    drawMatrix<-function(){
        idx<-which(e$m>0)
        px<- (ifelse(idx%%e$width==0,e$width,idx%%e$width)-1)/e$width+e$step/2
        py<- (ceiling(idx/e$height)-1)/e$height+e$step/2
        pxy<-data.frame(x=px,y=py,col=e$m[idx])
        points(pxy$x,pxy$y,col=pxy$col,pch=15,cex=4.4)
    }
    furit()
    head()
    if(!fail()){
        body()
        drawTable()
        drawMatrix()
    }
}

stage0<-function(){
    e$stage<-0
    plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
    text(0.5,0.7,label="Snake Game",cex=5)
    text(0.5,0.4,label="Any keyboard to start",cex=2,col=4)
    text(0.5,0.3,label="Up,Down,Left,Rigth to control direction",cex=2,col=2)
    text(0.2,0.05,label="Author:DanZhang",cex=1)
    text(0.5,0.05,label="http://blog.fens.me",cex=1)
}

stage2<-function(){
    e$stage<-2
    plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
    text(0.5,0.7,label="Game Over",cex=5)
    text(0.5,0.4,label="Space to restart, q to quit.",cex=2,col=4)
    text(0.5,0.3,label=paste("Congratulations! You have eat",nrow(e$tail),"fruits!"),cex=2,col=2)
    text(0.2,0.05,label="Author:DanZhang",cex=1)
    text(0.5,0.05,label="http://blog.fens.me",cex=1)
}


keydown<-function(K){
    print(paste("keydown:",K,",stage:",e$stage));
    if(e$stage==0){
        init()
        stage1()
        return(NULL)
    }
    if(e$stage==2){
        if(K=="q") q()
        else if(K==' ') stage0()
        return(NULL)
    }
    if(e$stage==1){
        if(K == "q") {
            stage2()
        } else {
            if(tolower(K) %in% c("up","down","left","right")){
                e$lastd<-e$dir
                e$dir<-tolower(K)
                stage1()
            }
        }
    }
    return(NULL)
}

run<-function(){
    par(mai=rep(0,4),oma=rep(0,4))
    e<<-new.env()
    stage0()
    getGraphicsEvent(prompt="Snake Game",onKeybd=keydown)
}
run()