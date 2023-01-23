load('/home/roberto/Documents/Pos-Doc/Mixture Models/ArticleData101022.mat')
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
          x = repo_comp{ctx,1,v}.^(1/3); x = rmoutliers(x); 
          y = repo_comp{ctx,2,v}.^(1/3); y = rmoutliers(y);
          nscomps(ctx,aux) = length(Smodel_results{ctx,1,v});
          nfcomps(ctx,aux) = length(Fmodel_results{ctx,1,v});
          [~,~, scond(ctx,aux)] = swtest_norm( x ); nscond(ctx,aux) = length(x);
          [~,~, fcond(ctx,aux)] = swtest_norm( y ); nfcond(ctx,aux) = length(y);
       end
    end
end


snormals = scond >= 0.01;
fnormals = fcond >= 0.01;

snormalspctx = sum(snormals,2);
fnormalspctx = sum(fnormals,2);

chisquaretable = zeros(2,2);

%line 1 normal, column 1: mixture
for ctx = 1:5
   for aux = 1:22
      if ( snormals(ctx,aux) == 1 )&&( nscomps(ctx,aux) > 1 )
      chisquaretable(1,1) = chisquaretable(1,1) + 1;    
      elseif ( snormals(ctx,aux) == 1 )&&( nscomps(ctx,aux) ==1 )
      chisquaretable(1,2) = chisquaretable(1,2) + 1;    
      elseif ( snormals(ctx,aux) == 0 )&&( nscomps(ctx,aux) > 1 )
      chisquaretable(2,1) = chisquaretable(2,1) + 1;        
      else
      chisquaretable(2,2) = chisquaretable(2,2) + 1;            
      end
   end
end

for ctx = 1:5
   for aux = 1:22
      if ( fnormals(ctx,aux) == 1 )&&( nfcomps(ctx,aux) > 1 )
      chisquaretable(1,1) = chisquaretable(1,1) + 1;    
      elseif ( fnormals(ctx,aux) == 1 )&&( nfcomps(ctx,aux) ==1 )
      chisquaretable(1,2) = chisquaretable(1,2) + 1;    
      elseif ( fnormals(ctx,aux) == 0 )&&( nfcomps(ctx,aux) > 1 )
      chisquaretable(2,1) = chisquaretable(2,1) + 1;        
      else
      chisquaretable(2,2) = chisquaretable(2,2) + 1;            
      end
   end
end