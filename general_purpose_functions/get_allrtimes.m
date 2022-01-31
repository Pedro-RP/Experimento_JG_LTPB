% rtimes_all = get_allrtimes(data,ids,from, till, tau_id)
%
% This function is part of the goalkeeper game routines. It returns the
% response times of a list of  participants identified in ids.
%
% INPUT:
% data = data matrix from the function building_DataMatrix
% ids = a list of integers identifying the participants
% from = from which sample of the response times it should pick.
% till = till which sample of the response times it should pick.
% tau_id = identifies which tree you want the sample
%
% OUTPUT:
% rtimes_all = A matrix in which each column is response times series of a
% participant
%
% Author: Paulo Roberto Cabral Passos
% Last Modified: 25/11/2020
% Status: Checked

function rtimes_all = get_allrtimes(data,ids,from, till, tau_id)

rtimes_all = zeros((till - from)+1, length(ids));
for a = 1:length(ids)
    rtimes_all(:,a) = get_rtimes(data, ids(a), from, till, tau_id);
end

end