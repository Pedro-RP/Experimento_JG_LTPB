% [TMT, table, freq] = transition_mt(contexts, PM)
%
% The function returns the matrix with the transitions from context to
% context.


function  [TMT, table,freq] = transition_mt(contexts, PM)

n = size(contexts,2);
TMT = zeros(n,n);

for a = 1:n
   for b = 1:n 
   pair1 = contexts{1,a};
   pair2 = contexts{1,b};
       if (size(pair1,2)== 2)&&(size(pair1,2) == size(pair2,2))
          %case 1 - contexts of same size
            if pair1(1,2)~= pair2(1,1)
                TMT(a,b) = 0;
            else
                dumb = pair2(1,2)+1;
                TMT(a,b) = PM( a, dumb);
            end
       elseif size(pair1,2) > size(pair2,2)
            dumb = pair2 +1;
            TMT(a,b) = PM(a,dumb);
       else
          %
            if (size(pair2,2) > size(pair1,2))&&(pair2(1,1) == pair1)
               dumb = pair2(1,2)+1; 
               TMT(a,b) = PM(a,dumb); 
            end
       end
   end
end

table = cell(n+1,n+1);
for a = 2:n+1
    table{1,a} = contexts{1, a-1};
    table{a,1} = contexts{1, a-1};
end

for a = 2:n+1
    for b = 2:n+1
        table{a,b} = TMT(a-1,b-1);
    end
end

[V,D] = eig(TMT');

index = find(abs(diag(D) - 1) < 10^-10);
freq = V(:,index)/sum(V(:,index));

end