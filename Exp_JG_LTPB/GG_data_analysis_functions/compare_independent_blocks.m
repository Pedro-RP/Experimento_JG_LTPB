% [pb1, pb2, pb3, cd1, cd2, cd3, e1, e2, e3 ] = compare_independent_blocks(data_control, data_LTPB)
%
% This function compares the distribuction of the response times of both
% groups in every block using the two-sample t-test statistical method. As
% output, it returns not only the p-value of each comparasion, but also the
% relative effect size that the LTPB group has compared to the control
% group using the relative mean difference method.
%
% INPUT:
%
% data_control = data matrix of the control group.
%
% data_LTPB = data matrix of the LTPB group.
%
% OUTPUT:
%
% pb1 = the p-value of the comparasion of block 1.
% pb2 = the p-value of the comparasion of block 2.
% pb3 = the p-value of the comparasion of block 3.
%
% hg1 = hedge's g effect value for the comparasion for block 1.
% hg2 = hedge's g effect value for the comparasion for block 2.
% hg3 = hedge's g effect value for the comparasion for block 3.
%
% e1 = the relative effect size of the comparasion of block 1.
% e2 = the relative effect size of the comparasion of block 2.
% e3 = the relative effect size of the comparasion of block 3.
%
%08/10/2022 by Pedro R. Pinheiro

function [pb1, pb2, pb3, hg1, hg2, hg3, e1, e2, e3 ] = compare_independent_blocks(data_control, data_LTPB)

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

%statiscal comparassion

[~, pb1] = ttest2 (MRTC1, MRTL1); % doing the 2-sample t-test for each block.
[~, pb2] = ttest2 (MRTC2, MRTL2);
[~, pb3] = ttest2 (MRTC3, MRTL3);

% calculating the relative effect size by relative mean difference 

MMRTC1 = mean (MRTC1);
MMRTC2 = mean (MRTC2);
MMRTC3 = mean (MRTC3);
MMRTL1 = mean (MRTL1);
MMRTL2 = mean (MRTL2);
MMRTL3 = mean (MRTL3);

e1 = (MMRTL1 * 100)/MMRTC1;
e2 = (MMRTL2 * 100)/MMRTC2;
e3 = (MMRTL3 * 100)/MMRTC3;

% Calculating Hedge's g effect size values

 mes1 = mes(MRTL1.',MRTC1.','hedgesg');
 mes2 = mes(MRTL2.',MRTC2.','hedgesg');
 mes3 = mes(MRTL3.',MRTC3.','hedgesg');

hg1 = mes1.hedgesg;
hg2 = mes2.hedgesg;
hg3 = mes3.hedgesg;

end
