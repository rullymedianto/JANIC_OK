
%% Number of Aircraft in Sector, Nin %%
[acs1] = cellfun(@vector_comunication1,COMCTR);
Nin = acs1';

%% Number of Workload Lower Center (LC) %%

workload1 = Nin(:,1);
max_workload1 = max(Nin(:,1));
min_workload1 = min(Nin(:,1));
average_workload1 = mean(Nin(:,1));

%%
% WLTOT = [max_workload1];

% plot(WL1,'y')
xlim([0 t])
ylim([0 3])
xlabel('Time')
ylabel('Workload')
title('Air Traffic Controller Workload')

hold on
plot(workload1,'b')

A = (nnz(workload1)/time)*100; 


wrkld = A

hold off
% timeElapsed_Vector_Workload = toc;
% 
% save('Workload_.mat','WLTOT')