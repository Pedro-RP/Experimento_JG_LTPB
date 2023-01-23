EEG = pop_loadbv('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/usp_data_r01/downsampled/', 'PDPaulPassos1022_000001SR1000.vhdr');
pathtogit = '/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/research_codes/';
fs = EEG.srate;
tau = 7; idnum = 1;
ntrials = 1500; correction = 1;
[data, channels, EEGtimes, EEGsignals] = to_datamatrix(EEG, ntrials, fs, idnum, tau, correction);
GoalkeeperLab(data,pathtogit,ntrials,EEGsignals, fs, channels)

