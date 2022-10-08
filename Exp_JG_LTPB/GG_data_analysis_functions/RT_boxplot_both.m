% function RT_boxplot_both(data_control, data_LTPB)
%
% This function calculates the mean reaction times of each participant of
% each group in each experimental block and plots the data in a boxplot,
% allowing for comparations between the behavior of each group as the
% experiment progresses.
%
% INPUT:
% data_control = data matrix of the control group
%
% data_LTPB = data matrix of the LTPB group.
%
%08/10/2022 by Pedro R. Pinheiro


function RT_boxplot_both(data_control, data_LTPB)

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

RTC1 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(1:334) %number os trials in the block

        RTC1 = RTC1 + RT{par}(k); %RTC1 -> Acurácia do grupo controle no bloco 1. É a soma dos termos contidos no intervalo k para RT{par}
    end

    MRTC1(par) = RTC1/334;  %MRTC1 é um vetor em que cada termo corresponde a média de acurácia de um participante no primeiro bloco.
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

%Boxplot
MRT1=[MRTC1 MRTL1];
MRT2=[MRTC2 MRTL2];
MRT3=[MRTC3 MRTL3];
MRTF = [MRT1 MRT1 MRT3]; %arrange the data in a single vector so the boxplot function can work.

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n),2*ones(1,control_n),3*ones(1,LTPB_n),4*ones(1,control_n),5*ones(1,LTPB_n)]; %grouping variable. 


BRTF = boxplot(MRTF,grp); %boxplot showing the mean response time evolution between each experimental block.

title('Distribution of the response times of each group in each block');
ylabel("Mean RTs(s/trial)");
ylim([0 2.5])
yticks([0:0.2:2.5])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - Control','1st Block - LTPB', '2nd Block - Control', '2nd Block - LTPB','3rd Block - Control', '3rd Block - LTPB'})
xline(2.5)
xline(4.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

end

