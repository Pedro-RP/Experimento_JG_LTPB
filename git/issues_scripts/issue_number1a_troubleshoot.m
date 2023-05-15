% Testes realizados no Ubuntu, compatibilizar os caminhos com o windows.

cd /home/paulo/Documents/PauloPosDoc/Pos-Doc % pasta com o repositório research codes
addpath(genpath('ResearchCodes'))
pathtogit = '/home/paulo/Documents/PauloPosDoc/Pos-Doc/ResearchCodes';
load('/home/paulo/Documents/PauloPosDoc/Pos-Doc/temp_data/data_set_issue_num1a.mat')
ntrials = 1000; data = data_control;

GoalkeeperLab(data,pathtogit,ntrials,[],[],[])