% [p_a, pb1_2, pb1_3, pb2_3, cd1_2, cd1_3, cd2_3, e1_2, e1_3, e2_3] = compare_paired_blocks(data)
%
% This function compares the distribuction of the response times of a
% single group alongside each block block using the two-sample t-test statistical method. As
% output, it returns not only the p-value of each comparasion, but also the
% relative effect size (using the relative mean difference method) and the
% hedge's g value.
%
% INPUT:
%
% data_control = a data matrix.
%
% OUTPUT:
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

data = data_control;

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

MRT = [MRT1.' MRT2.' MRT3.'];
[p,tbl] = anova_rm(MRT); %The first p value tests the main null hypothesis that 
%the column means are identical. The second p-value tests the null hypothesis that
%the row means are identical (this is the test for effective matching). 

p_a = p_an(1);

% MRZ = [MRT1
%        MRT2
%        MRT3];
% btw = [1
%        1
%        1
%        1
%        1
%        1
%        1];
% 
% [tbl, rn] = simple_mixed_anova(MRT);

