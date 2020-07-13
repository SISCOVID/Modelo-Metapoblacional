dLogPosCORONA <- function(fitmodel, theta, init.state, data) {
  log.prior <- fitmodel$dprior(theta, log = TRUE)
  log.likelihood <- dTrajObs_CORONA(fitmodel, theta, init.state, data, log = TRUE)
  log.posterior <- log.prior + log.likelihood
  
  return(log.posterior)
  
}

dTrajObs_CORONA <- function (fitmodel, theta, init.state, data, log = FALSE) {
  times <- rep(0:tail(data$time,n=1))
  traj <- fitmodel$simulate(theta, init.state, times)
  dens <- 0
  dens1 <- matrix(0,nrow(data),3)
  for (i in 1:nrow(data)) {
    data.point <- unlist(data[i, ])
    model.point <- unlist(traj[data.point[2]+1, ])
    density <- fitmodel$dPointObs(data.point = data.point, 
                                  model.point = model.point, theta = theta, log = TRUE)
    dens1[i,] <-c(data.point[["obs"]],model.point[["D"]],density) 
    dens <- sum(dens1[,3])
  }
  return(ifelse(log, dens, exp(dens)))
}

plotFit_DE <- function (fitmodel, theta, init.state, data, n.replicates = 1, 
                        summary = TRUE, alpha = min(1, 10/n.replicates), all.vars = FALSE, 
                        non.extinct = NULL, observation = TRUE, plot = TRUE){
  times <- rep(0:tail(data$time,n=1))
  if (n.replicates > 1) {
    cat("Simulate ", n.replicates, " replicate(s)\n")
  }
  traj <- simulateModelReplicates(fitmodel = fitmodel, theta = theta, 
                                  init.state = init.state, times = times, n = n.replicates, 
                                  observation = observation)
  if (all.vars) {
    state.names <- NULL
  }
  else {
    state.names <- grep("obs", names(traj), value = TRUE)
  }
  p <- plotTraj(traj = traj, state.names = state.names, data = data, 
                summary = summary, alpha = alpha, non.extinct = non.extinct, 
                plot = FALSE)
  if (plot) {
    print(p)
  }
  else {
    return(list(traj = traj, plot = p))
  }
}

