% spec_throughtime(sigselection, time, lw,overlap,fs, object)
%
% This function is part of the goalkeeper game routine, it plots the EEG 
% spectra through time in the the range usual range of interest (0-60 Hz).
%
% INPUT:
% sigselection = Matrix containing the data provided by the goalkeeper lab
% time = time vector provided by the goalkeeper lab
% lw = length of the window for each spectra
% overlap = length of the slide.
% fs = frequency sampling
% t = trial that will be shown
% object = figure object in which will be plotted
%
% Author: Paulo Roberto Cabral Passos Date: 25/05/2022

function spec_throughtime(sigselection, time, lw,overlap,fs, t, object)


a = 1; N = size(sigselection,2); 
BigFM = zeros(size(sigselection,1),lw/2+1,1);


w_beg = zeros(1, floor( (N-lw)/overlap ) );
window_center = zeros(1,length(w_beg));
j = 1; 
while ( a + lw-1 ) <= size(sigselection,2) 
w_beg(j) = a; w_term = a + lw -1;
[BigFM(:,:,j),f] = sig_fdomain(sigselection(:,w_beg(j):w_term),fs); 
center =  time( w_beg(j) ) +   (  ( time(w_term) ) - time( w_beg(j) )  )/2 - ( 1*(1/fs) )/2;
window_center(1,j) = center;
a = a + overlap;j = j+1;
end

fl = length(f); % frequency bins
lw = size(BigFM,3); % number of sliding windows 
nt = size(BigFM,1); % n trials
Spec = zeros(length(f),lw,nt);
for c = 1:nt
   for b = 1:lw
      for a = 1:fl
      Spec(fl-a+1,b,c) = BigFM(c,a,b); % each page with a map frequency x sliding window for each trial.
      end
   end
end

f_rev = flip(f); vlim = [find(f_rev <= 40,1) find(f_rev <= 0,1)]; % Defining the limits for visualization
set(0, 'CurrentFigure',object)
if t ~= 0
    denorm = max(max(Spec(vlim(1):vlim(2),:,t)));
    image(Spec(:,:,t)/denorm,'CDataMapping','scaled');
else
    Spec0 = zeros(size(Spec,1),size(Spec,2));
    for trial = 1:size(Spec,3)
        denorm = max(max(Spec(vlim(1):vlim(2),:,trial)));
        Spec0 = Spec0+(Spec(:,:,trial)/denorm); 
    end
    Spec0 = (1/size(Spec,3))*Spec0;    
    image(Spec0,'CDataMapping','scaled');    
end
colormap jet
h = gca;
h.FontSize = 10;
h.YTick = [1:1:fl]; %#ok<NBRAK>

labelsy = cell(length(f),1);

for a = 1:length(f_rev)
    if rem(a,4) == 0
       labelsy{a,1} = num2str(f_rev(a));
    else
       labelsy{a,1} = ''; 
    end
    
end

labelsx = cell(length(window_center),1);
for a = 1:length(window_center)
    if rem(a,2) == 0
       labelsx{a,1} = num2str(window_center(a),'%.2f');
    else
       labelsx{a,1} = ''; 
    end
    
end

h.YTickLabel =labelsy; cb = colorbar;
h.XTick = [1:1:length(window_center)];
h.XTickLabel = labelsx;

ylim(vlim) % setting the range of view
xlabel('Time (sec.)','FontSize',14)
ylabel('Frequency (Hz)','FontSize',14)
cb.Label.String = '|P_{1}(f)|_{norm}';

end

