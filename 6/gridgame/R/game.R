#' Game framework class
#'
#' The class is the base class of the gmae framework. 
#' You need extend the class within subclass.
#'
#'
#' @examples
#' \dontrun{
#'  Snake<-setRefClass("Snake",contains="Game")
#' }
Game<-setRefClass('Game',
                  
    fields=list(
      # System variables
      name="character", 
      debug='logical',  
      width='numeric',  
      height='numeric', 
      
      # App variables
      stage='numeric',  
      e='environment',  
      m='matrix',       
      isFail='logical'
    ),
                  
    methods=list(
      
      initialize = function(name,width,height,debug) {
        name<<-"R Game Framework"
        debug<<-FALSE
        width<<-height<<-20
      },
      
      init = function(){
        e<<-new.env()
        m<<-matrix(rep(0,width*height),nrow=width)
        isFail<<-FALSE
      },
      
      stage0=function(){
        stage<<-0
        init()
      },
      
      stage2=function(){
        stage<<-2
      },
      
      stage1=function(default=FALSE){
        stage<<-1
        if(FALSE){
          plot(0,0,xlim=c(0,1),ylim=c(0,1),type='n',xaxs="i", yaxs="i")
          text(0.5,0.7,label="Playing",cex=5)  
        }
      },
      
      index = function(col) {
        return(which(m==col))
      },
      
      fail=function(msg){
        print(paste("Game Over",msg))
        isFail<<-TRUE
        keydown('q')
        return(NULL)
      },
      
      keydown=function(K){
        if(stage==0){
          stage1()
          return(NULL)
        }  
        
        if(stage==2){
          if(K=="q") q()
          else if(K==' ') stage0()  
          return(NULL)
        } 
      },
      
      run=function(){
        par(mai=rep(0,4),oma=rep(0,4))
        stage0()
        
        if(.Platform$OS.type=='unix'){
          stop("These games are runing on Window!!")  
        }
        
        getGraphicsEvent(prompt="Snake Game",onKeybd=function(K){
          if(debug) print(paste("keydown",K))  
          return(keydown(K))
        })
      }
    )                  
)
