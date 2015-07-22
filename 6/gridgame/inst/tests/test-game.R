context("game")

test_that("Initial the construct function of Game class", {
  name<-"R"
  width<-height<-10
  
  game<-Game$new()
  game$initFields(name=name,width=width,height=height)
  expect_that(game$name,equals(name))
  expect_that(game$width,equals(width))
  expect_that(game$height,equals(height))
})


