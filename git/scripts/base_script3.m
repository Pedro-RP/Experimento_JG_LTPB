height = 5;
alphabet = [0 1 2];
pathtogit = '/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/ResearchCodes'; tau = 7; seq_length = 100;
tree_file_address = [pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt' ];
[contexts, PM,~ , ~] = build_treePM (tree_file_address);
seq = gentau_seq (alphabet, contexts, PM, seq_length);

% construct the set that will be the basis for the procedure
string_set = full_tree_with_vertices(alphabet, height);

% detecting the branches

brothers = indentifying_branches(string_set, height);

% reducing the time of the procedure
w_discard = []; aux_add = 1;
for d = 2:(height-1)
    chains = permwithrep([0 1 2], d);
    for c = 1:size(chains)
        [~, ~, occurance_count] = count_contexts({chains(c,:)}, seq);
        if occurance_count == 0
            w_discard{1,aux_add} = chains(c,:);
            aux_add = aux_add + 1;
        end
    end
end

h = height; eliminate = [];
while 1
    for w = 1:length(brothers)
        w_next = string_set{1,w};
        disc = 0;
        if length(w_next) == h
           for w_alt = 1:length(w_discard)
               if sufix_test(w_discard{1,w_alt},w_next)
                  bro_list = find(brothers == brothers(w)); bro_count = 0;
                  for br = 1:length(bro_list)
                      bro_count = bro_count ...
                          +sufix_test(w_discard{1,w_alt},string_set{1,bro_list(br)});
                  end
                  disc = floor( bro_count/length(bro_list) );
                  if disc == 1; break; end
               end
           end
           if disc == 1
              eliminate = [eliminate brothers(w)];
           end
        end
    end
h = h-1;
    if h < 3
       break; 
    end
end

eliminate = unique(eliminate);

new_string_set = {};
new_brothers = []; aux_add = 1;
for b = 1:length(brothers)
    if isempty(  find( eliminate == brothers(b) )  )
       new_string_set{1,aux_add} = string_set{1,b};
       new_brothers(1,aux_add) = brothers(b);
       aux_add = aux_add + 1;
    end
end

aux_rank = unique(new_brothers);
for b = 1:length(new_brothers)    
    new_brothers(b) = find(aux_rank == new_brothers(b));
end
string_set = new_string_set;
brothers = new_brothers;

% generate all combination of branches
[tree_list, elements] = generating_subtrees(brothers, string_set);

% performing corrections
wbar = waitbar(0, 'Rectifying trees...');
for t = 1:size(tree_list,1)
    if tree_list(t,1) == 1
       % correction procedure
       if ~isempty(string_set(find(elements(t,:) == 1))) %#ok<FNDSB>
           while 1
                 modified = 0;
                 tree_aux = string_set(find(elements(t,:) == 1)); %#ok<FNDSB>
                 for w = 1:length(tree_aux)
                            w_next = tree_aux{1,w}; one_modification = 0;
                            while ~isempty(w_next)
                                   uncles = generating_uncles(w_next, alphabet);
                                   % find where the uncles are in the string_set
                                   [elements_row, one_modification] = best_uncles_fit(pinpoint_uncleslocation(string_set, uncles), elements(t,:), string_set);
                                   if one_modification == 1
                                      elements(t,:) = elements_row; modified = 1;
                                   end
                                w_next = gen_imsufix(w_next);
                            end
                 end
                 if modified == 0
                    break
                 end
           end
       end  
    end
    waitbar(t/length(tree_list),wbar)
end
close(wbar)

elements_full = elements;

% rectifying according to the chain
wbar = waitbar(0, 'Rectifying trees according to the chain...');
for t = 1:length(tree_list)
    if tree_list(t,1) == 1
       for a = 1:size(elements,2)
           if elements(t,a) == 1
              [~, ~, occurance_count] = count_contexts(string_set(a), seq);
              if occurance_count == 0
                 elements(t,a) = 0; 
              end
           end
       end
    end
    waitbar(t/length(tree_list),wbar)
end
close(wbar)

elements = elements( find(tree_list == 1),: ); %#ok<FNDSB>
elements = unique(elements, 'rows');


% building the vertices trees representation
elements_vertices = zeros( size(elements,1), size(elements,2) );
wbar = waitbar(0, 'Getting the vertice tree representation...');
for t = 1:size(elements,1)
    for w = 1:size(elements,2)
        if elements(t,w) == 1
           w_next = string_set{1,w};
           while ~isempty(w_next)
                  for s = 1:length(string_set)
                      if isequal(string_set{1,s},w_next)
                         elements_vertices(t,s) = 1;
                      end
                  end
                  w_next = gen_imsufix(w_next);
           end           
        end
    end
    waitbar(t/size(elements,1),wbar)
end
close(wbar)

% Removing only childs

wbar = waitbar(0, 'Removing only childs...');
for t = 1:size(elements,1)
    while 1
        modified = 0;
        for w = 1:size(elements,2)
            if elements(t,w) == 1
               w_next = gen_imsufix(string_set{1,w});
               occurance_count = 0; bro_list = [];
               for b = 1:size(alphabet,2)
                   bro = [alphabet(b) w_next]; bro_list = [bro_list; bro];
                   for v = 1:size(elements,2)
                       if elements_vertices(t,v) == 1
                          if isequal(bro,string_set{1,v}); occurance_count = occurance_count+1;end
                       end
                   end
               end
               if occurance_count < 2 % found a only child
                  elements(t,w) = 0; elements_vertices(t,w) = 0; modified = 1;
                  for v = 1:size(elements,2)
                      if isequal(string_set{1,v},w_next)
                         elements(t,v) = 1; elements_vertices(t,v) = 1;
                      end
                  end
               end
            end
        end
        if modified == 0; break; end
    end
    waitbar(t/size(elements,1),wbar)
end
close(wbar)

elements = unique(elements,'rows');

for t = 1:size(elements,1)
       draw_contexttree(string_set(elements(t,:)==1), alphabet, [0 0 0])
       pause
       close
end
