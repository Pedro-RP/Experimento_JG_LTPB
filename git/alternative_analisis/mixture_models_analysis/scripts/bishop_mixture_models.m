% Mixture models study

% For one-dimensional data

x = -15:0.1:15;
mu1 = 0; mu2 = 3.5; mu3 = 7;
sig1 = 2; sig2 = 2; sig3 = 2;
mix1 = 0.25; mix2 = 0.5; mix3 = 0.25;

fx1 = mix1*(1/(sig1*sqrt(2*pi)))*exp((-1/2)*(1/sig1^2)*((x-mu1).^2));
fx2 = mix2*(1/(sig2*sqrt(2*pi)))*exp((-1/2)*(1/sig2^2)*((x-mu2).^2));
fx3 = mix3*(1/(sig3*sqrt(2*pi)))*exp((-1/2)*(1/sig3^2)*((x-mu3).^2));

fx = fx1+fx2+fx3;

figure
plot(x,fx1)
hold all
plot(x,fx2)
plot(x,fx3)
plot(x,fx)

% trapz(x,fx) % it follows that the linear combination integrates to 1.


% For the multi-variate case (using bivariate as an example)

y = x;
rho1 = 0;
rho2 = 0;
rho3 = 0;

% fx1M = (1/2*pi*sig1*sig1*sqrt(1-rho^2));
% fx1M = fx1M*exp( -(1/(2*(1-rho^2)))*( (((x-mu1)/(sig1)).^2) -2*rho*((x-mu1)/(sig1)).*((y-mu1)/(sig1)) + (((x-mu1)/(sig1)).^2) ) );


[X,Y] = meshgrid(x',y');
FX1 = 1/( 2*pi*sig1*sig2*sqrt(1-rho1^2) );
FX1exparg =  (  ( (X-mu1).^2 )/(sig1^2)  ) - 2*rho1*(X-mu1).*(Y-mu1)/(sig1*sig1) + (  ( (Y-mu1).^2 )/(sig1^2)  );
FX1 = FX1*exp(-FX1exparg/2*(1-rho1^2));

FX2 = 1/( 2*pi*sig1*sig2*sqrt(1-rho2^2) );
FX2exparg =  (  ( (X-mu2).^2 )/(sig1^2)  ) - 2*rho2*(X-mu2).*(Y-mu2)/(sig2*sig2) + (  ( (Y-mu2).^2 )/(sig2^2)  );
FX2 = FX2*exp(-FX2exparg/2*(1-rho2^2));

FX3 = 1/( 2*pi*sig1*sig2*sqrt(1-rho3^2) );
FX3exparg =  (  ( (X-mu3).^2 )/(sig3^2)  ) - 2*rho3*(X-mu3).*(Y-mu3)/(sig3*sig3) + (  ( (Y-mu3).^2 )/(sig3^2)  );
FX3 = FX3*exp(-FX3exparg/2*(1-rho3^2));

% For latter purposes
FXs(:,:,1) = FX1; FXs(:,:,2) = FX2; FXs(:,:,3) = FX3;

FX = mix1*FX1 + mix2*FX2 + mix3*FX3;

figure
subplot(1,2,1)
surf(X,Y,FX);
subplot(1,2,2)
contourf(X,Y,FX)

surfint = zeros(length(X),1);
for a = 1:length(X)
   surfint(a,1) = trapz(x,FX(:,a));     
end

trapz(x, surfint)

% Sampling strategy from pag. 432

% Defining the number of components and respective probabilities

k = 3;
p = [0.3 0.4 0.3]';

% For the next step, we will need to calculate the cumulative distributions
% of all FX


FXs_c = zeros(size(FXs,1),size(FXs,2),size(FXs,3)); % cumulative distributions of the components


for a = 1:k
   for by = 2:length(Y)
       for bx = 2:length(X)
          surfint = zeros(by,1); 
          for c = 2:length(surfint)
             surfint(c,1) = trapz(X(c,1:bx),FXs(c,1:bx,a)); 
          end
          FXs_c(bx,by,a) = trapz(Y(1:by,1),surfint);
       end
   end
end

figure % plotting the cumulative distributions
subplot(2,2,1)
surf(X,Y,FXs_c(:,:,1));
subplot(2,2,2)
surf(X,Y,FXs_c(:,:,2));
subplot(2,2,3)
surf(X,Y,FXs_c(:,:,3));

% Generating the z vectors

lower_plim = zeros(k,1);
higher_plim = zeros(k,1);

for a = 1:k
   if a == 1
       higher_plim(a,1) = p(a,1);
   else
       lower_plim(a,1) = higher_plim(a-1,1);
       higher_plim(a,1) = lower_plim(a,1)+p(a,1);
   end
end

N = 1000;
z_samples = zeros(N,1);
for a = 1:N
   s = unifrnd(0,1);
   for b = 1:k
      if ( s > lower_plim(b,1) )&&( s <= higher_plim(b,1) )
      z_samples(a,1) = b;
      end
   end
end


x_sample = zeros(N,1);
y_sample = zeros(N,1);
mu = [mu1, mu1; mu2, mu2; mu3, mu3];
sigma = [sig1, 0; 0, sig1]; % valid only when all sigmas are equal

% Using the 
for b = 1:length(z_samples)
    draw = mvnrnd(mu(z_samples(b),:),sigma,1);
    x_sample(b,1)= draw(1);
    y_sample(b,1)= draw(2);
end

% JUST FOR TESTING SOMETHING
% for b = 1:length(z_samples)
% Pylim = FXs_c(:,end,z_samples(b));
% zx = unifrnd(0,1);
% aux_x = find(Pylim >= zx, 1);
% Px_slice = FXs_c(aux_x,:,z_samples(b));
% zy = unifrnd(0,1);
% Px_slice_norm = Px_slice./max(Px_slice);
% aux_y = find(Px_slice_norm >= zy,1);
% x_sample(b,1)= X(1,aux_x);
% y_sample(b,1)= Y(aux_y,1);
% end

figure
subplot(1,2,1)
contourf(X,Y,FX)

subplot(1,2,2);
hold all
for a = 1:k
scatter(x_sample(find(z_samples == a)),y_sample(find(z_samples == a)),'filled') %#ok<FNDSB>
end
legend('k = 1','k = 2','k = 3')
axis([x(1) x(end) y(1) y(end)])