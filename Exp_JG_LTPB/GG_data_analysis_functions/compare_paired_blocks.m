% [p_anova, pb1_2, pb1_3, pb2_3, hg1_2, hg1_3, hg2_3, e1_2, e1_3, e2_3] = compare_paired_blocks(data)
%
% This function compares the distribuction of the response times of a
% single group alongside each block using the paired t-test statistical method. As
% output, it returns not only the p-value of each comparasion, but also the
% p_value of the repeated measures ANOVA test (corrected if needed),
% relative effect size (using the relative mean difference method) and the
% hedge's g value of each comparasion.
%
% INPUT:
%
% data_control = a data matrix.
%
% OUTPUT:
%
% p_a = the p-value of the repeated measures ANOVA test.
%
% pb1_2 = the p-value of the comparasion of blocks 1 and 2.
% pb1_3 = the p-value of the comparasion of blocks 1 and 3.
% pb2_3 = the p-value of the comparasion of blocks 2 and 3.
%
% hg1_2 = hedge's g effect value for the comparasion of blocks 1 and 2.
% hg1_3 = hedge's g effect value for the comparasion of blocks 1 and 3.
% hg2_3 = hedge's g effect value for the comparasion of blocks 2 and 3.
%
% e1_2 = the relative effect size of the comparasion of blocks 1 and 2.
% e1_3 = the relative effect size of the comparasion of blocks 1 and 3.
% e2_3 = the relative effect size of the comparasion of blocks 2 and 3.
%
%10/10/2022 by Pedro R. Pinheiro

function [p_anova, pb1_2, pb1_3, pb2_3, hg1_2, hg1_3, hg2_3, e1_2, e1_3, e2_3] = compare_paired_blocks(data)
for i = 1:size(data,1)

    T1(i)= data(i,7);


end

a=1;

for par = 1:(size(data,1)/1000) 
RT{par}=T1(a:a+999); 

a=a+1000;

end

%Block 1

RT1 = 0; %Response Time 
for par = 1:(size(data,1)/1000)
    for k = drange(1:334) %number os trials in the block

        RT1 = RT1 + RT{par}(k); %RT1 -> Response times of each control group participant in block 1
    end

    MRT1(par) = RT1/334;  %Mean Response Time 1 (MRT1) is a vector with mean response time of each participant of the group for block 1.
    RT1=0;

end

%%Block 2 

RT2 = 0;
for par = 1:(size(data,1)/1000)
    for k = drange(335:668)

        RT2 = RT2 + RT{par}(k); 
    end

    MRT2(par) = RT2/334;  
    RT2=0;
end

%Block 3 

RT3 = 0;
for par = 1:(size(data,1)/1000)
    for k = drange(669:1000)

        RT3 = RT3 + RT{par}(k); 
    end

    MRT3(par) = RT3/332;  
    RT3=0;
end


% Making a Repeated Measures Model

MRT = [MRT1.' MRT2.' MRT3.'];

t = table(MRT(:,1),MRT(:,2),MRT(:,3),... %the three dots indicate that the function continues in the next line
'VariableNames',{'Block1','Block2','Block3'});
wd = table([1 2 3]','VariableNames',{'Blocks'});

rm = fitrm(t,'Block1-Block3~1','WithinDesign',wd);

% Repeated Measures ANOVA

ranovatbl = ranova(rm);

% Mauchly test for sphericity

mauchly_test = mauchly(rm); 

if table2array(mauchly_test(1,4)) < 0.05
    p_anova = table2array(ranovatbl(1,6)); %correcting the p-value if the sphericity condition isn't met.
else
    p_anova = table2array(ranovatbl(1,5));
end

% Doing the paired t-test with bonferroni correction

[~,p12] = ttest(MRT1, MRT2);
pb1_2 = p12*3; %bonferoni correction for multiple comparasions

[~,p13] = ttest(MRT1, MRT3);
pb1_3 = p13*3; 

[~,p23] = ttest(MRT2, MRT3);
pb2_3 = p23*3; %bonferoni correction for multiple comparasions


% calculating the relative effect size by relative mean difference 

MMRT1 = mean (MRT1);
MMRT2 = mean (MRT2);
MMRT3 = mean (MRT3);

e1_2 = (MMRT1 * 100)/MMRT2;
e1_3 = (MMRT1 * 100)/MMRT3;
e2_3 = (MMRT2 * 100)/MMRT3;

% Calculating Hedge's g effect size values

mes1 = mes(MRT1.',MRT2.','hedgesg');
mes2 = mes(MRT1.',MRT3.','hedgesg');
mes3 = mes(MRT2.',MRT3.','hedgesg');

hg1_2 = mes1.hedgesg;
hg1_3 = mes2.hedgesg;
hg2_3 = mes3.hedgesg;
end
