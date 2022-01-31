% [Fr_M, all_ctx_resp, all_ctx_resp, ctx_count, ctxlist] = M_relative_relative frequency(data, ids, tau, from, till, addxlim, show)
%
% This function calculates the relative frequency of the groups of individuals given the
% tree (tau) and the trial to start (from) and end (till) the computation.
%
% ids is a list of ids to be included in the analysis.
% INPUT:
% data = matrix with all the data from the experiment obtained from responsetimeandresponses.mat
% ids = vector containing the ids (integers) included in the analysis. loading ids_final.mat,
% this corresponds to the ftids.
% nid = the number of the id of the volunteer  in ids.
% tau = the tree that will be used and depicted
% from = integer indicating from which trial begins
% till = integer indicating in which trial it ends
% addxlim = integer that adjust the graph of histogramns for better
% visualization
% show = 1 for showing the plot
% visualization
%
% OUTPUT:
% ctxlist = cell with dimensions 1 x |tau|. In each cell there is a
% context of tau
% all_ctx_resp = cell with dimensions |tau| x num. of groups + 1. In each cell there is in each column a vector
% with all the responses given to the context for the volunteer.
% Fr_M = cell with dimensions |tau| x num. of groups + 1. The entry {i,j}
% of the cell as at each column the relative frequence of each response
% given the context [0;1;2]. 

% Author: Paulo Roberto Cabral Passos Last Modified:30/07/2020


function [Fr_M, all_ctx_resp, ctx_count, ctxlist] = M_relative_frequency(data, ids, tau, from, till, addxlim, show) %#ok<STOUT>

all_ids = sort(ids); 

% Improving Appearence of The Plots.

set(0,'defaultfigurecolor',[1 1 1])
set(0, 'DefaultFigureRenderer', 'painters');

% Standard Visualization Parameters

taunum = 6;  % number of trees
alfal = 3;   % length of the alphabet
maxhist = 1.1; % vertical edge of the histogram axis
sbpl = 3; % subplot lines 
sbpc = 3; % subplot columns

% References for the trees

tau1 = {0 , 2 , [0 1], [1 1]};
tau2 = {0 , 2, [0 0 1], [1 0 1], [2 0 1], [1 1]};
tau3 = {[ 0 0], [1 0], [2 0], 1, [0 2], [1 2], [2 2]};
tau4 = {0 , [0 1] , [2 1], 2};
tau5 = {2, [2 1], [2 0], [1 0], [0 1], [2 0 0], [1 0 0], [0 0 0]};
tau6 = {2 , [2 1], [2 0], [1 1], [1 0], [0 1], [0 0]};

t1r = {[1], [0], [2 1], [0]}; 
t2r = {[1 0], [0], [0], [1], [1], [2]};
t3r = {[1], [2], [0], [0 2], [2], [0], [1]};
t4r = {[0 1], [2], [0], [2 1]};
t5r = {[1 0], [0], [0], [1 0], [2], [1 0], [2], [2]};
t6r= {[1 0], [1 0], [1 0], [2], [2], [2], [2]};

% Figure 1

eval(['tresp = t' num2str(tau) 'r;' ])
eval(['ctxlist = tau' num2str(tau) ';'])

suport = cell(1,1);
for a = 1:length(ctxlist)
 suport{a,1} =  num2str(ctxlist{1,a}) ; %#ok<AGROW>
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idpergroup = cell(taunum,1);

for a = 1:length(all_ids)
id = all_ids(a,1); group = data(find(data(:,6) == id, 1),1);
idpergroup{group,1} = [idpergroup{group,1}; id];
end

total_ctxresp = cell(1,1);
Fr_M = cell(length(ctxlist), taunum+1);
all_ctx_resp = cell(length(ctxlist), taunum);
ctx_count = zeros(length(ctxlist),1);

if show == 1
   figure 
end

for g = 1:taunum+1
        if g > taunum
            ids = all_ids;
        else
            ids = idpergroup{g,1};
        end

    [gctxtime, gctxer, gctxresp, contexts, ctxrnds] = rtanderperctxg(data, tau, from, till, ids, 0);

    for a = 1:length(ctxlist)
       fr_ind = zeros(alfal,length(ids));
       for b = 1:length(ids)           
           for c = 1:alfal
               fr_ind(c,b) =  sum(gctxresp{a,1}(:,b) == c-1)/length(gctxresp{a,1}(:,b));
           end           
       end
    ctx_count(a,1) = size(gctxresp{a,1},1);
    Fr_M{a,g} = mean(fr_ind,2);
    all_ctx_resp{a,g} = gctxresp{a,1};
    end
    
    
    if show == 1
        subplot(sbpl,sbpc,g)

        f4 = gca;

        aux = 0;
        changetick = [];
        changelabel = cell(1,1);
        for b = 1:length(contexts)
           if b == 1
            aux = 1;
           else
            aux = aux+ alfal+1;
           end
           auxhist = [];
           for c = 1:length(ids)
           auxhist = [auxhist; gctxresp{b,1}(:,c)]; 
           end
           histogram([auxhist+aux], 'Normalization','probability')
           hold on
           changetick = [changetick [0:alfal-1]+aux];
        end

        if g>taunum
        title(['TODOS (M =' num2str(length(ids)) ')'])
        else
        title(['G' num2str(g) ' (M =' num2str(length(ids)) ')' ])
        end


        if g == 7
        xlabel('a')
        end


        ylabel('f_{r, M}')


        f4.XTick = changetick;

        aux = 0; c = 1;
        for b = 1:length(changetick)
        aux2 = isempty(find(tresp{1,c} == aux,1));
            if aux2 == 0
                if tresp{1,c}(1,1) == aux
                f4.XTickLabel{b,1} = [ '**' num2str(aux) ];
                else
                f4.XTickLabel{b,1} = [ '*' num2str(aux) ];    
                end
            else
                f4.XTickLabel{b,1} =  num2str(aux);
            end    
            if aux == alfal-1
                aux = 0; c = c+1;
            else
               aux = aux+1;
            end
        end
        xtickangle(90)
        ylim([0 maxhist])
        f4.XLim(1,2) = f4.XLim(1,2)+ addxlim;
        
        if g == taunum+1
        h = legend(suport, 'FontSize', 10);
        set(h,'FontSize',8);
        newPosition = [0.35 0.05 0.2 0.32]; % standard [0.4 0.4 0.2 0.2]
        newUnits = 'normalized';
        set(h,'Position', newPosition,'Units', newUnits);
        end
    end

end

end