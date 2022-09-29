% [ F, dfb,dfer, MSB, MSE, p] = ANOVArm1f(A, alpha)
%
% Performs a ANOVA one-way repeated measures with the data in "A" for the
% the significancy level alpha. A is a matrix with different conditions in
% different columns and different subjects in different lines.

% A = the matrix containing the data.
% alpha = the significancy level.
% result = result of the hypothesis test
% F = Fisher ratio
% dfb = degrees of freedom of the MSB estimate.
% dfer = degrees of freedom of the MSE estimate.
% MSB = mean squared between
% MSE = mean squared error.
% p = p-value

function [ F, dfb,dfer, MSB, MSE, p] = ANOVArm1f(A, alpha)

c = size(A,2); % number of conditions
n = size(A,1); % number of subjects

% Calculating SSQt

Gm = 0; % grandmean

for a = 1: size(A,1)
   for b = 1: size(A,2)
      Gm = Gm + A(a,b); 
   end
end

Gm = Gm/(size(A,1)*size(A,2));

SSQt = 0;

for a = 1: size(A,1)
   for b = 1: size(A,2)
      SSQt = SSQt + (A(a,b)-Gm)^2; 
   end
end


% Calculating SSQb = SSQc 

Xmk = zeros(c,1);

for a = 1:c 
    Xmk(a,1) = mean(A(:,a));
end

SSQc = 0;
for a = 1:c
    SSQc = SSQc+(Xmk(a,1)-Gm)^2; 
end

SSQc = n*SSQc;

% Calculating SSQw

Xmk = zeros(c,1);

for a = 1:c 
    Xmk(a,1) = mean(A(:,a));
end

SSQw = 0;
for a = 1:c
    for b = 1:n
        SSQw = SSQw + (A(b,a) - Xmk(a,1))^2;
    end
end

% Calculating SSQp

totalpp = zeros(c,1);

for a = 1: n
totalpp(a,1) = sum(A(a,:));
end

total = sum(totalpp);

SSQp = (1/c)*sum(totalpp.^2) - (total^2)/(n*c);

% Calculating SSQer

SSQer = SSQw- SSQp;

% Calculating the degrees of freedom

dfer = (c*n - c)- (n - 1);
dfb = c-1;

% Calculating MSE

MSE = SSQer/dfer;
MSB = SSQc/dfb;

% Calculating F

F = MSB/MSE;

% Calculating etta2

etta2 = SSQc/SSQt;

% Calculating the critical F (substituting this for the graphical alternative)


x = [0:0.01:30];
Fdist = fcdf(x , dfb, dfer);

figure

plot(x,Fdist,'b')
title('ANOVA one-way repeated measures')
xlabel('values')
ylabel('probability')
hold on
plot(x,(1-alpha)*ones(length(x),1), 'r')
plot(ones(length(x),1)*F,linspace(0,1,length(x)), 'k')
legend('F distribution', '\alpha significance level', ['F_{calc} = ' num2str(F) ])

% verifying

ref = find(x>= F,1);

p = Fdist(1,ref-1);

p = 1-p;

end