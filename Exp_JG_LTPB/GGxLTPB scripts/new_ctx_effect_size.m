%Calculating the effect size of the difference between the distributions
% of the means of the response times in the new contexts of the LTPB Tree.
% (C0120 and C1120)

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

[MC0120_C,~] = boxcox(MC0120_C');
[MC1120_C,~] = boxcox(MC1120_C');

% Testing normality

[~,~,pC0] = swtest_norm(MC0120_C);
[~,~,pC1] = swtest_norm(MC1120_C);

% Testing equality of variances

[~, pFC] = vartest2 (MC0120_C', MC1120_C');

% Statistical comparasion and effect size analysis

pC0_1 = signrank(MC0120_C', MC1120_C');

% mesC1_2 = mes(MC1120_C.',MC0120_C.','U3');
% hgC1_2 = mesC1_2.U3;

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

[MC0120_L,~] = boxcox(MC0120_L');
[MC1120_L,~] = boxcox(MC1120_L');

% Testing normality

[~,~,pL0] = swtest_norm(MC0120_L);
[~,~,pL1] = swtest_norm(MC1120_L);

% Testing equality of variances

[~, pFL] = vartest2 (MC0120_L', MC1120_L');

% Statistical comparasion and effect size analysis

pL0_1 = signrank(MC0120_L', MC1120_L');

% mesL1_2 = mes(MC1120_L.',MC0120_L.','U3');
% hgL1_2 = mesL1_2.U3;