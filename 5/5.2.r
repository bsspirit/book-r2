# install.packages("devtools")
# install.packages("roxygen2")
# install.packages("testthat")

library(devtools)
library(roxygen2)
library(testthat)
search()

setwd("/home/conan/R")
create("/home/conan/R/chinaWeather")
setwd("/home/conan/R/chinaWeather")
dir()

load_all("/home/conan/R/chinaWeather")
filename
filename()
day<-as.Date("20110701",format="%Y%m%d")
filename(day)

source("/home/conan/R/chinaWeather/inst/tests/test.chinaWeather.R")
test_file("/home/conan/R/chinaWeather/inst/tests/test.chinaWeather.R")
test_dir("/home/conan/R/chinaWeather/inst/tests/",reporter = "summary")

src<-"/home/conan/R/chinaWeather/R/"
test<-"/home/conan/R/chinaWeather/inst/tests/"
auto_test(src,test)
test("/home/conan/R/chinaWeather")

roxygenize("/home/conan/R/chinaWeather")

load_all("/home/conan/R/chinaWeather")
test("/home/conan/R/chinaWeather")
document("/home/conan/R/chinaWeather")

check("/home/conan/R/chinaWeather")

library(devtools)
install_github("bsspirit/chinaWeatherDemo")
library(chinaWeather)
filename()
?filename