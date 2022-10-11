%RT_boxplot_global


%function RT_boxplot_both(data_control, data_LTPB)

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

%Boxplot

Media_temporal_global_C = (MRTC1 + MRTC2 + MRTC3)/3;
Media_temporal_global_L = (MRTL1 + MRTL2 + MRTL3)/3;

RTG = [Media_temporal_global_C Media_temporal_global_L];

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n)];


BRTG = boxplot(RTG,grp); % Boxplot Response Times Full is a boxplot showing the mean response time evolution between each experimental block.

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

%end




