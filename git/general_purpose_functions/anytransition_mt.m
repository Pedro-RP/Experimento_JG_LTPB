% [TMT, table, freq] = anytransition_mt(contexts, PM)
%
% The function returns the matrix with the transitions from context to
% context.


function  [TMT, table,freq] = anytransition_mt(contexts, PM)

n = size(contexts,2);
TMT = zeros(n,n);

for a = 1:n
   for b = 1:n 
   pair1 = contexts{1,a};
   pair2 = contexts{1,b};
      if size(pair1,2) == size(pair2,2)
       %case 1 - contexts of same size
            if size(pair1,2) ~= 1
                match = 1;
                for m = 1: size(pair2,2)-1
                    if pair1(1,1+m)~= pair2(1,m) 
                        match = 0;
                    end
                end
                if match == 0
                    TMT(a,b) = 0;
                else
                    dumb = pair2(1,size(pair2,2))+1;
                    TMT(a,b) = PM(a,dumb);
                end               
            else
                % sub-case - same size and equal one
                dumb = pair2(1,1)+1;
                TMT(a,b) = PM(a,dumb);
            end
        %case 2 - contexts with different sizes
      elseif size(pair1,2)>size(pair2,2)
           if size(pair2,2) ~= 1
                lp2 = size(pair2,2); lp1 = size(pair1,2);
                aux1 = lp2-1; aux2 = lp1-aux1+1;
                till = aux1; match = 1;
                for m = 1:till 
                if pair1(1,aux2) ~= pair2(1, aux1)
                match = 0;
                end
                aux2 = aux2+1;
                aux1 = aux1+1;
                end
                if match == 0
                TMT(a,b) = 0;
                else
                dumb = pair2(1,size(pair2,2));
                TMT(a,b) = PM(a,dumb+1);
                end               
           else
              % sub-case = contexts with different sizes and pair2 is equal one.
              dumb = pair2(1,1)+1;
              TMT(a,b) = PM(a,dumb);
           end
      elseif size(pair2,2) > size(pair1,2)
                % case 3 - contexts of different sizes
                if size(pair1,2) ~= 1
                    match = 1;
                    lp2 = length(pair2); lp1 = length(pair1);
                    aux1 = lp2 - 1 - (lp1 -1);
                    aux2 = 1;
                    for m = 1:lp2-1
                        if pair2(1,aux1) ~= pair1(1,aux2)
                        match = 0; 
                        end
                        aux2 = aux2+1;
                        aux1 = aux1+1;
                    end
                        if match == 0
                        TMT(a,b) = 0;
                        else
                        dumb = pair2(1,size(pair2,2))+1;
                        TMT(a,b) = PM(a, dumb);
                        end
                else
                    % sub-case -  contexts with different sizes and pair1
                    % equal one.
                    if pair2(1, (size(pair2,2)-1) ) == pair1(1,1)
                        dumb = pair2(1,size(pair2,2))+1;
                        TMT(a,b) = PM(a,dumb);
                    else
                        TMT(a,b) = 0;
                    end
                end
       else
           display('case4'); display(pair1); display(pair2);
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





