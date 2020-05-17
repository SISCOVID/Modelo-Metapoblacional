function dy = RHS(t,y,p,beta,mov,n_variables)
%function RHS integrates the system of 5*n (n = number of nodes)
%differential equations that describe the population dynamics
%
%INPUT t time point
%      y state variables (column vector with 5*n rows) SEIAHR
%      p structure with parameters (see initialize)
%
%OUTPUT dy derivatives (column vector with 5*n rows)

y = reshape(y,p.n,n_variables);%make variables a matrix (n,3) for easy coding (Eggs Nimphs Nodes)

N = sum(y(:,1:n_variables-1),2);

trans = beta.*y(:,1).*(p.s_a*y(:,3) + p.s_1*y(:,4) + p.s_2*y(:,5) + p.s_3*y(:,6))./N;


%rate of change of S
dy(:,1) =  - trans + mov'*y(:,1) - (mov)*y(:,1);
%rate of change of E
dy(:,2) = trans - (1-p.p)*(1-p.k)*y(:,2)/p.w - p.p*p.k*y(:,2)/p.w + mov'*y(:,2) - (mov)*y(:,2);
%rate of change of A
dy(:,3) = (1-p.p)*(1-p.k)*y(:,2)/p.w - p.r_1*y(:,3)/p.l_1 - (1-p.r_1)*y(:,3)/p.g_1 + mov'*y(:,3) - (mov)*y(:,3);
%rate of change of I1
dy(:,4) = p.p*p.k*y(:,2)/p.w - p.r_1*y(:,4)/p.l_1 - (1-p.r_1)*y(:,4)/p.g_1;
%rate of change of I2
dy(:,5) = p.r_1*y(:,4)/p.l_1 + p.r_1*y(:,3)/p.l_1 - p.r_2*y(:,5)/p.l_2 - (1-p.r_2)*y(:,5)/p.g_2;
%rate of change of I3
dy(:,6) = p.r_2*y(:,5)/p.l_2 - p.r_3*y(:,6)/p.l_3 - (1-p.r_3)*y(:,6)/p.g_3;
%rate of change of R
dy(:,7) = (1-p.r_1)*y(:,3)/p.g_1 + (1-p.r_1)*y(:,4)/p.g_1 + (1-p.r_2)*y(:,5)/p.g_2 + (1-p.r_3)*y(:,6)/p.g_3 + mov'*y(:,7) - (mov)*y(:,7);
%rate of change of D
dy(:,8) = p.r_3*y(:,6)/p.l_3;
%organize output vector as column
dy = dy(:);
end 
