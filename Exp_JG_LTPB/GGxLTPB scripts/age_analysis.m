L = [41, 39, 39, 44, 35, 26, 44, 33, 47, 47];
C = [25, 59, 29, 27, 38, 49, 31, 60, 52, 23];

% Checking mean and standart deviation

L_mean = mean(L);
L_std = std(L);

C_mean = mean(C);
C_std = std(C);

%Checking if the distribuition are normal

[~,~,pC] = swtest_norm(C.');
[~,~,pL] = swtest_norm(L.');

% Checking if the distribuitions have the same variance

[~, pF] = vartest2 (C, L);

% 2 sample t-test (parametric)
[h,pt] = ttest2(C,L);

% Wilcoxon ranksum test (nonparametric/ equal variances)
pW = ranksum(C,L);

% Brunner - Munzel test (nonparametric / different variances)

[pB] = brunner_munzel(C, L); 

grp = [zeros(1,10), ones(1,10)];

bxp = boxplot([C L], grp);

xticks([1 2])
xticklabels({'Control','LTPB'})

ylabel("Age")
ylim([18 60])

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14)

