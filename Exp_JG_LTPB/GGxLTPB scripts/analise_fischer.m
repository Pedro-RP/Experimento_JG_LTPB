%Escolaridade

E = table([4;8],[6;2],'VariableNames',{'Medio','Superior'},'RowNames',{'Controle','LTPB'});

[hE,pE,statsE] = fishertest(E);

%Sexo

S = table([8;9],[2;1],'VariableNames',{'M','F'},'RowNames',{'Controle','LTPB'});

[hS,pS,statsS] = fishertest(S);

% Modalidades (Online x Presencial)

M = table([6;3],[4;7],'VariableNames',{'Online','Presencial'},'RowNames',{'Controle','LTPB'});

[hM,pM,statsM] = fishertest(M);
