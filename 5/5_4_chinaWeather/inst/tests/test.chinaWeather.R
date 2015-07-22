library(testthat)
context("filename: current of date")

test_that("filename is current of date", {
  daystr<-paste(format(Sys.Date(), "%Y%m%d"),".csv",sep="")
  expect_that(filename(), equals(daystr))

  day<-as.Date("20110701",format="%Y%m%d")
  expect_that(filename(day), equals("20110701.csv"))
})

