% Control group


for i = 1:size(data_control,1)

    T1(i)= data_control(i,7);


end

a=1;

for par = 1:(size(data_control,1)/1000) 
RT1{par}=T1(a:a+999); 

a=a+1000;

end

for pos = 1:size(data_control,1)

    p1(pos)= data_control(pos,9);

end

b=1;

for par = 1:(size(data_control,1)/1000) 
P1{par}=p1(b:b+999); 

b=b+1000;

end

figure
alphal = 3;
[tau_est] = tauest_RT(3, RT1{5}, P1{5}, 1);

% LTPB group


for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);


end

a=1;

for par = 1:(size(data_LTPB,1)/1000) 
RT2{par}=T2(a:a+999); 

a=a+1000;

end

for pos = 1:size(data_LTPB,1)

    p2(pos)= data_LTPB(pos,9);

end

b=1;

for par = 1:(size(data_LTPB,1)/1000) 
    
P2{par}=p2(b:b+999); 

b=b+1000;

end

figure
alphal = 3;
[tau_est] = tauest_RT(alphal, RT2{6}, P2{6}, 1);

