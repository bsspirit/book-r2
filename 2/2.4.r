install.packages("mcga")
library(mcga)
f<-function(x){
  return ((x[1]-5)^2 + (x[2]-55)^2 +(x[3]-555)^2 +(x[4]-5555)^2 +(x[5]-55555)^2)
}
m <- mcga(  popsize=500, 
            chsize=5, 
            minval=0.0, 
            maxval=999999, 
            maxiter=2500, 
            crossprob=1.0, 
            mutateprob=0.01, 
            evalFunc=f)

print(m$population[1,])
m$costs[1]


install.packages("genalg")
library(genalg)
f<-function(x){
  return (abs(x[1]-sqrt(exp(1)))+abs(x[2]-log(pi)))
}
monitor <- function(obj) {
  xlim = c(obj$stringMin[1], obj$stringMax[1]);
  ylim = c(obj$stringMin[2], obj$stringMax[2]);
  plot(obj$population, xlim=xlim, ylim=ylim, xlab="sqrt(exp(1))", ylab="log(pi)");
}

m2 = rbga(c(1,1), 
          c(3,3),
          popSize=100,
          iters=1000,
          evalFunc=f,
          mutationChance=0.01,
          verbose=TRUE,
          monitorFunc=monitor
          )
plot(m2)
plot(m2, type="hist")
plot(m2, type="vars")
