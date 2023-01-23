
measures = cell(size(EEGincond,1),size(EEGincond,2));

for a = 1:size(EEGincond,1) % conditions
    for b = 1:size(EEGincond,2) % electrodes
        X = EEGincond{a,b};
        time = [1:size(X,2)]*(1/fs);
        dist = zeros(size(X,1),1);
        for c = 1:size(X,1) % trial
            x = X(c, :);
            x_abs = abs(x);
            thres = prctile(x_abs,95);
            N = length(find(x_abs >= thres));
            cfunc = zeros(length(time),1);
            aux = 0;
                for d = 1:length(cfunc)
                    if abs(x(d)) >= thres
                        aux = aux + 1;
                    end
                    cfunc(d) = aux/N;
                end
            latency = time(find(cfunc>0.5,1));
            dist(c) = latency;
        end
        measures{a,b} = dist;
    end 
end


