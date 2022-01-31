% Dw = weighted_distance(QC,PM, A)
%
% This function calculates what I am defining as the wheighted distance.
% Given QC which is the fr_ind cell of the function
% individual_relative_frequency and PM, the probability matrix of the tree,
% it gives the wheigted distance in which 0 the perfect match and 1 is
% the the farest distance between the matrices. A is the alphabet.
%
% Author: Paulo Passos  Last Modified: 07/08/2020

function Dw = weighted_distance(QC,PM, A)

C = zeros(size(PM,1),1);
QM = zeros(size(PM,1),length(A));
for w = 1:size(QC,1)
  QM(w,:) = QC{w,1}; C(w,1) = QC{w,2};
end

Dw = 0;
for w = 1:size(PM,1)
   dH = 0;
   for a = 1:size(PM,2)
       dH = dH + (sqrt(PM(w,a))-sqrt(QM(w,a)))^2;
   end
   dH = (1/sqrt(2))*sqrt(dH);
   Dw = Dw + C(w)*(1-dH);
end
Dw = 1-Dw/sum(C);

end