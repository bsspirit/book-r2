adjacencyMatrix<-function(pages){
  n<-max(apply(pages,2,max))
  A <- matrix(0,n,n)
  for(i in 1:nrow(pages)) A[pages[i,]$dist,pages[i,]$src]<-1
  A
}
probabilityMatrix<-function(G){
  cs <- colSums(G)
  cs[cs==0] <- 1
  n <- nrow(G)
  A <- matrix(0,nrow(G),ncol(G))
  for (i in 1:n) A[i,] <- A[i,] + G[i,]/cs
  A
}
eigenMatrix<-function(G,iter=100){
  iter<-10
  n<-nrow(G)
  x <- rep(1,n)
  for (i in 1:iter) x <- G %*% x
  x/sum(x)
}
pages<-read.table(file="page.csv",header=FALSE,sep=",")
names(pages)<-c("src","dist");pages
A<-adjacencyMatrix(pages);A
G<-probabilityMatrix(A);G
q<-eigenMatrix(G,100);q

dProbabilityMatrix<-function(G,d=0.85){
  cs <- colSums(G)
  cs[cs==0] <- 1
  n <- nrow(G)
  delta <- (1-d)/n
  A <- matrix(delta,nrow(G),ncol(G))
  for (i in 1:n) A[i,] <- A[i,] + d*G[i,]/cs
  A
}
pages<-read.table(file="page.csv",header=FALSE,sep=",")
names(pages)<-c("src","dist")
A<-adjacencyMatrix(pages);A
G<-dProbabilityMatrix(A);G
q<-eigenMatrix(G,100);q

calcEigenMatrix<-function(G){
  x <- Re(eigen(G)$vectors[,1])
  x/sum(x)
}
pages<-read.table(file="page.csv",header=FALSE,sep=",")
names(pages)<-c("src","dist")
A<-adjacencyMatrix(pages);A
G<-dProbabilityMatrix(A);G
q<-calcEigenMatrix(G);q




map <- function(S0, node = "a") {
  S <- apply(S0, 2, function(x) x/sum(x))
  if (node == "a")
    S[, 1:2] else S[, 3:4]
}
reduce <- function(A, B, a = 0.85, niter = 100) {
  n <- nrow(A)
  q <- rep(1, n)
  Ga <- a * A + (1 - a)/n * (A[A != 1] = 1)
  Gb <- a * B + (1 - a)/n * (B[B != 1] = 1)
  for (i in 1:niter) {
    qa <- as.matrix(q[1:ncol(A)])
    qb <- as.matrix(q[(ncol(A) + 1):n])
    q <- Ga %*% qa + Gb %*% qb
  }
  as.vector(q/sum(q))
}
S0 <- t(matrix(c(0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0),nrow = 4))
A <- map(S0, "a")
B <- map(S0, "b")
reduce(A, B)


reduce <- function(A, B, a = 0.85, niter = 100) {
  n <- nrow(A)
  q <- rep(1, n)
  Ga <- a * A + (1 - a)/n * (A[A != 1] = 1)
  Gb <- a * B + (1 - a)/n * (B[B != 1] = 1)
  for (i in 1:niter) {
    qa <- as.matrix(q[1:ncol(A)])
    qb <- as.matrix(q[(ncol(A) + 1):n])
    q <- Ga %*% qa + Gb %*% qb
  }
  print(q)
  print(as.vector(q/sum(q)))
}
reduce(A, B, niter=1)
reduce(A, B, niter=2)
reduce(A, B, niter=10)









