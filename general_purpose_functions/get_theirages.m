% [ages] = get_theirages(pcodes, codvalraw)
%
% This function receives:
% pcodes = cell containing a list o codes of participants
% codvalraw = questionarie cell array
%
% This function returns:
% ages = a vector containing the ages of the participants.

function [ages] = get_theirages(pcodes, codvalraw)

n = length(pcodes);
N = size(codvalraw,1);
ages = zeros(n,1);

    for a = 1:n
       for b = 2:N % becouse 1 is the header
            if strcmp(pcodes{a,1}, codvalraw{b,1})
            ages(a,1) = str2num(codvalraw{b,2}); %#ok<ST2NM>
            end
       end
    end

end