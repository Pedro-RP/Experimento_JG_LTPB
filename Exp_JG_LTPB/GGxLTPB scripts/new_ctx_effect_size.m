%Calculating the effect size of the difference between the distributions
% of the means of the response times in the new contexts of the LTPB Tree.
% (C0120 and C1120)

control_n = (size(data_control,1)/1000);
LTPB_n = (size(data_LTPB,1)/1000);

from_t = 1;
to_t = 1000;

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
    MC0120_C(par) = mean (C0120_C{par});
    MC1120_C(par) = mean (C1120_C{par});
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

[MC0120_C,kC0120_C] = boxcox(MC0120_C');
[MC1120_C,kC1120_C] = boxcox(MC1120_C');

x_name = '';
y_name = "Processed Mean RT";
tit = append('Distribution of the normalized mean RTs of the Control Group in the novel contexts (',num2str(from_t), '-', num2str(to_t),')');
sig_dif = 1;
test = 0;
acsis = [];
d_C = [MC0120_C' MC1120_C'];
grp = [ones(1,control_n),2*ones(1, control_n)];

figure
sbox_conection(grp', d_C',  x_name, y_name, tit, {'C0120'; 'C1120';}, sig_dif, test, acsis)
xline(2.5)
xline(1.5)
ylim([-5 5])
yticks(-5:0.4:5)


% Testing normality

[~,~,pC0] = swtest_norm(MC0120_C);
[~,~,pC1] = swtest_norm(MC1120_C);

% Testing equality of variances

[~, pFC] = vartest2 (MC0120_C', MC1120_C');

% Statistical comparasion and effect size analysis

[~, pC0_1 ]= ttest(MC0120_C', MC1120_C');

mesC0_1 = mes(MC1120_C.',MC0120_C.','hedgesg','isDep', 1);

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
    MC0120_L(par) = mean (C0120_L{par});
    MC1120_L(par) = mean (C1120_L{par});
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

[MC0120_L,kC0120_L] = boxcox(MC0120_L');
[MC1120_L,kC1120_L] = boxcox(MC1120_L');

x_name = '';
y_name = "Processed Mean RT";
tit = append('Distribution of the normalized mean RTs of the LTPB Group in the novel contexts (',num2str(from_t), '-',num2str(to_t), ')');
sig_dif = 1;
test = 0;
acsis = [];
d_C = [MC0120_L' MC1120_L'];
grp = [ones(1,LTPB_n),2*ones(1, LTPB_n)];

figure
sbox_conection(grp', d_C',  x_name, y_name, tit, {'C0120'; 'C1120';}, sig_dif, test, acsis)
xline(2.5)
xline(1.5)
ylim([-5 5])
yticks(-5:0.4:5)

% Testing normality

[~,~,pL0] = swtest_norm(MC0120_L);
[~,~,pL1] = swtest_norm(MC1120_L);

% Testing equality of variances

[~, pFL] = vartest2 (MC0120_L', MC1120_L');

% Statistical comparasion and effect size analysis

[~, pL0_1] = ttest(MC0120_L', MC1120_L');

mesL0_1 = mes(MC1120_L.',MC0120_L.','hedgesg',  'isDep', 1);
