


function [bwid, FX] = optimizing_histogram(X,XofFX,preFX)

% binwid function
p = 1; ctx = 1; 
tlimit = 1.5; ini = tlimit/150; 


minsqr = []; bwids = [];
bwid = ini; inc = 0;
while bwid < (tlimit/10) 
clas = 0:bwid:1.5;
counts = zeros(1,length(clas)-1);
ref_pointsC = zeros(1,length(clas)-1);
ref_pointsF = zeros(1,length(clas)-1);
    for n = 1:length(clas)-1
        aux = (X > clas(n))&(X <= clas(n+1));
        counts(n) = sum(aux);
        ref_pointsC(n) = ( clas(n)+clas(n+1) )/2;
        aux2 = abs(XofFX-ref_pointsC(n));
        ref_pointsF(n) = find( aux2 == min(aux2));
    end
FX = max(counts)*(1/max(preFX))*preFX;
inc = inc + 1;
% subplot(4,4,inc)
% histogram(X,'BinWidth',bwid)
% hold on
% stem(ref_pointsC,FX(ref_pointsF))
auxsum = 0;
    for a = 1:length(ref_pointsF)
       auxsum = auxsum + (FX(ref_pointsF(a))-counts(a))^2; 
    end
    minsqr = [minsqr auxsum]; %#ok<AGROW>
bwids = [ bwids bwid ]; %#ok<AGROW>
bwid = bwid + ini;
end

aux3 = find(minsqr == min(minsqr));
bwid = bwids(aux3);

clas = 0:bwid:1.5;
counts = zeros(1,length(clas)-1);
ref_pointsC = zeros(1,length(clas)-1);
ref_pointsF = zeros(1,length(clas)-1);
    for n = 1:length(clas)-1
        aux = (X > clas(n))&(X <= clas(n+1));
        counts(n) = sum(aux);
        ref_pointsC(n) = ( clas(n)+clas(n+1) )/2;
        aux2 = abs(XofFX-ref_pointsC(n));
        ref_pointsF(n) = find( aux2 == min(aux2));
    end
FX = (max(counts))*(1/max(preFX))*preFX;

% histogram(X,'BinWidth',bwid)
% hold on
% stem(XofFX,FX)

end

