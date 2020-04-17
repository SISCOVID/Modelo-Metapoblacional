function p = initialize(Nodes)
%function initialize generates a structure with all parameters, initial
%conditions and "network" information for integration  and plotting.
%
%INPUT netname network name (i.e France)
% 
%OUTPUT p structure with the following indices:

%load network information (N, num, alphas)
%network characteristics 
nn = length(Nodes);%number of nodes/locaties
p.n = nn;%number of nodes
p.d = [5.2 7];%transition times: latent infectious [days]
p.t = [1.75 0.2 nn];% transmission rate (if it is constant) and reporting rate 
%parameters for Beta. function that defines percapita migration rate and
%Initial conditions
S = Nodes;%initial number of susceptible inds
E = 0*ones(nn,1);%initial number of exposed inds
E(1) = 1;% one exposed in first node
I = 0*ones(nn,1);%initial number of infected inds*could be clinical or whatever
A = 0*ones(nn,1);%initial number of asymptomatic inds
R = 0*ones(nn,1);%initial number of recovered inds
p.Y0 = [S;E;I;A;R];%vector with initial conditions
%ode options (note the nonnegative term for zero crossing)
p.options = odeset('RelTol',1e-4,'AbsTol',1e-4,'NonNegative',1:1:nn*5);
end