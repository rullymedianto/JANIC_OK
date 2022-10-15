[h1, h2, h3, h4, h5] = cellfun(@plot_h,Sim1);
%vector_climbArray1 =movmedian(vector_climbArray1,5);
%plot(t,v1,'r',t,v2,'y',t,v3,'m',t,v4,'c',t,v5,'b');
ts1 = timeseries((h1)');
ts2 = timeseries((h2)');
ts3 = timeseries((h3)');
ts4 = timeseries((h4)');
ts5 = timeseries((h5)');


figure (1)
plot(ts1,'r');
hold on
plot(ts2,'b');
hold on
plot(ts3,'y');
hold on
plot(ts4,'c');
hold on
plot(ts5,'g');

        %legend('12NM','15NM')   
        xlim([0 t])
        ylim([0 30000])
        xlabel('time')
        ylabel('Velocity')
        title("Velocity")