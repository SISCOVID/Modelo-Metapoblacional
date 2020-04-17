function [T,Y] = runfun(Nodes,t,beta,mov)
%funtion runfun intialize network parameters and initial conditiosn, runs
%ode and generates graphical output
%
%INPUT nn number of cities
%      t time span for simulation - total simulation
%
%OUTPUT T time vector from ode solver
%       Y state variables (SEIAR)

p = initialize(Nodes);
t1 = 1; %time step for alpha use
%run ode for time duration specified by t
[T,Y] = ode45(@RHS,[0 t1],p.Y0,p.options,p,beta(1),mov);
Ynew = Y(end,:)';
Tnew = T(end);
c=2;
for i=2:t
    [T1,Y1] = ode45(@RHS,[Tnew Tnew+1],Ynew,p.options,p,beta(c),mov);
    Y = cat(1,Y,Y1(2:end,:));
    T = cat(1,T,T1(2:end));
    Ynew = Y1(end,:)';
    Tnew = T1(end);
    c = c + 1;
%     if c > 14 %%% this term is used if we need betas and mov to repeat
%                   during the simulation
%         c = 1;
%     end
end

n= length(Nodes);
%plots S and R
plot(T,Y(:,1:n),'color',[0 0 0],'LineWidth',1)
hold on
plot(T,Y(:,4*n+1:5*n),'color',[0 100/255 0],'LineWidth',1)
figure
%plots E, I and A
plot(T,Y(:,n+1:2*n),'color',[1 140/255 0],'LineWidth',1)
hold on
plot(T,Y(:,2*n+1:3*n),'color',[1 0 0],'LineWidth',1)
plot(T,Y(:,3*n+1:4*n),'color',[1 215/255 0],'LineWidth',1)
end 




