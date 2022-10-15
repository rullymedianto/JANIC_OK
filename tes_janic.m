tic
%clear all
numb=10;

% fprintf('Progress:\n');
% fprintf(['\n' repmat('.',1,numb) '\n\n']);
parfor_progress(numb);

parfor i=1:numb 

[outArray1(i),outArray2(i),outArray3(i),outArray4(i),outArray5(i),outArray6(i),outArray7(i)] = Gabungan_A();

% fprintf('\b|\n');
parfor_progress;
end

parfor_progress(0);
hasil = [outArray1',outArray2',outArray3',outArray4',outArray5',outArray6'];
korelasi = outArray7;

writematrix(hasil,'Hasil_Janic_JAJAR_6-2_10-20-10.csv')
writematrix(korelasi,'Korelasi_Janic_JAJAR_6-2_10-20-10.csv')

toc