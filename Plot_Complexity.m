
%% Plot Complexity
 yl=2;
 
subplot (4,2,1)
plot(complex(1,:)/th_acin,'b')
xlim([0 t]);
ylim([0 yl]);
yline(1,'r');
title('Aircraft in Sector')

subplot (4,2,2)
plot(complex(2,:)/th_actp,'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
title('Aircraft Type Mix')


subplot (4,2,3)
plot(complex(3,:)/th_spd,'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
title('Aircraft Speed Variance')

subplot (4,2,4)
plot(complex(4,:)/th_des,'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
title('Aircraft Descent')

subplot (4,2,5)
plot(complex(5,:)/th_clm,'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
title('Aircraft Climb')


subplot (4,2,6)
plot(complex(6,:)/th_con,'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
title('Number of Conflict')

subplot (4,2,7)
plot(complex(7,:)/th_com,'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
% title('Communication Duration')
title('Communication Frequency')

subplot (4,2,8)
plot(complex(8,:),'b')
xlim([0 t])
ylim([0 yl])
yline(1,'r');
title('Complexity')


% timeElapsed_Vector_Workload = toc;
% 
% save('Workload_.mat','WLTOT')