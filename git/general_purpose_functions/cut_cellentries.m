% % new_vector = cut_cellentries(cell_vector)
% % UNCOMMENTED YET DATE: 29/03/2023
% 
function new_vector = cut_cellentries(cell_vector)

vector_cut = cell(1, size(cell_vector,2));
   for w = 1:length(vector_cut)
       if length(cell_vector{1,w})>1
          vector_cut{1,w} = cell_vector{1,w}(1,2:end);
       else
          vector_cut{1,w} = cell_vector{1,w};
       end
   end
   vec_equal = zeros(1,length(vector_cut)); aux = 0;
   for w = 1:length(vector_cut)
       if vec_equal(1,w) == 0
           aux = aux+1;
           for w_alt = 1:length(vector_cut)
               if isequal(vector_cut{1,w},vector_cut{1,w_alt})
                  vec_equal(1,w_alt) = aux;
               end
           end           
       end
   end
   new_vector = cell( 1,max(vec_equal) );
   for w = 1:max(vec_equal)
       new_vector{1,w} = vector_cut{1,find(vec_equal == w, 1)};
   end
   
end