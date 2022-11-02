% [lv] = local_variance(data_control, data_LTPB)
%
% This function returns a struct containing the values of the local
% variance of each particicipant of the experiment in each block,
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
% lv = the data strucure containing the local variance values and related
% data.
%
% - The "local_variance" section contains the raw local variance data of
% each participant divided by group and block. Each value in the row
% represents the data of one participant.
%
% - The "between_comparasion" section deals with the comparasion between
% both groups alongside each experimental blocks. In "assumption_check", it
% is possible to see the Shapiro-Wilk normality test results for the data
% contained in each block and also check if both populations in each of the three
% blocks have the same variance, using a F test. In "t_test", it is
% possible to see the p-values of the 2-sample t-tests applied in each
% block. In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of the Control group over the 
% LTPB group. Figure 1 is a companion boxplot to this section.
%
% - The "within_comparasion" section deals with comparasions between the 
% local_variance data of different blocks of the same group. In "assumption
% check", it is possible to check the assumptions required for applying paired
% parametrical tests to the data sets, namely, normality of distribuitions
% and equal variance between pairs of blocks. In "rep_means_anova", it is
% possible to see the full table and the p-value of a repeated measures
% ANOVA applied to the data of an individual group(corrected with de GG method
% if the sphericity condition is violated). In "t_test", it is
% possible to see the p-values of the paired-sample t-tests applied in each
% pair of blocks. In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of one block over the 
% other. Figures 2 and 3 are a companion boxplot to this section.
%
% - The "global_comparasion" section deals with the comparasion between
% both groups global local_variance values (considering the whole game as a single block).
% In "assumption_check", it is possible to see the Shapiro-Wilk normality test results for the data
% contained in each group and also check if both populations have the same variance, using a F test.
% In "t_test", it is possible to see the p-values of the 2-sample t-tests applied in the comparasion. 
% In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of the Control group over the 
% LTPB group. Figure 4 is a companion boxplot to this section.
%
% 18/10/2022 by Pedro R. Pinheiro


function [lv] = local_variance(data_control, data_LTPB)

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
    Lv_C1(par) = (3/333) * Lv_sc1;
    Lv_sc1 = 0;
end

 Lv_C1(7) = [];

% Control - Block 2

Lv_sc2 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 335 : 667  % i goes from 1 to n-1
        Lv_sc2 = Lv_sc2 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv_C2(par) = (3/333) * Lv_sc2;
    Lv_sc2 = 0;
end

Lv_C2(7) = [];

% Control - Block 3

Lv_sc3 = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 669 : 999  % i goes from 1 to n-1
        Lv_sc3 = Lv_sc3 + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv_C3(par) = (3/331) * Lv_sc3;
    Lv_sc3 = 0;
end

Lv_C3(7) = [];

%Building a struct to store the results

lv.local_variance.Control.block_1 = Lv_C1;
lv.local_variance.Control.block_2 = Lv_C2;
lv.local_variance.Control.block_3 = Lv_C3;

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

% LTPB - Block 3

Lv_sL3 = 0;

for par = 1:(size(data_LTPB,1)/1000)
    for i = 669 : 999  % i goes from 1 to n-1
        Lv_sL3 = Lv_sL3 + (((RT2{par}(i) - RT2{par}(i+1))/(RT2{par}(i) + RT2{par}(i+1))).^2);
    end
    Lv_L3(par) = (3/331) * Lv_sL3;
    Lv_sL3 = 0;
end

lv.local_variance.LTPB.block_1 = Lv_L1;
lv.local_variance.LTPB.block_2 = Lv_L2;
lv.local_variance.LTPB.block_3 = Lv_L3;


%%% Comparation between groups

%Boxplot
Lv1=[Lv_C1 Lv_L1]; 
Lv2=[Lv_C2 Lv_L2];
Lv3=[Lv_C3 Lv_L3];
Lvf = [Lv1 Lv2 Lv3]; 

control_n = (size(data_control,1)/1000) -1;
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n),2*ones(1,control_n),3*ones(1,LTPB_n),4*ones(1,control_n),5*ones(1,LTPB_n)]; %grouping variable. 

figure

BLvf = boxplot(Lvf,grp); 

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


lv.between_comparasion.assumption_check.norm_check.pLv_C1 = pLv_C1;
lv.between_comparasion.assumption_check.norm_check.pLv_C2 = pLv_C2;
lv.between_comparasion.assumption_check.norm_check.pLv_C3 = pLv_C3;
lv.between_comparasion.assumption_check.norm_check.pLv_L1 = pLv_L1;
lv.between_comparasion.assumption_check.norm_check.pLv_L2 = pLv_L2;
lv.between_comparasion.assumption_check.norm_check.pLv_L3 = pLv_L3;

% Check if the variances are equal between each distribuction

[~, pF1] = vartest2 (Lv_C1, Lv_L1);
[~, pF2] = vartest2 (Lv_C2, Lv_L2);
[~, pF3] = vartest2 (Lv_C3, Lv_L3);

lv.between_comparasion.assumption_check.var_check.pF1 = pF1;
lv.between_comparasion.assumption_check.var_check.pF2 = pF2;
lv.between_comparasion.assumption_check.var_check.pF3 = pF3;

%statiscal comparassion

[~, pb1] = ttest2 (Lv_C1, Lv_L1); % doing the 2-sample t-test for each block.
[~, pb2] = ttest2 (Lv_C2, Lv_L2);
[~, pb3] = ttest2 (Lv_C3, Lv_L3);

lv.between_comparasion.t_test.pb1 = pb1;
lv.between_comparasion.t_test.pb2 = pb2;
lv.between_comparasion.t_test.pb3 = pb3;

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

lv.between_comparasion.effect_size.relative.e1 = e1;
lv.between_comparasion.effect_size.relative.e2 = e2;
lv.between_comparasion.effect_size.relative.e3 = e3;

% Calculating Hedge's g effect size values

 mes1 = mes(Lv_C1.',Lv_L1.','hedgesg');
 mes2 = mes(Lv_C2.',Lv_L2.','hedgesg');
 mes3 = mes(Lv_C3.',Lv_L3.','hedgesg');

hg1 = mes1.hedgesg;
hg2 = mes2.hedgesg;
hg3 = mes3.hedgesg;

lv.between_comparasion.effect_size.hedges_g.hg1 = hg1;
lv.between_comparasion.effect_size.hedges_g.hg2 = hg2;
lv.between_comparasion.effect_size.hedges_g.hg3 = hg3;

%%% Comparation Within Groups

%% Control Group

%Boxplot

Lvf_C = [Lv_C1.' Lv_C2.' Lv_C3.']; 
figure

BLvf_C = boxplot(Lvf_C); 
title('Distribution of the Local Variance of the Control Group in each block');
ylabel("Local Variance");
ylim([0 2])
yticks([0:0.2:2])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - Control', '2nd Block - Control', '3rd Block - Control'})
xline(2.5)
xline(1.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

% Checking normality of the data samples

[~,~,pLv_C1] = swtest_norm(Lv_C1.'); %Shapiro-Wilk test.
[~,~,pLv_C2] = swtest_norm(Lv_C2.');
[~,~,pLv_C3] = swtest_norm(Lv_C3.');

lv.within_comparasion.Control.assumption_check.norm_check.pLv_C1 = pLv_C1;
lv.within_comparasion.Control.assumption_check.norm_check.pLv_C2 = pLv_C2;
lv.within_comparasion.Control.assumption_check.norm_check.pLv_C3 = pLv_C3;

% F-test to check if the population variances are equal.

[~, pCF1_2] = vartest2 (Lv_C1, Lv_C2);
[~, pCF1_3] = vartest2 (Lv_C1, Lv_C3);
[~, pCF2_3] = vartest2 (Lv_C2, Lv_C3);

lv.within_comparasion.Control.assumption_check.var_check.pCF1_2 = pCF1_2;
lv.within_comparasion.Control.assumption_check.var_check.pCF1_3 = pCF1_3;
lv.within_comparasion.Control.assumption_check.var_check.pCF2_3 = pCF2_3;

% Making a Repeated Measures Model

MLV_C = [Lv_C1.' Lv_C2.' Lv_C3.'];

t_C = table(MLV_C(:,1),MLV_C(:,2),MLV_C(:,3),... %the three dots indicate that the function continues in the next line
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


lv.within_comparasion.Control.rep_meas_anova.p_anova_C = p_anova_C;
lv.within_comparasion.Control.rep_meas_anova.ranovatbl_C = ranovatbl_C;

% Doing the paired t-test with bonferroni correction. p-values higher than
% 1 should be interpreted as 1.

[~,pC12] = ttest(Lv_C1, Lv_C2);
pC1_2 = pC12*3; %bonferoni correction for multiple comparasions

[~,pC13] = ttest(Lv_C1, Lv_C3);
pC1_3 = pC13*3; 

[~,pC23] = ttest(Lv_C2, Lv_C3);
pC2_3 = pC23*3; %bonferoni correction for multiple comparasions

lv.within_comparasion.Control.t_test.pC1_2 = pC1_2;
lv.within_comparasion.Control.t_test.pC1_3 = pC1_3;
lv.within_comparasion.Control.t_test.pC2_3 = pC2_3;

% calculating the relative effect size by relative mean difference 

MLv_C1 = mean (Lv_C1);
MLv_C2 = mean (Lv_C2);
MLv_C3 = mean (Lv_C3);

eLv_C1_2 = (MLv_C2 * 100)/MLv_C1;
eLv_C1_3 = (MLv_C3 * 100)/MLv_C1;
eLv_C2_3 = (MLv_C3 * 100)/MLv_C2;

lv.within_comparasion.Control.effect_size.relative.eLv_C1_2 = eLv_C1_2;
lv.within_comparasion.Control.effect_size.relative.eLv_C1_3 = eLv_C1_3;
lv.within_comparasion.Control.effect_size.relative.eLv_C2_3 = eLv_C2_3;

% Calculating Hedge's g effect size values

mesC1_2 = mes(Lv_C2.',Lv_C1.','hedgesg');
mesC1_3 = mes(Lv_C3.',Lv_C1.','hedgesg');
mesC2_3 = mes(Lv_C3.',Lv_C2.','hedgesg');

hgC1_2 = mesC1_2.hedgesg;
hgC1_3 = mesC1_3.hedgesg;
hgC2_3 = mesC2_3.hedgesg;

lv.within_comparasion.Control.effect_size.hedges_g.hgC1_2 = hgC1_2;
lv.within_comparasion.Control.effect_size.hedges_g.hgC1_3 = hgC1_3;
lv.within_comparasion.Control.effect_size.hedges_g.hgC2_3 = hgC2_3;

%% LTPB Group

%Boxplot

Lvf_L = [Lv_L1.' Lv_L2.' Lv_L3.']; 

figure

BLvf_L = boxplot(Lvf_L); 

title('Distribution of the Local Variance of the LTPB Group in each block');
ylabel("Local Variance");
ylim([0 2])
yticks([0:0.2:2])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - LTPB', '2nd Block - LTPB', '3rd Block - LTPB'})
xline(2.5)
xline(1.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

% Checking normality of the data samples

[~,~,pLv_L1] = swtest_norm(Lv_L1.'); %Shapiro-Wilk test.
[~,~,pLv_L2] = swtest_norm(Lv_L2.');
[~,~,pLv_L3] = swtest_norm(Lv_L3.');

lv.within_comparasion.LTPB.assumption_check.norm_check.pLv_L1 = pLv_L1;
lv.within_comparasion.LTPB.assumption_check.norm_check.pLv_L2 = pLv_L2;
lv.within_comparasion.LTPB.assumption_check.norm_check.pLv_L3 = pLv_L3;

% F-test to check if the population variances are equal.

[~, pLF1_2] = vartest2 (Lv_L1, Lv_L2);
[~, pLF1_3] = vartest2 (Lv_L1, Lv_L3);
[~, pLF2_3] = vartest2 (Lv_L2, Lv_L3);

lv.within_comparasion.LTPB.assumption_check.var_check.pLF1_2 = pLF1_2;
lv.within_comparasion.LTPB.assumption_check.var_check.pLF1_3 = pLF1_3;
lv.within_comparasion.LTPB.assumption_check.var_check.pLF2_3 = pLF2_3;

% Making a Repeated Measures Model

MLV_L = [Lv_L1.' Lv_L2.' Lv_L3.'];

t_L = table(MLV_L(:,1),MLV_L(:,2),MLV_L(:,3),... %the three dots indicate that the function continues in the next line
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


lv.within_comparasion.LTPB.rep_meas_anova.p_anova_L = p_anova_L;
lv.within_comparasion.LTPB.rep_meas_anova.ranovatbl_L = ranovatbl_L;

% Doing the paired t-test with bonferroni correction

[~,pL12] = ttest(Lv_L1, Lv_L2);
pL1_2 = pL12*3; %bonferoni correction for multiple comparasions

[~,pL13] = ttest(Lv_L1, Lv_L3);
pL1_3 = pL13*3; 

[~,pL23] = ttest(Lv_L2, Lv_L3);
pL2_3 = pL23*3; %bonferoni correction for multiple comparasions

lv.within_comparasion.LTPB.t_test.pL1_2 = pL1_2;
lv.within_comparasion.LTPB.t_test.pL1_3 = pL1_3;
lv.within_comparasion.LTPB.t_test.pL2_3 = pL2_3;

% calculating the relative effect size by relative mean difference 

MLv_L1 = mean (Lv_L1);
MLv_L2 = mean (Lv_L2);
MLv_L3 = mean (Lv_L3);

eLv_L1_2 = (MLv_L2 * 100)/MLv_L1;
eLv_L1_3 = (MLv_L3 * 100)/MLv_L1;
eLv_L2_3 = (MLv_L3 * 100)/MLv_L2;

lv.within_comparasion.LTPB.effect_size.relative.eLv_L1_2 = eLv_L1_2;
lv.within_comparasion.LTPB.effect_size.relative.eLv_L1_3 = eLv_L1_3;
lv.within_comparasion.LTPB.effect_size.relative.eLv_L2_3 = eLv_L2_3;

% Calculating Hedge's g effect size values

mesL1_2 = mes(Lv_L2.',Lv_L1.','hedgesg');
mesL1_3 = mes(Lv_L3.',Lv_L1.','hedgesg');
mesL2_3 = mes(Lv_L3.',Lv_L2.','hedgesg');

hgL1_2 = mesL1_2.hedgesg;
hgL1_3 = mesL1_3.hedgesg;
hgL2_3 = mesL2_3.hedgesg;

lv.within_comparasion.LTPB.effect_size.hedges_g.hgL1_2 = hgL1_2;
lv.within_comparasion.LTPB.effect_size.hedges_g.hgL1_3 = hgL1_3;
lv.within_comparasion.LTPB.effect_size.hedges_g.hgL2_3 = hgL2_3;

%%% Global comparasion

Lv_scG = 0;

for par = 1:(size(data_control,1)/1000)
    for i = 1 : 999  % i goes from 1 to n-1
        Lv_scG = Lv_scG + (((RT1{par}(i) - RT1{par}(i+1))/(RT1{par}(i) + RT1{par}(i+1))).^2);
    end
    Lv_CG(par) = (3/999) * Lv_scG;
    Lv_scG = 0;
end

Lv_scL = 0;

for par = 1:(size(data_LTPB,1)/1000)
    for i = 1 : 999  % i goes from 1 to n-1
        Lv_scL = Lv_scL + (((RT2{par}(i) - RT2{par}(i+1))/(RT2{par}(i) + RT2{par}(i+1))).^2);
    end
    Lv_LG(par) = (3/999) * Lv_scL;
    Lv_scL = 0;
end

lv.local_variance.Control.global = Lv_CG;
lv.local_variance.LTPB.global = Lv_LG;

%Boxplot

LvG = [Lv_CG Lv_LG]; 

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n)]; %grouping variable. 

figure

BLvG = boxplot(LvG,grp); 

title('Distribution of the Local Variance of each group in the whole experiment');
ylabel("Local Variance");
ylim([0 2])
yticks([0:0.2:2])
xticks([1 2 3 4 5 6])
xticklabels({'Control','LTPB'})

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

% Checking normality of the data samples

[~,~,pLv_CG] = swtest_norm(Lv_CG.'); %Shapiro-Wilk test.
[~,~,pLv_LG] = swtest_norm(Lv_LG.');


lv.global_comparasion.assumption_check.norm_check.pLv_CG = pLv_CG;
lv.global_comparasion.assumption_check.norm_check.pLv_LG = pLv_LG;


% Check if the variances are equal between each distribuction

[~, pFG] = vartest2 (Lv_CG, Lv_LG);


lv.global_comparasion.assumption_check.var_check.pFG = pFG;

%statiscal comparassion

[~, pG] = ttest2 (Lv_CG, Lv_LG); % doing the 2-sample t-test for each block.


lv.global_comparasion.t_test.pG = pG;


% calculating the relative effect size by relative mean difference 

MLv_CG = mean (Lv_CG);
MLv_LG = mean (Lv_LG);

eG = (MLv_CG * 100)/MLv_LG;

lv.global_comparasion.effect_size.relative.eG = eG;

% Calculating Hedge's g effect size values

 mesG = mes(Lv_CG.',Lv_LG.','hedgesg');

hgG = mesG.hedgesg;

lv.global_comparasion.effect_size.hedges_g.hgG = hgG;

end