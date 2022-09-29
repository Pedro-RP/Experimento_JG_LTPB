% rtimes = get_rtimes(data, nid, from, till, tau_id)
%
% This function is part of the goalkeeper game routines. It returns the
% response times of the participant identified in nid.
%
% INPUT:
% data = data matrix from the function building_DataMatrix
% nid = integer that identifies the participant
% from = from which sample of the response times it should pick.
% till = till which sample of the response times it should pick.
% tau_id = identifies which tree you want the sample
%
% OUTPUT:
% rtimes = vector containing the response times
%
% Author: Paulo Roberto Cabral Passos
% Last Modified: 25/11/2020
% Status: Checked


function rtimes = get_rtimes(data, nid, from, till, tau_id)

beg = 0;
for a = 1:size(data,1)
  if ((data(a,6) == nid)&&(data(a,5) == tau_id))&&(data(a,3) == 1)
      beg = a;
      break
  end 
end
stop = 0;
for a = beg:size(data,1)
  if data(a,3) < data(beg,3)
     stop = a-1;
     break
  end
end
if stop == 0
   stop = size(data,1);
end
times = data(beg:stop,7);
rtimes = times(from:till,1);


end