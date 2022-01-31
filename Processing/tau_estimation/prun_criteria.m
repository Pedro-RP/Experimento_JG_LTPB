% cut = prun_criteria(leafs,schain, rtchain)
%
% This function is decides if the branch should be prunned or not. If at
% least one pair of contexts have different laws, then the context won't be
% prunned.
%
% Author: Paulo Passos Last Modified: 24/05/2020


function ncut = prun_criteria(leafs,schain, rtchain)

% DISCARDING EMPTY LEAFS
holder = cell(1,1); aux = 1;
for a = 1:size(leafs,2)
  if ~isempty(leafs{1,a})
      holder{1,aux} = leafs{1,a}; aux = aux+1;
  end
end
leafs = holder;


[~, loc, count] = count_contexts(leafs, schain);

celldist = cell(1,length(leafs));

for a = 1:length(leafs)
   for b = 1:count(a,1)
      if (loc(a,b)+1) <= length(rtchain)
      celldist{1,a} = [celldist{1,a}; rtchain(1,(loc(a,b)+1))];
      end
   end
end

compare = combnk(1:size(leafs,2),2);

results = zeros(size(compare,1),1);


for a = 1:size(compare,1)
x = celldist{1,compare(a,1)};
y = celldist{1,compare(a,2)};
results(a,1) = kstest2(x,y);
end

if sum(results,1)/length(results) ~=0
ncut = 1;
else
ncut = 0;
end

end

% Backup-code

% % cut = prun_criteria(leafs,schain, rtchain)
% %
% % This function is....
% %
% % Author: Paulo Passos Last Modified: 24/05/2020
% 
% 
% function ncut = prun_criteria(leafs,schain, rtchain)
% 
% [~, loc, count] = count_contexts(leafs, schain);
% 
% celldist = cell(1,length(leafs));
% 
% for a = 1:length(leafs)
%    for b = 1:count(a,1)
%       if (loc(a,b)+1) <= length(rtchain)
%       celldist{1,a} = [celldist{1,a}; rtchain(1,(loc(a,b)+1))];
%       end
%    end
% end
% 
% compare = combnk(1:length(leafs),2);
% 
% results = zeros(size(compare,1),1);
% 
% for a = 1:size(compare,1)
% x = celldist{1,compare(a,1)};
% y = celldist{1,compare(a,2)};
% results(a,1) = kstest2(x,y);
% end
% 
% if sum(results,1)/length(results) == 1
% ncut = 1;
% else
% ncut = 0;
% end
% 
% end