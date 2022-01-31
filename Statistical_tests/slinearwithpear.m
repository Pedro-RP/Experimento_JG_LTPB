% [alfa, beta,r, tcrit, tcalc, p] = slinearwithpear(predictor,predicted, alpha)
%
% Performs a simple linear regression, gives the pearson correlation
% coefficint and the parameters of the significance test.
% predictor = vector with the data of the predictor
% predicted = vector with the data that should be predicted
% alpha = level of significance for the t-test
% alfa = alfa coefficient of the linear regression (alfa + beta*predictor)
% beta = beta coefficient of the linear regression (alfa + beta*predictor)
% tcrit = t critical value for the t-test given the significance level
% alpha
% tcalc = t-value calculated for the correlation coefficient.
% p = p-value of the test.


function [alfa, beta,r, tcrit, tcalc, p] = slinearwithpear(predictor,predicted, alpha)

xmean = mean(predictor);
ymean = mean(predicted);

num_a = predictor - xmean;
num_b = predicted - ymean;
num = sum(num_a*num_b');
den_a = sum(num_a.^(2));

beta = num/den_a;
alfa = ymean - beta*xmean;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

den_b = sum(num_b.^(2));
denr = sqrt(den_a*den_b);

r = num/denr;

[tcrit,tcalc, p] = testing_r(r, length(predictor),alpha);

end