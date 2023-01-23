load('processed_data')

rng(1);
fs = 1000;
ct = 3; comp_w = 500; comp_sl = 100;
comp_ext = min([length(find(repo_time{ct,1} >= 0)) length(find(repo_time{ct,2} >= 0))]);
ctx = {'0', '01', '11', '21', '2'};

steps = (comp_ext - comp_w - 1)/comp_sl;
steps = floor(steps);

groupid = []; data = []; c_time = []; tickzis = cell(1,steps);
gl = -1; gr = 0;
time1 = repo_time{ct,1}; time2 = repo_time{ct,2};
for n = 1:steps
    bl = find( time1 >= 0,1) + (n-1)*comp_sl;
    br = find( time2 >= 0,1) + (n-1)*comp_sl;
    el = bl + comp_w; er = br + comp_w;
    c_time = [c_time mean([ time1(bl) time1(el) ])];
    datl = repo{ct,1};
    gl = gl + 2; gr = gr + 2;
    for a = 1:size(datl,1)
       x = datl(a,bl:el);
       bridge = brownianbridge(length(x));
       data = [data dot(x,bridge)];
       groupid = [groupid gl];
    end
    datr = repo{ct,1};
    for a = 1:size(datr,1)
       x = datr(a,br:er);
       bridge = brownianbridge(length(x));
       data = [data dot(x,bridge)];
       groupid = [groupid gr];
    end
tickzis{1,n} = ''; 
end


sbox_comp(groupid', data',  'mid. time (sec.)', 'bridge proj.', ['w = ' num2str(ctx{ct})], tickzis, 0, 0, [])
h = gca;
h.XTick = 1.5:2:(1.5+2*(length(c_time)-1)); tickz = cell(length(c_time));
for a = 1:length(c_time)    
   ticks{a,1} = num2str(c_time(a),'%.2f');
end
h.XTickLabel = ticks;
xlim([0 max(h.XTick+1)])