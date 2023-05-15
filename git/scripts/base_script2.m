% estimating the context trees for response times per epoch

pathtogit = '/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/research_codes';
addpath(genpath(pathtogit))

% loading data

load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_15042023/data_files_r02/valid_20092022.mat')
load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_15042023/thesis_data_r01/set2_matrix.mat')

epochs = [1 334; 335 664; 665 1000];

% processing
est_trees = cell(sum(valid_p), size(epochs,1));
epoch_trees = cell(size(epochs,1),1);
for ep = 1:size(epochs,1)    
    aux = 1;
    for a = 1:length(valid_p)
       if valid_p(a) == 1
          [rt, chain] = get_rtimes(data, a, epochs(ep,1), epochs(ep,2), 7);
          [tau_est] = tauest_RT(3, rt', chain', 0);
          est_trees{aux,ep} = tau_est;
          aux = aux+1;
       end
    end
% calculating the mode trees
[epoch_trees{ep,1}] = taumode_est(3, est_trees', floor(log10(epochs(1,2))/log10(3)), 0, 0);
disp(['end of epoch' num2str(ep)])
end


%% preparing tree of maximum variability
close all
ms_factor = 30;

load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/data_files_r04/estimated_trees_epochs28032023.mat')
num_part = size(est_trees,1);
all_retrieved = {};
ep = 1; aux_add = 1;
for p = 1:size(est_trees,1)
    tree = est_trees{p,ep};
    for w = 1:size(tree,2)
       aux_v = 0;
       for w_alt = 1:size(all_retrieved,2)
           if isequal(all_retrieved{1, w_alt},tree{1, w})
              aux_v = 1;
           end
       end
       if aux_v == 0
          all_retrieved{1,aux_add} = tree{1,w}; %#ok<SAGROW>
          aux_add = aux_add+1;
       end
    end
end

vec_let = zeros(1,size(all_retrieved,2));
for w = 1:size(all_retrieved,2)
    aux = 1;
    for w_alt = 1:size(all_retrieved,2)
       if length(all_retrieved{1,w}) < length(all_retrieved{1,w_alt})
          if sufix_test(all_retrieved{1,w},all_retrieved{1,w_alt})
             aux = 0;
          end
       end
    end
    vec_let(1,w) = aux;
end

limit_tree = cell(1,sum(vec_let));
aux_add = 1;
for w = 1:length(vec_let)
    if vec_let(1,w) == 1
       limit_tree{1,aux_add} = all_retrieved{1,w};
       aux_add = aux_add + 1;
    end
end

% graphics
close all
set(0, 'DefaultFigureRenderer', 'painters')
set(0, 'DefaultFigureColor', [1 1 1] )
draw_contexttree(limit_tree, [0 1 2], [0 0 0])
lines = findobj('Type','line');
for l = 1:length(lines)
   lines(l).LineWidth = 3;
end

% fixing the location of leafs
texts = findobj('Type','text');
for w =1:length(texts)
    cord = texts(w).Position;
    dist = 10^6; ltf = 0;
    for l = 1:length(lines)
        aux_dist = sqrt(  (lines(l).XData(2)-cord(1))^2 + (lines(l).YData(2)-cord(2))^2  );
        if aux_dist < dist
           dist = aux_dist;
           ltf = l;
        end
    end
    texts(w).Position = [lines(ltf).XData(2), lines(ltf).YData(2) 0];
end



while 1
    limit_tree = cut_cellentries(limit_tree);
    check_indtree = 1;
    for w = 1:length(limit_tree)
        if length(limit_tree{1,w})>1
           check_indtree = 0;
        end
    end

    if check_indtree == 0    
        %
        new_tree = {}; aux = 1;
        for w = 1:length(limit_tree)
            if ~( length(limit_tree{1,w}) == 1 )
                new_tree{1,aux} = limit_tree{1,w};
                aux = aux+1;
            end
        end
        limit_tree = new_tree;
        %
        texts = findobj('Type','text');
        first_child = zeros(1,length(limit_tree) );
        for l = 1:length(limit_tree)
            astring = strrep( num2str(limit_tree{1,l}), ' ','');
            for t = 1:length(texts)
                bstring = texts(t).String;
                if length(bstring) > length(astring) 
                   bstring = bstring(2:end);
                end
                if isequal(astring,bstring)
                   first_child(1,l) = t;
                   break;
                end
            end
        end

        place_text = zeros( 2,length(limit_tree) );
        for fc = 1:length(first_child)
            child = texts(first_child(fc)).Position;
            dist = 10^(6); aux = 0;
            for l = 1:length(lines)
                aux_dist = sqrt(  ( lines(l).XData(2) - child(1) )^2 + ( lines(l).YData(2) - child(2) )^2  );
                if aux_dist < dist
                   place_text(:,fc) =  [ lines(l).XData(1); lines(l).YData(1) ];
                   dist = aux_dist;
                end
            end
        end

        for t = 1:size(place_text,2)
            ct_string = strrep(num2str(limit_tree{1,t}),' ','');
            text(place_text(1,t), place_text(2,t), ct_string)
        end

    else
        limit_tree = {0 , 1 , 2};
        texts = findobj('Type','text');
        first_child = zeros(1,length(limit_tree) );
        for l = 1:length(limit_tree)
            astring = strrep( num2str(limit_tree{1,l}), ' ','');
            for t = 1:length(texts)
                bstring = texts(t).String;
                if length(bstring) > length(astring) 
                   bstring = bstring(2:end);
                end
                if isequal(astring,bstring)
                   first_child(1,l) = t;
                   break;
                end
            end
        end
        place_text = zeros(2,3);
        for fc = 1:length(first_child)
            child = texts(first_child(fc)).Position;
            dist = 10^(6); aux = 0;
            for l = 1:length(lines)
                aux_dist = sqrt(  ( lines(l).XData(2) - child(1) )^2 + ( lines(l).YData(2) - child(2) )^2  );
                if aux_dist < dist
                   place_text(:,fc) =  [ lines(l).XData(1); lines(l).YData(1) ];
                   dist = aux_dist;
                end
            end
        end

        for t = 1:size(place_text,2)
            ct_string = strrep(num2str(limit_tree{1,t}),' ','');
            text(place_text(1,t), place_text(2,t), ct_string)
        end
        break;
    end
end

% adding the null location
aux_dist = -10^(3); aux = 0;
for l= 1:length(lines)
    if lines(l).YData(1) > aux_dist
       aux_dist = lines(l).YData(1);
       aux = l;
    end
end

text(lines(l).XData(1), lines(l).YData(1), 'null')

%% Counting the number per epoch
all_retcounts = zeros( 1,length(all_retrieved) );
for p = 1:size(est_trees,1)
   for v = 1: length(all_retrieved)
           ctree = est_trees{p,ep};
       for w =1:length(ctree)
           if isequal(ctree{1,w}, all_retrieved{1,v})
              all_retcounts(1,v) = all_retcounts(1,v)+1;  
           end
       end
   end
end
null_counts = 0;
for p =1:size(est_trees,1)
    if isempty(est_trees{p,ep})
       null_counts = null_counts+1;
    end
end


%% Substituting the text by squares
texts = findobj('Type','text');
for w = 1:length(all_retrieved)
    astring = strrep(num2str( all_retrieved{1,w} ),' ','');
    for t = 1:length(texts)
        bstring = texts(t).String;
        if isequal(astring,bstring)
           plot(texts(t).Position(1), texts(t).Position(2),'ob','MarkerFaceColor','b','MarkerSize', (all_retcounts(1,w)/num_part)*ms_factor) 
        end
    end
end

null_marker = findobj('Type','text','String','null');
plot(null_marker.Position(1), null_marker.Position(2),'ob','MarkerFaceColor','b','MarkerSize', (null_counts/num_part)*ms_factor) 

texts = findobj('Type','text');
for t = 1:length(texts)
    delete(texts(t))
end
%% Marking sizes
% openfig('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/simulation_data/delete_after_use.fig')
g_ax = gca; max_show = 19;
xinterval = abs( g_ax.XLim(2)-g_ax.XLim(1) );
for c = 1:max_show
    text(min(g_ax.XLim)+c*xinterval/num_part, max(g_ax.YLim)+0.15, num2str(c))
    plot( min(g_ax.XLim)+c*xinterval/num_part, max(g_ax.YLim),'ob','MarkerFaceColor','b','MarkerSize', (c/num_part)*ms_factor)
end

saveas(gcf,['/home/roberto/Documents/pos-doc/article/painel2_parts/Modes/epoch' num2str(ep) '.png' ])
%% Preparing the individual trees
% preparing the figures
set(0, 'DefaultFigureRenderer', 'painters')
set(0, 'DefaultFigureColor', [1 1 1] )
load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/data_files_r04/estimated_trees_epochs28032023.mat')
close all

ep = 1; tit_tip = [2 5 8]; sub_tip = [1 2 3; 4 5 6; 7 8 9]; part_tip = [1 3; 4 6; 7 9; 10 12; 13 15; 16 18; 19 21; 22 22 ];
fig_trees = figure;
p_segment = 8;
for p = part_tip(p_segment,1):part_tip(p_segment,2)
    for ep = 1:3
        w = sub_tip(p - part_tip(p_segment-1,2),ep);
        subplot(3,3,w)
        if sum(ep == tit_tip)
           title(['p' num2str(p)])    
        end
        tree = est_trees{p,ep};
        draw_contexttree(tree, [0 1 2], [0 0 0])
        lines = findobj('Type','line');
        texts = findobj('Type','text');
        for l = 1:length(lines)
            lines(l).LineWidth = 3;
        end
        for t = 1:length(texts)
            if length(texts(t).String) > 4
               texts(t).FontSize = 8;
            elseif length(texts(t).String) > 3
               texts(t).FontSize = 10;
            else
               texts(t).FontSize = 12;
            end
        end
    end
end

saveas(gcf,['/home/roberto/Documents/pos-doc/article/painel2_parts/trees_part' num2str(part_tip(p_segment,1)) '-' num2str(part_tip(p_segment,2)) '.png' ])