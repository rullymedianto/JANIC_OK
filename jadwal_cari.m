% N = randi([1 2]);
%sa = zeros(1,N);
time=1000;
N= 1;%randi([1]);
k=randi([1 2]);    

for iii=1:N
    k=k+(60*(randi([1 2])));
    sa(1,iii)=k
    if k>time
        return
    end
    
end

