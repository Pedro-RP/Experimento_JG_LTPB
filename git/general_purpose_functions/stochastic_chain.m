% chain = stochastic_chain(contexts,tmt,freq,S)
%
% This function produces a stochastic chain of length S, given the
% transition matrix, the frequency of ocurrence of each context and the
% context.
% contexts = line cell containing the contexts
% tmt = transition matrix of the context tree
% freq = frequency of ocurrence of each context
% S = the size of the chain
% chain = the chain produced with size Scc


function chain = stochastic_chain(contexts,tmt,freq,S)

N = size(freq,1);
freq_thres = zeros(N,1);
aux = 0;

    for a = 1:N
    aux = aux+ freq(a,1);
    freq_thres(a,1) = aux;
    end
    
% Constructing a cumulative matrix

ctmt = zeros(N,N);


for a = 1:N
aux = 0;    
    for b = 1:N
        if tmt(a,b) ~= 0
        aux = aux + tmt(a,b);
        ctmt(a,b) = aux;
        end
    end
end
    
    
% Choosing from which context we will start

raf = rand(1);
init = 0; ll = 0;
for a = 1:N
   if (raf>= ll)&&(raf <= freq_thres(a,1))
       init = a;
   end
   ll = freq_thres(a,1);
end

chain = contexts{1,init};
aux = chain;

ct = 0; toct = 0;
S = S - length(aux);
coins = zeros(1+S,1); coins(1,1) = raf;

for a = 1:S
coin = rand(1); id = 0;
coins(a+1,1) = coin;
    % identifying in which context we are
    for b = 1: N
        id = strcmp(num2str(aux),num2str(contexts{1,b}));
        if id == 1
        ct = b;    
            break;
        end
    end
    % identifying to with context should go
    ll = 0;
    for c = 1:N
       if (ctmt(ct,c) ~= 0)
           if (coin >= ll)&&(coin <= ctmt(ct,c))
           toct = c;
           end
           ll = ctmt(ct,c);
       end
    end
    % storing the context
    aux = contexts{1,toct};
    % Increasing the sequence
    chain = [chain aux(1,length(aux))];
 end


end


