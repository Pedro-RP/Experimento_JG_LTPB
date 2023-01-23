function tree = BiContexts_to_tree(contexts, Alphabet)

NODES = cell(100,1);
% create a node for each context
max_level = 0;

la = length(Alphabet);

for ii = 1 : length(contexts)
    level = size(contexts{ii}, 2); %level = length(contexts{ii});
    txt = contexts{ii};
    %txt = mat2str(contexts{ii});
    %txt(regexp(txt,'[[ ]]'))=[]; % elimina corchetes y espacios en blanco
    NODES{level} = [NODES{level}, node(txt)];
    if level > max_level
        max_level = level;
    end
end

for ii = max_level : -1 : 1
    % looks for sibling, create parents and add it to the next level
    is_sibling = zeros(1,numel(NODES{ii}));
    for jj = 1 : numel(NODES{ii})
        if ~is_sibling(jj)
            n1 = NODES{ii}(jj);
            new_node = node(n1.data(:,2:end), n1); %new_node = node(n1.data(2:end), n1);
            col = n1.data(:,1);                    %idx_sibling = find(Alphabet == str2double(n1.data(1)));
            idx_sibling = la*col(1) + col(2);
            for kk = jj + 1 : numel(NODES{ii})
                if ~is_sibling(kk)
                    n2 = NODES{ii}(kk);
                    if isequal(n1.data(:,2:end), n2.data(:,2:end))  % strcmp(n1.data(2:end), n2.data(2:end))
                        %determine where to insert
                        col = n2.data(:,1);
                        ida = la*col(1) + col(2);  %ida = find(Alphabet == str2double(n2.data(1)));
                        idx = find(idx_sibling > ida, 1);
                        if ~isempty(idx)
                            new_node.insert_child(n2, idx);
                            idx_sibling = [idx_sibling(1:idx-1), ida, idx_sibling(idx:end)];
                        else
                            new_node.add_child(n2);
                            idx_sibling = [idx_sibling, ida];
                        end
                        is_sibling(kk) = 1;
%                         is_sibling(jj) = 1;
                    end
                end
            end
            if ii > 1
                NODES{ii-1} = [NODES{ii-1}, new_node];
            end
        end
    end 
end

if max_level > 0
    tree = new_node;
else
    tree = node('empty');

end