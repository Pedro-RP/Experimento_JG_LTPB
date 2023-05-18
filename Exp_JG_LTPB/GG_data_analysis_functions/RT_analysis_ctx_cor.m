function [rt] = RT_analysis_ctx_cor(data_control, data_LTPB)

%%Block 1

%Control

[~, mctxs_RT_control, ctxs_propC, mctxs_RT_LTPB, ctxs_propL] =  comp_ctx (data_control, data_LTPB, 1, 334, 0);

for par = 1:(size(data_control,1)/1000)
    MRTC1(par) = 0;
   for ctx_row = 1:5
        MRTC1(par) = MRTC1(par) + (mctxs_RT_control{ctx_row}(par) * ctxs_propC{ctx_row}(par));
   end
end

%LTPB

for par = 1:(size(data_LTPB,1)/1000)
    MRTL1(par) = 0;
   for ctx_row = 1:5
        MRTL1(par) = MRTL1(par) + (mctxs_RT_LTPB{ctx_row}(par) * ctxs_propL{ctx_row}(par));
   end
end

%%Block 2 

[~, mctxs_RT_control, ctxs_propC, mctxs_RT_LTPB, ctxs_propL] =  comp_ctx (data_control, data_LTPB, 335, 668, 0);

% Control

for par = 1:(size(data_control,1)/1000)
    MRTC2(par) = 0;
   for ctx_row = 1:5
        MRTC2(par) = MRTC2(par) + (mctxs_RT_control{ctx_row}(par) * ctxs_propC{ctx_row}(par));
   end
end


% LTPB

for par = 1:(size(data_LTPB,1)/1000)
    MRTL2(par) = 0;
   for ctx_row = 1:5
        MRTL2(par) = MRTL2(par) + (mctxs_RT_LTPB{ctx_row}(par) * ctxs_propL{ctx_row}(par));
   end
end

% Block 3 

[~, mctxs_RT_control, ctxs_propC, mctxs_RT_LTPB, ctxs_propL] =  comp_ctx (data_control, data_LTPB, 669, 1000, 0);

% Control

for par = 1:(size(data_control,1)/1000)
    MRTC3(par) = 0;
   for ctx_row = 1:5
        MRTC3(par) = MRTC3(par) + (mctxs_RT_control{ctx_row}(par) * ctxs_propC{ctx_row}(par));
   end
end


% LTPB

for par = 1:(size(data_LTPB,1)/1000)
    MRTL3(par) = 0;
   for ctx_row = 1:5
        MRTL3(par) = MRTL3(par) + (mctxs_RT_LTPB{ctx_row}(par) * ctxs_propL{ctx_row}(par));
   end
end

rt.response_times.Control.block_1 = MRTC1;
rt.response_times.Control.block_2 = MRTC2;
rt.response_times.Control.block_3 = MRTC3;
rt.response_times.LTPB.block_1 = MRTL1;
rt.response_times.LTPB.block_2 = MRTL2;
rt.response_times.LTPB.block_3 = MRTL3;

%%% Comparation between groups

%Boxplot
MRT1=[MRTC1 MRTL1]; %Mean response times block 1
MRT2=[MRTC2 MRTL2];
MRT3=[MRTC3 MRTL3];
MRTF = [MRT1 MRT2 MRT3]; %Mean Response Times Full -> arrange the data in a single vector so the boxplot function can work.

control_n = (size(data_control,1)/1000) ;
LTPB_n = (size(data_LTPB,1)/1000); %number of participants in each group

grp =[ones(1,control_n),2*ones(1,LTPB_n),3*ones(1,control_n),4*ones(1,LTPB_n),5*ones(1,control_n),6*ones(1,LTPB_n)]; %grouping variable. 

x_name = '';
y_name = "Mean Response Time(s)";
tit = 'Distribution of the Mean Response Times of each group in each block';
sig_dif = 1;
test = 0;
acsis = [];

figure
sbox_comp(grp', MRTF',  x_name, y_name, tit,{}, sig_dif, test, acsis)
xline(2.5)
xline(4.5)
ylim([0 2.5])
yticks([0:0.2:2.5])
xticks([1 2 3 4 5 6])
xticklabels({'1st Block - Control','1st Block - LTPB', '2nd Block - Control', '2nd Block - LTPB','3rd Block - Control', '3rd Block - LTPB'})
xlim([0.5 7])


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

%statiscal comparassion -> Parametric

[~, pb1] = ttest2 (MRTC1, MRTL1); % doing the 2-sample t-test for each block.
[~, pb2] = ttest2 (MRTC2, MRTL2);
[~, pb3] = ttest2 (MRTC3, MRTL3);

rt.between_comparasion.t_test.pb1 = pb1;
rt.between_comparasion.t_test.pb2 = pb2;
rt.between_comparasion.t_test.pb3 = pb3;

%statiscal comparassion -> Non - parametric / (equal variances assumed)

[wpb1] = ranksum (MRTC1, MRTL1);  %wilcoxon rank sum test
[wpb2] = ranksum (MRTC2, MRTL2);
[wpb3] = ranksum (MRTC3, MRTL3);

rt.between_comparasion.w_test.pb1 = wpb1;
rt.between_comparasion.w_test.pb2 = wpb2;
rt.between_comparasion.w_test.pb3 = wpb3;


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

% Calculating Cohen's U3 (nonparametric effect size measure)

 mesU1 = mes(MRTC1.',MRTL1.','U3');
 mesU2 = mes(MRTC2.',MRTL2.','U3');
 mesU3 = mes(MRTC3.',MRTL3.','U3');

U3_1 = mesU1.U3;
U3_2 = mesU2.U3;
U3_3 = mesU3.U3;

rt.between_comparasion.effect_size.U3.U3_1 = U3_1;
rt.between_comparasion.effect_size.U3.U3_2 = U3_2;
rt.between_comparasion.effect_size.U3.U3_3 = U3_3;

%%% Comparation Within Groups

%% Control Group

%Boxplot

d_C = [MRTC1 MRTC2 MRTC3]; 
grp2 = [ones(1,control_n),2*ones(1, control_n),3*ones(1,control_n)];

x_name = '';
y_name = "Mean Response Time(s)";
tit = 'Distribution of the Mean Response Times of the Control group in each block';
sig_dif = 1;
test = 0;
acsis = [];

figure
sbox_conection(grp2', d_C',  x_name, y_name, tit,{'1st Block'; '2nd Block'; '3rd Block'}, sig_dif, test, acsis)
xline(2.5)
xline(1.5)
ylim([0 2.5])
yticks([0:0.2:2.5])

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

%% Non-parametric tests

% Friedman test (alternative to the one way repeated measures ANOVA)

[pFri_C,Fritbl_C] = friedman(M_C,1,'off'); 

rt.within_comparasion.Control.Friedman_test.pFri_C = pFri_C;
rt.within_comparasion.Control.Friedman_test.Fritbl_C = Fritbl_C;

% Signed rank Wilcoxon test with bonferroni correction. p-values higher than
% 1 should be interpreted as 1.

pwC1_2 = signrank(MRTC1, MRTC2);
pwC1_2 = pwC1_2*3; %bonferoni correction for multiple comparasions

pwC1_3 = signrank(MRTC1, MRTC3);
pwC1_3 = pwC1_3*3; 

pwC2_3 = signrank(MRTC2, MRTC3);
pwC2_3 = pwC2_3*3; 

rt.within_comparasion.Control.w_test.pC1_2 = pwC1_2;
rt.within_comparasion.Control.w_test.pC1_3 = pwC1_3;
rt.within_comparasion.Control.w_test.pC2_3 = pwC2_3;

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

mesC1_2 = mes(MRTC1.',MRTC2.','hedgesg', 'isDep',1);
mesC1_3 = mes(MRTC1.',MRTC3.','hedgesg', 'isDep',1);
mesC2_3 = mes(MRTC2.',MRTC3.','hedgesg', 'isDep',1);

hgC1_2 = mesC1_2.hedgesg;
hgC1_3 = mesC1_3.hedgesg;
hgC2_3 = mesC2_3.hedgesg;

rt.within_comparasion.Control.effect_size.hedges_g.hgC1_2 = hgC1_2;
rt.within_comparasion.Control.effect_size.hedges_g.hgsC1_3 = hgC1_3;
rt.within_comparasion.Control.effect_size.hedges_g.hgC2_3 = hgC2_3;

% Calculating Cohen's U3 

 mesUC1_2 = mes(MRTC2.',MRTC1.','U3');
 mesUC1_3 = mes(MRTC3.',MRTC1.','U3');
 mesUC2_3 = mes(MRTC3.',MRTC2.','U3');

U3C_1_2 = mesUC1_2.U3;
U3C_1_3 = mesUC1_3.U3;
U3C_2_3 = mesUC2_3.U3;

rt.within_comparasion.Control.effect_size.U3.U3C_1_2 = U3C_1_2;
rt.within_comparasion.Control.effect_size.U3.U3C_1_3 = U3C_1_3;
rt.within_comparasion.Control.effect_size.U3.U3C_2_3 = U3C_2_3;



%% LTPB Group

%Boxplot

d_L = [MRTL1 MRTL2 MRTL3]; 
grp2 = [ones(1,LTPB_n),2*ones(1, LTPB_n),3*ones(1,LTPB_n)];

x_name = '';
y_name = "Mean Response Time(s)";
tit = 'Distribution of the Mean Response Times of the LTPB group in each block';
sig_dif = 1;
test = 0;
acsis = [];

figure
sbox_conection(grp2', d_L',  x_name, y_name, tit,{'1st Block'; '2nd Block'; '3rd Block'}, sig_dif, test, acsis)
xline(2.5)
xline(1.5)
ylim([0 2.5])
yticks([0:0.2:2.5])

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

%% Non-parametric tests

% Friedman test (alternative to the one way repeated measures ANOVA)

[pFri_L,Fritbl_L] = friedman(M_L,1,'off'); 

rt.within_comparasion.LTPB.Friedman_test.pFri_L = pFri_L;
rt.within_comparasion.LTPB.Friedman_test.Fritbl_L = Fritbl_L;

% Signed rank Wilcoxon test with bonferroni correction.

pwL1_2 = signrank(MRTL1, MRTL2);
pwL1_2 = pwL1_2*3; %bonferoni correction for multiple comparasions

pwL1_3 = signrank(MRTL1, MRTL3);
pwL1_3 = pwL1_3*3; 

pwL2_3 = signrank(MRTL2, MRTL3);
pwL2_3 = pwL2_3*3; 

rt.within_comparasion.LTPB.w_test.pL1_2 = pwL1_2;
rt.within_comparasion.LTPB.w_test.pL1_3 = pwL1_3;
rt.within_comparasion.LTPB.w_test.pL2_3 = pwL2_3;


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

mesL1_2 = mes(MRTL1.',MRTL2.','hedgesg', 'isDep',1);
mesL1_3 = mes(MRTL1.',MRTL3.','hedgesg', 'isDep',1);
mesL2_3 = mes(MRTL2.',MRTL3.','hedgesg', 'isDep',1);

hgL1_2 = mesL1_2.hedgesg;
hgL1_3 = mesL1_3.hedgesg;
hgL2_3 = mesL2_3.hedgesg;

rt.within_comparasion.LTPB.effect_size.hedges_g.hgL1_2 = hgL1_2;
rt.within_comparasion.LTPB.effect_size.hedges_g.hgL1_3 = hgL1_3;
rt.within_comparasion.LTPB.effect_size.hedges_g.hgL2_3 = hgL2_3;

% Calculating Cohen's U3 

 mesUL1_2 = mes(MRTL2.',MRTL1.','U3');
 mesUL1_3 = mes(MRTL3.',MRTL1.','U3');
 mesUL2_3 = mes(MRTL3.',MRTL2.','U3');

U3L_1_2 = mesUL1_2.U3;
U3L_1_3 = mesUL1_3.U3;
U3L_2_3 = mesUL2_3.U3;

rt.within_comparasion.LTPB.effect_size.U3.U3L_1_2 = U3L_1_2;
rt.within_comparasion.LTPB.effect_size.U3.U3L_1_3 = U3L_1_3;
rt.within_comparasion.LTPB.effect_size.U3.U3L_2_3 = U3L_2_3;


%%% Global comparasion

[~, mctxs_RT_control, ctxs_propC, mctxs_RT_LTPB, ctxs_propL] =  comp_ctx (data_control, data_LTPB, 1, 1000, 0);

for par = 1:(size(data_control,1)/1000)
    GTMC(par) = 0;
   for ctx_row = 1:5
        GTMC(par) = GTMC(par) + (mctxs_RT_control{ctx_row}(par) * ctxs_propC{ctx_row}(par));
   end
end

%LTPB

for par = 1:(size(data_LTPB,1)/1000)
    GTML(par) = 0;
   for ctx_row = 1:5
        GTML(par) = GTML(par) + (mctxs_RT_LTPB{ctx_row}(par) * ctxs_propL{ctx_row}(par));
   end
end



rt.response_times.Control.global = GTMC;
rt.response_times.LTPB.global = GTML;

%Boxplot

RTG = [GTMC GTML];

grp3 =[ones(1,control_n),2*ones(1,LTPB_n)]; 

x_name = '';
y_name = "Mean Response Time (s)";
tit = 'Distribution of the Mean Response Times of each group considering the whole experiment';
sig_dif = 1;
test = 0;
acsis = [];

figure
sbox_comp(grp3', RTG',  x_name, y_name, tit,{}, sig_dif, test, acsis)
ylim([0 2.5])
yticks([0:0.2:2.5])
xline(1.5)
xticks([1 2])
xticklabels({'Control','LTPB'})


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

%statiscal comparassion - Non - parametric

[wpG] = ranksum (GTMC, GTML);  %wilcoxon rank sum test

rt.global_comparasion.w_test.pG = wpG;

% calculating the relative effect size by relative mean difference

MGTMC = mean (GTMC);
MGTML = mean (GTML);

eG = (MGTML * 100)/MGTMC;

rt.global_comparasion.effect_size.relative.eG = eG;

% Calculating Hedge's g effect size values

mesG = mes(GTML.',GTMC.','hedgesg');

hgG = mes1.hedgesg;

rt.global_comparasion.effect_size.hedges_g.hgG = hgG;

% Calculating Cohen's U3 

mesUG = mes(GTMC.',GTML.','U3');

U3G = mesUG.U3;

rt.global_comparasion.effect_size.U3.U3G = U3G;

end