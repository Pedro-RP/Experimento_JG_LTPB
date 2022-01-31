% sc = step_cell(alt_id, cells)
%
% This function is part of the Goalkeeper game analysis
%
% This function returns a matrix Nx2 with the identification of the step to
% wich the cell belong in the first column given the alternative id column
% vector and the number of cells per step.
%
% alt_id = vector containing, for each cell, the id of the participant
% cells = vector containing, the number of cells in each step.

function sc = step_cell(alt_id, cells)

ttime = length(alt_id);
ttime2 = max(alt_id);
b = 1;
sc = zeros(length(alt_id),2);
    for a = 1: length(cells)
        c = 1;bi = b;
        while b <= (bi+cells(1,a)-1)
        sc(b,1) = c;
        c = c+1; b = b+1;
        end
    end

    for a = 1:max(alt_id)
    s = 0;
       for b = 1:length(alt_id)
          if alt_id(b,1) == a
              if sc(b,1) == 1
              s=s+1;    
              sc(b,2) = s;     
              else
              sc(b,2) =s;    
              end
          end
       end 
    end
    
end