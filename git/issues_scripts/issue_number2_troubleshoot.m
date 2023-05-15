% Testes realizados no Ubuntu, compatibilizar os caminhos com o windows.

cd /home/paulo/Documents/PauloPosDoc/Pos-Doc % pasta com o repositório research codes
addpath(genpath('ResearchCodes'))
pathtogit = '/home/paulo/Documents/PauloPosDoc/Pos-Doc/ResearchCodes';

% Arquivo a ser aberto com o pacote EEGLAB
addpath('/home/paulo/Documents/PauloPosDoc/Pos-Doc/BagOfCodesAndData/eeglab2021.1')

% Abrindo o EEGLAB
eeglab

% No EEGLAB:
% 1 - File > import data > using EEGLAB functions and plug-ins > From brain
% vision recorder .vhdr or .ahdr file
% 2 - Selecionar o dado.
% 3 - Selecionar OK nas janelas seguintes.
% 4 - Fechar janela do EEGLAB.


% Por inspecao a estrutura ALLEEG.event a correcao NAO deve ser utilizada (parametro = 0). Se
% qualquer dos marcadores em type apresentar dois espacos entre a letra e o
% numero, entao o dado esta na formatacao anterior.

% A estrutura em ALLEEG indica 291 trials, nao 300. O numero de trials pode
% ser verificado calculando o numero de ocorrencias o evento 'G  1' enviado
% pelo jogo no inicio de cada trial, exceto no primeiro (que e descartado em
% funcao da ausencia da marcacador). 

% Contando o numero de eventos 'G  1'

occurrances = 0;
for c = 1:length(ALLEEG.event)
    if isequal('G  1', ALLEEG.event(c).type)
       occurrances = occurrances +1;
    end
end

ntrials = occurances; fs = ALLEEG.srate; idnum = 1; tau = 13; correction = 0;
[data, channels, EEGtimes, EEGsignals] = to_datamatrix(ALLEEG, ntrials, fs, idnum, tau, 0);

% Dessa forma a funcao to_datamatrix funciona adequadamente, assim como a
% GoalkeeperLab.

GoalkeeperLab(data,pathtogit,ntrials,EEGsignals,fs,channels)



