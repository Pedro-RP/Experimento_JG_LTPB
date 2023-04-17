% [stats, mctxs_RT_control, mctxs_RT_LTPB] =  comp_ctx (data_control, data_LTPB, from_t, to_t)
%
% This function compares the mean reaction times (RTs) of both groups
% according to each specific context. One boxplot for each comparasion is
% generated and a struct containg information regarding statistc tests is
% generated.
%
% INPUT:
%
% data_control = data matrix from the control group.
%
% data_ltpb = data matrix from the LTPB group.
%
% from_t = starting trial of the interval of trials you wish to analyze.
%
% to_t = finishing trial of the interval of trials you wish to analyze.
%
% OUTPUT:
% 
% stats =  structure containing the statistical tests for the comparasions
% between the mean RTs of the groups for each contexts. The test used was
% the wilcoxon ranksum test and the effect size measure was Cohen's
% U3. Parametric test assumptions are tested.
%
% mctxs_RT_control = list containg all of the mean RTs of the control group
% members grouped by context. Each one of the 5 columns is a context, in
% the order: 0, 01, 11, 21, 2. Ex: The first column contain a list of the
% mean RTs of the participants of the control group on the context 0.
% 
% mctxs_RT_LTPB = list containg all of the mean RTs of the LTPB group
% members grouped by context. Each one of the 5 columns is a context, in
% the order: 0, 01, 11, 21, 2.
%
% 17/04/2023 by Pedro R. Pinheiro

function [stats, mctxs_RT_control, mctxs_RT_LTPB] =  comp_ctx (data_control, data_LTPB, from_t, to_t)

control_n = (size(data_control,1)/1000) ;
LTPB_n = (size(data_LTPB,1)/1000);
sig_dif = 1;
test = 0;
acsis = [];
x_name = '';
y_name = "Mean Response Time (s)";
grp =[ones(1,control_n),2*ones(1,LTPB_n)]; 
mctxs_RT_control  = [];
mctxs_RT_LTPB = [];

for ctx_row = 1:5 %number of contexts

    if ctx_row == 1 %w=0
        [mctx_RT_control, mctx_RT_LTPB] = create_mean_RTs_ctx (data_control, data_LTPB, from_t, to_t, ctx_row);
        
        mctxs_RT_control {ctx_row} = mctx_RT_control; %building two variables with the mean RRT values for all the contexts
        mctxs_RT_LTPB {ctx_row} = mctx_RT_LTPB;
        
        [~,~,pC] = swtest_norm(mctx_RT_control.'); 
        stats.w0.assumption_check.norm_check.pC = pC;
        
        [~,~,pL] = swtest_norm(mctx_RT_LTPB.');
        stats.w0.assumption_check.norm_check.pL = pL;
        
        [~, pF] = vartest2 (mctx_RT_control, mctx_RT_LTPB);
        stats.w0.assumption_check.var_check.pF = pF;
        
        [wpG] = ranksum (mctx_RT_control, mctx_RT_LTPB);  %wilcoxon rank sum test
        stats.w0.w_test.p = wpG;
        
        mesU = mes(mctx_RT_control.',mctx_RT_LTPB.','U3');
        U3 = mesU.U3;
        stats.w0.effect_size.U3 = U3;
        
        RTC = [mctx_RT_control mctx_RT_LTPB];
        tit = append('Distribution of the Mean Response Times of each group for w = 0',' (', num2str(from_t), '-',num2str(to_t),')');
        figure
        sbox_comp(grp', RTC',  x_name, y_name, tit,{}, sig_dif, test, acsis)
        ylim([0 2.5])
        yticks([0:0.2:2.5])
        xline(1.5)
        xticks([1 2])
        xticklabels({'Control','LTPB'})
    end
if ctx_row == 2 %w=01
        [mctx_RT_control, mctx_RT_LTPB] = create_mean_RTs_ctx (data_control, data_LTPB, from_t, to_t, ctx_row);
        
        mctxs_RT_control {ctx_row} = mctx_RT_control;
        mctxs_RT_LTPB {ctx_row} = mctx_RT_LTPB;
        
        [~,~,pC] = swtest_norm(mctx_RT_control.'); 
        stats.w01.assumption_check.norm_check.pC = pC;
        
        [~,~,pL] = swtest_norm(mctx_RT_LTPB.');
        stats.w01.assumption_check.norm_check.pL = pL;
        
        [~, pF] = vartest2 (mctx_RT_control, mctx_RT_LTPB);
        stats.w01.assumption_check.var_check.pF = pF;
        
        [wpG] = ranksum (mctx_RT_control, mctx_RT_LTPB);  %wilcoxon rank sum test
        stats.w01.w_test.p = wpG;
        
        mesU = mes(mctx_RT_control.',mctx_RT_LTPB.','U3');
        U3 = mesU.U3;
        stats.w01.effect_size.U3 = U3;
        
        RTC = [mctx_RT_control mctx_RT_LTPB];
        tit = append('Distribution of the Mean Response Times of each group for w = 01',' (',num2str(from_t), '-',num2str(to_t),')');
        figure
        sbox_comp(grp', RTC',  x_name, y_name, tit,{}, sig_dif, test, acsis)
        ylim([0 2.5])
        yticks([0:0.2:2.5])
        xline(1.5)
        xticks([1 2])
        xticklabels({'Control','LTPB'})
end

if ctx_row == 3 %w=11
        [mctx_RT_control, mctx_RT_LTPB] = create_mean_RTs_ctx (data_control, data_LTPB, from_t, to_t, ctx_row);
      
        mctxs_RT_control {ctx_row} = mctx_RT_control;
        mctxs_RT_LTPB {ctx_row} = mctx_RT_LTPB;
        
        [~,~,pC] = swtest_norm(mctx_RT_control.'); 
        stats.w11.assumption_check.norm_check.pC = pC;
        
        [~,~,pL] = swtest_norm(mctx_RT_LTPB.');
        stats.w11.assumption_check.norm_check.pL = pL;
        
        [~, pF] = vartest2 (mctx_RT_control, mctx_RT_LTPB);
        stats.w11.assumption_check.var_check.pF = pF;
        
        [wpG] = ranksum (mctx_RT_control, mctx_RT_LTPB);  %wilcoxon rank sum test
        stats.w11.w_test.p = wpG;
        
        mesU = mes(mctx_RT_control.',mctx_RT_LTPB.','U3');
        U3 = mesU.U3;
        stats.w11.effect_size.U3 = U3;
        
        RTC = [mctx_RT_control mctx_RT_LTPB];
        tit = append('Distribution of the Mean Response Times of each group for w = 11',' (',num2str(from_t), '-',num2str(to_t),')');
        figure
        sbox_comp(grp', RTC',  x_name, y_name, tit,{}, sig_dif, test, acsis)
        ylim([0 2.5])
        yticks([0:0.2:2.5])
        xline(1.5)
        xticks([1 2])
        xticklabels({'Control','LTPB'})
end

if ctx_row == 4 %w=21
        [mctx_RT_control, mctx_RT_LTPB] = create_mean_RTs_ctx (data_control, data_LTPB, from_t, to_t, ctx_row);
        
        mctxs_RT_control {ctx_row} = mctx_RT_control;
        mctxs_RT_LTPB {ctx_row} = mctx_RT_LTPB;
        
        [~,~,pC] = swtest_norm(mctx_RT_control.'); 
        stats.w21.assumption_check.norm_check.pC = pC;
        
        [~,~,pL] = swtest_norm(mctx_RT_LTPB.');
        stats.w21.assumption_check.norm_check.pL = pL;
        
        [~, pF] = vartest2 (mctx_RT_control, mctx_RT_LTPB);
        stats.w21.assumption_check.var_check.pF = pF;
        
        [wpG] = ranksum (mctx_RT_control, mctx_RT_LTPB);  %wilcoxon rank sum test
        stats.w21.w_test.p = wpG;
        
        mesU = mes(mctx_RT_control.',mctx_RT_LTPB.','U3');
        U3 = mesU.U3;
        stats.w21.effect_size.U3 = U3;
        
        RTC = [mctx_RT_control mctx_RT_LTPB];
        tit = append('Distribution of the Mean Response Times of each group for w = 21',' (',num2str(from_t), '-',num2str(to_t),')');
        figure
        sbox_comp(grp', RTC',  x_name, y_name, tit,{}, sig_dif, test, acsis)
        ylim([0 2.5])
        yticks([0:0.2:2.5])
        xline(1.5)
        xticks([1 2])
        xticklabels({'Control','LTPB'})
end

if ctx_row == 5 %w=2
        [mctx_RT_control, mctx_RT_LTPB] = create_mean_RTs_ctx (data_control, data_LTPB, from_t, to_t, ctx_row);
        
        mctxs_RT_control {ctx_row} = mctx_RT_control;
        mctxs_RT_LTPB {ctx_row} = mctx_RT_LTPB;
        
        [~,~,pC] = swtest_norm(mctx_RT_control.'); 
        stats.w2.assumption_check.norm_check.pC = pC;
        
        [~,~,pL] = swtest_norm(mctx_RT_LTPB.');
        stats.w2.assumption_check.norm_check.pL = pL;
        
        [~, pF] = vartest2 (mctx_RT_control, mctx_RT_LTPB);
        stats.w2.assumption_check.var_check.pF = pF;
        
        [wpG] = ranksum (mctx_RT_control, mctx_RT_LTPB);  %wilcoxon rank sum test
        stats.w2.w_test.p = wpG;
        
        mesU = mes(mctx_RT_control.',mctx_RT_LTPB.','U3');
        U3 = mesU.U3;
        stats.w2.effect_size.U3 = U3;
        
        RTC = [mctx_RT_control mctx_RT_LTPB];
        tit = append('Distribution of the Mean Response Times of each group for w = 2',' (',num2str(from_t), '-',num2str(to_t),')');
        figure
        sbox_comp(grp', RTC',  x_name, y_name, tit,{}, sig_dif, test, acsis)
        ylim([0 2.5])
        yticks([0:0.2:2.5])
        xline(1.5)
        xticks([1 2])
        xticklabels({'Control','LTPB'})
end

end

function [mctx_RT_control, mctx_RT_LTPB] = create_mean_RTs_ctx (data_control, data_LTPB, from_t, to_t, ctx_row) % This function produces a list for each group containg
%the mean RTs in a given context for every participant of the group.
%"ctx_row" is the corresponding row to the context that you wish to
%analyze in the ct_pos matrix.

tree_file_address= "C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\git\files_for_reference\tree_behave12.txt"; %change this to match your machine

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7);
    
end

a=1;

for par = 1:(size(data_control,1)/1000) 
RT1{par}=T1(a:a+999); 

a=a+1000;

end

for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);
end     
a=1;

for par = 1:(size(data_LTPB,1)/1000) 
RT2{par}=T2(a:a+999); 


a=a+1000;

end

% Making the control group mean RTs list

for par = 1:(size(data_control,1)/1000)
 
[~,~,~,~,~,ct_pos]= rtanderperctx(data_control,par,from_t,to_t,tree_file_address,0,12);

ctx_p = nonzeros(ct_pos (ctx_row,:)).'; % "nonzeros' removes excess zeros after the last ocurrence of the context
ctx_RT = zeros(1, size(ctx_p,2)); %the code return an incorret list for the last participant if this line is omitted (?)

for i = 1: size(ctx_p,2)
    ctx_RT (i) = RT1{par}(ctx_p(i)+1); %every RT of a participant after a context
end

mctx_RT_control (par) = mean(ctx_RT);

end

% Making the LTPB group mean RT list

for par = 1:(size(data_LTPB,1)/1000)
 
[~,~,~,~,~,ct_pos]= rtanderperctx(data_LTPB,par,from_t,to_t,tree_file_address,0,12);

ctx_p = nonzeros(ct_pos (ctx_row,:)).'; % "nonzeros' removes excess zeros after the last ocurrence of the context
ctx_RT = zeros(1, size(ctx_p,2)); %the code return an incorret list for the last participant if this line is omitted (?)

for i = 1: size(ctx_p,2)
    ctx_RT (i) = RT2{par}(ctx_p(i)+1); %every RT of a participant after a context
end

mctx_RT_LTPB(par) = mean(ctx_RT);

end

end
end
