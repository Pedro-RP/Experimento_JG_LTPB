
function [k, found] = caseforcut(mode_tau,pos , retrieved_ctx, ctxcount)


% Finding the positions in retrieved_ctx
k = 0;
found = zeros(1,length(pos));
w_pos = zeros(1,length(pos));
for a = 1:length(pos)
    u = mode_tau{1,pos(a)};
     for b = 1:length(retrieved_ctx)
         v = retrieved_ctx{1,b}; 
        if isequal(u,v)
           found(1,a) = found(1,a)+1; 
           w_pos(1,a) = b;
        end
     end
end


if sum(found) == 0
   return 
end



keep = zeros(1,length(pos));
for a = 1:length(pos)
    suf_pos = []; % positions are associated with retrieved_ctx
   if found(1,a) ~= 0
      w = mode_tau{1,pos(a)};
      % Find all sufixes
      for b = 1:length(retrieved_ctx)
          v = retrieved_ctx{1,b};
          if sufix_test(v,w)
             if length(v) ~= length(w)
                suf_pos = [suf_pos b]; %#ok<AGROW>
             end
          end
      end
      aux = 1; % aux = 1 for keeping
      if ~isempty(suf_pos)
          for b = 1:length(suf_pos)
             if ctxcount(1,w_pos(1,a)) < ctxcount(1,suf_pos(1,b))
                aux = 0;
                break;
             end
          end         
      end
      if aux == 1; keep(1,a) = 1; end
   end
end

if ~isempty(find(keep ~= 0)) %#ok<EFIND>
k = 1;
end

end