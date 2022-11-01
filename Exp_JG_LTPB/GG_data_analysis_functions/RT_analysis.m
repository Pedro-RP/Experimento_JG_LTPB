% [rt] = RT_analysis(data_control, data_LTPB)
%
% This function returns a struct containing the values of the mean response times
% of each particicipant of the experiment in each block,
% the results of tests aiming to validate the assumptions of parametric tests 
% for comparasitions between groups and within the same group, the results
% of said parametric tests for comparasions betweeen groups and within
% the same group and also boxplots corresponding to said comparasions.
% 
% INPUT:
%
% data_control = data matrix from the control group.

% data_ltpb = data matrix from the LTPB group.
%
% OUTPUT:
% 
% rt = the data strucure containing the mean response time values and related
% data.
%
% - The "response_times" section contains the raw mean response time data of
% each participant divided by group and block. Each value in the row
% represents the data of one participant.
%
% - The "between_comparasion" section deals with the comparasion between
% both groups alongside each experimental blocks. In "assumption_check", it
% is possible to see the Shapiro-Wilk normality test results for the data
% contained in each block (p > 0.05 indicates normality) and also check if both populations in each of the three
% blocks have the same variance, using a F test (p > 0.05 indicates normality). In "t_test", it is
% possible to see the p-values of the 2-sample t-tests applied in each
% block. In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of the LTPB group over the 
% Control group. Figure 1 is a companion boxplot to this section.
%
% - The "within_comparasion" section deals with comparasions between the 
% response time data of different blocks of the same group. In "assumption
% check", it is possible to check the assumptions required for applying paired
% parametrical tests to the data sets, namely, normality of distribuitions
% and equal variance between pairs of blocks. In "rep_means_anova", it is
% possible to see the full table and the p-value of a repeated measures
% ANOVA applied to the data of an individual group (corrected with de GG method
% if the sphericity condition is violated). In "t_test", it is
% possible to see the p-values of the paired-sample t-tests applied in each
% pair of blocks. In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of one block over the 
% other. Figures 2 and 3 are a companion boxplot to this section.
%
% - The "global_comparasion" section deals with the comparasion between
% both groups global mean response time values (considering the whole game as a single block).
% In "assumption_check", it is possible to see the Shapiro-Wilk normality test results for the data
% contained in each group and also check if both populations have the same variance, using a F test.
% In "t_test", it is possible to see the p-values of the 2-sample t-tests applied in the comparasion. 
% In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of the Control group over the 
% LTPB group. Figure 4 is a companion boxplot to this section.
%
% 26/10/2022 by Pedro R. Pinheiro


function [rt] = RT_analysis(data_control, data_LTPB)

% Control group

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7);


end

a=1;

for par = 1:(size(data_control,1)/1000) 
RT1{par}=T1(a:a+999); 

a=a+1000;

end

%Block 1 - Control

RTC1 = 0; %Response Time Control
for par = 1:(size(data_control,1)/1000)
    for k = drange(1:334) %number os trials in the block

        RTC1 = RTC1 + RT1{par}(k); %RTC1 -> Response times of each control group participant in block 1
    end

    MRTC1(par) = RTC1/334;  %Mean Response Time Control 1 (MRTC1) is a vector with mean response time of each participant of the control group for block 1.
    RTC1=0;

end

%%Block 2 - Control

RTC2 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(335:668)

        RTC2 = RTC2 + RT1{par}(k); 
    end

    MRTC2(par) = RTC2/334;  
    RTC2=0;
end


%Block 3 - Control

RTC3 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(669:1000)

        RTC3 = RTC3 + RT1{par}(k); 
    end

    MRTC3(par) = RTC3/332;  
    RTC3=0;
end

rt.response_times.Control.block_1 = MRTC1;
rt.response_times.Control.block_2 = MRTC2;
rt.response_times.Control.block_3 = MRTC3;

%LTPB group

for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);
end     
a=1;

for par = 1:(size(data_LTPB,1)/1000) 
RT2{par}=T2(a:a+999); 


a=a+1000;

end

%Block 1 - LTPB

RTL1 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(1:334) 

        RTL1 = RTL1 + RT2{par}(k); 
    end
    MRTL1(par) = RTL1/334;  
    RTL1=0;

end

%Block 2 - LTPB

RTL2 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(335:668) 

        RTL2 = RTL2 + RT2{par}(k); 
    end

    MRTL2(par) = RTL2/334;  
    RTL2=0;
end

%Block 3 - LTPB

RTL3 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(669:1000)

        RTL3 = RTL3 + RT2{par}(k); 
    end

    MRTL3(par) = RTL3/332;  
    RTL3=0;
end


rt.response_times.LTPB.block_1 = MRTL1;
rt.response_times.LTPB.block_2 = MRTL2;
rt.response_times.LTPB.block_3 = MRTL3;

%%% Comparation between groups

%Boxplot
MRT1=[MRTC1 MRTL1]; %Mean response times block 1
MRT2=[MRTC2 MRTL2];
MRT3=[MRTC3 MRTL3];
MRTF = [MRT1 MRT2 MRT3]; %Mean Response Times Full -> arrange the data in a single vector so the boxplot function can work.

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n),2*ones(1,control_n),3*ones(1,LTPB_n),4*ones(1,control_n),5*ones(1,LTPB_n)]; %grouping variable. 

figure 

BRTF = boxplot(MRTF,grp); % Boxplot Response Times Full is a boxplot showing the mean response time evolution between each experimental block.

title('Distribution of the Mean Response Times of each group in each block');
ylabel("Mean Response Time(s)");
ylim([0 2.5])
yticks([0:0.2:2.5])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - Control','1st Block - LTPB', '2nd Block - Control', '2nd Block - LTPB','3rd Block - Control', '3rd Block - LTPB'})
xline(2.5)
xline(4.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14


% Checking normality of the data samples

[~,~,pC1] = swtest_norm(MRTC1.'); %Shapiro-Wilk test.
[~,~,pC2] = swtest_norm(MRTC2.');
[~,~,pC3] = swtest_norm(MRTC3.');
[~,~,pL1] = swtest_norm(MRTL1.'); %Shapiro-Wilk test.
[~,~,pL2] = swtest_norm(MRTL2.');
[~,~,pL3] = swtest_norm(MRTL3.');


rt.between_comparasion.assumption_check.norm_check.pC1 = pC1;
rt.between_comparasion.assumption_check.norm_check.pC2 = pC2;
rt.between_comparasion.assumption_check.norm_check.pC3 = pC3;
rt.between_comparasion.assumption_check.norm_check.pL1 = pL1;
rt.between_comparasion.assumption_check.norm_check.pL2 = pL2;
rt.between_comparasion.assumption_check.norm_check.pL3 = pL3;

% Check if the variances are equal between each distribuction

[~, pF1] = vartest2 (MRTC1, MRTL1);
[~, pF2] = vartest2 (MRTC2, MRTL2);
[~, pF3] = vartest2 (MRTC3, MRTL3);

rt.between_comparasion.assumption_check.var_check.pF1 = pF1;
rt.between_comparasion.assumption_check.var_check.pF2 = pF2;
rt.between_comparasion.assumption_check.var_check.pF3 = pF3;

%statiscal comparassion

[~, pb1] = ttest2 (MRTC1, MRTL1); % doing the 2-sample t-test for each block.
[~, pb2] = ttest2 (MRTC2, MRTL2);
[~, pb3] = ttest2 (MRTC3, MRTL3);

rt.between_comparasion.t_test.pb1 = pb1;
rt.between_comparasion.t_test.pb2 = pb2;
rt.between_comparasion.t_test.pb3 = pb3;

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

rt.between_comparasion.effect_size.relative.e1 = e1;
rt.between_comparasion.effect_size.relative.e2 = e2;
rt.between_comparasion.effect_size.relative.e3 = e3;

% Calculating Hedge's g effect size values

 mes1 = mes(MRTL1.',MRTC1.','hedgesg');
 mes2 = mes(MRTL2.',MRTC2.','hedgesg');
 mes3 = mes(MRTL3.',MRTC3.','hedgesg');

hg1 = mes1.hedgesg;
hg2 = mes2.hedgesg;
hg3 = mes3.hedgesg;

rt.between_comparasion.effect_size.hedges_g.hg1 = hg1;
rt.between_comparasion.effect_size.hedges_g.hg2 = hg2;
rt.between_comparasion.effect_size.hedges_g.hg3 = hg3;

%%% Comparation Within Groups

%% Control Group

%Boxplot

f_C = [MRTC1.' MRTC2.' MRTC3.']; 
figure

Bf_C = boxplot(f_C); 
title('Distribution of the Mean Response Times of the Control Group in each block');
ylabel("Mean Response Time (s)");
ylim([0 2.5])
yticks([0:0.2:2])
xticks([1 2 3])
xticklabels({'1st Block', '2nd Block', '3rd Block'})
xline(2.5)
xline(1.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

% Checking normality of the data samples

[~,~,pC1] = swtest_norm(MRTC1.');

[~,~,pC2] = swtest_norm(MRTC2.');

[~,~,pC3] = swtest_norm(MRTC3.');

rt.within_comparasion.Control.assumption_check.norm_check.pC1 = pC1;
rt.within_comparasion.Control.assumption_check.norm_check.pC2 = pC2;
rt.within_comparasion.Control.assumption_check.norm_check.pC3 = pC3;

% F-test to check if the population variances are equal.

[~, pCF1_2] = vartest2 (MRTC1, MRTC2);
[~, pCF1_3] = vartest2 (MRTC1, MRTC3);
[~, pCF2_3] = vartest2 (MRTC2, MRTC3);

rt.within_comparasion.Control.assumption_check.var_check.pCF1_2 = pCF1_2;
rt.within_comparasion.Control.assumption_check.var_check.pCF1_3 = pCF1_3;
rt.within_comparasion.Control.assumption_check.var_check.pCF2_3 = pCF2_3;

% Making a Repeated Measures Model

M_C = [MRTC1.' MRTC2.' MRTC3.'];

t_C = table(M_C(:,1),M_C(:,2),M_C(:,3),... %the three dots indicate that the function continues in the next line
'VariableNames',{'Block1','Block2','Block3'});
wd_C = table([1 2 3]','VariableNames',{'Blocks'});

rm_C = fitrm(t_C,'Block1-Block3~1','WithinDesign',wd_C);

% Repeated Measures ANOVA

ranovatbl_C = ranova(rm_C);

% Mauchly test for sphericity

mauchly_test_C = mauchly(rm_C); 

if table2array(mauchly_test_C(1,4)) < 0.05
    p_anova_C = table2array(ranovatbl_C(1,6)); %correcting the p-value if the sphericity condition isn't met
else
    p_anova_C = table2array(ranovatbl_C(1,5));
end


rt.within_comparasion.Control.rep_meas_anova.p_anova_C = p_anova_C;
rt.within_comparasion.Control.rep_meas_anova.ranovatbl_C = ranovatbl_C;

% Doing the paired t-test with bonferroni correction. p-values higher than
% 1 should be interpreted as 1.

[~,pC12] = ttest(MRTC1, MRTC2);
pC1_2 = pC12*3; %bonferoni correction for multiple comparasions

[~,pC13] = ttest(MRTC1, MRTC3);
pC1_3 = pC13*3; 

[~,pC23] = ttest(MRTC2, MRTC3);
pC2_3 = pC23*3; %bonferoni correction for multiple comparasions

rt.within_comparasion.Control.t_test.pC1_2 = pC1_2;
rt.within_comparasion.Control.t_test.pC1_3 = pC1_3;
rt.within_comparasion.Control.t_test.pC2_3 = pC2_3;

% calculating the relative effect size by relative mean difference 

MMRTC1 = mean (MRTC1);
MMRTC2 = mean (MRTC2);
MMRTC3 = mean (MRTC3);

eC1_2 = (MMRTC1 * 100)/MMRTC2;
eC1_3 = (MMRTC1 * 100)/MMRTC3;
eC2_3 = (MMRTC2 * 100)/MMRTC3;

rt.within_comparasion.Control.effect_size.relative.eC1_2 = eC1_2;
rt.within_comparasion.Control.effect_size.relative.eC1_3 = eC1_3;
rt.within_comparasion.Control.effect_size.relative.eC2_3 = eC2_3;

% Calculating Hedge's g effect size values

mesC1_2 = mes(MRTC1.',MRTC2.','hedgesg');
mesC1_3 = mes(MRTC1.',MRTC3.','hedgesg');
mesC2_3 = mes(MRTC2.',MRTC3.','hedgesg');

hgC1_2 = mesC1_2.hedgesg;
hgC1_3 = mesC1_3.hedgesg;
hgC2_3 = mesC2_3.hedgesg;

rt.within_comparasion.Control.effect_size.hedges_g.hgC1_2 = hgC1_2;
rt.within_comparasion.Control.effect_size.hedges_g.hgsC1_3 = hgC1_3;
rt.within_comparasion.Control.effect_size.hedges_g.hgC2_3 = hgC2_3;

%% LTPB Group

%Boxplot

f_L = [MRTL1.' MRTL2.' MRTL3.']; 

figure

Bf_L = boxplot(f_L); 

title('Distribution of the Mean Response Times of the LTPB Group in each block');
ylabel("Mean Response Time (s)");
ylim([0 2.5])
yticks([0:0.2:2])
xticks([1 2 3])
xticklabels({'1st Block', '2nd Block', '3rd Block'})
xline(2.5)
xline(1.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

% Checking normality of the data samples

[~,~,pL1] = swtest_norm(MRTL1.'); %Shapiro-Wilk test.
[~,~,pL2] = swtest_norm(MRTL2.');
[~,~,pL3] = swtest_norm(MRTL3.');

rt.within_comparasion.LTPB.assumption_check.norm_check.pL1 = pL1;
rt.within_comparasion.LTPB.assumption_check.norm_check.pL2 = pL2;
rt.within_comparasion.LTPB.assumption_check.norm_check.pL3 = pL3;

% F-test to check if the population variances are equal.

[~, pLF1_2] = vartest2 (MRTL1, MRTL2);
[~, pLF1_3] = vartest2 (MRTL1, MRTL3);
[~, pLF2_3] = vartest2 (MRTL2, MRTL3);

rt.within_comparasion.LTPB.assumption_check.var_check.pLF1_2 = pLF1_2;
rt.within_comparasion.LTPB.assumption_check.var_check.pLF1_3 = pLF1_3;
rt.within_comparasion.LTPB.assumption_check.var_check.pLF2_3 = pLF2_3;

% Making a Repeated Measures Model

M_L = [MRTL1.' MRTL2.' MRTL3.'];

t_L = table(M_L(:,1),M_L(:,2),M_L(:,3),... %the three dots indicate that the function continues in the next line
'VariableNames',{'Block1','Block2','Block3'});
wd_L = table([1 2 3]','VariableNames',{'Blocks'});

rm_L = fitrm(t_L,'Block1-Block3~1','WithinDesign',wd_L);

% Repeated Measures ANOVA

ranovatbl_L = ranova(rm_L);

% Mauchly test for sphericity

mauchly_test_L = mauchly(rm_L); 

if table2array(mauchly_test_L(1,4)) < 0.05
    p_anova_L = table2array(ranovatbl_L(1,6)); %correcting the p-value if the sphericity condition isn't met.
else
    p_anova_L = table2array(ranovatbl_L(1,5));
end


rt.within_comparasion.LTPB.rep_meas_anova.p_anova_L = p_anova_L;
rt.within_comparasion.LTPB.rep_meas_anova.ranovatbl_L = ranovatbl_L;

% Doing the paired t-test with bonferroni correction

[~,pL12] = ttest(MRTL1, MRTL2);
pL1_2 = pL12*3; %bonferoni correction for multiple comparasions

[~,pL13] = ttest(MRTL1, MRTL3);
pL1_3 = pL13*3; 

[~,pL23] = ttest(MRTL2, MRTL3);
pL2_3 = pL23*3; %bonferoni correction for multiple comparasions

rt.within_comparasion.LTPB.t_test.pL1_2 = pL1_2;
rt.within_comparasion.LTPB.t_test.pL1_3 = pL1_3;
rt.within_comparasion.LTPB.t_test.pL2_3 = pL2_3;

% calculating the relative effect size by relative mean difference 

MMRTL1 = mean (MRTL1);
MMRTL2 = mean (MRTL2);
MMRTL3 = mean (MRTL3);

eL1_2 = (MMRTL1 * 100)/MMRTL2;
eL1_3 = (MMRTL1 * 100)/MMRTL3;
eL2_3 = (MMRTL2 * 100)/MMRTL3;

rt.within_comparasion.LTPB.effect_size.relative.eL1_2 = eL1_2;
rt.within_comparasion.LTPB.effect_size.relative.eL1_3 = eL1_3;
rt.within_comparasion.LTPB.effect_size.relative.eL2_3 = eL2_3;

% Calculating Hedge's g effect size values

mesL1_2 = mes(MRTL1.',MRTL2.','hedgesg');
mesL1_3 = mes(MRTL1.',MRTL3.','hedgesg');
mesL2_3 = mes(MRTL2.',MRTL3.','hedgesg');

hgL1_2 = mesL1_2.hedgesg;
hgL1_3 = mesL1_3.hedgesg;
hgL2_3 = mesL2_3.hedgesg;

rt.within_comparasion.LTPB.effect_size.hedges_g.hgL1_2 = hgL1_2;
rt.within_comparasion.LTPB.effect_size.hedges_g.hgL1_3 = hgL1_3;
rt.within_comparasion.LTPB.effect_size.hedges_g.hgL2_3 = hgL2_3;

%%% Global comparasion


for par = 1:(size(data_control,1)/1000)
     GTMC(par) = mean(RT1{par}); %global temporal means control
end

for par = 1:(size(data_LTPB,1)/1000)
     GTML(par) = mean(RT2{par}); %global temporal means LTPB
end

rt.response_times.Control.global = GTMC;
rt.response_times.LTPB.global = GTML;

%Boxplot

RTG = [GTMC GTML];

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n)]; 

figure

BRTG = boxplot(RTG,grp); 

title('Distribution of the Mean Response Times of each group considering the whole experiment');
ylabel("Mean Response Time (s)");
ylim([0 2.5])
yticks([0:0.2:2.5])
xticks([1 2])
xticklabels({'Control','LTPB'})
xline(1.5)



figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14


% Checking normality of the data samples

[~,~,pGC] = swtest_norm(GTMC.'); 
[~,~,pGL] = swtest_norm(GTML.');


rt.global_comparasion.assumption_check.norm_check.pGC = pGC;
rt.global_comparasion.assumption_check.norm_check.pGL = pGL;


% Check if the variances are equal between each distribuction

[~, pFG] = vartest2 (GTMC, GTML);


rt.global_comparasion.assumption_check.var_check.pFG = pFG;

%statiscal comparassion

[~, pG] = ttest2 (GTMC, GTML); % doing the 2-sample t-test.


rt.global_comparasion.t_test.pG = pG;


% calculating the relative effect size by relative mean difference

MGTMC = mean (GTMC);
MGTML = mean (GTML);


eG = (MGTML * 100)/MGTMC;

rt.global_comparasion.effect_size.relative.eG = eG;

% Calculating Hedge's g effect size values

mesG = mes(GTML.',GTMC.','hedgesg');

hgG = mes1.hedgesg;

rt.global_comparasion.effect_size.hedges_g.hgG = hgG;

end