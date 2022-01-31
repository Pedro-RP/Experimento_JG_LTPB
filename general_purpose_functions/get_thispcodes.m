% function [pcodes] = get_thispcodes(alt_id, id, data)
%
% This function is part of the Goalkeeper Routine
% This function receives:
% alt_id = a vector containing the alternative id's of participants.
% id =  a string of vectors containing the participants codes.
% data = organized data with group, day, alternative code, tree.
%
% This function returns:
% pcodes = cell with the codes.

function [pcodes] = get_thispcodes(alt_id, id, data)

n = length(alt_id);
N = size(data,1);
pcodes = cell(n,1);

    for a = 1:n
       for b = 1:N
        if (data(b,4) == alt_id(a,1))&&(data(b,5) == 0)
            pcodes{a,1} = an_partpos(id,b);
        end
       end
    end


end