hold = cellfun(@plot_holding,Holding_status);

ts1 = timeseries((hold)');

figure (1)
plot(ts1,'r');

        %legend('12NM','15NM')   
        xlim([0 t])
        ylim([0 5])
        xlabel('time')
        ylabel('Holding')
        title("Number of Holding")