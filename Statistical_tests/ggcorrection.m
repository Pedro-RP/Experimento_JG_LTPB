% [df1,df2,eps] = ggcorrection(S,n,c)
%
% This function performs the Greenhouse-Geisser correction of the degrees
% of freedom for the ANOVArmf1 if the sphericity condition is violated.
%
% S = double-centered covariance matrix.
% n = number of subjects.
% c = number of conditions.
% eps = epsilon estimate.
% df1 = corrected degrees of freedom
% df2 = corrected degrees of freedom

function [df1,df2,eps] = ggcorrection(S,n,c)

epsn = 0;
epsd = 0;
    for a = 1:c
    epsn = epsn + S(a,a);
    end
epsn =epsn^2;
    
    for a = 1:c
       for b = 1:c
       epsd = epsd + S(a,b)^2;
       end
    end

epsd = (c-1)*epsd;

eps = epsn/epsd;

df1 = eps*(c-1);
df2 = eps*(c-1)*(n-1);
end

