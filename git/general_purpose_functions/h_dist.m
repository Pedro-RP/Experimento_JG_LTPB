% h = h_dist (p,q)
%
% Calculates the hellinger distance (h) between two probability distributions p
% and q.

function h = h_dist (p,q)

h = 0;
for k = 1:length(p)
    h = h +( sqrt(p(k))-sqrt(q(k)) )^2;
end
h = (1/2)*sqrt(h);

end


