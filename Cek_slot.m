[contr1, contr2, contr3, contr4, contr5] = cellfun(@Cek_slot_func,APPTW);

vector_contr = [contr1', contr2',contr3', contr4', contr5'];

array_contr1 = vector_contr(:,1);
array_contr2 = vector_contr(:,2);
array_contr3 = vector_contr(:,3);
array_contr4 = vector_contr(:,4);
array_contr5 = vector_contr(:,5);



x1 =linspace(1,time+1,time+1);
% x2 =linspace(1,time,time);
Slot = slot(1,:);


f1= figure; 
% f2 = figure;

figure(f1);
plot(x1',Slot,'r', x1',array_contr1,'b',x1',array_contr2,'c',x1',array_contr3,'g', x1',array_contr4,'y', x1',array_contr5,'g')
% plot(x1',array_contr4,'y')

xlim([0 t])
ylim([0 5])
xlabel('time')
ylabel('Slot Controller')
title("Slot Controller")  
