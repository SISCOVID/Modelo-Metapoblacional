%%% script to run with random data
Nodes = round(rand(2,1)*100); % population per node (code asumes everyone is susceptible)
t = 100; % time
beta = rand(t,1)*10; % betas per day (or time step)
mov = rand(2,2)/10; % movement matrix
mov = mov - diag(diag(mov)); % zeros in mov diagonal

[T,Y] = runfun(Nodes,t,beta,mov);