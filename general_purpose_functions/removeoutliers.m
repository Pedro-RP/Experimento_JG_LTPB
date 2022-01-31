

function Y = removeoutliers(X)

Q1 = prctile(X,25);
Q3 = prctile(X,75);
IQR = Q3-Q1;
ul = Q3+1.5*IQR;
ll = Q1-1.5*IQR;

Y = [];
for a = 1:length(X)
    if (X(a,1)< ul)&&(X(a,1) > ll)
       Y = [Y; X(a)]; %#ok<AGROW>
    end
end


end