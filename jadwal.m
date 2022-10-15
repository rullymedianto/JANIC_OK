function[sa]=jadwal(time)
% N = randi([1 2]);
%sa = zeros(1,N);
% N=randi([1 2]);
N=8;
k=randi([1 2]);    

for iii=1:N
    k=k+(20*(randi([2 6])));
    sa(1,iii)=k;
    if k>time
        return
    end
    
end
end

