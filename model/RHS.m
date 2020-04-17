function dy = RHS(t,y,p,beta,mov)
%function RHS integrates the system of 5*n (n = number of nodes)
%differential equations that describe the population dynamics
%
%INPUT t time point
%      y state variables (column vector with 5*n rows) SEIAHR
%      p structure with parameters (see initialize)
%
%OUTPUT dy derivatives (column vector with 5*n rows)


y = reshape(y,p.t(3),5);%make variables a matrix (n,5) for easy coding (SEIAR)
%compute beta for migration (proportion of insects leaving per unit of
%time)

N = sum(y(:,1:5),2); %total population per node

trans = beta*y(:,1).*(y(:,3)+y(:,4))./N; %transmission term

%rate of change of S
dy(:,1) =  - trans + mov'*y(:,1)./(N-y(:,3)) - (mov)*y(:,1)./(N-y(:,3));
%rate of change of E
dy(:,2) = trans - y(:,2)/p.d(1) + mov'*y(:,2)./(N-y(:,3)) - (mov)*y(:,2)./(N-y(:,3));
%rate of change of I
dy(:,3) = p.t(2)*y(:,2)/p.d(1) - y(:,3)/(p.d(2)); 
%rate of change of A
dy(:,4) = (1 - p.t(2))*y(:,2)/p.d(1) - y(:,4)/p.d(2) + mov'*y(:,4)./(N-y(:,3)) - (mov)*y(:,4)./(N-y(:,3));
%rate of change of R
dy(:,5) = y(:,4)/p.d(2) + y(:,3)/p.d(2) + mov'*y(:,5)./(N-y(:,3)) - (mov)*y(:,5)./(N-y(:,3));
%organize output vector as column
dy = dy(:);
end 
