% tic
%% Weighting factor for each parameter %%
w1 = 0.12182 ; % Weighting factor for A/C in sector
w2 = 0.10146  ; % Weighting factor for A/C type
w3 = 0.09236  ; % Weighting factor for speed ratio
w4 = 0.10778 ; % Weighting factor  for number of descending A/C
w5 = 0.08990  ; % Weighting factor for number of climbing A/C
w6 = 0.38866 ; % Weighting factor for RTF represented by potential conflict (overtaking and crossing)
w7 = 0.09802 ; % Weighting factor for frequency of ATCo's coordination and communication

%% Aircraft in Sector %%
[acs1] = cellfun(@vector_acinsector1,Sim1);

A1 = acs1;

%% Aircraft Type %%
[at1] = cellfun(@vector_aircrafttype1,Sim1);

A2 = at1;

%% Speed Ratio %%              
[sr1] = cellfun(@vector_speedratio1,Sim1);

A3 = sr1;

%% Aircraft Descent %%        
[tr1] = cellfun(@vector_descent1,Sim1);

A4 = tr1;

%% Aircraft Climb %%
[cl1]  = cellfun(@vector_climb1,Sim1);

A5 = cl1;

%% Number of Conflict %%
[noc1] = cellfun(@number_of_conflict1,Sim1);

A6 = noc1;

%% Number of Coordination in the Sector %%
[comm1] = cellfun(@vector_comunication1,COMCTR);

A7 = comm1;

%% Number of Complexity Lower East (LE)%%
numofcomplexityArray1 = w1*A1(1,:) + w2*A2(1,:) + w3*A3(1,:) + w4*A4(1,:) + w5*A5(1,:) + w6*A6(1,:)+ w7*A7(1,:);
CA1 = numofcomplexityArray1;

max_complexity1 = max(CA1);
average_complexity1 = mean(CA1);
max_aircraftinsector1 = max(A1(1,:));
mean_aircraftinsector1 = mean(A1(1,:));
max_conflictinsector1 = max(A6(1,:));
mean_conflictinsector1 = mean(A6(1,:));
workload_comm1 = find(A7(1,:));


AA1 = (nnz(comm1)/time)*100; 

CATOT = CA1 ;

% %legend('12NM','15NM')
% plot(CA1,'y')       
%  xlim([0 t])
%  ylim([0 10])
%  xlabel('Time')
%  ylabel('Complexity')
%  title('Air Traffic Complexity')  
% 
% 
% hold on
% plot(CA1,'r')
% plot(CA3,'c')
% plot(CA4,'r')
% 
% hold off
% timeElapsed_Vector_Complexity = toc;

%saveas (plotnumofcomplexity2,'Air_Traffic_Complexity.jpg');         
save('Complexity_.mat', 'CATOT') 
