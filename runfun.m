function [T,Y] = runfun(p,node,t,beta,mov,n_variables)
%funtion runfun intialize network parameters and initial conditiosn, runs
%ode and generates graphical output
%
%INPUT nn number of cities
%      t time span for simulation - total simulation
%
%OUTPUT T time vector from ode solver
%       Y state variables (SEIAR)
global shifts
step = 1; %time step for alpha use
%run ode for time duration specified by t
[T,Y] = ode15s(@RHS,[0 step],p.Y0,p.options,p,beta(:,1),mov{1},n_variables);
Ynew = Y(end,:)';
Tnew = T(end);
a=2;
b=2;
global betah
betah = [];
for i=2:t
   
    matriz = mov{b};
    bet = beta(:,a);

%     INTERVENTIONS

global daysSince

for n=1:length(node)
    if(Ynew((n_variables-3)*length(node)+n)>node(n).hosp && a>=daysSince*shifts)
        matriz(:,n) = matriz(:,n)*0.15;
        matriz(n,:) = matriz(n,:)*0.15;
        bet(n) = 0.05*1.5;
    end
end
    
    betah = [betah,bet];
    
    % SIMS
    [T1,Y1] = ode15s(@RHS,[Tnew Tnew+step],Ynew,p.options,p,bet,matriz,n_variables);
    Y = cat(1,Y,Y1(2:end,:));
    T = cat(1,T,T1(2:end));
    Ynew = Y1(end,:)';
    Tnew = T1(end);
    a = a + 1;
    b = b + 1;
    if b > 8*shifts %%% this term is used if we mov to repeat during the simulation
     b = 1;
    end


end


end 




