
function log_test = have_tmt(tree_file_address)

[contexts, PM, ~, ~] = build_treePM (tree_file_address);

log_test = 1;

l = zeros(length(contexts),1);
for a = 1:length(contexts)
   l(a,1) = length(contexts{a}); 
end

l_min = min(l);
for a = 1:length(contexts)
   w = contexts{a};
   if length(w) == l_min
       non_zero = find(PM(a,:) > 0)-1; 
       %working 1
        for b = 1:length(non_zero)
           next = [w non_zero(b)];
           while 1
           counter = 0;
           % working 2
                for c = 1:length(contexts)
                    counter = counter + sufix_test(next,contexts{c});
                end
                if counter > 1
                   log_test = 0;
                   
                   return;
                end
                if counter == 1
                   break;
                end
           % working 2
                if length(next) == 1
                    break;
                end
           next = next(2:end);
           end
        end       
       %working 1
   end
end


end






