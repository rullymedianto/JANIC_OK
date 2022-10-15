
%% Number of Aircraft in Sector, Nin %%
[acs1, acs2, acs3, acs4, acs5, acs6] = cellfun(@vector_acinsector1,Sim1);
vector_acinsectorArray1 = [acs1' acs2' acs3' acs4' acs5' acs6'];
%vector_acinsectorArray1 = movmedian(vector_acinsectorArray1,5);
Nin = vector_acinsectorArray1;

max_workload1 = max(WL1);
min_workload1 = min(WL1);
average_workload1 = mean(WL1);
max_aircraftinsector1 = max(Nin(:,1));
mean_aircraftinsector1 = mean(Nin(:,1));

% Workload_param1 = [max_workload1 min_workload1];

%% Number of Workload Lower Center (LC) %%
numofworkloadArray2 = Fid*Ninto(:,2) + Fra*Nin(:,2) + Finto*Ninto(:,2) + (Fcf*(Npoi(:,2) + Nseg(:,2))) + Fout*Nout(:,2);
WL2 = numofworkloadArray2;
%WL2 = movmedian(numofworkloadArray2,5);
plotnumofworkload2 = plot(WL2,'m');

max_workload2 = max(WL2);
min_workload2 = min(WL2);
average_workload2 = mean(WL2);
max_aircraftinsector2 = max(Nin(:,2));
mean_aircraftinsector2 = mean(Nin(:,2));

% Workload_param2 = [max_workload2 min_workload2];

%% Number of Workload Lower East (LE) %%
numofworkloadArray3 = Fid*Ninto(:,3) + Fra*Nin(:,3) + Finto*Ninto(:,3) + (Fcf*(Npoi(:,3) + Nseg(:,3))) + Fout*Nout(:,3);
WL3 = numofworkloadArray3;
%WL3 = movmedian(numofworkloadArray3,5);
plotnumofworkload3 = plot(WL3,'c');

max_workload3 = max(WL3);
min_workload3 = min(WL3);
average_workload3 = mean(WL3);
max_aircraftinsector3 = max(Nin(:,3));
mean_aircraftinsector3 = mean(Nin(:,3));

% Workload_param3 = [max_workload3 min_workload3];

%% Number of Workload Terminal West (TW) %%
numofworkloadArray4 = Fid*Ninto(:,4) + Fra*Nin(:,4) + Finto*Ninto(:,4) + (Fcf*(Npoi(:,4) + Nseg(:,4))) + Fout*Nout(:,4);
WL4 = numofworkloadArray4;
%WL4 = movmedian(numofworkloadArray4,5);
plotnumofworkload4 = plot(WL4,'r');

max_workload4 = max(WL4);
min_workload4 = min(WL4);
average_workload4 = mean(WL4);
max_aircraftinsector4 = max(Nin(:,4));
mean_aircraftinsector4 = mean(Nin(:,4));

% Workload_param4 = [max_workload4 min_workload4];

%% Number of Workload Terminal East (TE) %%
numofworkloadArray5 = Fid*Ninto(:,5) + Fra*Nin(:,5) + Finto*Ninto(:,5) + (Fcf*(Npoi(:,5) + Nseg(:,5))) + Fout*Nout(:,5);
WL5 = numofworkloadArray5;
%WL5 = movmedian(numofworkloadArray5,5);
plotnumofworkload5 = plot(WL5,'g');

max_workload5 = max(WL5);
min_workload5 = min(WL5);
average_workload5 = mean(WL5);
max_aircraftinsector5 = max(Nin(:,5));
mean_aircraftinsector5 = mean(Nin(:,5));

% Workload_param5 = [max_workload5 min_workload5];

%% Number of Workload Terminal South (TS) %%
numofworkloadArray6 = Fid*Ninto(:,6) + Fra*Nin(:,6) + Finto*Ninto(:,6) + (Fcf*(Npoi(:,6) + Nseg(:,6))) + Fout*Nout(:,6);
WL6 = numofworkloadArray6;
%WL6 = movmedian(numofworkloadArray6,5);
plotnumofworkload6 = plot(WL6,'b');

max_workload6 = max(WL6);
min_workload6 = min(WL6);
average_workload6 = mean(WL6);
max_aircraftinsector6 = max(Nin(:,6));
mean_aircraftinsector6 = mean(Nin(:,6));

% Workload_param6 = [max_workload6 min_workload6];

%% Number of Workload Arrival North (AN) %%
numofworkloadArray7 = Fid*Ninto(:,7) + Fra*Nin(:,7) + Finto*Ninto(:,7) + (Fcf*(Npoi(:,7) + Nseg(:,7))) + Fout*Nout(:,7);
WL7 = numofworkloadArray7;
%WL7 = movmedian(numofworkloadArray7,5);
plotnumofworkload7 = plot(WL7,'w');

max_workload7 = max(WL7);
min_workload7 = min(WL7);
average_workload7 = mean(WL7);
max_aircraftinsector7 = max(Nin(:,7));
mean_aircraftinsector7 = mean(Nin(:,7));

% Workload_param7 = [max_workload7 min_workload7];

%% Number of Workload Arrival East (AE) %%
numofworkloadArray8 = Fid*Ninto(:,8) + Fra*Nin(:,8) + Finto*Ninto(:,8) + (Fcf*(Npoi(:,8) + Nseg(:,8))) + Fout*Nout(:,8);
WL8 = numofworkloadArray8;
%WL8 = movmedian(numofworkloadArray8,5);
plotnumofworkload8 = plot(WL8,'k');

max_workload8 = max(WL8);
min_workload8 = min(WL8);
average_workload8 = mean(WL8);
max_aircraftinsector8 = max(Nin(:,8));
mean_aircraftinsector8 = mean(Nin(:,8));

% Workload_param8 = [max_workload8 min_workload8];

%%
WLTOT = [WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8];

plot(WL1,'y')
xlim([0 t])
ylim([0 10])
xlabel('Time')
ylabel('Workload')
title('Air Traffic Controller Workload')

hold on
plot(WL2,'m')
plot(WL3,'c')
plot(WL4,'r')
plot(WL5,'g')
plot(WL6,'b')
plot(WL7,'w')
plot(WL8,'k')

hold off
timeElapsed_Vector_Workload = toc;

save('Workload_.mat','WLTOT')