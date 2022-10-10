% function [p1_2, p1_3, p2_3] = paired_samples_norm_check(data)
%
% This function checks the normality of the data contained in each of the
% experimental blocks comparasions of the group presented using the shapiro-wilk test.
% p-values below 0.05 indicate that the data isn't normal.
%
% INPUT:
% data = data matrix of the control or the LTPB group
%
% OUTPUT:
%
% p1_2 = the p-value statistic of the response time data of the comparasion
% between blocks 1 and 2.
%
% p1_3 = the p-value statistic of the response time data of of the comparasion
% between blocks 1 and 3.
%
% p2_3 = the p-value statistic of the response time data of the comparasion
% between blocks 2 and 3.
%
%08/10/2022 by Pedro R. Pinheiro

function [p1_2, p1_3, p2_3] = paired_samples_norm_check(data)


for i = 1:size(data,1)

    T1(i)= data(i,7);


end

a=1;

for par = 1:(size(data,1)/1000) 
RT{par}=T1(a:a+999); 

a=a+1000;

end

%Block 1

RT1 = 0; %Response Time 
for par = 1:(size(data,1)/1000)
    for k = drange(1:334) %number os trials in the block

        RT1 = RT1 + RT{par}(k); %RT1 -> Response times of each control group participant in block 1
    end

    MRT1(par) = RT1/334;  %Mean Response Time 1 (MRT1) is a vector with mean response time of each participant of the group for block 1.
    RT1=0;

end

%%Block 2 

RT2 = 0;
for par = 1:(size(data,1)/1000)
    for k = drange(335:668)

        RT2 = RT2 + RT{par}(k); 
    end

    MRT2(par) = RT2/334;  
    RT2=0;
end

%Block 3 

RT3 = 0;
for par = 1:(size(data,1)/1000)
    for k = drange(669:1000)

        RT3 = RT3 + RT{par}(k); 
    end

    MRT3(par) = RT3/332;  
    RT3=0;
end

%Checking normality for the comparasion between blocks 1 and 2

for b = 1:size (MRT1,2)
    MRT1_2(b) = MRT1(b) - MRT2(b);
end

%Checking normality for the comparasion between blocks 1 and 3

for b = 1:size (MRT1,2)
    MRT1_3(b) = MRT1(b) - MRT3(b);
end

%Checking normality for the comparasion between blocks 2 and 3

for b = 1:size (MRT1,2)
    MRT2_3(b) = MRT2(b) - MRT3(b);
end

[~,~,p1_2] = swtest_norm(MRT1_2.');

[~,~,p1_3] = swtest_norm(MRT1_3.');

[~,~,p2_3] = swtest_norm(MRT2_3.');
end