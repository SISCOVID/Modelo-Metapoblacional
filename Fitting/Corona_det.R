simulate <- function(theta,init.state,times) {
  ode <-function(t,x,params){
    
    S<-x[1]
    E<-x[2]
    A<-x[3]
    I1<-x[4]
    I2<-x[5]
    I3<-x[6]
    R <- x[7]
    D <- x[8]

    
    with(as.list(params),{
      
      N = S+E+A+I1+I2+I3+R
      
      if (t < 19) {
        beta = b1
      }
      if (t > 18 & t < 34) {
        beta = b2
      }
      if (t > 33 & t < 49) {
        beta = b3
      }
      if (t > 48 & t < 64) {
        beta = b4
      }
      if (t > 63 & t < 79) {
        beta = b5
      }
      if (t > 78 & t < 94) {
        beta = b6
      }
      if (t > 93) {
        beta = b7
      }
      
      sigmaa <- 1
      sigma1 <- 0.5
      sigma2 <- 0.1
      sigma3 <- 0.1
      
      omega <- 5
      rho1 <- 0.2
      rho2 <- 2/7
      rho3 <- 0.5
      
      lambda1 <- 5
      lambda2 <- 6
      lambda3 <- 10
      
      gamma1 <- 8
      gamma2 <- 8
      gamma3 <- 10
      
      dS <- -1*beta*S*(sigmaa*A+sigma1*I1+sigma2*I2+sigma3*I3)/N 
      dE <- beta*S*(sigmaa*A+sigma1*I1+sigma2*I2+sigma3*I3)/N - E/omega
      dA <- (1-phi)*E/omega - rho1*A/lambda1 - (1-rho1)*A/gamma1
      dI1 <- phi*E/omega - rho1*I1/lambda1 - (1-rho1)*I1/gamma1
      dI2 <- rho1*I1/lambda1 + rho1*A/lambda1 - rho2*I1/lambda2 - (1-rho2)*I2/gamma2
      dI3 <- rho2*I2/lambda2 - rho3*I3/lambda3 - (1-rho3)*I3/gamma3
      dR <- (1-rho1)*A/gamma1 + (1-rho1)*I1/gamma1 + (1-rho2)*I2/gamma2 + (1-rho3)*I3/gamma3
      dD <- rho3*I3/lambda3
      
      dx <- c(dS,dE,dA,dI1,dI2,dI3,dR,dD) 
      list(dx)
    })
  }
  
  traj <- as.data.frame(lsoda(init.state, times, ode, theta))
  return(traj)
}




rPointObs <- function(model.point, theta){
  
  obs.point <- rpois(n=1, lambda=model.point[["D"]])  
  return(c(obs=obs.point))
}

dPointObs <- function(data.point, model.point, theta,log = FALSE){
  model.point <- model.point[["D"]]
  if(model.point < 5e-08){
    model.point <- 6e-08
  }
  y <- dpois(x=data.point[["obs"]],lambda=model.point,log=log)
  return(y)
}

dprior <- function(theta, log = FALSE) {
  
  log.prior.b1 <- dunif(theta[["b1"]], min = 0, max = 5, log = TRUE)  
  log.prior.b2 <- dunif(theta[["b2"]], min = 0, max = 5, log = TRUE)  
  log.prior.b3 <- dunif(theta[["b3"]], min = 0, max = 5, log = TRUE)
  log.prior.b4 <- dunif(theta[["b4"]], min = 0, max = 5, log = TRUE)
  log.prior.b5 <- dunif(theta[["b5"]], min = 0, max = 5, log = TRUE)
  log.prior.b6 <- dunif(theta[["b6"]], min = 0, max = 5, log = TRUE)
  log.prior.b7<- dunif(theta[["b7"]], min = 0, max = 5, log = TRUE)
  
  log.prior.phi <- dunif(theta[["phi"]], min = 0, max = 1, log = TRUE)  
  
  
  
  log.sum =  log.prior.b1 + log.prior.b2 + log.prior.b3 + log.prior.b4 + log.prior.b5 + log.prior.b6 + log.prior.b7 +  log.prior.phi
  
  
  return(ifelse(log, log.sum, exp(log.sum)))
  
}

name <- "Corona"
state.names <- c("S","E","A","I1","I2","I3","R","D")
theta.names <- c("b1","b2","b3","b4","b5","b6","b7","phi")

Corona_det <- fitmodel(name, state.names, theta.names,simulate, rPointObs, dprior,dPointObs)  
