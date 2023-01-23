close all
topoplot(ones(32,1),EEGchanlocs,'style','blank','electrodes', 'labels')
f = gcf;
f.Color = [1 1 1];
h = findobj('Type','text');
ax1 = gca;
ax1.Position = [0.384,0.260,0.23,0.47];
hold on

channel_ord = cell(1,31);
channel_ord = {'FP1','F7','F3','FT9','FC1','FC5','T7',...
    'C3', 'CP1','CP5','TP9','P3','P7','O1','Pz',...
    'FP2','F8','F4','FT10','FC2','FC6','T8',...
    'C4','CP2','CP6','TP10','P4','P8','O2','Oz','Cz'};

electrodes = [1 3 2 4 6 5 8 7 11 10 9 13 14 15 12 31 30 29 26 28 27 25 24 22 21 20 18 19 17 16 23];

for a = 1:length(h)
   st = h(a).String;
   pos = h(a).Position;
   delete(h(a))
   text(pos(1)-0.025,pos(2)+0.05,pos(3),st,'FontWeight', 'bold')
   plot(pos(1),pos(2),'ko','MarkerSize',12,'MarkerFaceColor', [0.5 0.5 0.5])
end

ax_posleft = [0.381,0.801,0.02, 0.17;
    0.107,0.707,0.02, 0.17;
    0.229,0.636,0.02, 0.17;
    0.030,0.586,0.02, 0.17;
    0.304,0.527,0.02, 0.17;
    0.153,0.5,0.02, 0.17;
    0.075,0.367,0.02, 0.17;
    0.210,0.367,0.02, 0.17;
    0.305,0.24,0.02, 0.17;
    0.152,0.233,0.02, 0.17;
    0.030,0.217,0.02, 0.17;
    0.227,0.093,0.02, 0.17;
    0.107,0.063,0.02, 0.17;
    0.381,0.030,0.02, 0.17;
    0.457,0.062,0.02, 0.17;
    ];


ax_posright = ax_posleft;

for a = 1:size(ax_posleft,1)
   axes('Position',ax_posleft(a,:))
   group = []; dists = [];
   for b = 1:size(measures,1)
       group = [group; b*ones(length(measures{b,electrodes(a)}),1) ];
       dists = [dists; measures{b,electrodes(a)}];
   end
   sbox_varsizemini(group, dists,  '', '', '', '', 0.05, 1, [])
   ax_posright(a,1) = 1-ax_posleft(a,1);
   title(channel_ord{1,a},'FontSize',8)
   set(gca,'XColor','none','YColor','none')
end

for a = 1:size(ax_posright,1)
    axes('Position',ax_posright(a,:))
   group = []; dists = [];
   for b = 1:size(measures,1)
       group = [group; b*ones(length(measures{b,electrodes(a+15)}),1) ];
       dists = [dists; measures{b,electrodes(a+15)}];
   end
   sbox_varsizemini(group, dists,  '', '', '', '', 0.05, 1, [])
   title(channel_ord{1,15+a},'FontSize',8)
   set(gca,'XColor','none','YColor','none')
end

axes('Position',[0.488,0.739,0.02, 0.17])
group = []; dists = [];
for b = 1:size(measures,1)
   group = [group; b*ones(length(measures{b,electrodes(31)}),1) ];
   dists = [dists; measures{b,electrodes(31)}];
end
sbox_varsizemini(group, dists,  '', '', '', '', 0.05, 1, [])
title(channel_ord{1,end},'FontSize',8)
set(gca,'XColor','none','YColor','none')