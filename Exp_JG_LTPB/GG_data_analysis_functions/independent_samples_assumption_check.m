% [pC1, pL1, pF1, pC2, pL2, pF2, pC3, pL3, pF3] = independent_samples_assumption_check(data_control, data_LTPB)
%
% This function checks the normality of the data contained in each of the
% experimental blocks of the groups presented using the shapiro-wilk test.
% p-values below 0.05 indicate that the data isn't normal. The function
% also checks if the populations compared in each block have the same
% variance, using an F-test where a p value below 0.05 indicates that the
% variances are not equal. Equal variances is a requisite of some
% statistical tests.
%
% INPUT:
% data = data matrix of the control or the LTPB group
%
% OUTPUT:
%
% pC1 = the p-value statistic of the response time data of the control group in the first block.
% pC2 = the p-value statistic of the response time data of the control group in the second block.
% pC3 = the p-value statistic of the response time data of the control group in the third block.
% pL1 = the p-value statistic of the response time data of the LTPB group in the first block.
% pL2 = the p-value statistic of the response time data of the LTPB group in the second block.
% pL3 = the p-value statistic of the response time data of the LTPB group in the third block.
%
% pF1 = the p-value statistic of the F test of the first block.
% pF2 = the p-value statistic of of the F test of the second block.
% pF3 = the p-value statistic of of the F test of the third block.
%
%11/10/2022 by Pedro R. Pinheiro

function [pC1, pL1, pF1, pC2, pL2, pF2, pC3, pL3, pF3] = independent_samples_assumption_check(data_control, data_LTPB)

%control group

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7);


end

a=1;

for par = 1:(size(data_control,1)/1000) 
RT{par}=T1(a:a+999); 

a=a+1000;

end

%Block 1 - Control

RTC1 = 0; %Response Time Control
for par = 1:(size(data_control,1)/1000)
    for k = drange(1:334) %number os trials in the block

        RTC1 = RTC1 + RT{par}(k); %RTC1 -> Response times of each control group participant in block 1
    end

    MRTC1(par) = RTC1/334;  %Mean Response Time Control 1 (MRTC1) is a vector with mean response time of each participant of the control group for block 1.
    RTC1=0;

end

%%Block 2 - Control

RTC2 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(335:668)

        RTC2 = RTC2 + RT{par}(k); 
    end

    MRTC2(par) = RTC2/334;  
    RTC2=0;
end

%Block 3 - Control

RTC3 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(669:1000)

        RTC3 = RTC3 + RT{par}(k); 
    end

    MRTC3(par) = RTC3/332;  
    RTC3=0;
end

%LTPB group

for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);
end     
a=1;

for par = 1:(size(data_LTPB,1)/1000) 
RT{par}=T2(a:a+999); 


a=a+1000;

end

%Block 1 - LTPB

RTL1 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(1:334) 

        RTL1 = RTL1 + RT{par}(k); 
    end
    MRTL1(par) = RTL1/334;  
    RTL1=0;

end

%Block 2 - LTPB

RTL2 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(335:668) 

        RTL2 = RTL2 + RT{par}(k); 
    end

    MRTL2(par) = RTL2/334;  
    RTL2=0;
end

%Block 3 - LTPB

RTL3 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(669:1000)

        RTL3 = RTL3 + RT{par}(k); 
    end

    MRTL3(par) = RTL3/332;  
    RTL3=0;
end

% Checking normality of the data samples

[~,~,pC1] = swtest_norm(MRTC1.'); %Shapiro-Wilk test.
[~,~,pC2] = swtest_norm(MRTC2.');
[~,~,pC3] = swtest_norm(MRTC3.');
[~,~,pL1] = swtest_norm(MRTL1.'); %Shapiro-Wilk test.
[~,~,pL2] = swtest_norm(MRTL2.');
[~,~,pL3] = swtest_norm(MRTL3.');

% Check if the variances are equal between each distribuction

[~, pF1] = vartest2 (MRTC1, MRTL1);
[~, pF2] = vartest2 (MRTC2, MRTL2);
[~, pF3] = vartest2 (MRTC3, MRTL3);

end