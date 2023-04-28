% function [stats, MC0120_C, MC1120_C, MC0120_L, MC1120_L] = new_ctx_effect_size (data_control, data_LTPB, from_t, to_t)
%
% This function compares the mean reaction times (RTs) of both groups
% in the two novel context that appeared at the LTPB mode tree (C0120 and C1120).
% The comparasions are made inside the same group and not between groups. The goal
% is finding if the distinction between both of this contexts noted in the mode tree
% can be attributed to the mean RTs of the participants and the effect size
% if said difference. One boxplot for each comparasion is
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
% stats =  structure containing the statistical tests for the comparasions.
% The test used was the wilcoxon signrank test and the effect size measure was Cohen's
% U3. Parametric test assumptions are tested.
%
% Vectors contating the mean RTs of the participants of both groups in each
% context. "_C" is for control and "_L" is for LTPB.
%
% 17/04/2023 by Pedro R. Pinheiro


function [stats, MC0120_C, MC1120_C, MC0120_L, MC1120_L] = new_ctx_effect_size (data_control, data_LTPB, from_t, to_t)

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000);

%Control group

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7); %response times of every trial of every participant

end

a=1;

for par = 1:(size(data_control,1)/1000)
    
    RT1{par}=T1(a:a+999);  %response times of every trial grouped by participant
    a=a+1000;

end

for par = 1:(size(data_control,1)/1000)
   
    RT1{par} = RT1{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end
    

for pos = 1:size(data_control,1)

    p1(pos)= data_control(pos,9); %stochastic chain info for all of the participants

end

b=1;

for par = 1:(size(data_control,1)/1000) 
    
    P1{par}=p1(b:b+999);  %stochastic chain info grouped by participant
    b=b+1000;

end

for par = 1:(size(data_control,1)/1000)
   
    P1{par} = P1{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end
    

for par = 1:(size(data_control,1)/1000) 
     C0120_C{par} = double.empty; % all of the RTs of each participant of the control group in response to context 0120
     C1120_C{par} = double.empty;
end


for par = 1:(size(data_control,1)/1000) 
    for i = 1:size(P1{par},2)
        if P1{par}(i) == 0 && i < size(P1{par},2) && i > 3
            if P1{par}(i-3) ==0
                C0120_C{par} = [C0120_C{par} RT1{par}(i+1)]; % If the ctx is C0120, picks the response time of the next trial after the last element of the context.
            elseif  P1{par}(i-3) == 1
                C1120_C{par} = [C1120_C{par} RT1{par}(i+1)];
            end
            
        end
        
    end
    
end

for par = 1:(size(data_control,1)/1000)
    MC0120_C(par) = trimmean (C0120_C{par},10);
    MC1120_C(par) = trimmean (C1120_C{par},10);
end

x_name = '';
y_name = "Mean RT(s)";
tit = append('Distribution of the mean RTs of the Control Group in the novel contexts (',num2str(from_t), '-', num2str(to_t),')');
sig_dif = 1;
test = 0;
acsis = [];
d_C = [MC0120_C MC1120_C];
grp = [ones(1,control_n),2*ones(1, control_n)];

figure
sbox_conection(grp', d_C',  x_name, y_name, tit, {'C0120'; 'C1120';}, sig_dif, test, acsis)
xline(2.5)
xline(1.5)
ylim([0 2.5])
yticks(0:0.2:2.5)

% Testing normality

[~,~,pC0] = swtest_norm(MC0120_C');
[~,~,pC1] = swtest_norm(MC1120_C');

stats.control.assumption_check.normality_check.C0120 = pC0;
stats.control.assumption_check.normality_check.C1120 = pC1;

% Testing equality of variances

[~,pFC] = vartest2 (MC0120_C, MC1120_C);

stats.control.assumption_check.variance_check = pFC;

% Statistical comparasion and effect size analysis

[pC0_1]= signrank(MC0120_C, MC1120_C);

stats.control.w_test = pC0_1;

mesC0_1 = mes(MC0120_C',MC1120_C','U3');
stats.control.U3 = mesC0_1.U3;

%LTPB group


for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7); %response times of every trial of every participant

end

a=1;

for par = 1:(size(data_LTPB,1)/1000)
    
    RT2{par}=T2(a:a+999);  %response times of every trial grouped by participant
    a=a+1000;

end

for par = 1:(size(data_LTPB,1)/1000)
   
    RT2{par} = RT2{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end
    

for pos = 1:size(data_LTPB,1)

    p2(pos)= data_LTPB(pos,9); %stochastic chain info for all of the participants

end

b=1;

for par = 1:(size(data_LTPB,1)/1000) 
    
    P2{par}=p2(b:b+999);  %stochastic chain info grouped by participant
    b=b+1000;

end

for par = 1:(size(data_LTPB,1)/1000)
   
    P2{par} = P2{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end
    

for par = 1:(size(data_LTPB,1)/1000) 
     C0120_L{par} = double.empty; % all of the RTs of each participant of the control group in response to context 0120
     C1120_L{par} = double.empty;
end


for par = 1:(size(data_LTPB,1)/1000) 
    for i = 1:size(P2{par},2)
        if P2{par}(i) == 0 && i < size(P2{par},2) && i > 3
            if P2{par}(i-3) ==0
                C0120_L{par} = [C0120_L{par} RT2{par}(i+1)]; % If the ctx is C0120, picks the response time of the next trial after the last element of the context.
            elseif  P2{par}(i-3) == 1
                C1120_L{par} = [C1120_L{par} RT2{par}(i+1)];
            end
            
        end
        
    end
    
end

for par = 1:(size(data_LTPB,1)/1000)
    MC0120_L(par) = trimmean (C0120_L{par},2);
    MC1120_L(par) = trimmean (C1120_L{par},2);
end

x_name = '';
y_name = "Mean RT (s)";
tit = append('Distribution of the mean RTs of the LTPB Group in the novel contexts (',num2str(from_t), '-',num2str(to_t), ')');
sig_dif = 1;
test = 0;
acsis = [];
d_L = [MC0120_L MC1120_L];
grp = [ones(1,LTPB_n),2*ones(1, LTPB_n)];

figure
sbox_conection(grp', d_L',  x_name, y_name, tit, {'C0120'; 'C1120';}, sig_dif, test, acsis)
xline(2.5)
xline(1.5)
ylim([0 2.5])
yticks(0:0.2:2.5)

% Testing normality

[~,~,pL0] = swtest_norm(MC0120_L');
[~,~,pL1] = swtest_norm(MC1120_L');

stats.LTPB.assumption_check.normality_check.C0120 = pL0;
stats.LTPB.assumption_check.normality_check.C1120 = pL1;

% Testing equality of variances

[~, pFL] = vartest2 (MC0120_L, MC1120_L);

stats.LTPB.assumption_check.variance_check = pFL;

% Statistical comparasion and effect size analysis

[pL0_1] = signrank(MC0120_L, MC1120_L);

stats.LTPB.w_test = pL0_1;

mesL0_1 = mes(MC0120_L',MC1120_L','U3');

stats.LTPB.U3 = mesL0_1.U3;

end