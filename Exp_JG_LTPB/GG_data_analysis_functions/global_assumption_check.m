% [pGC,pGL, pFG] = global_assumption_check(data_control, data_LTPB)
%
% This function checks the normality of the data contained in each of the
% groups global response time data using the shapiro-wilk test.
% p-values below 0.05 indicate that the data isn't normal. The function
% also checks if the populations of each group have the same
% variance, using an F-test where a p value below 0.05 indicates that the
% variances are not equal. Equal variances is a requisite of some
% statistical tests.
%
% INPUT:
% data_control = data matrix of the control group.
% data_LTPB = data matrix of the LTPB group.
%
% OUTPUT:
%
% pGC = the p-value statistic of the response time data of the control
% group.
% pGL = the p-value statistic of the response time data of the LTPB group.
%
% pFG = the p-value statistic of the F test.
%
%11/10/2022 by Pedro R. Pinheiro

function [pGC,pGL, pFG] = global_assumption_check(data_control, data_LTPB)

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


% Checking normality of the data samples

[~,~,pGC] = swtest_norm(GTMC.'); 
[~,~,pGL] = swtest_norm(GTML.');


% Check if the variances are equal between each distribuction

[~, pFG] = vartest2 (GTMC, GTML);

end
