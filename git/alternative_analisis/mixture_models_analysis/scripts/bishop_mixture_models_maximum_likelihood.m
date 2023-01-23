% Implementing Expectation maximization for Guassian Mixture Models pag. 439.
rng(0);
X = zeros(5000,1);
Rmu = [20 25]'; sig = [5 3]';
RSig = sig.^2';
Rmix = [0.7 0.3];
K = length(Rmix);
N = size(X,1);
Nk = zeros(size(Rmix,1),size(Rmix,2));


lower_plim = zeros(K,1);
higher_plim = zeros(K,1);

for a = 1:K
   if a == 1
       higher_plim(a,1) = Rmix(a);
   else
       lower_plim(a,1) = higher_plim(a-1);
       higher_plim(a,1) = lower_plim(a)+Rmix(a);
   end
end

N = length(X);
z_samples = zeros(N,1);
for a = 1:N
   s = unifrnd(0,1);
   for b = 1:K
      if ( s > lower_plim(b,1) )&&( s <= higher_plim(b,1) )
      z_samples(a,1) = b;
      end
   end
end

% Drawing according to the z vector 
for b = 1:length(z_samples)
    draw = random('Normal',Rmu(z_samples(b)),sqrt(  RSig( z_samples(b) )  ) );
    X(b) = draw;
end
X = X.^(1/3);

mu = [1 2]'; mu4check = mu; % The initial guess of mu for the two groups have to be different.
Sig = [1 2]'; sig4chech = Sig;
mix = [0.5 0.5]'; mix4check = mix;

figure
histogram(X,'Normalization','pdf');

L = 10^6; it = 0;
Gamma_znk = zeros(N,K);
Sig_hist = [];
Mu_hist = [];

while 1
    % Calculating the log-likelihood
    first_sum = 0;
    for n = 1:N
       second_sum = 0;
       for k = 1:K 
          second_sum = second_sum + mix(k)*pdf('Normal',X(n),mu(k), sqrt(Sig(k)) );
       end
       first_sum = first_sum + log(second_sum);
    end
    deltaL = abs(first_sum - L);
    if deltaL < 0.0000001
        break
    end
    L = first_sum;
%   Calculating gamma(z_nk)
    for n = 1:N
       den_sum = 0;
       for j = 1:K
       den_sum = den_sum + mix(j)*pdf('Normal', X(n) , mu(j) , sqrt(Sig(j)) );
       end
       for k = 1:K
       Gamma_znk(n,k) = (  mix(k)*pdf( 'Normal', X(n) , mu(k),  sqrt(Sig(k)) ) )/den_sum;     
       end
    end
    % Calculating Nk
    Nk = sum(Gamma_znk,1);
    % Calculating Mu
    for k = 1:K
       munew_sum = 0;
       for n = 1:N
          munew_sum = munew_sum + Gamma_znk(n,k)*X(n);
       end
       mu(k) = (1/Nk(k))*munew_sum;
    end
    % Calculating Sig
    for k = 1:K
        signew_sum = 0;
        for n =1:N
           signew_sum = signew_sum + Gamma_znk(n,k)*( X(n)^2 - mu(k)^2 ); 
        end
        Sig(k) = ( 1/Nk(k) )*signew_sum;
        mix(k) = Nk(k)/N;
    end
    it = it+1;
end

h = gca;
ll = min(X)-std(X); rr = max(X)+std(X);
x = [ll:0.01: rr]';
fxk_est = zeros(length(x),K);
for k = 1:K
   fxk_est(:,k) = mix(k)*normpdf(x,mu(k),sqrt(Sig(k))); 
end
fx_est = sum(fxk_est,2);

yyaxis right
plot(x,fx_est,'r-','LineWidth',3)


