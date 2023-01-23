function draw_BiContextTree(BiContexts, Alphabet, varargin)
    %varargin(1) have the specified color
    %varargin(2) have the specified height
    
    % call the usual function
    tree = BiContexts_to_tree(BiContexts, Alphabet);
    
    %
    dt = DrawTree(tree);
    buchheim(dt);
    
    switch length(varargin)
        case 1
            dt.do_graphic(varargin{1});
        case 2
            dt.do_graphic(varargin{1}, varargin{2});
        case 0
            dt.do_graphic();
    end

end