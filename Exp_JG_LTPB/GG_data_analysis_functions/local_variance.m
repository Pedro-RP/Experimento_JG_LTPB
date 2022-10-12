

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7);

end

a=1;

for par = 1:(size(data_control,1)/1000) 
RT1{par}=T1(a:a+999); 

a=a+1000;

end

% Control - Block 1

Lv_sc1 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 1 : 333  % i goes from 1 to n-1
        Lv_sc1 = Lv_sc1 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv1(par) = (3/333) * Lv_sc1;
    Lv_sc1 = 0;
end

% Control - Block 2

Lv_sc2 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 335 : 667  % i goes from 1 to n-1
        Lv_sc2 = Lv_sc2 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv2(par) = (3/333) * Lv_sc2;
    Lv_sc2 = 0;
end

% Control - Block 3

Lv_sc3 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 669 : 999  % i goes from 1 to n-1
        Lv_sc3 = Lv_sc3 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv3(par) = (3/331) * Lv_sc3;
    Lv_sc3 = 0;
end

% Control - Block 1

Lv_sc1 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 1 : 333  % i goes from 1 to n-1
        Lv_sc1 = Lv_sc1 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv_C1(par) = (3/333) * Lv_sc1;
    Lv_sc1 = 0;
end

% Control - Block 2

Lv_sc2 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 335 : 667  % i goes from 1 to n-1
        Lv_sc2 = Lv_sc2 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv_C2(par) = (3/333) * Lv_sc2;
    Lv_sc2 = 0;
end

% Control - Block 3

Lv_sc3 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 669 : 999  % i goes from 1 to n-1
        Lv_sc3 = Lv_sc3 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv_C3(par) = (3/331) * Lv_sc3;
    Lv_sc3 = 0;
end

% Control - Block 1

Lv_sc1 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 1 : 333  % i goes from 1 to n-1
        Lv_sc1 = Lv_sc1 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv1(par) = (3/333) * Lv_sc1;
    Lv_sc1 = 0;
end

% Control - Block 2

Lv_sc2 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 335 : 667  % i goes from 1 to n-1
        Lv_sc2 = Lv_sc2 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv2(par) = (3/333) * Lv_sc2;
    Lv_sc2 = 0;
end

% Control - Block 3

Lv_sc3 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 669 : 999  % i goes from 1 to n-1
        Lv_sc3 = Lv_sc3 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv3(par) = (3/331) * Lv_sc3;
    Lv_sc3 = 0;
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

% LTPB - Block 1

Lv_sL1 = 0;

for par = 1:(size(data_LTPB,1)/1000)
    for i = 1 : 333  % i goes from 1 to n-1
        Lv_sL1 = Lv_sL1 + (((RT2{par}(i) - RT2{par}(i+1))/(RT2{par}(i) + RT2{par}(i+1))).^2);
    end
    Lv_L1(par) = (3/333) * Lv_sL1;
    Lv_sL1 = 0;
end

% LTPB - Block 2

Lv_sL2 = 0;

for par = 1:(size(data_LTPB,1)/1000)
    for i = 335 : 667  % i goes from 1 to n-1
        Lv_sL2 = Lv_sL2 + (((RT2{par}(i) - RT2{par}(i+1))/(RT2{par}(i) + RT2{par}(i+1))).^2);
    end
    Lv_L2(par) = (3/333) * Lv_sL2;
    Lv_sL2 = 0;
end

% Control - Block 3

Lv_sL3 = 0;

for par = 1:(size(data_LTPB,1)/1000)
    for i = 669 : 999  % i goes from 1 to n-1
        Lv_sL3 = Lv_sL3 + (((RT2{par}(i) - RT2{par}(i+1))/(RT2{par}(i) + RT2{par}(i+1))).^2);
    end
    Lv_L3(par) = (3/331) * Lv_sL3;
    Lv_sL3 = 0;
end

%Boxplot
Lv1=[Lv_C1 Lv_L1]; %Mean response times block 1
Lv2=[Lv_C2 Lv_L2];
Lv3=[Lv_C3 Lv_L3];
Lvf = [Lv1 Lv2 Lv3]; %Mean Response Times Full -> arrange the data in a single vector so the boxplot function can work.

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n),2*ones(1,control_n),3*ones(1,LTPB_n),4*ones(1,control_n),5*ones(1,LTPB_n)]; %grouping variable. 


BLvf = boxplot(Lvf,grp); % Boxplot Response Times Full is a boxplot showing the mean response time evolution between each experimental block.

title('Distribution of the Local Variance of each group in each block');
ylabel("Local Variance");
ylim([0 2])
yticks([0:0.2:2])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - Control','1st Block - LTPB', '2nd Block - Control', '2nd Block - LTPB','3rd Block - Control', '3rd Block - LTPB'})
xline(2.5)
xline(4.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14



% Checking normality of the data samples

[~,~,pLv_C1] = swtest_norm(Lv_C1.'); %Shapiro-Wilk test.
[~,~,pLv_C2] = swtest_norm(Lv_C2.');
[~,~,pLv_C3] = swtest_norm(Lv_C3.');
[~,~,pLv_L1] = swtest_norm(Lv_L1.'); %Shapiro-Wilk test.
[~,~,pLv_L2] = swtest_norm(Lv_L2.');
[~,~,pLv_L3] = swtest_norm(Lv_L3.');

% Check if the variances are equal between each distribuction

[~, pF1] = vartest2 (Lv_C1, Lv_L1);
[~, pF2] = vartest2 (Lv_C2, Lv_L2);
[~, pF3] = vartest2 (Lv_C3, Lv_L3);

%statiscal comparassion

[~, pb1] = ttest2 (Lv_C1, Lv_L1); % doing the 2-sample t-test for each block.
[~, pb2] = ttest2 (Lv_C2, Lv_L2);
[~, pb3] = ttest2 (Lv_C3, Lv_L3);

% calculating the relative effect size by relative mean difference 

MLv_C1 = mean (Lv_C1);
MLv_C2 = mean (Lv_C2);
MLv_C3 = mean (Lv_C3);
MLv_L1 = mean (Lv_L1);
MLv_L2 = mean (Lv_L2);
MLv_L3 = mean (Lv_L3);

e1 = (MLv_C1 * 100)/MLv_L1;
e2 = (MLv_C2 * 100)/MLv_L2;
e3 = (MLv_C3 * 100)/MLv_L3;

% Calculating Hedge's g effect size values

 mes1 = mes(Lv_C1.',Lv_L1.','hedgesg');
 mes2 = mes(Lv_C2.',Lv_L2.','hedgesg');
 mes3 = mes(Lv_C3.',Lv_L3.','hedgesg');

hg1 = mes1.hedgesg;
hg2 = mes2.hedgesg;
hg3 = mes3.hedgesg;