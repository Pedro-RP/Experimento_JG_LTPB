% [retrieved_ctx, ctxcount] = ctx_estcount(unique, count)
%
% This function receives a cell of cells containing the unique estimated
% trees (unique) and the number of estimations of each unique tree and
% output the number of times that each context was estimated.

function [retrieved_ctx, ctxcount] = ctx_estcount(unique, count)

retrieved_ctx = cell(1,1); next = 1;
for a = 1:length(unique)
    for b = 1:length(unique{1,a})
    u = unique{1,a}{1,b};
    aux = 0;
        for c = 1:length(retrieved_ctx)
            if isequal(u,retrieved_ctx{1,c})
            aux = 1;
            break;
            end
        end
        if aux == 0
        retrieved_ctx{1,next} = u;
        next = next+1;
        end
    end
end

ctxcount = zeros(1,length(retrieved_ctx));
for a = 1:length(retrieved_ctx)
u = retrieved_ctx{1,a};
    for b = 1:length(unique)
        for c = 1:length(unique{1,b})
        v = unique{1,b}{1,c};
            if isequal(u,v)
            ctxcount(1,a) = ctxcount(1,a)+count(1,b);
            end
        end
    end
end

end