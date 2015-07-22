teacher <- function(x, ...) UseMethod("teacher")
teacher.lecture <- function(x) print("讲课")
teacher.assignment <- function(x) print("布置作业")
teacher.correcting <- function(x) print("批改作业")
teacher.default<-function(x) print("你不是teacher")
student <- function(x, ...) UseMethod("student")
student.attend <- function(x) print("听课")
student.homework <- function(x) print("写作业")
student.exam <- function(x) print("考试")
student.default<-function(x) print("你不是student")

a<-'teacher'
b<-'student'
attr(a,'class') <- 'lecture'
teacher(a)
attr(b,'class') <- 'attend'
student(b)
attr(a,'class') <- 'assignment'
teacher(a)
attr(b,'class') <- 'homework'
student(b)
attr(a,'class') <- 'correcting'
teacher(a)
attr(b,'class') <- 'exam'
student(b)

ab<-'student_teacher'
attr(ab,'class') <- c('lecture','homework')
teacher(ab)
student(ab)

student.correcting <- function(x) print("帮助老师批改作业")
char0 = character(0)
create <- function(classes=char0, parents=char0) {
   mro <- c(classes)
   for (name in parents) {
       mro <- c(mro, name)
       ancestors <- attr(get(name),'type')
       mro <- c(mro, ancestors[ancestors != name])
   }
   return(mro)
}

NewInstance <- function(value=0, classes=char0, parents=char0) {
   obj <- value
   attr(obj,'type') <- create(classes, parents)
   attr(obj,'class') <- c('attend','homework','exam')
   return(obj)
}
StudentObj <- NewInstance()
s1 <- NewInstance('普通同学',classes='normal', parents='StudentObj')
s2 <- NewInstance('课代表',classes='leader', parents='StudentObj')
attr(s2,'class') <- c(attr(s2,'class'),'correcting')
s1;s2

e1 <- NewInstance('优等生',classes='excellent', parents='StudentObj')
e2 <- NewInstance('次等生',classes='poor', parents='StudentObj')
student.exam <- function(x,score) {
   p<-"考试"
   if(score>85) print(paste(p,"优秀",sep=""))
   if(score<70) print(paste(p,"及格",sep=""))
}
attr(e1,'class') <- 'exam'
student(e1,90)
attr(e2,'class') <- 'exam'
student(e2,66)


char0 = character(1)
teacher_fun<-function(x=char0){
   if(x=='lecture'){
       print("讲课")
   }else if(x=='assignment'){
       print("布置作业")
   }else if(x=='correcting'){
       print("批改作业")
   }else{
       print("你不是teacher")
   }
}
student_fun<-function(x=char0){
   if(x=='attend'){
       print("听课")
   }else if(x=='homework'){
       print("写作业")
   }else if(x=='exam'){
       print("考试")
   }else{
       print("你不是student")
   }
}
teacher_fun('lecture')
student_fun('attend')


student_fun<-function(x=char0,role=0){
   if(x=='attend'){
     print("听课")
   }else if(x=='homework'){
     print("写作业")
   }else if(x=='exam'){
     print("考试")
   }else if(x=='correcting'){
     if(role==1){#课代表
       print("帮助老师批改作业")
     }else{
       print("你不是课代表")
     }
   }else{
     print("你不是student")
   }
}
student_fun('correcting')
student_fun('correcting',1)


student_fun<-function(x=char0,role=0,score){
   if(x=='attend'){
     print("听课")
   }else if(x=='homework'){
     print("写作业")
   }else if(x=='exam'){
     p<-"考试"
     if(score>85) print(paste(p,"优秀",sep=""))
     if(score<70) print(paste(p,"及格",sep=""))
   }else if(x=='correcting'){
     if(role==1){  #课代表
        print("帮助老师批改作业")
     }else{
        print("你不是课代表")
     }
   }else{
      print("你不是student")
   }
}
student_fun('exam',score=90)
student_fun('exam',score=66)


