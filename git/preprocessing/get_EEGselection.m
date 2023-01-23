% [sigselection, interval_pre, interval_pos] = get_EEGselection(data, id, ct_pos, pos_select, EEGsignals, channel, from, till, ntrials,tree, timeref)
% 
% Get the EEG signals with the given parameters (to be used with goalkeeperlab).
%
% INPUT:
% data = data matrix from the goalkeeper
% id = number of the participant in the matrix
% ctx_num = number of the context in the context tree of treebehave.
% ct_pos = contains the positions of ocurrence of each context (see input function)
% pos_select = selects positions of interest in ct_pos
% EEGsignals = matrix with eeg signals of each channel line-wise.
% from = starting from trial
% till = ending in trial
% ntrials = number of trials in the experiment
% tree = number of tree
% OUTPUT:
% sigselection = EEG signals according to the given parameters.
% interval_pre = number of samples before the response
% interval_pos = number of samples after the response
%
% date: 13/04/2022     author: Paulo Roberto Cabral Passos

function [sigselection, interval] = get_EEGselection(data, id, ctx_num, ct_pos, pos_select, EEGsignals, channel, from, till, ntrials, tree, timeref)


aux_pos = ct_pos(ctx_num,find(ct_pos(ctx_num,:) >=  1)); %#ok<FNDSB>
if (aux_pos(end)+1)>ntrials
   aux_pos = aux_pos(1:end-1);
end
aux_pos = aux_pos +1;

b = 0; e = 0;
for a = 1:length(data)
   if (data(a,3) == 1)&&((data(a,6) == id)&&(data(a,5) == tree))
        b = a+from-1;
        e = b+(till-from);
        break;
   end
end

% Quick remainder:
% 10: response latence
% 11: trial initiation by the goalkeeper # (not in use) #
% 12: appearance of the arrows
% 13: beggining of the feedback
% 14: end of the feedback



if timeref == 1 
liminf_pre = data(b:e,12); liminf_pre = liminf_pre(aux_pos); liminf_pre = liminf_pre(pos_select,1); % set to trial initiation
limsup_pre = data(b:e,10); limsup_pre = limsup_pre(aux_pos); limsup_pre = limsup_pre(pos_select,1); % set to response latency
interval_pre = min(limsup_pre-liminf_pre); liminf_pre = limsup_pre-interval_pre;

sigselection =  zeros(length(pos_select), interval_pre+1);  %zeros(length(pos_select),interval_pre+1);
    for a = 1:length(pos_select)
              sigselection(a,:) = EEGsignals(channel,liminf_pre(a):limsup_pre(a));
    end
    interval = interval_pre;
else
    liminf_pos = data(b:e,10); liminf_pos = liminf_pos(aux_pos); liminf_pos = liminf_pos(pos_select,1); % set to response latency
    limsup_pos = data(b:e,14); limsup_pos = limsup_pos(aux_pos); limsup_pos = limsup_pos(pos_select,1); % set to end of feedback
    
    aux_out = limsup_pos-liminf_pos;
    thres = mean(aux_out) - 3*std(aux_out);
    out = find(aux_out < thres,1); flag = 0;
        if ~isempty(out)
           flag = 1;
           aux_out(out) = 10^10;
        end

    interval_pos = min(aux_out);
    limsup_pos = liminf_pos+interval_pos;
    sigselection =  zeros(length(pos_select), interval_pos+1);  %zeros(length(pos_select),interval_pre+1);
    for a = 1:length(pos_select)
          if (flag == 1)&&(a == out)
              % do nothing
          else
              sigselection(a,:) = EEGsignals(channel,liminf_pos(a):limsup_pos(a));
          end
    end
    interval = interval_pos;
end

end


% Back-up
