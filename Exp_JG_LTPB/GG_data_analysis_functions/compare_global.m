% [pG, eG, hgG] = compare_global(data_control, data_LTPB)
%
% This function compares the distribuction of the response times of both
% groups in the whole game using the two-sample t-test statistical method. As
% output, it returns not only the p-value of the comparasion, but also the
% relative effect size (using the relative mean difference method) and the
% hedge's g value.
%
% INPUT:
%
% data_control = data matrix of the control group.
%
% data_LTPB = data matrix of the LTPB group.
%
% OUTPUT:
%
% pb1 = the p-value of the global comparasion.
%
% hgG = hedge's g effect value for the comparasion.
%
% eG = the relative effect size of the comparasion.
%
%10/10/2022 by Pedro R. Pinheiro

function [pG, eG, hgG] = compare_global(data_control, data_LTPB)
%control group

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7);

end

a=1;

for par = 1:(size(data_control,1)/1000) 
RT1{par}=T1(a:a+999); 

a=a+1000;

end

%LTPB group

for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);
end     
a=1;

for par = 1:(size(data_LTPB,1)/1000) 
RT2{par}=T2(a:a+999); 


a=a+1000;

end

o = 1;
for par = 1:(size(data_control,1)/1000)
     GTMC(par) = mean(RT1{par}); %global temporal means control
     o = o + 1000;
end



v = 1;
for par = 1:(size(data_LTPB,1)/1000)
     GTML(par) = mean(RT2{par}); %global temporal means LTPB
     v = o + 1000;
end


%statiscal comparassion

[~, pG] = ttest2 (GTMC, GTML); % doing the 2-sample t-test.

% calculating the relative effect size by relative mean difference 

MGTMC = mean (GTMC);
MGTML = mean (GTML);


eG = (MGTML * 100)/MGTMC;

% Calculating Hedge's g effect size values

mes1 = mes(GTML.',GTMC.','hedgesg');

hgG = mes1.hedgesg;
end