% outlierflag = isoutlier(sample)
%
% The function receives a sample (vector) and returns a vector of zeros and
% ones, in which the 1 indicates an outlier.
% INPUT:
% sample = vector;
% OUTPUT:
% outlierflag = vector of zeros and ones in which the 1 indicates a
% outlier;
% date: 12/04/2022  author: Paulo Roberto Cabral Passos;

function outlierflag = isoutlier(sample)

q3 = prctile(sample,75);
q1 = prctile(sample,25);

upperlimit = q3+1.5*(q3-q1);
lowerlimit = q1-1.5*(q3-q1);

outlierflag = (sample < lowerlimit)|(sample > upperlimit);

end