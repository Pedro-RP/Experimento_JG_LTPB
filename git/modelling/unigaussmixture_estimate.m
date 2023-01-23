% [mu_est, sigm_est, mix_est, it, fx_est] = unigaussmixture_estimate(X, mu, sigm, mix )
%
% This function takes the vector of samples in X and estimates a gaussian
% mixture model with the given initial parameters:
%
% INPUT:
% X = column vector containing the samples.
% mu = line vector containing the initial guess for the mean of each
% component.
% sigm = line vector containing the initial guess for the variance of each
% component.
% mix = line vector containing the initial guess for the mixture coefficients of each
% component.
%
% OUTPUT:
% mu_est = estimated means
% sigm_est = estimated variances
% mix_est = estimated mixture coefficients
% it = number of iterations.
% fx_est = density estimate from the estimated parameters.
%
% Author: Paulo Roberto Cabral Passos    Date: 23/05/2022


function [mu_est, sigm_est, mix_est, it, fx_est] = unigaussmixture_estimate(X, mu, sigm, mix)

N = size(X,1);
K = size(mu,2);
Nk = zeros(1,K);

L = 10^5;it = 0;
Gamma_znk = zeros(N,K);
while 1
    % Calculating the log-likelihood
    first_sum = 0;
    for n = 1:N
       second_sum = 0;
       for k = 1:K 
          second_sum = second_sum + mix(k)*mvnpdf(X(n),mu(k),sigm(k));
       end
       first_sum = first_sum + log(second_sum);
    end
    if abs(first_sum - L) <= 10^(-8)
       break;
    end
    L = first_sum;
    % Calculating gamma(z_nk)
    for n = 1:N
       den_sum = 0;
       for j = 1:K
       den_sum = den_sum + mix(j)*mvnpdf( X(n) , mu(j) , sigm(j));
       end
       for k = 1:K
       Gamma_znk(n,k) = (  mix(k)*mvnpdf( X(n) , mu(k), sigm(k))  )/den_sum;     
       end
    end  
    Nk(:,:) = sum(Gamma_znk,1);
    for k = 1:K
       munew_sum = 0;
       for n = 1:N
          munew_sum = munew_sum + Gamma_znk(n,k)*X(n);
       end
       mu(k) = (1/Nk(k))*munew_sum;
    end
    for k = 1:K
        signew_sum = 0;
        for n =1:N
           signew_sum = signew_sum + Gamma_znk(n,k)*( X(n)^2 - mu(k)^2 ); 
        end
        sigm(k) = ( 1/Nk(k) )*signew_sum;
        mix(k) = Nk(k)/N;
    end
    it = it+1;
end

mu_est = mu; sigm_est = sigm; mix_est = mix;

x = [min(X):0.05: max(X)]';
fxk_est = zeros(length(x),K);
for k = 1:K
   fxk_est(:,k) = mix(k)*normpdf(x,mu_est(k),sigm_est(k)); 
end
fx_est = sum(fxk_est,2);

end