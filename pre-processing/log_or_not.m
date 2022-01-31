% log_or_not(cells, sc,sr, tree);
%
% This function is part of the goalkeeper game routine
%
% Given the cell numaretion (cells), the expected response (sc), 
% the response (sr) and the tree (tree) vectors, it returns if the response
% is logical or not.

function fvec = log_or_not(cells, sc, sr, tree)

mlength = length(cells);
fvec = zeros(mlength,1);

a = 0; 
while(a <= mlength)
a = a+1;    
    while (a<mlength)&&(cells(a,1) <= cells(a+1,1))        
        if cells(a,1) == 1
        b = a;
        t = tree(a);
        end
    a= a+1;    
    end
    if (a <= mlength)
        e = a;
        if t ~= 0
        fvec(b:e,1) = logicintree(t,sc(b:e,1), sr(b:e,1));
        end
    end
clc;
display([num2str(a) ' of ' num2str(mlength) ]);    
end




end