% [ids, vids, tauofid, gametest, trees, treesizes] = data_setaspects(data, ntrials, pathtogit)
%
% This function returns the aspects of the dataset.
%
% INPUT:
% data = data matrix.
% ntrials = number of trials in the goalkeeper game experiment.
% pathtogit = adress of the git folder
%
% OUTPUT:
% ids = unique ids in the dataset
% vids = viable ids, this is excluding those with problems and gametests
% tauofid = tree of each id in case each id just played one.
% gametest = ids corresponding to tests.
% trees =  column vector with the number id of the trees in the dataset;
% treesizes  = column vector with the number of contexts of 'trees'.
%
% Author: Paulo Passos  date: 11/06/2021

function [ids, vids, tauofid, gametest, trees, treesizes] = data_setaspects(data, ntrials,pathtogit)
ids = unique(data(:,6)); % num. of participants

trees = [];
for a = 1:size(data,1)
   if isempty(trees)
      trees = data(a,5);
   else
      if isempty(find(trees == data(a,5)))
         trees = [trees; data(a,5)];
      end
   end
end

ntau = length(trees);

nintau  = zeros(1,ntau);
for a = 1:ntau
    nintau(1,a) = length(find(data(:,5) == (6+a)))/ntrials; 
end

% Identifying the participant with less than "ntrials"

gametest = [];
for a = 1:length(ids)
   if length(find(data(:,6) == a)) < ntrials 
       gametest = [gametest; a];
   end
end
nintau = ceil(nintau);

% Identifying the tree of each participant

tauofid = zeros(length(ids),1);
for a = 1:length(ids)
    for b = 1:size(data,1)
       if data(b,6) == ids(a); tauofid(a,1) = data(b,5); end
    end
end


%Excluding game_test
aux_tab = [];
vids = [];
for a = 1:length(tauofid)
    if isempty(find(tauofid(a) == gametest))
       aux_tab = [aux_tab tauofid(a)];
       vids =  [vids; ids(a)];
    end
end
tauofid = aux_tab;

treesizes = zeros(length(trees),1);

for a = 1:ntau
   tree_file_address = [pathtogit '/files_for_reference/tree_behave' num2str(trees(a)) '.txt' ];
   [contexts, ~, ~, ~] = build_treePM (tree_file_address);
   treesizes(a) = length(contexts);
end
[~,I] = sort(trees);
trees = trees(I);
treesizes = treesizes(I);

display( ['Dataset: Participants (' num2str(length(tauofid)) '); Game Tests (' num2str(length(gametest)) '); Trees (' num2str(ntau) ')' ])
end