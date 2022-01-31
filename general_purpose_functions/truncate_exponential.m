% [nx,fx,Fnx] = truncate_exponential(lambda,t_int,x,fest)
%
% The function provides the truncated density function of the exponential
% function with parameter lambda. The trunction is done in the interval
% [a,b].
%
% INPUT:
%
% x =  x domain of the fx density function
% fest = density function
% t_int = interval of truncation
% lambda = parameter of the truncated distribution.
%
% OUTPUT:
%
% nx = new x axis.
% fx = truncated density function.
% Fnx = Cumulative density function for inverse sampling.
%
%
% Author: Paulo Passos     Date: 14/06/2021 

function [nx,fx,Fnx] = truncate_exponential(lambda,t_int,x,fest)

%t_int = [0.5 1.5];
ll = find(x >= t_int(1),1);
rl = find(x >= t_int(2),1);


nx = x(ll:rl);
prefest = fest(ll:rl);
norm_kct = trapz(nx,prefest);

Fnx = zeros(length(nx),1);

for a = 2:length(nx)
    Fnx(a,1) = (1/norm_kct)*trapz(nx(1,1:a),prefest(1,1:a));
end

nx = nx';
fx = (1/norm_kct)*lambda*exp(-lambda*nx); 

end