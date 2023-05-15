% Testes realizados no Ubuntu, compatibilizar os caminhos com o windows.
% Obs.: A funcao to_datamatrix foi movida para a pasta dataset_management

cd /home/paulo/Documents/PauloPosDoc/Pos-Doc % pasta com o repositório research codes
addpath(genpath('ResearchCodes'))
pathtogit = '/home/paulo/Documents/PauloPosDoc/Pos-Doc/ResearchCodes';

% Arquivo a ser aberto com o pacote EEGLAB
addpath('/home/paulo/Documents/PauloPosDoc/Pos-Doc/BagOfCodesAndData/eeglab2021.1')
eeglab

% etapas seguidas:
% 1. Na aba File > Load existing dataset > PDPauloPassos1022_v01filtpreICA.set
% 2. Fechar a Interface de Usuário do pacote eeglab

ntrials = 1500; fs = ALLEEG.srate;
[data, channels, EEGtimes, EEGsignals] = to_datamatrix(ALLEEG, ntrials, fs, 1, 7, 1);

GoalkeeperLab(data,pathtogit,ntrials,EEGsignals,fs,channels)