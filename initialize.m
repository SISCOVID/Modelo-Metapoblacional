function p = initialize(City,n_variables)

Nodes = [City.node.pop];
shifts = City.nShifts;

nn = length(Nodes);
p.n = nn;

p.s_a = 1;
p.s_1 = 0.5;
p.s_2 = 0.1;
p.s_3 = 0.1;
p.p = 0.2280516;
% p.k = 0.7;
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
S = Nodes';
E = 0*ones(nn,1);
E(1) = 1;
A = 0*ones(nn,1);
I1 = 0*ones(nn,1);
I2 = 0*ones(nn,1);
I3 = 0*ones(nn,1);
R = 0*ones(nn,1);
D = 0*ones(nn,1);
p.Y0 = [S;E;A;I1;I2;I3;R;D];

p.options = odeset('RelTol',1e-4,'AbsTol',1e-4,'NonNegative',1:1:nn*n_variables);

end