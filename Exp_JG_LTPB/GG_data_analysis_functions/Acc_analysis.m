% [acc] = Acc_analysis(data_control, data_LTPB)
%
% This function returns a struct containing the values of the accuracy
% of each particicipant of the experiment in each block,
% the results of tests aiming to validate the assumptions of parametric tests 
% for comparasitions between groups and within the same group, the results
% of said parametric tests for comparasions betweeen groups and within
% the same group and also boxplots corresponding to said comparasions.
% Nonparametric alternatives are also presented.
% 
% INPUT:
%
% data_control = data matrix from the control group.

% data_ltpb = data matrix from the LTPB group.
%
% OUTPUT:
% 
% acc = the data strucure containing the accuracy values and related
% data.
%
% - The "Accuracy" section contains the raw accuracy data of
% each participant divided by group and block. Each value in the row
% represents the data of one participant.
%
% - The "between_comparasion" section deals with the comparasion between
% both groups alongside each experimental blocks. In "assumption_check", it
% is possible to see the Shapiro-Wilk normality test results for the data
% contained in each block (p > 0.05 indicates normality) and also check if both populations in each of the three
% blocks have the same variance, using a F test (p > 0.05 indicates equal variances). In "t_test", it is
% possible to see the p-values of the 2-sample t-tests applied in each
% block. In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of the LTPB group over the 
% Control group. The nonparametric alternatives includes the Wilcoxon Ranksum test and the
% Cohen's U3 effect size measure.Figure 1 is a companion boxplot to this section.
%
% - The "within_comparasion" section deals with comparasions between the 
% accuracy data of different blocks of the same group. In "assumption
% check", it is possible to check the assumptions required for applying paired
% parametric tests to the data sets, namely, normality of distribuitions
% and equal variance between pairs of blocks. In "rep_means_anova", it is
% possible to see the full table and the p-value of a repeated measures
% ANOVA applied to the data of an individual group (corrected with de GG method
% if the sphericity condition is violated). In "t_test", it is
% possible to see the p-values of the paired-sample t-tests applied in each
% pair of blocks. In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of one block over the 
% other. The nonparametric alternatives includes the Wilcoxon Signed Ranks test and the
% Cohen's U3 effect size measure. Figures 2 and 3 are a companion boxplot to this section. 
%
% - The "global_comparasion" section deals with the comparasion between
% both groups global accuracy values (considering the whole game as a single block).
% In "assumption_check", it is possible to see the Shapiro-Wilk normality test results for the data
% contained in each group and also check if both populations have the same variance, using a F test.
% In "t_test", it is possible to see the p-values of the 2-sample t-tests applied in the comparasion. 
% In "effect_size" it is possible to see both the relative effect
% size and the hedge's g value effect size of the Control group over the 
% LTPB group. The nonparametric alternatives includes the Wilcoxon Ranksum test and the
% Cohen's U3 effect size measure. Figure 4 is a companion boxplot to this section.
%
% 23/01/2023 by Pedro R. Pinheiro


function [acc] = Acc_analysis(data_control, data_LTPB)

%% Creating the accuracy vectors for each group and block

% Control Group

for i = 1:size(data_control,1)
  
   if data_control(i,8) == data_control(i,9) %checking if the participant predicted the correct outcome
       WC(i)= 1;    
   else 
       WC(i)= 0;
   end
   
end

wc=1;

for par = 1:(size(data_control,1)/1000) 
    
    AC{par} = WC(wc:wc+999);
    wc=wc+1000;

end


%Block 1 - Control

AC1 = 0; 
for par = 1:(size(data_control,1)/1000)
    for k = drange(1:334) %number os trials in the block

        AC1 = AC1 + AC{par}(k); 
    end

    MAC1(par) = AC1/334; 
    AC1=0;

end

%%Block 2 - Control

AC2 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(335:668)

        AC2 = AC2 + AC{par}(k); 
    end

    MAC2(par) = AC2/334;  
    AC2=0;
end

%Block 3 - Control

AC3 = 0;
for par = 1:(size(data_control,1)/1000)
    for k = drange(669:1000)

        AC3 = AC3 + AC{par}(k); 
    end

    MAC3(par) = AC3/332;  
    AC3=0;
end

acc.Accuracy.Control.block_1 = MAC1;
acc.Accuracy.Control.block_2 = MAC2;
acc.Accuracy.Control.block_3 = MAC3;

% %LTPB group

for i = 1:size(data_LTPB,1)
  
   if data_LTPB(i,8) == data_LTPB(i,9)
       WL(i)= 1;    
   else 
       WL(i)= 0;
   end
   
end

wl=1;

for par = 1:(size(data_LTPB,1)/1000) 
    
    AL{par} = WL(wl:wl+999);
    wl=wl+1000;

end


%Block 1 - LTPB

AL1 = 0; 
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(1:334) %number os trials in the block

        AL1 = AL1 + AL{par}(k); 
    end

    MAL1(par) = AL1/334; 
    AL1=0;

end
%MAL1(5)=[];

%%Block 2 - LTPB

AL2 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(335:668)

        AL2 = AL2 + AL{par}(k); 
    end

    MAL2(par) = AL2/334;  
    AL2=0;
end

%MAL2(5)=[];

%Block 3 - LTPB

AL3 = 0;
for par = 1:(size(data_LTPB,1)/1000)
    for k = drange(669:1000)

        AL3 = AL3 + AL{par}(k); 
    end

    MAL3(par) = AL3/332;  
    AL3=0;
end

%MAL3(5)=[];

acc.Accuracy.LTPB.block_1 = MAL1;
acc.Accuracy.LTPB.block_2 = MAL2;
acc.Accuracy.LTPB.block_3 = MAL3;


%%% Comparation between groups

%Boxplot
MA1=[MAC1 MAL1]; 
MA2=[MAC2 MAL2];
MA3=[MAC3 MAL3];
MAF = [MA1 MA2 MA3]; 
control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[ones(1,control_n),2*ones(1,LTPB_n),3*ones(1,control_n),4*ones(1,LTPB_n),5*ones(1,control_n),6*ones(1,LTPB_n)]; %grouping variable. 

x_name = '';
y_name = "Accuracy";
tit = 'Distribution of the Accuracy of each group in each block';
sig_dif = 1;
test = 0;
acsis = [];

% Boxplots with the individual data points
figure
sbox_comp(grp', MAF',  x_name, y_name, tit,{}, sig_dif, test, acsis)
xline(2.5)
xline(4.5)
ylim([0 1])
yticks([0:0.2:1])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - Control','1st Block - LTPB', '2nd Block - Control', '2nd Block - LTPB','3rd Block - Control', '3rd Block - LTPB'})
xlim([0.5 7])

% Checking normality of the data samples

[~,~,pC1] = swtest_norm(MAC1.'); %Shapiro-Wilk test.
[~,~,pC2] = swtest_norm(MAC2.');
[~,~,pC3] = swtest_norm(MAC3.');
[~,~,pL1] = swtest_norm(MAL1.'); %Shapiro-Wilk test.
[~,~,pL2] = swtest_norm(MAL2.');
[~,~,pL3] = swtest_norm(MAL3.');


acc.between_comparasion.assumption_check.norm_check.pC1 = pC1;
acc.between_comparasion.assumption_check.norm_check.pC2 = pC2;
acc.between_comparasion.assumption_check.norm_check.pC3 = pC3;
acc.between_comparasion.assumption_check.norm_check.pL1 = pL1;
acc.between_comparasion.assumption_check.norm_check.pL2 = pL2;
acc.between_comparasion.assumption_check.norm_check.pL3 = pL3;

% Check if the variances are equal between each distribuction

[~, pF1] = vartest2 (MAC1, MAL1);
[~, pF2] = vartest2 (MAC2, MAL2);
[~, pF3] = vartest2 (MAC3, MAL3);

acc.between_comparasion.assumption_check.var_check.pF1 = pF1;
acc.between_comparasion.assumption_check.var_check.pF2 = pF2;
acc.between_comparasion.assumption_check.var_check.pF3 = pF3;

%statiscal comparassion

[~, pb1] = ttest2 (MAC1, MAL1); % doing the 2-sample t-test for each block.
[~, pb2] = ttest2 (MAC2, MAL2);
[~, pb3] = ttest2 (MAC3, MAL3);

acc.between_comparasion.t_test.pb1 = pb1;
acc.between_comparasion.t_test.pb2 = pb2;
acc.between_comparasion.t_test.pb3 = pb3;


%statiscal comparassion - Non - parametric

[wpb1] = ranksum (MAC1, MAL1);  %wilcoxon rank sum test
[wpb2] = ranksum (MAC2, MAL2);
[wpb3] = ranksum (MAC3, MAL3);

acc.between_comparasion.w_test.pb1 = wpb1;
acc.between_comparasion.w_test.pb2 = wpb2;
acc.between_comparasion.w_test.pb3 = wpb3;

% calculating the relative effect size by relative mean difference 

MMAC1 = mean (MAC1);
MMAC2 = mean (MAC2);
MMAC3 = mean (MAC3);
MMAL1 = mean (MAL1);
MMAL2 = mean (MAL2);
MMAL3 = mean (MAL3);

e1 = (MMAL1 * 100)/MMAC1;
e2 = (MMAL2 * 100)/MMAC2;
e3 = (MMAL3 * 100)/MMAC3;

acc.between_comparasion.effect_size.relative.e1 = e1;
acc.between_comparasion.effect_size.relative.e2 = e2;
acc.between_comparasion.effect_size.relative.e3 = e3;

% Calculating Hedge's g effect size values

 mes1 = mes(MAL1.',MAC1.','hedgesg');
 mes2 = mes(MAL2.',MAC2.','hedgesg');
 mes3 = mes(MAL3.',MAC3.','hedgesg');

hg1 = mes1.hedgesg;
hg2 = mes2.hedgesg;
hg3 = mes3.hedgesg;

acc.between_comparasion.effect_size.hedges_g.hg1 = hg1;
acc.between_comparasion.effect_size.hedges_g.hg2 = hg2;
acc.between_comparasion.effect_size.hedges_g.hg3 = hg3;

% Calculating Cohen's U3 (nonparametric effect size measure)

 mesU1 = mes(MAC1.',MAL1.','U3');
 mesU2 = mes(MAC2.',MAL2.','U3');
 mesU3 = mes(MAC3.',MAL3.','U3');

U3_1 = mesU1.U3;
U3_2 = mesU2.U3;
U3_3 = mesU3.U3;

acc.between_comparasion.effect_size.U3.U3_1 = U3_1;
acc.between_comparasion.effect_size.U3.U3_2 = U3_2;
acc.between_comparasion.effect_size.U3.U3_3 = U3_3;


%%%% Comparation Within Groups

%%% Control Group

%Boxplot

f_C = [MAC1.' MAC2.' MAC3.']; 
figure

Bf_C = boxplot(f_C); 
title('Distribution of the Accuracy of the Control Group in each block');
ylabel("Accuracy");
ylim([0 1])
yticks([0:0.2:1])
xticks([1 2 3])
xticklabels({'1st Block', '2nd Block', '3rd Block'})
xline(2.5)
xline(1.5)


figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

% Checking normality of the data samples

[~,~,pC1] = swtest_norm(MAC1.');

[~,~,pC2] = swtest_norm(MAC2.');

[~,~,pC3] = swtest_norm(MAC3.');

acc.within_comparasion.Control.assumption_check.norm_check.pC1 = pC1;
acc.within_comparasion.Control.assumption_check.norm_check.pC2 = pC2;
acc.within_comparasion.Control.assumption_check.norm_check.pC3 = pC3;

% F-test to check if the population variances are equal.

[~, pCF1_2] = vartest2 (MAC1, MAC2);
[~, pCF1_3] = vartest2 (MAC1, MAC3);
[~, pCF2_3] = vartest2 (MAC2, MAC3);

acc.within_comparasion.Control.assumption_check.var_check.pCF1_2 = pCF1_2;
acc.within_comparasion.Control.assumption_check.var_check.pCF1_3 = pCF1_3;
acc.within_comparasion.Control.assumption_check.var_check.pCF2_3 = pCF2_3;

% Making a Repeated Measures Model

M_C = [MAC1.' MAC2.' MAC3.'];

a_C = table(M_C(:,1),M_C(:,2),M_C(:,3),... %the three dots indicate that the function continues in the next line
'VariableNames',{'Block1','Block2','Block3'});
wd_C = table([1 2 3]','VariableNames',{'Blocks'});

rm_C = fitrm(a_C,'Block1-Block3~1','WithinDesign',wd_C);

%% Parametric tests
% Repeated Measures ANOVA

ranovatbl_C = ranova(rm_C);

% Mauchly test for sphericity

mauchly_test_C = mauchly(rm_C); 

if table2array(mauchly_test_C(1,4)) < 0.05
    p_anova_C = table2array(ranovatbl_C(1,6)); %correcting the p-value if the sphericity condition isn't met
else
    p_anova_C = table2array(ranovatbl_C(1,5));
end


acc.within_comparasion.Control.rep_meas_anova.p_anova_C = p_anova_C;
acc.within_comparasion.Control.rep_meas_anova.ranovatbl_C = ranovatbl_C;

% Doing the paired t-test with bonferroni correction. p-values higher than
% 1 should be interpreted as 1.

[~,pC12] = ttest(MAC1, MAC2);
pC1_2 = pC12*3; %bonferoni correction for multiple comparasions

[~,pC13] = ttest(MAC1, MAC3);
pC1_3 = pC13*3; 

[~,pC23] = ttest(MAC2, MAC3);
pC2_3 = pC23*3; %bonferoni correction for multiple comparasions

acc.within_comparasion.Control.t_test.pC1_2 = pC1_2;
acc.within_comparasion.Control.t_test.pC1_3 = pC1_3;
acc.within_comparasion.Control.t_test.pC2_3 = pC2_3;

%% Non-parametric tests

% Friedman test (alternative to the one way repeated measures ANOVA)

[pFri_C,Fritbl_C] = friedman(M_C,1, 'off'); 

acc.within_comparasion.Control.Friedman_test.pFri_C = pFri_C;
acc.within_comparasion.Control.Friedman_test.Fritbl_C = Fritbl_C;

% Signed rank Wilcoxon test with bonferroni correction. p-values higher than
% 1 should be interpreted as 1.

pwC1_2 = signrank(MAC1, MAC2);
pwC1_2 = pwC1_2*3; %bonferoni correction for multiple comparasions

pwC1_3 = signrank(MAC1, MAC3);
pwC1_3 = pwC1_3*3; 

pwC2_3 = signrank(MAC2, MAC3);
pwC2_3 = pwC2_3*3; 

acc.within_comparasion.Control.w_test.pC1_2 = pwC1_2;
acc.within_comparasion.Control.w_test.pC1_3 = pwC1_3;
acc.within_comparasion.Control.w_test.pC2_3 = pwC2_3;

% calculating the relative effect size by relative mean difference 

MMAC1 = mean (MAC1);
MMAC2 = mean (MAC2);
MMAC3 = mean (MAC3);

eC1_2 = (MMAC2 * 100)/MMAC1;
eC1_3 = (MMAC3 * 100)/MMAC1;
eC2_3 = (MMAC3 * 100)/MMAC2;

acc.within_comparasion.Control.effect_size.relative.eC1_2 = eC1_2;
acc.within_comparasion.Control.effect_size.relative.eC1_3 = eC1_3;
acc.within_comparasion.Control.effect_size.relative.eC2_3 = eC2_3;

% Calculating Hedge's g effect size values

mesC1_2 = mes(MAC2.',MAC1.','hedgesg', 'isDep',1);
mesC1_3 = mes(MAC3.',MAC1.','hedgesg','isDep',1);
mesC2_3 = mes(MAC3.',MAC2.','hedgesg', 'isDep',1);

hgC1_2 = mesC1_2.hedgesg;
hgC1_3 = mesC1_3.hedgesg;
hgC2_3 = mesC2_3.hedgesg;

acc.within_comparasion.Control.effect_size.hedges_g.hgC1_2 = hgC1_2;
acc.within_comparasion.Control.effect_size.hedges_g.hgC1_3 = hgC1_3;
acc.within_comparasion.Control.effect_size.hedges_g.hgC2_3 = hgC2_3;

% Calculating Cohen's U3 

 mesUC1_2 = mes(MAC2.',MAC1.','U3');
 mesUC1_3 = mes(MAC3.',MAC1.','U3');
 mesUC2_3 = mes(MAC3.',MAC2.','U3');

U3C_1_2 = mesUC1_2.U3;
U3C_1_3 = mesUC1_3.U3;
U3C_2_3 = mesUC2_3.U3;

acc.within_comparasion.Control.effect_size.U3.U3C_1_2 = U3C_1_2;
acc.within_comparasion.Control.effect_size.U3.U3C_1_3 = U3C_1_3;
acc.within_comparasion.Control.effect_size.U3.U3C_2_3 = U3C_2_3;


%%% LTPB Group

%Boxplot

x_name = '';
y_name = "Accuracy";
tit = 'Distribution of the Accuracy of the LTPB Group in each block';
sig_dif = 1;
test = 0;
acsis = [];
d_L = [MAL1 MAL2 MAL3];
grp2 = [ones(1,LTPB_n),2*ones(1,LTPB_n),3*ones(1,LTPB_n)];

figure
sbox_conection(grp2', d_L',  x_name, y_name, tit, {'1st Block'; '2nd Block'; '3rd Block'}, sig_dif, test, acsis)
ylim([0 1])
yticks([0:0.2:1])
xticks([1 2 3])
xticklabels({'1st Block', '2nd Block', '3rd Block'})
xline(2.5)
xline(1.5)


% Checking normality of the data samples

[~,~,pL1] = swtest_norm(MAL1.'); %Shapiro-Wilk test.
[~,~,pL2] = swtest_norm(MAL2.');
[~,~,pL3] = swtest_norm(MAL3.');

acc.within_comparasion.LTPB.assumption_check.norm_check.pL1 = pL1;
acc.within_comparasion.LTPB.assumption_check.norm_check.pL2 = pL2;
acc.within_comparasion.LTPB.assumption_check.norm_check.pL3 = pL3;

% F-test to check if the population variances are equal.

[~, pLF1_2] = vartest2 (MAL1, MAL2);
[~, pLF1_3] = vartest2 (MAL1, MAL3);
[~, pLF2_3] = vartest2 (MAL2, MAL3);

acc.within_comparasion.LTPB.assumption_check.var_check.pLF1_2 = pLF1_2;
acc.within_comparasion.LTPB.assumption_check.var_check.pLF1_3 = pLF1_3;
acc.within_comparasion.LTPB.assumption_check.var_check.pLF2_3 = pLF2_3;

% Making a Repeated Measures Model

M_L = [MAL1.' MAL2.' MAL3.'];

a_L = table(M_L(:,1),M_L(:,2),M_L(:,3),... %the three dots indicate that the function continues in the next line
'VariableNames',{'Block1','Block2','Block3'});
wd_L = table([1 2 3]','VariableNames',{'Blocks'});

rm_L = fitrm(a_L,'Block1-Block3~1','WithinDesign',wd_L);

% Repeated Measures ANOVA

ranovatbl_L = ranova(rm_L);

% Mauchly test for sphericity

mauchly_test_L = mauchly(rm_L); 

if table2array(mauchly_test_L(1,4)) < 0.05
    p_anova_L = table2array(ranovatbl_L(1,6)); %correcting the p-value if the sphericity condition isn't met.
else
    p_anova_L = table2array(ranovatbl_L(1,5));
end


acc.within_comparasion.LTPB.rep_meas_anova.p_anova_L = p_anova_L;
acc.within_comparasion.LTPB.rep_meas_anova.ranovatbl_L = ranovatbl_L;

% Doing the paired t-test with bonferroni correction

[~,pL12] = ttest(MAL1, MAL2);
pL1_2 = pL12*3; %bonferoni correction for multiple comparasions

[~,pL13] = ttest(MAL1, MAL3);
pL1_3 = pL13*3; 

[~,pL23] = ttest(MAL2, MAL3);
pL2_3 = pL23*3; %bonferoni correction for multiple comparasions

acc.within_comparasion.LTPB.t_test.pL1_2 = pL1_2;
acc.within_comparasion.LTPB.t_test.pL1_3 = pL1_3;
acc.within_comparasion.LTPB.t_test.pL2_3 = pL2_3;

% Friedman test (alternative to the one way repeated measures ANOVA)

[pFri_L,Fritbl_L] = friedman(M_L, 1,'off'); 

acc.within_comparasion.LTPB.Friedman_test.pFri_L = pFri_L;
acc.within_comparasion.LTPB.Friedman_test.Fritbl_L = Fritbl_L;

% Signed rank Wilcoxon test with bonferroni correction.

pwL1_2 = signrank(MAL1, MAL2);
pwL1_2 = pwL1_2*3; %bonferoni correction for multiple comparasions

pwL1_3 = signrank(MAL1, MAL3);
pwL1_3 = pwL1_3*3; 

pwL2_3 = signrank(MAL2, MAL3);
pwL2_3 = pwL2_3*3; 

acc.within_comparasion.LTPB.w_test.pL1_2 = pwL1_2;
acc.within_comparasion.LTPB.w_test.pL1_3 = pwL1_3;
acc.within_comparasion.LTPB.w_test.pL2_3 = pwL2_3;

% calculating the relative effect size by relative mean difference 

MMAL1 = mean (MAL1);
MMAL2 = mean (MAL2);
MMAL3 = mean (MAL3);

eL1_2 = (MMAL2 * 100)/MMAL1;
eL1_3 = (MMAL3 * 100)/MMAL1;
eL2_3 = (MMAL3 * 100)/MMAL2;

acc.within_comparasion.LTPB.effect_size.relative.eL1_2 = eL1_2;
acc.within_comparasion.LTPB.effect_size.relative.eL1_3 = eL1_3;
acc.within_comparasion.LTPB.effect_size.relative.eL2_3 = eL2_3;

% Calculating Hedge's g effect size values

mesL1_2 = mes(MAL2.',MAL1.','hedgesg', 'isDep',1);
mesL1_3 = mes(MAL3.',MAL1.','hedgesg', 'isDep',1);
mesL2_3 = mes(MAL3.',MAL2.','hedgesg', 'isDep',1);

hgL1_2 = mesL1_2.hedgesg;
hgL1_3 = mesL1_3.hedgesg;
hgL2_3 = mesL2_3.hedgesg;

acc.within_comparasion.LTPB.effect_size.hedges_g.hgL1_2 = hgL1_2;
acc.within_comparasion.LTPB.effect_size.hedges_g.hgL1_3 = hgL1_3;
acc.within_comparasion.LTPB.effect_size.hedges_g.hgL2_3 = hgL2_3;

% Calculating Cohen's U3 

 mesUL1_2 = mes(MAL2.',MAL1.','U3');
 mesUL1_3 = mes(MAL3.',MAL1.','U3');
 mesUL2_3 = mes(MAL3.',MAL2.','U3');

U3L_1_2 = mesUL1_2.U3;
U3L_1_3 = mesUL1_3.U3;
U3L_2_3 = mesUL2_3.U3;

acc.within_comparasion.LTPB.effect_size.U3.U3L_1_2 = U3L_1_2;
acc.within_comparasion.LTPB.effect_size.U3.U3L_1_3 = U3L_1_3;
acc.within_comparasion.LTPB.effect_size.U3.U3L_2_3 = U3L_2_3;

%%% Global comparasion


for par = 1:(size(data_control,1)/1000)
     GAC(par) = mean(AC{par}); 
end

for par = 1:(size(data_LTPB,1)/1000)
     GAL(par) = mean(AL{par}); 
end

acc.Accuracy.Control.global = GAC;
acc.Accuracy.LTPB.global = GAL;

%Boxplot

AG = [GAC GAL];

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[zeros(1,control_n),ones(1,LTPB_n)]; 

figure

BRTG = boxplot(AG,grp); 

title('Distribution of the Accuracy of each group considering the whole experiment');
ylabel("Accuracy");
ylim([0 1])
yticks([0:0.2:1])
xticks([1 2])
xticklabels({'Control','LTPB'})
xline(1.5)



figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14


% Checking normality of the data samples

[~,~,pGC] = swtest_norm(GAC.'); 
[~,~,pGL] = swtest_norm(GAL.');


acc.global_comparasion.assumption_check.norm_check.pGC = pGC;
acc.global_comparasion.assumption_check.norm_check.pGL = pGL;


% Check if the variances are equal between each distribuction

[~, pFG] = vartest2 (GAC, GAL);


acc.global_comparasion.assumption_check.var_check.pFG = pFG;

%statiscal comparassion - Parametric

[~, pG] = ttest2 (GAC, GAL); % doing the 2-sample t-test.


acc.global_comparasion.t_test.pG = pG;

%statiscal comparassion - Non - parametric

[wpG] = ranksum (GAC, GAL);  %wilcoxon rank sum test

acc.global_comparasion.w_test.pG = wpG;


% calculating the relative effect size by relative mean difference

MGAC = mean (GAC);
MGAL = mean (GAL);


eG = (MGAL * 100)/MGAC;

acc.global_comparasion.effect_size.relative.eG = eG;

% Calculating Hedge's g effect size values

mesG = mes(GAL.',GAC.','hedgesg');

hgG = mes1.hedgesg;

acc.global_comparasion.effect_size.hedges_g.hgG = hgG;

% Calculating Cohen's U3 

mesUG = mes(GAC.',GAL.','U3');

U3G = mesUG.U3;

acc.global_comparasion.effect_size.U3.U3G = U3G;


end
