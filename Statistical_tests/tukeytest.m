% [r,dftk,table] = tukeytest(A,MSE)
%
% This function performs a Tukey test after ANOVArm1f. It does not give the
% Q critical value, you should look in the table.
% MSE = Mean Square Error of the ANOVA test.
% A = Data matrix(subjects, condition)
% r = parameter of the  Q distribution.
% dftk = degrees of freedom of the tukey test
% table = Cell that contains the q_obs. You should interpret the differences in means
% by the line and column configuration. Example: line 1, colum 2 = mean(1)
% - mean(2).
% tkt = same information as in table, but without the labels.

function [r,dftk,table,tkt] = tukeytest(A,MSE)

% tukey procedure

c = size(A,2);
n = size(A,1);

tkt = zeros(c,c);

for a = 1:c
   for b = 1:c
      tkt(a,b) = mean(A(:,a),1)-mean(A(:,b),1); 
      tkt(a,b) = tkt(a,b)/( sqrt(MSE*(1/n)) );
      tkt(a,b) = abs(tkt(a,b));
   end
end


dftk = n-c;
r = c;

% table

table = cell(c+1,c+1);

for a = 2:c+1
table{1,a} = [' mu' num2str(a-1)  ];
table{a,1} = [' mu' num2str(a-1)  ];
end

for a = 2: c+1
    for b = 2:c+1
        table{a,b} = tkt(a-1,b-1);
    end
end



end