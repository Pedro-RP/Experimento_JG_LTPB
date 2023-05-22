function [PES] = PES_LTPB (data_control, data_LTPB, from_t, to_t, steps, limit_range, pathtogit)


data_control(:, 12)  = 1;
data_LTPB (:, 12) = 1;
subgroup = 1;
reatribute = 1;
tau = 12; 

x_name = '';
y_name = "Mean RT(Failure) - Mean RT (Success)";
sig_dif = 1;
test = 0;
acsis = [];


control_n = (size(data_control,1)/1000) ;
LTPB_n = (size(data_LTPB,1)/1000);

%Control Group

data_summaryC = erroreffectpropagation_analysis(data_control, subgroup, reatribute, pathtogit, tau, from_t, to_t, limit_range, steps);

for par = 1:control_n
    for ctx = 1:5
        successC{ctx}(par) = mean (data_summaryC.successes_repository{par,ctx});
        failureC{ctx}(par) = mean(data_summaryC.failures_repository{par,ctx});
    end
end

PES.data.control.success = successC;
PES.data.control.failure = failureC;

%LTPB Group

data_summaryL = erroreffectpropagation_analysis(data_LTPB, subgroup, reatribute, pathtogit, tau, from_t, to_t, limit_range, steps);
for par = 1:LTPB_n
    for ctx = 1:5
        successL{ctx}(par) = mean (data_summaryL.successes_repository{par,ctx});
        failureL{ctx}(par) = mean(data_summaryL.failures_repository{par,ctx});
    end
end

PES.data.LTPB.success = successL;
PES.data.LTPB.failure = failureL;

%% Analysis comparing the magnitude of the post error difference between each group

for par = 1: control_n
    for ctx = 1:5
        magC{ctx}(par) = failureC{ctx}(par) - successC {ctx}(par); %difference between the means of failures and successes
    end
end

for par = 1: LTPB_n
    for ctx = 1:5
        magL{ctx}(par) = failureL{ctx}(par) - successL {ctx}(par);
    end
end

% Making boxplots

for ctx = 1:5
    if ctx == 1
        ctxw = '0';
        stepctx = steps(ctx);
    elseif ctx == 2
        ctxw = '01';
        stepctx = steps(ctx);
    elseif ctx == 3
        ctxw = '11';
        stepctx = steps(ctx);
    elseif ctx == 4
        ctxw = '21';
        stepctx = steps(ctx);
    elseif ctx == 5
        ctxw = '2';
        stepctx = steps(ctx);
    end

tit = append('Error analysis (','w = ', ctxw, ' / step = ', num2str(stepctx), ' / ', num2str(from_t), '-', num2str(to_t),')');
grp = [ones(1,control_n),2*ones(1, LTPB_n)];

d_M = [magC{ctx} magL{ctx}];

figure
sbox_comp(grp', d_M',  x_name, y_name, tit,{}, sig_dif, test, acsis)
xticklabels({'Control','LTPB'});
yline(0)
ylim([-0.8 0.8])
yticks(-0.8:0.1:0.8)

end

PES.data.control.magnitude = magC;
PES.data.LTPB.magnitude = magL;

% Checking normality of the data samples

[~,~,pC0] = swtest_norm(magC{1}.'); %Shapiro-Wilk test.
PES.assumption_check.normality_check.control.pC0 = pC0; 

[~,~,pC01] = swtest_norm(magC{2}.'); 
PES.assumption_check.normality_check.control.pC01 = pC01; 

[~,~,pC11] = swtest_norm(magC{3}.'); 
PES.assumption_check.normality_check.control.pC11 = pC11; 

[~,~,pC21] = swtest_norm(magC{4}.'); 
PES.assumption_check.normality_check.control.pC21 = pC21; 

[~,~,pC2] = swtest_norm(magC{5}.'); 
PES.assumption_check.normality_check.control.pC2 = pC2; 

[~,~,pL0] = swtest_norm(magL{1}.'); %Shapiro-Wilk test.
PES.assumption_check.normality_check.LTPB.pL0 = pL0; 

[~,~,pL01] = swtest_norm(magL{2}.'); 
PES.assumption_check.normality_check.LTPB.pL01 = pL01; 

[~,~,pL11] = swtest_norm(magL{3}.'); 
PES.assumption_check.normality_check.LTPB.pL11 = pL11; 

[~,~,pL21] = swtest_norm(magL{4}.'); 
PES.assumption_check.normality_check.LTPB.pL21 = pL21; 

[~,~,pL2] = swtest_norm(magL{5}.'); 
PES.assumption_check.normality_check.LTPB.pL2 = pL2; 

% Checking equality of variances

[~, pF0] = vartest2 (magC{1}, magL{1});
PES.assumption_check.var_check.pF0 = pF0; 

[~, pF01] = vartest2 (magC{2}, magL{2});
PES.assumption_check.var_check.pF01 = pF01; 

[~, pF11] = vartest2 (magC{3}, magL{3});
PES.assumption_check.var_check.pF11 = pF11; 

[~, pF21] = vartest2 (magC{4}, magL{4});
PES.assumption_check.var_check.pF21 = pF21; 

[~, pF2] = vartest2 (magC{5}, magL{5});
PES.assumption_check.var_check.pF2 = pF2; 

%statiscal comparassion -> Non - parametric / (equal variances assumed)

[wp0] = ranksum (magC{1}, magL{1});
PES.ranksum.w0 = wp0;

[wp01] = ranksum (magC{2}, magL{2});
PES.ranksum.w01 = wp01;

[wp11] = ranksum (magC{3}, magL{3});
PES.ranksum.w11 = wp11;

[wp21] = ranksum (magC{4}, magL{4});
PES.ranksum.w21 = wp21;

[wp2] = ranksum (magC{5}, magL{5});
PES.ranksum.w2 = wp2;

% Calculating Cohen's U3 (nonparametric effect size measure)

 mesw0 = mes(magC{1}.',magL{1}.','U3');
 PES.U3.w0 = mesw0.U3;
 
 mesw01 = mes(magC{2}.',magL{2}.','U3');
 PES.U3.w01 = mesw01.U3;
 
 mesw11 = mes(magC{3}.',magL{3}.','U3');
 PES.U3.w11 = mesw11.U3;
 
 mesw21 = mes(magC{4}.',magL{4}.','U3');
 PES.U3.w21 = mesw21.U3;
 
 mesw2 = mes(magC{5}.',magL{5}.','U3');
 PES.U3.w2 = mesw2.U3;
 
 % Comparing each magnitude distribution to a population with median 0 to
 % see if there is an effect
 
[wC0] =  signrank(magC{1});
PES.zero_comparasion.control.w0 = wC0;

[wC01] =  signrank(magC{2});
PES.zero_comparasion.control.w01 = wC01;

[wC11] =  signrank(magC{3});
PES.zero_comparasion.control.w11 = wC11;

[wC21] =  signrank(magC{4});
PES.zero_comparasion.control.w21 = wC21;

[wC2] =  signrank(magC{5});
PES.zero_comparasion.control.w2 = wC2;
 
[wL0] =  signrank(magL{1});
PES.zero_comparasion.LTPB.w0 = wL0;

[wL01] =  signrank(magL{2});
PES.zero_comparasion.LTPB.w01 = wL01;

[wL11] =  signrank(magL{3});
PES.zero_comparasion.LTPB.w11 = wL11;

[wL21] =  signrank(magL{4});
PES.zero_comparasion.LTPB.w21 = wL21;

[wL2] =  signrank(magL{5});
PES.zero_comparasion.LTPB.w2 = wL2;


%% Analysis comparing successes and failures of each group for each context (inside each group)

% 
% % Control
% 
% group = 'Control';
% grp = [ones(1,control_n),2*ones(1, control_n)];
% 
% for ctx = 1:5
%     if ctx == 1
%         ctxw = '0';
%         stepctx = steps(ctx);
%     elseif ctx == 2
%         ctxw = '01';
%         stepctx = steps(ctx);
%     elseif ctx == 3
%         ctxw = '11';
%         stepctx = steps(ctx);
%     elseif ctx == 4
%         ctxw = '21';
%         stepctx = steps(ctx);
%     elseif ctx == 5
%         ctxw = '2';
%         stepctx = steps(ctx);
%     end
%     
% tit = append('Error analysis - ', group, ' / w = ', ctxw, ' / step = ', num2str(stepctx), ' / ', num2str(from_t), '-', num2str(to_t));
% 
% d_C = [successC{ctx} failureC{ctx}];
% 
% figure
% sbox_conection(grp', d_C',  x_name, y_name, tit, {'Success'; 'Failure';}, sig_dif, test, acsis)
% xline(1.5)
% ylim([0 2.5])
% yticks(0:0.2:2.5)
% 
%        
% end
% 
% %LTPB
% 
% group = 'LTPB';
% grp = [ones(1,LTPB_n),2*ones(1, LTPB_n)];
% 
% for ctx = 1:5
%     if ctx == 1
%         ctxw = '0';
%         stepctx = steps(ctx);
%     elseif ctx == 2
%         ctxw = '01';
%         stepctx = steps(ctx);
%     elseif ctx == 3
%         ctxw = '11';
%         stepctx = steps(ctx);
%     elseif ctx == 4
%         ctxw = '21';
%         stepctx = steps(ctx);
%     elseif ctx == 5
%         ctxw = '2';
%         stepctx = steps(ctx);
%     end
%     
% tit = append('Error analysis - ', group, ' / w = ', ctxw, ' / step = ', num2str(stepctx), ' / ', num2str(from_t), '-', num2str(to_t));
% 
% d_L = [successL{ctx} failureL{ctx}];
% 
% figure
% sbox_conection(grp', d_L',  x_name, y_name, tit, {'Success'; 'Failure';}, sig_dif, test, acsis)
% xline(1.5)
% ylim([0 2.5])
% yticks(0:0.2:2.5)
%        
% end
end