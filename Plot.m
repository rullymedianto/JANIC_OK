close all
%load('Result1.mat')
t = time;
hold on
% scatter3(Sim{1,1}(2,:),Sim{1,1}(3,:),Sim{1,1}(4,:))
xlabel('x');
ylabel('y');
zlabel('z');
% axis equal
hold on;

%figureFullScreen('Name','Full screen figure size');
%for i = 1:2:t
 
        %% Subplot

% figure ('Figure 1','Aircraft Movement')
%  subplot(2,1,1);
%         title("3D Graph (t = " + i + ")")
%         plotwaypoint3 = scatter3(NavData(:,1),NavData(:,2),NavData(:,3),'b');
%         Graph = scatter3(Sim1{1,i}(2,:), Sim1{1,i}(3,:),Sim1{1,i}(4,:),20,Conflict_2{1,i}(:,:),'filled');
%         
%         aa = round(Sim1{1,i}(19,:))'; 
%             bb = num2str(aa); cc = cellstr(bb);
%        
%             %dd = 'leftarrow'
%             dx1 = 0.1; dy1 = 0.1; % displacement so the text does not overlay the data points
%             %dx2 = 5; dy2 = 1;
% 
%         %if aa < 100
%             txt1 = text(Sim1{1,i}(2,:)+dx1, Sim1{1,i}(3,:)+dy1,Sim1{1,i}(4,:),cc,'color','red','FontSize',7);
%             %txt1a = text(NavData(:,1)+dx1,NavData(:,2)+dy1,NavData(:,3),label,'color','green','FontSize',7);
%             text1a = text(NavData(:,1),NavData(:,2),NavData(:,3),label,'FontSize',7,'HorizontalAlignment','right');
%         xlim([-150000 200000])
%         ylim([-100000 80000])
%         zlim([0 10000])
%         hold on
        
% subplot(2,1,2);
          %title("2D Graph (t = " + i + ")")
%           plotwaypoint2 = scatter(NavData(:,1),NavData(:,2),5,'filled','b'); %All WP
%           txt2a = text(NavData(:,1),NavData(:,2),label,'FontSize',5,'HorizontalAlignment','right');
%          
          plotwaypoint2 = scatter(NavData(1:19,1),NavData(1:19,2),5,'filled','b'); %Arr WP
          txt2a = text(NavData(1:19,1),NavData(1:19,2),label(1:19,1),'FontSize',5,'HorizontalAlignment','right');
          
         
%           plotwaypoint2 = scatter(NavData(35:82,1),NavData(35:82,2),5,'filled','b'); %Dep WP
%           txt2a = text(NavData(35:82,1),NavData(35:82,2),label(35:82,1),'FontSize',5,'HorizontalAlignment','right');
%           
         
          for i = 1:2:t
          
              title("2D Graph (t = " + i + ")");
        
              if Sim1{1,i}(4,:) > 75       
            simulationplot2 = scatter(Sim1{1,i}(2,:), Sim1{1,i}(3,:),20,Conflict_2{1,i}(:,:),'filled');
%           simulationplot2 = scatter(Sim1{1,i}(2,:), Sim1{1,i}(3,:),20,'filled');
%              aa = round(mps2kt(Sim1{1,i}(19,:)')); 
             aa = round(Sim1{1,i}(10,:)');
             bb = num2str(aa); cc = cellstr(bb);
        
            % aa1 = round(mtr2ft(Sim1{1,i}(4,:)')); 
              aa1 = round(Sim1{1,i}(4,:)'); 
             bb1 = num2str(aa1); cc1 = cellstr(bb1);
             
             aa2 = Sim1{1,i}(19,:)'; 
             bb2 = num2str(aa2); cc2 = cellstr(bb2);
             
             %dd = 'leftarrow'
             dx1 = 1000; dy1 = 2000; % displacement so the text does not overlay the data points
             dx2 = 2000; dy2 = -1500;
             dx3 = 500; dy3 = 1500;

        %if aa < 100
            txt2 = text(Sim1{1,i}(2,:)+dx1, Sim1{1,i}(3,:)+dy1, cc,'color','red','FontSize',7);
            txt2a = text(Sim1{1,i}(2,:)+dx2, Sim1{1,i}(3,:)+dy2, cc1,'color','red','FontSize',7);
            %txt2b = text(Sim1{1,i}(2,:)+dx3, Sim1{1,i}(3,:)+dy3, cc2,'color','blue','FontSize',7);
            %txt2a = text(NavData(:,1)+dx1,NavData(:,2)+dy1,label,'color','green','FontSize',7);
            
          %       for j = 1:airplane
%             XY{1,j}(1,i) = Sim{1,i}(2,j);
%             XY{1,j}(2,i) = Sim{1,i}(3,j);
%         plot(XY{1,j}(1,:),XY{1,j}(2,:),'r');       
        xlim([-150000 200000]);

        


hold on
        xlabel('x (meter)');
        ylabel('y (meter)');
%     %% Delete
%         delete(simulationplot2);
%         delete(plotwaypoint2);
%         delete(Graph)
%         delete(plotwaypoint3);    
%         %delete(trackplot)
%        % Pause
%         pause(0.05);
        
%  figure ('Name','Separation and Aircraft') ;       
%  subplot(2,1,1); 
%          title("Separation Minimum")
%          plotseparation = plot([1:i],Separation_Minimum(1,[1:i]),'r');
%          xlim([0 2000])
%          ylim ([0 30000])
%          xlabel('x (time)')
%          ylabel('y (meter)')
%         hold on
% subplot(2,1,2)
%         title("Capacity Maximum")
%         plotcapacity = plot([1:i],CapacityArray{1,1}(1,[1:i]),'r');
%         xlim([0 3600])
%         ylim([0 50])
%         xlabel('x (time')
%         ylabel('y (Airplane)')
%         hold on
% Pause
        pause(0.05);
        %% Delete
        delete(simulationplot2);
        %delete(plotwaypoint2);
        %delete(Graph)
        %delete(plotwaypoint3);    
        %delete(trackplot)
        %delete (txt1);
        delete (txt2);
        delete (txt2a);
%         delete (txt2b);
%         delete(plotseparation);
%         delete(plotcapacity);
% R= nm(75);
% gambar_lingkaran_75=circleplot(-29127.2,-71619.2,R);
% R1= nm(10);
% gambar_lingkaran_10=circleplot(-29127.2,-71619.2,R1);
% 
% scatter(-76291.1000000000, 23571.4000000000);
              end
          end
         
