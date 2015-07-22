rm(list=ls())
setwd("/home/conan/R/demo")
package.skeleton(name="sayHello",code_files="/home/conan/R/demo/sayHello.R")

library(sayHello)
sayHello("Conan")
?sayHello

remove.packages("sayHello")
library(sayHello)

