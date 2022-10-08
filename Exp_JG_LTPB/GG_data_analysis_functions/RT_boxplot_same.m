% function RT_boxplot_same(data, group_name)
%
% This function calculates the mean reaction times of each participant of
% one of the experimental groups in each experimental block and plots the data in a boxplot,
% allowing for comparations between the behavior of a single group across
% multiple blocks.
%
% INPUT:
% data = data matrix of the control or the LTPB group
%
%
%08/10/2022 by Pedro R. Pinheiro

group_name = 'LTPB';
data = data_LTPB

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

MRTF = [MRT1.' MRT2.' MRT3.']; %Mean Response Times Full -> arrange the data in a single vector so the boxplot function can work.
BRTF = boxplot(MRTF);

BRTF = boxplot(MRTF); % Boxplot Response Times Full is a boxplot showing the mean response time evolution between each experimental block.

title(append('Distribution of the response times of the',' ', group_name, ' group in each block'));
ylabel("Mean RTs(s/trial)");
ylim([0 2.5])
yticks([0:0.2:2.5])
xticks([1 2 3])
xticklabels({'1st Block', '2nd Block','3rd Block'})
xline(2.5)
xline(1.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

