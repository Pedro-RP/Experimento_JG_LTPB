L = [41, 39, 39, 44, 35, 26, 44, 31, 45, 47];
C = [25, 59, 29, 27, 38, 49, 31, 60, 54, 52];


[~,~,pC] = swtest_norm(C.');
[~,~,pL] = swtest_norm(L.');

[~, pF] = vartest2 (C, L);

[h,pt] = ttest2(C,L);

pW = ranksum(C,L);

grp = [zeros(1,10), ones(1,10)];

bxp = boxplot([C L], grp);

xticks([1 2])
xticklabels({'Control','LTPB'})

ylabel("Age")
ylim([18 60])

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14)

