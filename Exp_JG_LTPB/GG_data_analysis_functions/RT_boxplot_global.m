% RT_boxplot_global(data_control, data_LTPB)
%
% This function calculates the mean reaction times of each participant of
% each group considering the whole experiment and plots the data in a boxplot,
% allowing for comparations between the overall behavior of each group.
%
% INPUT:
% data_control = data matrix of the control group
%
% data_LTPB = data matrix of the LTPB group.
%
%08/10/2022 by Pedro R. Pinheiro


function RT_boxplot_global(data_control, data_LTPB)
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

for par = 1:(size(data_control,1)/1000)
     GTMC(par) = mean(RT1{par}); %global temporal means control
end



for par = 1:(size(data_LTPB,1)/1000)
     GTML(par) = mean(RT2{par}); %global temporal means LTPB
end

RTG = [GTMC GTML];

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n)];


BRTG = boxplot(RTG,grp); 

title('Distribution of the response times of each group considering the whole experiment');
ylabel("Mean RT(s)");
ylim([0 2.5])
yticks([0:0.2:2.5])
xticks([1 2 3 4 5 6])
xticklabels({'Control','LTPB'})
xline(2.5)
xline(4.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

end




