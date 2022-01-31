% [df, W, Xw, p] = sphericitytest(A,chimin,chimax, alpha)
%
% The function performs the Mauchly's sphericity test on the data of "A".
% This test is used to verify if the sphericity is satisfied in repeated me
% measures data."A" is a matrix in which each column corresponds to a dif-
% ferent condition and each line to a different object who will be reapete-
% dly measured.
%
% A = matrix data
% Chimin = minimum value of the Xw distribution
% Chimax = maximum value of the Xw distribution
% alpha = significancy test
% df = degrees of freedom of the W statistic
% W = statistic of the Mauchly's test
% Xw = statistic of the corresponding Chi-squared distribution.
% p = p-value.


function  [df, W, X2w, p] = sphericitytest(A,chimin,chimax, alpha)

% Data conditions and objects

n = size(A,1);
c = size(A,2);

% Calculating the estimates of the covariances between the groups


aux = zeros(2,2);
tmat = zeros(c,c);

for a = 1: c
   for b = 1:c
   aux = cov(A(:,a), A(:,b));
   tmat(a,b) = aux(1,2);
   end 
end

ta = sum(tmat,2)/c;
tm = sum(ta,1)/c;

% Calculating the double-centered covariance matrix

S = zeros(c,c);

for a = 1: c
   for b = 1:c 
   S(a,b) = tmat(a,b) - ta(a,1) - ta(b,1) + tm;
   end
end

% Calculating the eigenvalues of the covariance matrix

lambv = eig(S);

% Calculating the statistic W
aux2 = find(lambv < 1*10^(-10));

nzl = [];
for a = 1: c
   if isempty(find(aux2 == a,1))
       nzl = [nzl ; lambv(a,1)]; %#ok<AGROW>
   end
end

Wn = 1;
Wd = 0;
for a = 1: size(nzl,1)
    Wn = Wn*nzl(a,1);
    Wd = Wd + nzl(a,1);
end

Wd = ( (1/(c-1))*Wd )^(c-1);
W = Wn/Wd;

% Approximating the W distribution with a Chi-squared.

f = 2*(c-1)^(2)+c+2;
f = f/( 6*(c-1)*(n-1) );

X2w = -(1-f)*(n-1)*log(W); % approximation with the Chi-squared

% Calculating the degrees of freedom

df = (1/2)*c*(c-1);

% Comparing the statistic with the distribution

x = chimin:0.001:chimax; 
X2dist = chi2cdf(x,df);

figure

plot(x,X2dist,'b')
title('Machauly Sphericity Test')
xlabel('values')
ylabel('probability')
hold on
plot(x,(1-alpha)*ones(length(x),1), 'r')
plot(ones(length(x),1)*X2w,linspace(0,1,length(x)), 'k')
legend('\chi_{w}^{2}-squared distribution', ['\alpha significance level ' num2str(alpha) ], ['Xw = ' num2str(X2w) ])

ref = find(x >= X2w,1);

p = X2dist(1,ref);

p = 1-p;

end