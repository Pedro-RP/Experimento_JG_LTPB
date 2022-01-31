% [contexts, PM, responses, rnds] = build_treePM (tree_file_address)
%
% This function reads a text file with address given by 'tree_file_address' and
% returns the contexts in a cell structure called 'contexts', the probability
% matrix in matrix form in 'PM', the possible responses given 
% each context in 'responses', and a vector indicating if the context is 
% not-deterministic in 'rnds'.
%
% The file must have only two lines, ex.:
%
% ctx: {0; 01; 11; 2}
% pm: {(0,1,0); (0,0.25,0.75); (1,0,0); (1,0,0)}
%
% Description

function [contexts, PM, responses, rnds] = build_treePM (tree_file_address)

fid = fopen(tree_file_address);
des = fscanf(fid,'%s');
fclose(fid); 

contexts = cell(1,count(des,'('));
PM = zeros(count(des,'('), count(des,',')/count(des,'(') +1);

data = split(des,'pm:');
ctx_des = data{1}; ctx_des = split(ctx_des,'ctx:');
ctx_des = ctx_des{2};
ctx_des = replace(ctx_des, '{','');ctx_des = replace(ctx_des, '}','');
ctx_des = split(ctx_des,';');

for a = 1:length(ctx_des)
    vec = zeros(1,length(ctx_des{a}));
    for b = 1:length(ctx_des{a})
    vec(1,b) = str2num(ctx_des{a}(1,b)); %#ok<ST2NM>
    end
    contexts{a} = vec;
end


pm_des = data{2};
pm_des = split(pm_des,'pm:'); 
pm_des = replace(pm_des, '{','');pm_des = replace(pm_des, '}','');
pm_des = split(pm_des,';');

for a = 1:length(contexts)
    aux1 = pm_des{a};
    aux1 = replace(aux1,'(',''); aux1 = replace(aux1,')','');
    aux2 = split(aux1,',');
    for b = 1:size(PM,2)
        PM(a,b) = str2num(aux2{b}); %#ok<ST2NM>
    end
end

responses = cell(1, size(PM,1));
rnds = zeros(1, size(PM,1));
for a = 1:size(PM,1)
    for b = 1:size(PM,2)
        if PM(a,b) ~= 0
           responses{1,a} = [responses{1,a} (b-1)];  
        end
    end
    if length(responses{1,a}) > 1
        rnds(1,a) = 1;
    end
end

end