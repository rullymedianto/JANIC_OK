tic

numb=12;
parfor_progress(numb);

parfor i=1:numb 

[outArray1(i),outArray2(i),outArray3(i),outArray4(i),outArray5(i),outArray6(i),outArray7(i),outArray8(i),outArray9(i),outArray10(i), ya1(i), ya2(i), ya3(i), ya4(i),ya5(i)] = Gabungan_JAJAR_A();
parfor_progress;



end

parfor_progress(0);
hasil = [outArray1',outArray2',outArray3',outArray4',outArray5',outArray6',outArray7',outArray8',outArray9',outArray10',ya1', ya2', ya3', ya4',ya5'];
korelasi = outArray10;
% input= [ya1 ya2 ya3 ya4];


writematrix(hasil,'Hasil_Janic_Jajar_05-15_SPD_4in_0,5_ 3600s_12bb.csv')
writematrix(korelasi,'Korelasi_Janic_Jajar_05-15_SPD_4in_0,5_3600s_12bb.csv')
% writematrix(input,'Input_5-10_5_3600s_5.csv')

timeElapsed_Simulation_schedule = toc
waktu_end = datetime('now')