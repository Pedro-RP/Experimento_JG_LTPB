% function [mov_average] = temporal_mov_average(data,data_name,window, pa = 1)
%

% end
%


%function [mov_average] = temporal_mov_average(data,data_name,window, pa = 1)

data = data_full;
data_name = 'data_full';
window = 100;
condition = 'participant';
pa = 1;

% Contruindo média móvel temporal
for i = 1:size(data,1)
   P(i)=data(i,7);
end
   

i=1;

for p=1:(size(data,1)/1000) 
u=P(i:i+999);
mov_average{p}= movmean(u,window);

i=i+1000;

end

if strcmpi(condition,'group')

x = linspace(1,1000,1000);
if strcmpi(data_name,'data_control') %unlike '==', strcmpi allows comparsions between matrixes of different dimensions
    title(append('Temporal Moving Average -', ' Control Group')) %Mudar o nome de acordo com o arquivo aberto
elseif strcmpi(data_name,'data_LTPB')
     title(append('Temporal Moving Average -', ' LTPB Group'))
elseif strcmpi(data_name,'data_full')
     title(append('Temporal Moving Average -', ' Full'))
end
    
    
xlabel("Número da Jogada")
ylabel("RT(s/trial)")

set(0,'defaultaxescolororder', [[1 0 0]
                                [0 0 1]
                                [1 1 0]
                                [0 0 0]
                                [1 0 1]
                                [0 1 1]]);
                           
set(0,'defaultaxeslinestyleorder',{'-',':','-.'})

hold on
for I= 1:(size(data,1)/1000) 
l = strcat('Participant:T0',num2str(data(I*1000 ,11)));
plot(x, mov_average{I},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',l)
ylim([0 5])
end

xline(334,'--','DisplayName','Break 1');
xline(668,'--','DisplayName','Break 2');
plot(NaN,NaN,'display',append('Window =', num2str(window)), 'linestyle', 'none') %put the window information in the legend

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

hold off
legend show


elseif strcmpi(condition,'participant')

    tree_file_address= "C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\git\files_for_reference\tree_behave12.txt";
    
    [ctx_rtime,ctx_er,ctx_resp,contexts,ctxrnds,ct_pos]=rtanderperctx(data_LTPB,pa,1,1000,tree_file_address,0,12);

    T=repmat(0,1,1000); %marca quando houveram contextos infrequentes
    t=repmat(0,1,1000); %proporção de contextos infrequentes a cada jogada
    
    %%loop que itera sobre o arquivo ctx_pos e pra cada posição da linha 4 muda 0 para 1 em T
    for k = drange(1:1000)
        if ct_pos(4,k) ~= 0
        T(ct_pos(4,k))=1;
        t(k)=sum(T(1,1:k))/k;
        elseif  ct_pos(4,k) == 0
        t(k)=sum(T(1,1:k))/k;
        end
    end
    
   Id=data(pa*1000 ,11);
   space='|';
   
   if strcmpi(data_name,'data_control')
       Name=append(' ', num2str(pa),' in the Control Group ',space,' T ',num2str(Id), ' in the GG');
   elseif strcmpi(data_name,'data_LTPB')
       Name=append(' ', num2str(pa),' in the LTPB Group ',space,' T ',num2str(Id), ' in the GG');
   elseif strcmpi(data_name,'data_full')
       Name=append(' ', num2str(pa),' overall ',space,' T ',num2str(Id), ' in the GG');
   end
   
   x = linspace(1,1000,1000);

   title(strcat('Temporal Moving Average of participant ', Name)) 
   xlabel("Número da Jogada")


   set(0,'defaultaxescolororder', [[1 0 0]
                                [0 0 1]
                                [1 1 0]
                                [0 0 0]
                                [1 0 1]
                                [0 1 1]]);
                           
   set(0,'defaultaxeslinestyleorder',{'-',':','-.'})

   hold on
   for i= 1:(size(data,1)/1000)
       l = num2str(i);
   end
   yyaxis left 
   plot(x,mov_average{pa},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName','Moving Average')
   ylim ([0 5])
   ylabel("RTs")

   yyaxis right 
   ct=plot(x,t,'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'Infrequent contexts proportion', 'color', [0 0 1]);
   ylim([0 0.2])
   yticks([0:0.05:0.2])
   ylabel("Infrequent contexts proportion")


   xline(334,'--','DisplayName','Break 1');
   xline(668,'--','DisplayName','Break 2');

   plot(NaN,NaN,'display',append('Window =', num2str(window)), 'linestyle', 'none')

   figureHandle = gcf;
   set(findall(figureHandle,'type','text'),'fontSize',14)
   
   hold off
   legend show

end