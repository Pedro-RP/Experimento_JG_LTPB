%seq = gentau_seq (alphabet, contexts, PM, num)



function seq = gentau_seq (alphabet, contexts, PM, num)

seq = zeros(1,num);
prime = randi([1 length(contexts)],1); 
seq(1,1:length(contexts{1,prime})) = contexts{1,prime};

start = length(contexts{1,prime})+1;

% Constructing a probability matrix

CM = zeros(size(PM,1),size(PM,2));
for a = 1:size(PM,1)
   aux = 0;
   for b = 1:size(PM,2)
   CM(a,b) = PM(a,b)+aux;
   aux = CM(a,b);
   end
end

dumb = 0;

for a = start:num
    for b = 1:length(contexts)
       ctx = contexts{1,b};
       st = (a-1)-length(ctx)+1; ed = a-1;
       if (st)>0
            qmark = sum(seq(1,st:ed) == ctx,2)/length(ctx); 
            if qmark == 1
            draw = rand(1,1);
            % holding for a moment 
                for c = 0: (length(alphabet)-1)
                    if draw < CM(b,length(alphabet)-c)
                       next = length(alphabet)-c;
                    else
                        break;
                    end
                end
                seq(1,a) = alphabet(1,next);
                % Continuar aqui
            end
       end
    end
end



end




