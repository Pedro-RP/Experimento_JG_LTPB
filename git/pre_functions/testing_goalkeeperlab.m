% Setting paths
working_path = '/home/roberto/Documents/Pos-Doc/pd_paulo_passos_neuromat';

% Adding paths
addpath(genpath(working_path))

% Loading data
%load([working_path '<PATH TO DATA MATRIX>'])
%load([working_path '<PATH TO DATA MATRIX>'])

% Script Description:
%
% The following script stores should run after uploading EEG data from the
% goalkeeper lab. It prepare the parameters and data for the goalkeeper
% lab initiation.


fs = 1000;
ntrials = 1500;
[data, channels, EEGtimes, EEGsignals] = to_datamatrix(ALLEEG, ntrials, fs, 1, 7, 1);
GoalkeeperLab(data,[working_path '/research_codes'],ntrials,EEGsignals,fs,channels)
