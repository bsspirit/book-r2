search()

a<-1:10;a
assign('b',seq(1:10));b

1:10+10:1

a<-1:100000
b<-100000:1
run1<-function(){
  sum(as.numeric(a+b))
}
run2<-function(){
  c2<-0
  for(i in 1:length(a)){
      c2<-a[i]+b[i]+c2
    }
  c2
}
system.time(run1())
system.time(run2())

ls()
ls(pattern="^sum$",envir=baseenv())
