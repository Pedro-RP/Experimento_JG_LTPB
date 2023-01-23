

function [data, channels, EEGtimes, EEGsignals] = to_datamatrix(ALLEEG, ntrials, fs, ID, tau)

% Counting the number of trials
trials = 0;
for a = 1:length(ALLEEG.event)
    if strcmp(ALLEEG.event(a).type, 'G  1')
       trials = trials+1;
    end
end

% Registering channels
channels = cell(length(ALLEEG.chanlocs),1);

for a = 1:length(ALLEEG.chanlocs) 
    channels{a,1} = ALLEEG.chanlocs(a).labels;
end

%Building the data matrix

data = zeros (ntrials,14);

data(:,1) = ones(ntrials,1);
data(:,2) = ones(ntrials,1);
data(:,4) = ones(ntrials,1);
data(:,5) = ones(ntrials,1);
data(:,6) = ones(ntrials,1);

% collecting stochastic chain, latency of the response (10), trial
% initiation game (11) and trial initiation display (12)

warmup = trials-ntrials; count = 0; rcount = 0;
for a = 1:length(ALLEEG.event)   
    if strcmp(ALLEEG.event(a).type, 'G  1')
       count = count +1; 
    end
    if count > warmup
       if ~strcmp(ALLEEG.event(a).type, 'G  1')
          if strcmp(ALLEEG.event(a).type(1), 'G') && strcmp(ALLEEG.event(a+1).type(1), 'G')
             rcount = rcount+1;
             data(rcount,10) = ALLEEG.event(a).latency;
             data(rcount,11) = ALLEEG.event(a-1).latency;
             if ALLEEG.event(a).type(4) == '2'
             data(rcount,9) = 0;
             elseif ALLEEG.event(a).type(4) == '4'
             data(rcount,9) = 1;
             else
             data(rcount,9) = 2;    
             end
             %%%%%%% Getting the trial initiation by the display
             if strcmp(ALLEEG.event(a-2).type, 'D  2')
             data(rcount,12) = ALLEEG.event(a-2).latency;
             else
             data(rcount,12) = ALLEEG.event(a-1).latency;    
             end
             %%%%%%%
             %%%%%%% Getting the begining of the fb (14)
             if (a+2 <= length(ALLEEG.event)) && strcmp(ALLEEG.event(a+2).type,'D  3')
             data(rcount,13) = ALLEEG.event(a+2).latency; 
             end                 
             %%%%%%% Getting the end of the fb (14)
             if (a+4 <= length(ALLEEG.event)) && strcmp(ALLEEG.event(a+4).type,'D  1')
             data(rcount,14) = ALLEEG.event(a+4).latency;
             else
             data(rcount,14) = ALLEEG.event(length(ALLEEG.event)).latency; 
             end    
          end
       end
    end
end

% collecting responses

warmup = trials-ntrials; count = 0; rcount = 0;
for a = 1:length(ALLEEG.event)   
    if strcmp(ALLEEG.event(a).type, 'G  1')
       count = count +1; 
    end
    if count > warmup
       if ~strcmp(ALLEEG.event(a).type, 'G  1')
          if strcmp(ALLEEG.event(a).type(1), 'G') && (~strcmp(ALLEEG.event(a+1).type(1), 'G'))
             rcount = rcount+1;
             if ALLEEG.event(a).type(4) == '2'
             data(rcount,8) = 0;
             elseif ALLEEG.event(a).type(4) == '4'
             data(rcount,8) = 1;
             else
             data(rcount,8) = 2;    
             end
          end
       end
    end
end

% Response time calculated from 

for a = 1:size(data,1)
   data(a,7) =  (data(a,10)-data(a,12))*(1/500);
end

EEGtimes = ALLEEG.times;
EEGsignals = ALLEEG.signals;

end