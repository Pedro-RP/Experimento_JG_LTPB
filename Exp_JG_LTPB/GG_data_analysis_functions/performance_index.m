% [PI_final] = performance_index(data,data_name,pa)
%
% This function calculates and returns the performance index (PI) for each trial of
% each participant of each group. It also plots the behavior of the PI of
% the indivual in the last 2 blocks of the experiment alongside the
% proportion of infrequent contexts.
%
% NOTE: Uptade the tree_file_address to the file in your machine the
% corresponds to tree 12.
%
% INPUT:
%
% data = data matrix.
%
% data_name = name of the data matrix variable as a string. THE INFORMATION HAS TO
% ALWAYS BE THE SAME AS THE ONE IN DATA.
% Example: If data is "data_control", data_name should be "'data_control'".
%
%
% pa = the number of the participant in the current group that you would
% like to analyse. 
%
% OUTPUT:
% PI_final = a list containg the moving averages of the response times of
% all the participants in the desired group, using a moving window of your
% choosing
%
%08/10/2022 by Pedro R. Pinheiro

function [PI_final] = performance_index(data,data_name,pa)

tree_file_address= "C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\git\files_for_reference\tree_behave12.txt";
[~,~,~,~,~,ct_pos]= rtanderperctx(data,pa,1,1000,tree_file_address,0,12);


p_mod=[0 1 0
    0 1 0
    0 0 1
    0 0 1
    0.7 0.3 0];
P_ctx=[0.23
    0.10
    0.10
    0.23
    0.33];

%Ocurrence of each context until a specific trial 
Q=repmat(0,5,1000);
for mc = drange(1:5)
    for j = drange(1:1000)
        if ct_pos(mc,j) ~= 0
            Q(mc,ct_pos(mc,j))=1;
            q(mc,j)=sum(Q(mc,1:j));
        elseif  ct_pos(mc,j) == 0
    q(mc,j)=sum(Q(mc,1:j));
        end
    end
end    
%The matrix represents the times that the participant choose answers A given each context 
for nc= drange(1:5)
    Qz=repmat(0,3,1000);
    qz=repmat(0,3,1000);
    for jk = drange(335:1000)
        if Q(nc,jk) == 1 
            if data(jk+1,8)==0 
                Qz(1,jk)= 1;
            elseif data(jk+1,8)== 1
                Qz(2,jk)= 1;
            elseif data(jk+1,8)== 2     
                Qz(3,jk)= 1;
            end
        end
        qz(1,jk)=sum(Qz(1,1:jk));
        qz(2,jk)=sum(Qz(2,1:jk));
        qz(3,jk)=sum(Qz(3,1:jk)); 
    end
    contz{nc}=qz;
end

% Calculating the empirical probability of each context  
for dc = drange(1:5)   
    pz=repmat(0,3,666);
    for kl=drange(1:666)
        
        pz(1,kl)=contz{dc}(1,kl+334)/q(dc,kl+334);  
        pz(2,kl)=contz{dc}(2,kl+334)/q(dc,kl+334);
        pz(3,kl)=contz{dc}(3,kl+334)/q(dc,kl+334); 
    end
    conty{dc}=pz;
end  
 



%calculation of the performance index for each context 
PI=repmat(0,5,666);
for lc = drange(1:5)   
    for kt=drange(1:666)
        PI(lc,kt)=1-((abs(conty{lc}(1,kt)-p_mod(lc,1))+abs(conty{lc}(2,kt)-p_mod(lc,2))+abs(conty{lc}(3,kt)- p_mod(lc,3)))/2);
    end
end

PIt=repmat(0,5,666);
for tc = drange(1:5)
    for bk = drange(1:666)
        PIt(tc,bk)=PI(tc,bk)*P_ctx(tc);    
    end 
end

PI_final=sum(PIt); %final performance index


%calculation of the infrequent contexts proportion

T=repmat(0,1,1000); 
t=repmat(0,1,1000);
for k = drange(1:1000)
            if ct_pos(4,k) ~= 0
            T(ct_pos(4,k))=1;
            t(k)=sum(T(1,1:k))/k;
            elseif  ct_pos(4,k) == 0
            t(k)=sum(T(1,1:k))/k;  
            end
        end

%Building the plot of performance analysis

x = linspace(335,1000,666);
xlim ([335 1000])
xticks([335:50:1000])

Id=data(pa*1000 ,11);
space = '|';
if strcmpi(data_name,'data_control')
    Name=append(' ', num2str(pa),' in the Control Group ',space,' T ',num2str(Id), ' in the GG');
elseif strcmpi(data_name,'data_LTPB')
    Name=append(' ', num2str(pa),' in the LTPB Group ',space,' T ',num2str(Id), ' in the GG');
elseif strcmpi(data_name,'data_full')
    Name=append(' ', num2str(pa),' overall ',space,' T ',num2str(Id), ' in the GG');
end

      
title(append('Individual performance of', ' ', 'participant', Name))
 
xlabel("Trial Number")


yyaxis left
ac=plot(x,PI_final,'LineWidth',2.5,'MarkerSize',2.5, 'DisplayName', 'Performance Index', 'color', [1 0 0]);
ylim([0 1])
ylabel('Performance Index')
xline(668,'--','DisplayName','Break 2');
 
yyaxis right 
ct=plot(x,t(335:1000),'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'Infrequent contexts', 'color', [0 0 1]);
ylim([0 0.2])
yticks([0:0.05:0.2])
ylabel("Infrequent context proportion")

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14)


lgd = legend;
lgd.Location = 'northeastoutside';
legend show

end

