% function [p1, p2, p3] = independent_samples_norm_check(data)
%
% This function checks the normality of the data contained in each of the
% experimental blocks of the group presented using the shapiro-wilk test.
% p-values below 0.05 indicate that the data isn't normal.
%
% INPUT:
% data = data matrix of the control or the LTPB group
%
% OUTPUT:
%
% p1 = the p-value statistic of the response time data of the first block.
%
% p2 = the p-value statistic of the response time data of the second block.
%
% p3 = the p-value statistic of the response time data of the third block.
%
%08/10/2022 by Pedro R. Pinheiro

function [p1, p2, p3] = independent_samples_norm_check(data)

for i = 1:size(data,1)

    T1(i)= data(i,7);


end

a=1;

for par = 1:(size(data,1)/1000) 
RT{par}=T1(a:a+999); 

a=a+1000;

end

%Block 1 - Control

RT1 = 0; %Response Time Control
for par = 1:(size(data,1)/1000)
    for k = drange(1:334) %number os trials in the block

        RT1 = RT1 + RT{par}(k); %RT1 -> Response times of each group participant in block 1
    end

    MRT1(par) = RT1/334;  %Mean Response Time 1 (MRT1) is a vector with mean response time of each participant of the group for block 1.
    RT1=0;

end

%%Block 2 - Control

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

[~,~,p1] = swtest_norm(MRT1.'); %Shapiro-Wilk test.
[~,~,p2] = swtest_norm(MRT2.');
[~,~,p3] = swtest_norm(MRT3.');

end