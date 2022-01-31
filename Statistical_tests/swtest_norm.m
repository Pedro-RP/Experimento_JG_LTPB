%[W,Z,p] = swtest_norm(x)
%
% This test performs the Shapiro-Wilk test for assessing normality of the
% data in the x column vector.
% x = vector column data
% W =  statistic of the Shapiro Wilk test
% Z = the approximated Z statistic for W
% p = p-value of the test


function [W,Z,p] = swtest_norm(x)

N = size(x,1);
xs = sort(x,1);

index = [1:N]'; %#ok<NBRAK>

m = norminv( (index-0.375)/(N+0.25) );

SS_m = m'*m;

u = 1/sqrt(N);

U = [u^5 u^4 u^3 u^2 u SS_m^(-1/2)]';

c_an = [-2.706056 4.434685 -2.071190 -0.147981 0.221157 m(N,1)]';

c_an1 = [-3.582633 5.682633 -1.752461 -0.293762 0.042981 m(N-1,1)]'; 



A = zeros(N,1);

A(N,1) = c_an'*U;
A(N-1,1) =  c_an1'*U;

en = SS_m-2*m(N,1)^2-2*m(N-1,1)^2;
ed = 1-2*A(N,1)^2-2*A(N-1,1)^2;
e = en/ed;

for a = 1:N-2
    if a == 1
       A(1,1) = -A(N,1); 
    elseif a == 2
       A(2,1) = -A(N-1,1);
    else
       A(a,1) = m(a,1)/sqrt(e);
    end
end

Wn = 0;
Wd = 0;


for a = 1:N
   Wn = Wn+A(a,1)*xs(a,1);
   Wd = Wd+(xs(a,1)-mean(xs,1))^2; 
end

W = (Wn^2)/Wd;

mu_c = [0.0038915 -0.083751 -0.31082 -1.5861]';
mu_v = [log(N)^3 log(N)^2 log(N) 1]';
mu = mu_c'*mu_v;

v_c = [0.0030302 -0.082676 -0.4803]';
v_v = [log(N)^2 log(N) 1]';
v = v_c'*v_v;
v = exp(v);


Z = (log(1-W)- mu)/v;

% Comparing the statistic with the distribution

alpha = 0.05;
pts = -10:0.001:10; 

pd = makedist('Normal');
ncdf = cdf(pd,pts);


% figure
% 
% plot(pts,ncdf,'b')
% title('Shapiro-Wilk Normality Test')
% xlabel('values')
% ylabel('probability')
% hold on
% plot(pts,(1-alpha)*ones(length(pts),1), 'r')
% plot(ones(length(pts),1)*Z,linspace(0,1,length(pts)), 'k')
% legend('Standard normal distribution', ['\alpha significance level ' num2str(alpha) ], ['Zcalc = ' num2str(Z) ])

ref = find(pts >= Z,1);

p = ncdf(1,ref);

p = 1-p;

end