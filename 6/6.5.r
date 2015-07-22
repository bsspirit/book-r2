setwd("D:/workspace/R/app")
library(devtools)
library(roxygen2)
library(testthat)

create(paste(getwd(),"/gridgame",sep="")) 
setwd(paste(getwd(),"/gridgame",sep=""))
dir(full.names=TRUE) 

setwd("D:/workspace/R/app/gridgame")
load_all(getwd())
snake() 
g2048() 

test(getwd())
document(getwd())
check(getwd())

build()
build(binary=TRUE)

library(devtools)
install_github("gridgame","bsspirit")
