% Y = inverse_sampling(x,fx,n)

% The function provides a 'n' size sample from the distribution with
% density function given by (x,fx). A spline method is used for
% interpolation.
%
% INPUT:
%
% x =  x domain of the fx density function
% fx = density function
% n = sample size
%
% OUTPUT:
%
% Y = vector with the sample from the random variable with fx with density
% function
%
% Author: Paulo Passos     Date: 14/06/2021 

function Y = inverse_sampling(x,fx,n)

% Calculating the CDF

Fx = zeros(length(x),1);
for a= 2:length(x)
Fx(a) = trapz(x(1:a),fx(1:a));    
end

% Generating the random number from a uniform distribution

ui = rand(n,1);
xi = pchip(Fx,x,ui);

Y = xi;
end