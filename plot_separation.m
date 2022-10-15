close all
load('Result1.mat')
t = 200;
hold on
% scatter3(Sim{1,1}(2,:),Sim{1,1}(3,:),Sim{1,1}(4,:))
xlabel('x')
ylabel('y')
zlabel('z')
% axis equal
hold on;

for i = 1:2:t
figure ('Name','Separation and Aircraft') ;       
 subplot(2,1,1); 
         title("Separation Minimum")
         plotseparation = plot([1:i],separationminimum(1,[1:i]),'r');
         xlim([0 2000])
         ylim ([0 30000])
         xlabel('x (time)')
         ylabel('y (meter)')
        hold on

subplot(2,1,2)
        title("Capacity Maximum")
        plotcapacity = plot([1:i],CapacityArray{1,1}(1,[1:i]),'r');
        xlim([0 3600])
        ylim([0 50])
        xlabel('x (time')
        ylabel('y (Airplane)')
        hold on

pause(0.05);
delete(plotseparation);
delete(plotcapacity);   
end