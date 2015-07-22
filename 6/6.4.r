moveFun<-function(x,dir){         # 移动函数
   if(dir == 'right') x<-rev(x)    # 如果向右移动，则倒叙排列

   len0<-length(which(x==0))       # 0长度
   x1<-x[which(x>0)]               #去掉0
   pos1<-which(diff(x1)==0)        # 找到挨着相等的元素的位置

   if(length(pos1)==3){            # 3个索引
     pos1<-pos1[c(1,3)]
   }else if(length(pos1)==2 && diff(pos1)==1){     # 2个索引
     pos1<-pos1[1]
   }

   x1[pos1]<-x1[pos1]*2
   x1[pos1+1]<-0

   x1<-x1[which(x1>0)]             #去掉0
   x1<-c(x1,rep(0,4))[1:4]         #补0，取4个

   if(dir == 'right') x1<-rev(x1)
   return(x1)
 }

library(testthat)
x<-c(4,2,2,2)
expect_that(moveFun(x,'left'), equals(c(4,4,2,0)))
expect_that(moveFun(x,'right'), equals(c(0,4,2,4)))

x<-c(4,4,2,4)
expect_that(moveFun(x,'left'), equals(c(8,2,4,0)))
expect_that(moveFun(x,'right'), equals(c(0,8,2,4)))

x<-c(2,2,0,2)
expect_that(moveFun(x,'left'), equals(c(4,2,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,2,4)))

x<-c(2,4,2,4)
expect_that(moveFun(x,'left'), equals(c(2,4,2,4)))
expect_that(moveFun(x,'right'), equals(c(2,4,2,4)))

x<-c(4,4,2,2)
expect_that(moveFun(x,'left'), equals(c(8,4,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,8,4)))

x<-c(2,2,4,4)
expect_that(moveFun(x,'left'), equals(c(4,8,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,4,8)))

x<-c(4,4,0,4)
expect_that(moveFun(x,'left'), equals(c(8,4,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,4,8)))

x<-c(4,0,4,4)
expect_that(moveFun(x,'left'), equals(c(8,4,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,4,8)))

x<-c(4,0,4,2)
expect_that(moveFun(x,'left'), equals(c(8,2,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,8,2)))

x<-c(2,2,2,2)
expect_that(moveFun(x,'left'), equals(c(4,4,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,4,4)))

x<-c(2,2,2,0)
expect_that(moveFun(x,'left'), equals(c(4,2,0,0)))
expect_that(moveFun(x,'right'), equals(c(0,0,2,4)))