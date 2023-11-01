% [mov_average] = GG_mov_average(interest,data,data_name,mode,window,pa)
%
% This function has a myriad of features related to the moving averages technique.
% As output, it returns a list containg the moving averages of the response times or the accuracy of
% all the participants in the desired group, using a moving window of your
% choosing. Using the mode "group", the functions plots the moving averages
% of the response times or the accuracy information of each trial of each participant of the desired group all at once as a function of time. In the
% mode "participant", the function plots individual moving averages graphs
% of the response times or the accuracy alongside the proportion of infrequent contexts
% (211)that the participant has encountered until the current trial.
%
% INPUT:
%
% interest = Write "acc" if you want to analyse accuracy and "RTs" if you
% want to analyse response times.
%
% data = data matrix.
%
% data_name = name of the data matrix variable as a string. THE INFORMATION HAS TO
% ALWAYS BE THE SAME AS THE ONE IN DATA.
% Example: If data is "data_control", data_name should be "'data_control'".
%
% mode =  The mode of analysis that the function will use. This accepts the following parameters:
% "group"-> enables the function to plot the moving averages
% of the response times of each trial of each participant of the desired
% group all at once as a function of time.
% "participant"-> enables the function to plot individual moving averages graphs
% of the response times alongside the proportion of infrequent contexts
% that the participant has encountered until the current trial.
%
% window =  the moving window that you would like to analyse. It is recommended a window of 101. 
% Example: Setting the window to 100, will make each trial value to be the
% mean of the 50 numbers after it, the 50 numbers before it and itself.
%
% pa = the number of the participant in the current group that you would
% like to analyse. If mode is set to "group", this value doesn't matter and
% you can write anything in it.
%
% OUTPUT:
% mov_average = a list containg the moving averages of the response times of
% all the participants in the desired group, using a moving window of your
% choosing
%
%08/10/2022 by Pedro R. Pinheiro



function [mov_average] = GG_mov_average(interest,data,data_name,condition,window, pa)

if strcmpi(interest,'RTs')

    for i = 1:size(data,1)
       RT(i)=data(i,7);
    end


    i=1;

    for p=1:(size(data,1)/1000) %number of participants
        u=RT(i:i+999); %response times of each participant
        mov_average{p}= movmean(u,window); %moving averages of each participant

    i=i+1000;

    end

    if strcmpi(condition,'group')

        x = linspace(1,1000,1000);
        if strcmpi(data_name,'data_control') %unlike '==', strcmpi allows comparsions between matrixes of different dimensions
            title(append('Média móvel dos tempos de resposta -', ' Grupo controle')) 
        elseif strcmpi(data_name,'data_LTPB')
            title(append('Média móvel dos tempos de resposta -', ' Grupo LTPB'))
        elseif strcmpi(data_name,'data_full')
            title(append('Temporal Moving Average -', ' Full'))
        end


        xlabel("Número da Jogada")
        ylabel("Tempo de Resposta Médio(s)")

        set(0,'defaultaxescolororder', [[1 0 0]
                                        [0 0 1]
                                        [1 1 0]
                                        [0 0 0]
                                        [1 0 1]
                                        [0 1 1]]);

        set(0,'defaultaxeslinestyleorder',{'-',':','-.'})

        hold on
        for I= 1:(size(data,1)/1000) 
            l = append('Participante',' ', num2str(I));
            plot(x, mov_average{I},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',l)
            ylim([0 5])
        end

        xline(334,'--','DisplayName','Intervalo 1');
        xline(668,'--','DisplayName','Intervalo 2');
        plot(NaN,NaN,'display',append('Janela =', num2str(window)), 'linestyle', 'none') %put the window information in the legend

        figureHandle = gcf;
        set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

        hold off
        
        lgd = legend;
        lgd.Location = 'northeastoutside';
        legend show


    elseif strcmpi(condition,'participant')

        tree_file_address= "C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\git\files_for_reference\tree_behave12.txt";

        [~,~,~,~,~,ct_pos]=rtanderperctx(data,pa,1,1000,tree_file_address,0,12); %output arguments marked with tilde (~~) are ignored.

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
       xlabel("Trial Number")

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
       ylabel("Mean RT(s)")

       yyaxis right 
       ct=plot(x,t,'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'Infrequent contexts proportion', 'color', [0 0 1]);
       ylim([0 0.2])
       yticks([0:0.05:0.2])
       ylabel("Infrequent contexts proportion")


       xline(334,'--','DisplayName','Intervalo 1');
       xline(668,'--','DisplayName','Intervalo 2');

       plot(NaN,NaN,'display',append('Janela=', num2str(window)), 'linestyle', 'none')

       figureHandle = gcf;
       set(findall(figureHandle,'type','text'),'fontSize',14)

       hold off
       
       lgd = legend;
        lgd.Location = 'northeastoutside';
       legend show

    end

elseif strcmpi(interest,'acc')
    
    for i = 1:size(data,1)

       if data(i,8)== data(i,9)
           A(i)= 1;    %vector where 1's represents a correct prediction and 0's represents a prediction error.
       else 
           A(i)= 0;
       end


    end

    i=1;

    for m=1:(size(data,1)/1000) ;
        w=A(i:i+999);
        mov_average{m}= movmean(w,window);

    i=i+1000;

    end

    if strcmpi(condition,'group')

            x = linspace(1,1000,1000);
            if strcmpi(data_name,'data_control')
                title(append('Média móvel da acurácia -', ' Grupo Controle')) 
            elseif strcmpi(data_name,'data_LTPB')
                title(append('Média móvel da acurácia -', ' Grupo LTPB'))
            elseif strcmpi(data_name,'data_full')
                title(append('Accuracy Moving Average -', ' Full'))
            end


            xlabel("Número da jogada")
            ylabel("Acurácia média")

            set(0,'defaultaxescolororder', [[1 0 0]
                                            [0 0 1]
                                            [1 1 0]
                                            [0 0 0]
                                            [1 0 1]
                                            [0 1 1]]);

            set(0,'defaultaxeslinestyleorder',{'-',':','-.'})

            hold on
            for I= 1:(size(data,1)/1000) 
                l = append('Participante',' ', num2str(I));
                plot(x, mov_average{I},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',l)
                ylim([0 1])
            end

            xline(334,'--','DisplayName','Intervalo 1');
            xline(668,'--','DisplayName','Intervalo 2');
            plot(NaN,NaN,'display',append('Janela =', num2str(window)), 'linestyle', 'none') %put the window information in the legend

            figureHandle = gcf;
            set(findall(figureHandle,'type','text'),'fontSize',14) %make all text in the figure to size 14

            hold off

            lgd = legend;
            lgd.Location = 'northeastoutside';
            legend show


        elseif strcmpi(condition,'participant')

            tree_file_address= "C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\git\files_for_reference\tree_behave12.txt";

            [~,~,~,~,~,ct_pos]=rtanderperctx(data,pa,1,1000,tree_file_address,0,12); %output arguments marked with tilde (~~) are ignored.

            T=repmat(0,1,1000); 
            t=repmat(0,1,1000); 

            %%loop that works with ct_pos and for each position on line 4 (the most infrequent context), changes 0 to 1 in T.
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

           title(strcat('Accuracy Moving Average of participant ', Name)) 
           xlabel("Trial Number")

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
           ylim ([0 1])
           ylabel("Mean Accuracy")

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

           lgd = legend;
            lgd.Location = 'northeastoutside';
           legend show

    end    
    
end
end