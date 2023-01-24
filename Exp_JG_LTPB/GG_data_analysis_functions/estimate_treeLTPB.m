function 

alphal = 3;


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

nrowsC = ceil(((size(data_control,1)/1000)/3));

figure

for par = 1:(size(data_control,1)/1000) 

subplot(nrowsC,3, par)
[tau_est1] = tauest_RT(alphal, RT1{par}, P1{par}, 1);

title(append('C ', num2str(par)));

tau_estC{par} = tau_est1;

end

suptitle('Context Trees of the Control Group')

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

nrowsL = ceil(((size(data_LTPB,1)/1000)/3));

figure

for par = 1:(size(data_LTPB,1)/1000) 

subplot(nrowsL,3, par)
[tau_est2] = tauest_RT(alphal, RT2{par}, P2{par}, 1);

title(append('L ', num2str(par)));

tau_estL{par} = tau_est2;

end

suptitle('Context Trees of the LTPB Group')

