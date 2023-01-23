% LTPB group

part=1;


for i = 1:size(data_LTPB,1)

    T1(i)= data_LTPB(i,7);


end

a=1;

for par = 1:(size(data_LTPB,1)/1000) 
RT1{par}=T1(a:a+999); 

a=a+1000;

end

for pos = 1:size(data_LTPB,1)

    p(pos)= data_LTPB(pos,9);

end

b=1;

for par = 1:(size(data_LTPB,1)/1000) 
P1{par}=p(b:b+999); 

b=b+1000;

end

figure
alphal = 3;
[tau_est] = tauest_RT(alphal, RT1{4}, P1{4}, 1);

