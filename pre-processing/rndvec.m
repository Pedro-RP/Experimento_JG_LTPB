% rndr = rndvec(rndness, mlength)
%
% This function is part of the Goalkeeper game routine
%
% The function takes the string containing the information that indicates
% if a response is random or not and return in a vector format in which
% 'Y' is indicated by 1, and 'n' is indicated by 0.
%
% Entries:
% rndness = string containing the responses.
% mlength = vector length previously calculated.
%
% Return:
% rndr =  vector format of rndness;

function rndr = rndvec(rndness, mlength)

rndr = zeros(mlength,1);
b = 1;
for a =1:length(rndness)
    if (rndness(1,a) == 'Y')||(rndness(1,a) == 'n')
        if rndness(1,a) == 'Y'
            rndr(b,1) = 1;
            b = b+1;
        else
            rndr(b,1) = 0;
            b = b+1;
        end
    else
    end
end

end