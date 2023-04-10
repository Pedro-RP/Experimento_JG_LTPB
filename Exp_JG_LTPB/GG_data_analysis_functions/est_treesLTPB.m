% function [tau_estC, mode_tauC, tau_estL, mode_tauL] =  est_treesLTPB (data_control, data_LTPB, from_t, to_t)
%
% This function recieves the data from both groups of the experiment and
% returns a figure for each data matrix containing all of the context
% trees of the group, one tree for each participant.
% The function also returns the mode tree for each group.
%
% INPUT:
%
% data_control = data matrix from the control group.
%
% data_ltpb = data matrix from the LTPB group.
%
% OUTPUT:
% 
% tau_estC = each cell of this variable is a list of the contexts that are
% present in the tree of one of the participants of the control group.
% The column number represents the identification of the participant of whom the
% tree belongs.
%
% tau_estL = each cell of this variable is a list of the contexts that are
% present in the tree of one of the participants of the LTPB group.
% The column number represents the identification of the participant of whom the
% tree belongs.
%
% mode_tauC = list of contexts present in the mode tree of the control
% group.
%
% mode_tauL = list of contexts present in the mode tree of the LTPB
% group.
%
% 26/01/2023 by Pedro R. Pinheiro



function [tau_estC, mode_tauC, tau_estL, mode_tauL] =  est_treesLTPB (data_control, data_LTPB, from_t, to_t)

alphal = 3; %length of the alphabet of the stochastic chain
N = to_t-from_t+1; %length of the stochastic chain;
L = floor(log10(N)/log10(3));

%% Control group

% Estimating individual trees

for i = 1:size(data_control,1)

    T1(i)= data_control(i,7); %response times of every trial of every participant

end

a=1;

for par = 1:(size(data_control,1)/1000)
    
    RT1{par}=T1(a:a+999);  %response times of every trial grouped by participant
    a=a+1000;

end

for par = 1:(size(data_control,1)/1000)
   
    RT1{par} = RT1{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end
    

for pos = 1:size(data_control,1)

    p1(pos)= data_control(pos,9); %stochastic chain info for all of the participants

end

b=1;

for par = 1:(size(data_control,1)/1000) 
    
    P1{par}=p1(b:b+999);  %stochastic chain info grouped by participant
    b=b+1000;

end

for par = 1:(size(data_control,1)/1000)
   
    P1{par} = P1{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end
    

nrowsC = ceil(((size(data_control,1)/1000)/3)); %number of rows containing plots that the figure will have 


% Buiding the figure containing all of the context trees of the group

figure

for par = 1:(size(data_control,1)/1000) %one plor per participant

    subplot(nrowsC,3, par)
    [tau_est1] = tauest_RT(alphal, RT1{par}, P1{par}, 1);
    title(append('C ', num2str(par))); %title of each individual plot
    tau_estC{par} = tau_est1;

end

suptitle(append('Context Trees of the Control Group (', num2str(from_t), '-',num2str(to_t),')')) %title of the whole figure


% Estimating the mode tree

[mode_tauC] = taumode_est(alphal,tau_estC, L, 1, 0);
title(append('Mode Tree of the Control Group (', num2str(from_t), '-',num2str(to_t),')'));


%% LTPB group


for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);


end

a=1;

for par = 1:(size(data_LTPB,1)/1000) 
    
    RT2{par}=T2(a:a+999); 
    a=a+1000;

end

for par = 1:(size(data_LTPB,1)/1000)
   
    RT2{par} = RT2{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end

for pos = 1:size(data_LTPB,1)

    p2(pos)= data_LTPB(pos,9);

end

b=1;

for par = 1:(size(data_LTPB,1)/1000) 
    
    P2{par}=p2(b:b+999); 
    b=b+1000;

end

for par = 1:(size(data_LTPB,1)/1000)
   
    P2{par} = P2{par}(from_t : to_t); %selecting only the chosen interval to be analyzed
    
end

% Buiding the figure containing all of the context trees of the group

nrowsL = ceil(((size(data_LTPB,1)/1000)/3));

figure

for par = 1:(size(data_LTPB,1)/1000) 

    subplot(nrowsL,3, par)
    [tau_est2] = tauest_RT(alphal, RT2{par}, P2{par}, 1);
    title(append('L ', num2str(par)));
    tau_estL{par} = tau_est2;

end

suptitle(append('Context Trees of the LTPB Group (', num2str(from_t), '-',num2str(to_t),')'));

% Estimating the mode tree

[mode_tauL] = taumode_est(alphal,tau_estL, L, 1, 0);
title(append('Mode Tree of the LTPB Group (', num2str(from_t), '-',num2str(to_t),')'));


end