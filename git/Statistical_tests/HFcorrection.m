% [new_dfb, new_dfer, p] = HFcorrection(data,F)
%
% This function calculates a new p-value according to the Huynh-Feldt
% correction given the F calculated in the ANOVA repeated measures
% procedure and the data with values of different subjects in the lines and
% different conditions in the columns.
%
% INPUT:
%
% data = matrix containing the data with subjects along the lines.
% F = F estatistic calculated with the ANOVA repeated measures
%
% OUTPUT:
% new_dfb = new degree of freedom for the F distribution
% new_dfer = new degree of freedon for the F distribution
% p = new p-value

% Author: Paulo Roberto Cabral Passos Last Modified: 28/02/2021


function [new_dfb, new_dfer, p] = HFcorrection(data,F)

% Calculating the double-centered covariance matrix

cov_M = cov(data);
mcov = mean(cov_M,2);
GMcov = mean(mcov);
PcovM = zeros(size(data,2),size(data,2));

for a = 1:size(data,2)
   for b = 1:size(data,2)
   PcovM(a,b) = (cov_M(a,b)-GMcov)-(mcov(a)- GMcov)-(mcov(b)-GMcov);
   end
end

% Esphericity index estimate calculation

epsilon = 0;
ep_sNum = 0;
ep_sDnum = 0;
for a = 1:length(PcovM)
   for b = 1: length(PcovM)
        if a == b
        ep_sNum = ep_sNum + PcovM(a,b);
        end
   ep_sDnum = ep_sDnum + PcovM(a,b)^2;
   end
end

epsilon = (ep_sNum^2)/((length(PcovM)-1)*ep_sDnum);

% Huynh-Feldt correction

HFepsilon_Num = (size(data,1)*(size(data,2)-1)*epsilon-2);
HFepsilon_Dnum = (size(data,2)-1)*(size(data,1) - 1 - (size(data,2)-1)*epsilon);
HFepsilon = HFepsilon_Num/HFepsilon_Dnum;

new_dfb = HFepsilon*(size(data,2)-1);
new_dfer = HFepsilon*(size(data,2)-1)*(size(data,1)-1);


% New p-value

x = [0:0.01:30]; %#ok<NBRAK>
Fdist = fcdf(x , new_dfb, new_dfer);
ref = find(x>= F,1);
p = Fdist(1,ref-1);
p = 1-p;

end