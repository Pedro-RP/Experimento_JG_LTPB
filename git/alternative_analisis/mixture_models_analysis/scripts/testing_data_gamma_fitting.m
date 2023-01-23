load('/home/roberto/Documents/Pos-Doc/Mixture Models/ArticleData.mat')
load('/home/roberto/Documents/Pos-Doc/Mixture Models/valid20092022.mat')
load('/home/roberto/Documents/Pos-Doc/Mixture Models/SandFmodels.mat')

nctx = 5;
nvalid = sum(valid_p);
scond = zeros(nctx,nvalid); nscond = zeros(nctx,nvalid);
fcond = zeros(nctx,nvalid); nfcond = zeros(nctx,nvalid);
nscomps = zeros(nctx,nvalid); nfcomps = zeros(nctx,nvalid);

for ctx = 1:5
    aux = 0;
    for v = 1:length(valid_p)
       if valid_p(v) == 1
          aux = aux+1;
          x = repo_comp{ctx,1,v}; 
          [pshape, pscale, ~, ~, ~] = gamma_model(x, [0 60], 0.05, 0);
          x_comp = gamrnd(pshape,pscale,length(x),1);
          %
          y = repo_comp{ctx,2,v};
          [pshape, pscale, ~, ~, ~] = gamma_model(y, [0 60], 0.05, 0);
          y_comp = gamrnd(pshape,pscale,length(y),1);          
          % testing
          [ ~, scond(ctx,aux)] = kstest2(x,x_comp); 
          nscond(ctx,aux) = length(x);
          
          [~, fcond(ctx,aux)] = kstest2(y,y_comp); 
          nfcond(ctx,aux) = length(y);
       end
    end
end


sgamma = scond >= 0.01;
fgamma = fcond >= 0.01;

N = size(sgamma,1)*size(sgamma,2)+size(fgamma,1)*size(fgamma,2);

sgammapctx = sum(sum(sgamma,2));
fgammapctx = sum(sum(fgamma,2));

pctx = (sgammapctx+fgammapctx)/N;


