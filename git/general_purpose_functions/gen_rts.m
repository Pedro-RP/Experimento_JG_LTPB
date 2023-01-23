% rts = gen_rts(partition, chain, alpha)
%
% This function provides a simulated chain of response times (or any other 
% real valued measure) in which the each different partition is generated
% from a different normal distribution. Each element of the partition is
% identified based on the chain. Alpha defines the variance of each normal
% distribution.
%
% INPUT:
% partition = partition to be used for sampling
% chain = used for identifying the elements of the partition.
% alpha = defines the variance of the normal distributions used in sampling
% show = if (1) shows the distributions in a histogram.
%
% OUTPUT:
% rts = response times according to the partition
%
% Author: Paulo Roberto Cabral Passos   Last Modified: 18/01/2023

function rts = gen_rts(partition, chain, alpha, show)

%partition = contexts;
%alpha = 0.5;

dists = cell(length(partition),1);
[~, pos,~] = count_contexts(partition,chain);
rts = zeros(1,length(chain));
for sset = 1:length(partition)
    for k = 1:size(pos,2)
        pointer = pos(sset,k)+1;
        if (pointer == 1)||(pointer > length(chain))
            break;
        else
            sample = sset+randn(1)*alpha;
            rts(1,pointer) = sample;
            dists{sset,1} = [ dists{sset,1}; sample ];
        end
    end
end
for k = 1:length(chain)
    if rts(1,k) == 0
    rts(1,k)= mean(rts(1,2:end))+ alpha*randn(1);
    else
        break
    end
end

if show == 1 
   hold all
   for d = 1:length(partition)
      histogram(dists{d,1}, 'FaceAlpha',0.4) 
   end
end

end