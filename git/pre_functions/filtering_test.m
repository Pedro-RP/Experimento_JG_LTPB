% Defining the signal

fs = 500;

% load('/home/paulo/Documents/ExperimentData/ColetaINDCpilotoDownsampled/Matlab/pilotoINDC.mat')
[data, channels, EEGtimes, EEGsignals] = to_datamatrix(ALLEEG, 1500, fs, 1, 7);
fx = EEGsignals(16,500*60*60:500*60*60+500*30); % Oz-16
x = [1:size(fx,2)]'; %#ok<NBRAK>
fx = double(fx);

%Made-up signal
x = [1:10*fs];

y1 = sin(5*x*(1/fs)*2*pi);

y2 = sin(10*x*(1/fs)*2*pi);

fx = y1 + y2;

figure

subplot(2,2,1)
plot(x,fx)
L = length(x);

% Spectrum of the signal

Fx = fft(fx);
f = fs*(0:(L/2))/L;

P2 = abs(Fx); 
P1 = P2(1:L/2+1);
%P1(2:end-1) = 2*P1(2:end-1);

subplot(2,2,2)
plot(f,P1) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% High-pass filtering

low_cut = 1;

[c_high,d_high] = butter(2,low_cut*2/fs, 'high' );
[h,w] = freqz(c_high,c_high);

fxfilt = filtfilt(c_high,d_high,fx);

% Low-pass filtering

upper_cut = 30;

[c_low,d_low] = butter(2,upper_cut*2/fs, 'low' );

fxfilt = filtfilt(c_low,d_low,fxfilt);

subplot(2,2,3)

plot(x,fxfilt)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Filtered spectrum

Fxfilt = fft(fxfilt);
f = fs*(0:(L/2))/L;

P2 = abs(Fxfilt); 
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,2,4)
plot(f,P1) 




