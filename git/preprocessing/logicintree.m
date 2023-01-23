% logicvec = logicintree(tree, seq, resp)
%
% This function is part of the Goalkeeper game routine
%
% This function returns a vector that tells if a response is or not logical
% given the tree.
% tree = number indicating the tree (single value)
% seq = the stochastic chain (column vector)
% resp = the response to the stochastic chain. (column vector)
% logicvec = vector telling if the response is or not logical. (column
% vector with zero indicating logical error and 1 otherwise)


function logicvec = logicintree(tree, seq, resp)

ml = length(seq);
logicvec = zeros(ml,1);

% Here you place the tree contexts
pct.t1 = {0 , 2 , [0 1], [1 1]}; %These are for the tree one
pct.t2 = {0 , 2, [0 0 1], [1 0 1], [2 0 1], [1 1]};
pct.t3 = {[ 0 0], [1 0], [2 0], 1, [0 2], [1 2], [2 2]};
pct.t4 = {0 , [0 1] , [2 1], 2};
pct.t5 = {2, [2 1], [2 0], [1 0], [0 1], [2 0 0], [1 0 0], [0 0 0]};
pct.t6 = {2 , [2 1], [2 0], [1 1], [1 0], [0 1], [0 0]};

% Here you place the responses with probability different from zero for respective tree 

pct.t1r = {[1], [0], [1 2], [0]}; % here, for exemple, the context 0 1 allow the responses 1 and 2.  
pct.t2r = {[0 1], [0], [0], [1], [1], [2]};
pct.t3r = {[1], [2], [0], [0 2], [2], [0], [1]};
pct.t4r = {[0 1], [2], [0], [1 2]};
pct.t5r = {[0 1], [0], [0], [0 1], [2], [0 1], [2], [2]};
pct.t6r = {[0 1], [0 1], [0 1], [2], [2], [2], [2]}; %#ok<STRNU>
%%%%%%%%%%%%
dtree = []; dresp = [];
eval(['dtree = pct.t' num2str(tree) ';'])
eval(['dresp = pct.t' num2str(tree) 'r ;'])

ldtree = 0;
for a = 1:length(dtree)
   if length(dtree{1,a}) > ldtree
       ldtree = length(dtree{1,a});
   end
end


logicvec(1,1) = 1; % the first response is always logic.

for a = 2: ml    
    if resp(a,1) ~= seq(a,1)
            for b = 1: length(dtree) % Testing contexts
               aux = dtree{1,b}; laux = length(aux);
               first = a -laux; last = a -1;
               if first >= 1
                   aux2 = seq(first:last,1);
                   fcont = sum( aux' == aux2)/laux;
                   if fcont == 1
                      logic = 0;
                      pr = dresp{1,b};
                      for c = 1: length(pr) % Testing the responses
                          if resp(a) == pr(1,c)
                              logic = 1;
                              break;
                          end
                      end % testing the responses
                   end
                   if fcont ==1
                      break;
                   end
               end
            end % Testing contexts
            if fcont == 0
            logic = 1;    
            end
    else
        logic = 1;
    end
    % Considen putting this part
%     if (fcont == 0)
%     logic
%     end
    % Consider putting this part
logicvec(a,1) = logic;
end




end



