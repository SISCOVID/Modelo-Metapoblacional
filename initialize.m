function p = initialize(Nodes,n_variables)
%function initialize generates a structure with all parameters, initial
%conditions and "network" information for integration  and plotting.
%
%INPUT netname network name (i.e France)
%
%OUTPUT p structure with the following indices:

%load network information (N, num, alphas)
%network characteristics
% nn = length(Nodes);%number of nodes/locaties
% p.n = nn;%number of nodes
% p.d = [5 7 7 7 7];%transition times: latent infectious1 infectious2 infectious3 death time [days]
% p.t = [1.75 0.2 0.85 0.90 0.95 nn];% transmission rate, reporting rate, recovery prop I0,  recovery prop I1, recovery prop I2
%parameters for Beta. function that defines percapita migration rate and

global shifts

nn = length(Nodes);
p.n = nn;

p.s_a = 1;
p.s_1 = 0.5;
p.s_2 = 0.1;
p.s_3 = 0.1;
p.p = 1;
p.k = 0.7;
p.w = 5*shifts;
p.r_1 = 0.2;
p.r_2 = 2/7;
p.r_3 = 0.5;
p.l_1 = 5*shifts;
p.l_2 = 6*shifts;
p.l_3 = 10*shifts;
p.g_a = 10*shifts;
p.g_1 = 8*shifts;
p.g_2 = 8*shifts;
p.g_3 = 10*shifts;
    

%Initial conditions
S = Nodes';%initial number of susceptible inds
E = 0*ones(nn,1);%initial number of exposed inds
E(1) = 1;% one exposed in first node
A = 0*ones(nn,1);%initial number of asymptomatic inds
I1 = 0*ones(nn,1);%initial number of infected inds*could be clinical or whatever
I2 = 0*ones(nn,1);%initial number of infected inds*could be clinical or whatever
I3 = 0*ones(nn,1);%initial number of infected inds*could be clinical or whatever
R = 0*ones(nn,1);%initial number of recovered inds
D = 0*ones(nn,1);%initial number of death individuals
p.Y0 = [S;E;A;I1;I2;I3;R;D];%vector with initial conditions
%ode options (note the nonnegative term for zero crossing)
p.options = odeset('RelTol',1e-4,'AbsTol',1e-4,'NonNegative',1:1:nn*n_variables);
end