function [  ] = graphMetaPop(City)
global v_Variables

City = City(1);
T = City.T;
Y = City.Y;
n_nodes = length(City.node);

n_variables = length(v_Variables);


figure()
set(gcf,'color','w');

for g=1:n_nodes
    hold on
    %Susceptibles 1st variable
    plot3(T,g*ones(size(T)),Y(:,g),'k','LineWidth',2)
% plot(T,Y(:,g),'k','LineWidth',2)
    
    %Recovered 7th variable
    plot3(T,g*ones(size(T)),Y(:,(g+(6*n_nodes))),'g','LineWidth',2)
%     plot(T,Y(:,(g+(6*n_nodes))),'g','LineWidth',2)    
    %Deaths 8th variable
    plot3(T,g*ones(size(T)),Y(:,(g+(7*n_nodes))),'m','LineWidth',2)
% plot(T,Y(:,(g+(7*n_nodes))),'m','LineWidth',2)
    
end

figure()
set(gcf,'color','w');

total = zeros(length(Y(:,1)),1);

for g=1:n_nodes
    hold on
%     %Exposed 2nd variable
%     plot3(T,g*ones(size(T)),Y(:,(g+(1*n_nodes))),'b','LineWidth',2)
%     
%     %Asymptomatic 3th variable
%     plot3(T,g*ones(size(T)),Y(:,(g+(2*n_nodes))),'k','LineWidth',2)
    
%     Infected1 4rd variable
%     plot3(T,g*ones(size(T)),Y(:,(g+(3*n_nodes))),'LineWidth',2,'color',[1 0.85 0.85])
% plot(T,Y(:,(g+(3*n_nodes))),'LineWidth',2,'color',[1 0.85 0.85])
    
%     Infected2 5rd variable
%     plot3(T,g*ones(size(T)),Y(:,(g+(4*n_nodes))),'LineWidth',2,'color',[1 0.6 0.6])
% plot(T,Y(:,(g+(4*n_nodes))),'LineWidth',2,'color',[1 0.6 0.6])
    
%     Infected3 6rd variable
    plot3(T,g*ones(size(T)),Y(:,(g+(5*n_nodes))),'r','LineWidth',2)

% % plot(T,Y(:,(g+(5*n_nodes))),'r','LineWidth',2)
%     total = total+Y(:,(g+(5*n_nodes)));

% total = Y(:,(g+(3*n_nodes)))+Y(:,(g+(4*n_nodes)))+Y(:,(g+(5*n_nodes)));
% plot(T,total)

end

set(gca,'ytick',1:n_nodes);

set(gca,'yticklabel',{'Riomar';'NorteCH';'SurOcc';'SurOr';'Metrop'});

% figure()
% plot(total)

end


