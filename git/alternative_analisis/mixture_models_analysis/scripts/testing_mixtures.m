% load('/home/paulo/Documents/PauloPosDoc/Pos-Doc/StudyCode/ArticleData.mat')
% 
% bwid = 0.0775;
% 
% mod_outp = 7;
% npart = size(repo_comp,3);
% nctx = size(repo_comp,1);
% Smodel_results = cell(nctx,mod_outp,npart);
% Fmodel_results = cell( nctx,mod_outp,npart);
% for a = 1:npart
%    for b = 1:nctx
%        for c = 1:2
%            if valid_p(a) == 1
%               X = repo_comp{b,c,a}.^(1/3);
%               [model_repo, bic_list,dropped] = bic_mixture1D(X,5);
%               aux = max(bic_list(find(dropped == 0))); %#ok<FNDSB>
%               selection = find(bic_list == aux);
%               for d = 1:mod_outp
%                  if c == 1 
%                  Smodel_results{b,d,a} = model_repo{selection,d}; 
%                  else
%                  Fmodel_results{b,d,a} = model_repo{selection,d};
%                  end
%               end
%            end
%        end 
%    end
% end

load('/home/paulo/Documents/PauloPosDoc/Pos-Doc/StudyCode/ArticleData.mat')

bwid = 0.0775;

mod_outp = 7;
npart = size(repo_comp,3);
nctx = size(repo_comp,1);
Cmodel_results = cell(nctx,mod_outp,npart);
for a = 1:npart
   for b = 1:nctx
       if valid_p(a) == 1
          X = [repo_comp{b,1,a}; repo_comp{b,2,a}];
          X = X.^(1/3);
          [model_repo, bic_list,dropped] = bic_mixture1D(X,5);
          aux = max(bic_list(find(dropped == 0))); %#ok<FNDSB>
          selection = find(bic_list == aux);
          for d = 1:mod_outp
             Cmodel_results{b,d,a} = model_repo{selection,d}; 
          end
       end
   end
end



