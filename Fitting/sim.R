library('fitR')
library('MASS')
library(tidyr)
library(ggplot2)
library('coda')
library(lattice)

source('functions_corona.R')
source('Corona_det.R')
load("Data.RData")
init.state <- c(S=1000000,E=0,A=0,I1=2,I2=0,I3=0,R=0,D=0) # S susceptible population
theta <- c(b1=0.8,b2=0.8,b3=0.8,b4=0.8,b5=0.8,b6=0.8,b7=0.8,phi=0.5) # initial conditions

data1 <- dataset
data1<-data1[complete.cases(data1), ]
data1$time <- as.numeric(data1$time)
data1$obs <- as.numeric(data1$obs)
data1$date <- as.Date(data1$date)


posTdC <- function(theta){
  
  my_fitmodel1 <- Corona_det
  my_init.state <- init.state
  return(dLogPosCORONA(fitmodel = my_fitmodel1,
                       theta = theta,
                       init.state =  my_init.state,
                       data = data1))
  
}

init.theta <- theta
lower <- c(b1=0,b2=0,b3=0,b4=0,b5=0,b6=0,b7=0,phi=0)
upper <- c(b1=3,b2=3,b3=3,b4=3,b5=3,b6=3,b7=3,phi=1)

n.iterations <- 1000
adapt.size.start <- 100
adapt.size.cooling <- 0.999
adapt.shape.start <- 200

my_mcmc.TdC <- mcmcMH(target = posTdC,
                      init.theta = theta,
                      limits = list(lower = lower,upper = upper),
                      n.iterations = n.iterations,
                      adapt.size.start = adapt.size.start,
                      adapt.size.cooling = adapt.size.cooling,
                      adapt.shape.start = adapt.shape.start)


theta <- colMeans(my_mcmc.TdC$trace[100:1000,1:8])
covmat <- my_mcmc.TdC$covmat.empirical

n.iterations <- 10000
adapt.size.start <- 200
adapt.size.cooling <- 0.999
adapt.shape.start <- 200

my_mcmc.TdC2 <- mcmcMH(target = posTdC,
                       init.theta = theta,
                       covmat = covmat,
                       limits = list(lower = lower,upper = upper),
                       n.iterations = n.iterations,
                       adapt.size.start = adapt.size.start,
                       adapt.size.cooling = adapt.size.cooling,
                       adapt.shape.start = adapt.shape.start)

save(my_mcmc.TdC,my_mcmc.TdC2)
