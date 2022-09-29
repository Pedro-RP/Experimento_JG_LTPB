function Presoftware(data)
close all
set(0,'defaultfigurecolor',[1 1 1]); set(0, 'DefaultFigureRenderer', 'painters');

strfig.data = data;
assignin('base','aux',0);
f = figure;
guidata(f,strfig)
set(f,'Resize','off')
f.Position = [50 1 1317 649];

% Fields

% Label Volunteer
lvolfield = uicontrol(f,'Style','text','String', 'Volunteer:'); lvolfield.Position = [630 595 100 20]; 
lvolfield.BackgroundColor = [1 1 1]; uicontrol(lvolfield);
% Field Volunteer
volfield = uicontrol(f,'Style','edit'); volfield.Position = [650 575 60 20]; uicontrol(volfield); volfield.Tag = 'vol';

% Label Tree
ltreefield = uicontrol(f,'Style','text','String', 'Tree: '); ltreefield.Position = [630 545 100 20];
ltreefield.BackgroundColor = [1 1 1];uicontrol(ltreefield);
% Field Tree
taufield = uicontrol(f,'Style','edit'); taufield.Position = [650 525 60 20]; uicontrol(taufield); taufield.Tag = 'tree';

% Label minimum value of response time
lleftl = uicontrol(f,'Style','text','String', 'Min time: '); lleftl.Position = [630 495 100 20];
lleftl.BackgroundColor = [1 1 1]; uicontrol(lleftl);
% Field minimum value of response time
leftl = uicontrol(f,'Style','edit'); leftl.Position = [650 475 60 20]; uicontrol(leftl); leftl.Tag = 'mintime';

% Label maximum value of response time
lrightl = uicontrol(f,'Style','text','String', 'Max time: '); lrightl.Position = [730 495 100 20];
lrightl.BackgroundColor = [1 1 1]; uicontrol(lrightl);
% Field maximum value of response time
rightl = uicontrol(f,'Style','edit'); rightl.Position = [750 475 60 20]; uicontrol(leftl); rightl.Tag = 'maxtime';

% Label context
lwcxt = uicontrol(f,'Style','text','String', 'Context: '); lwcxt.Position = [630 445 100 20];
lwcxt.BackgroundColor = [1 1 1]; uicontrol(lwcxt);
% Field context
wcxt = uicontrol(f,'Style','edit'); wcxt.Position = [650 425 60 20]; uicontrol(wcxt); wcxt.Tag = 'context';

% Label Left Trial definition
lfromtrial = uicontrol(f,'Style','text','String', 'From trial: '); lfromtrial.Position = [730 445 100 20];
lfromtrial.BackgroundColor = [1 1 1]; lfromtrial.BackgroundColor = [1 1 1]; uicontrol(lfromtrial);
% Field Left Trial definition
fromtrial = uicontrol(f,'Style','edit'); fromtrial.Position = [750 425 60 20]; uicontrol(fromtrial); fromtrial.Tag = 'fromtrial';

% Label Right Trial definition
ltotrial = uicontrol(f,'Style','text','String', 'To trial: '); ltotrial.Position = [850 445 100 20];
ltotrial.BackgroundColor = [1 1 1]; uicontrol(ltotrial);
% Field Right Trial definition
totrial = uicontrol(f,'Style','edit'); totrial.Position = [875 425 60 20]; uicontrol(totrial);totrial.Tag = 'totrial';

% Label Model
lexpomodel = uicontrol(f,'Style','text','String', 'Model: '); lexpomodel.Position = [625 395 100 20]; lexpomodel.BackgroundColor = [1 1 1]; uicontrol(lexpomodel);
% Field Models
expomodel = uicontrol(f,'Style','radiobutton','String','Option 1','String', 'Exponential'); expomodel.Position = [650 375 100 20];expomodel.BackgroundColor = [1 1 1]; expomodel.Tag = 'exponential';
normmodel = uicontrol(f,'Style','radiobutton','String','Option 1','String', 'Normal'); normmodel.Position = [750 375 100 20]; normmodel.BackgroundColor = [1 1 1]; normmodel.Tag = 'normal';
gammamodel = uicontrol(f,'Style','radiobutton','String','Option 1','String', 'Gamma'); gammamodel.Position = [850 375 100 20]; gammamodel.BackgroundColor = [1 1 1]; gammamodel.Tag = 'gamma';
lognormalmodel = uicontrol(f,'Style','radiobutton','String','Option 1','String', 'Lognormal'); lognormalmodel.Position = [950 375 100 20]; lognormalmodel.BackgroundColor = [1 1 1]; lognormalmodel.Tag = 'lognormal';


lfilterrate = uicontrol(f,'Style','text','String', 'Filtering Options: '); lfilterrate.Position = [605 345 200 20]; lfilterrate.BackgroundColor = [1 1 1]; uicontrol(lfilterrate);
filterrate = uicontrol(f,'Style','radiobutton','String','Option 1','String', 'Filter'); filterrate.Position = [650 325 100 20]; filterrate.BackgroundColor = [1 1 1]; filterrate.Tag = 'filter';

lposit = uicontrol(f,'Style','text','String', 'Filtering Position: '); lposit.Position = [850 345 200 20]; lposit.BackgroundColor = [1 1 1];uicontrol(lposit);
posit = uicontrol(f,'Style','edit'); posit.Position = [930 325 40 20]; posit.Tag = 'position';

conditioning = uicontrol(f,'Style','popupmenu','String',{'-','SUCCESSES','FAILURES'}); conditioning.Position = [1100 325 150 20]; conditioning.Tag = 'condition';

lfplot = uicontrol(f,'Style','text'); lfplot.String = 'Frequency plot parameters'; lfplot.Position = [630 295 200 20]; lfplot.BackgroundColor = [1 1 1]; uicontrol(lfplot);

llaksis = uicontrol(f,'Style','text','String', 'left axis: '); llaksis.Position = [630 275 100 20]; llaksis.BackgroundColor = [1 1 1]; uicontrol(llaksis);
laksis = uicontrol(f,'Style','edit'); laksis.Position = [650 255 60 20]; uicontrol(laksis); laksis.Tag = 'laksis';

lraksis = uicontrol(f,'Style','text','String', 'right axis: '); lraksis.Position = [730 275 100 20]; lraksis.BackgroundColor = [1 1 1]; uicontrol(lraksis);
raksis = uicontrol(f,'Style','edit'); raksis.Position = [750 255 60 20]; uicontrol(raksis); raksis.Tag = 'raksis';

lbwidfield = uicontrol(f,'Style','text','String', 'Bin Width: '); lbwidfield.Position = [630 230 100 20]; lbwidfield.BackgroundColor = [1 1 1]; uicontrol(lbwidfield);
bwidfield = uicontrol(f,'Style','edit'); bwidfield.Position = [650 210 60 20]; uicontrol(bwidfield); bwidfield.Tag = 'bwid';

savecurrentd = uicontrol(f,'Style','pushbutton'); savecurrentd.Position = [650 180 125 20]; 
savecurrentd.String = 'Save Distribution'; uicontrol(savecurrentd);
savecurrentd.Callback = @savingdata;
    function savingdata(savecurrentd,~)
    strfig = guidata(updateb); % loading the data
    auxws = evalin('base', 'aux');
    if auxws == 0
       auxws = 1;
       assignin('base','dist',[]);
       assignin('base','groups',[]);
       assignin('base','aux',auxws);
    elseif auxws == 1
        auxws = auxws+1;
        assignin('base','aux',auxws)
    else
        display('Unable to save more distributions');
        return
    end
    nl = length(evalin('base','sample'));
    distws = evalin('base','dist'); distws = [distws; evalin('base','sample')];
    assignin('base','dist',distws);
    groupsws = evalin('base','groups'); groupsws = [groupsws; auxws*ones(nl,1)];
    assignin('base','groups',groupsws);
    % Boxplotting
    grafiks = findobj('Type','axes');
    if length(grafiks)>0
        for a = 1:length(grafiks)
           if abs(grafiks(a).Position(1)-0.7) < 10^(-10)
             delete(grafiks(a))
           end
        end
    end 
    ax3 = axes(f,'Position', [0.7 0.075 0.25 0.30]); ax3.Tag = 'axes3';
    sses = findobj('Tag','axes3');
    boxplot(distws,groupsws)
    ylabel('time(sec.)')
    end
cleard = uicontrol(f,'Style','pushbutton'); cleard.Position = [650 155 125 20]; 
cleard.String = 'Clear Distributions'; uicontrol(cleard);
cleard.Callback = @cleardists;
    function cleardists(cleard,~)
        assignin('base','aux',0);
        assignin('base','dist',[]);
        assignin('base','groups',[]);
    % Removing saved data axes
    grafiks = findobj('Type','axes');
    if length(grafiks)>0
        for a = 1:length(grafiks)
           if abs(grafiks(a).Position(1)-0.7) < 10^(-10)
             delete(grafiks(a))
           end
        end
    end

    end
testd = uicontrol(f,'Style','pushbutton'); testd.Position = [650 130 125 20]; 
testd.String = 'Test Distributions'; uicontrol(testd);
testd.Callback = @TestDist;
    function TestDist(testd,~)
    distws = evalin('base','dist');
    groupsws = evalin('base','groups');
    x1 = distws(find(groupsws == 1),1); x1 = x1(find(isoutlier(x1) == 0),1);
    x2 = distws(find(groupsws == 2),1); x2 = x2(find(isoutlier(x2) == 0),1);
    [~,p] = kstest2(x1,x2);
    ksresult = uicontrol(f,'Style','text','String', ['Result: ' num2str(p,'%2f')]); ksresult.Position = [610 100 200 20]; ksresult.BackgroundColor = [1 1 1]; uicontrol(ksresult);
    end
clresul = uicontrol(f,'Style','pushbutton'); clresul.Position = [650 70 125 20]; 
clresul.String = 'Clear Results'; uicontrol(clresul);
clresul.Callback = @clresults;
    function clresults(clresul,~) %#ok<INUSD>
        % Delete the results
        auxfordel = findobj('Style','text');
        if ~isempty(auxfordel)
            for clr = 1:length(auxfordel)
                if abs(auxfordel(clr).Position(2) - 100) < 10^(-10)
                    delete(auxfordel(clr))
                    break;
                end
            end
        end
    end
% lbplot = uicontrol(f,'Style','text','String', 'Boxplot parameters: '); lbplot.Position = [610 100 200 20]; lbplot.BackgroundColor = [1 1 1]; uicontrol(lbplot);
% ltopl = uicontrol(f,'Style','text','String', 'Upper lim.: '); ltopl.Position = [630 80 100 20]; ltopl.BackgroundColor = [1 1 1]; uicontrol(ltopl);
% topl = uicontrol(f,'Style','edit'); topl.Position = [650 60 60 20]; uicontrol(topl);
% 
% lbotl = uicontrol(f,'Style','text','String', 'Lower lim.: '); lbotl.Position = [730 80 100 20]; lbotl.BackgroundColor = [1 1 1]; uicontrol(lbotl);
% botl = uicontrol(f,'Style','edit'); botl.Position = [750 60 60 20]; uicontrol(botl);

ltotal = uicontrol(f,'Style','text','String', ''); ltotal.Position = [450 280 120 40]; ltotal.BackgroundColor = [1 1 1]; uicontrol(ltotal);ltotal.Tag = 'total';


updateb = uicontrol(f,'Style','pushbutton'); updateb.Position = [775 575 60 20]; 
updateb.String = 'Update'; uicontrol(updateb);
updateb.Callback = @upthedata;
    function upthedata(updateb, ~)
    ntrials = 1000; % THIS SHOULD BE REMOVED LATTER
    strfig = guidata(updateb); % loading the data
    data = strfig.data;
    % Removing Previous axes
    grafiks = findobj('Type','axes'); auxdel = [];
    if length(grafiks)>0
        for a = 1:length(grafiks)
           if abs(grafiks(a).Position(1) - 0.05) < 10^(-10)
             auxdel = [auxdel a];
           end
        end
        pnorthw = grafiks(auxdel(1));psouthw = grafiks(auxdel(2));
        delete(pnorthw); delete(psouthw);
    end
    
    while ~isempty(findobj('Type','uitable'))
        ttable = findobj('Type','uitable'); delete(ttable(1))
    end
    % Defining the tree of interest
    h = findobj('Tag','tree');
    tau = str2num(h.String); 
    
    % Defining the range of interest
    h = findobj('Tag','fromtrial'); from = str2num(h.String); 
    h = findobj('Tag','totrial'); till = str2num(h.String);
    
    % Defining restrictions of the response time
    h = findobj('Tag','mintime'); limitingl = str2num(h.String);
    h = findobj('Tag','maxtime'); limitingr = str2num(h.String);
    
    % Defining the volunteer
    h = findobj('Tag','vol'); p = str2num(h.String);
    
    % Defining graphical aspects
    h = findobj('Tag','bwid'); bwid = str2num(h.String);
    h = findobj('Tag','laksis'); lak = str2num(h.String);
    h = findobj('Tag','raksis'); rak = str2num(h.String);
    
    % Loading the mean parameters
    [ids, vids, tauofid, gametest, trees, treesizes] = data_setaspects(data, ntrials);
    t_id = find(tauofid == tau);
    tau_repo = cell(length(t_id),treesizes(find(trees == tau)));
    counts_total = zeros(length(t_id),treesizes(find(trees == tau)));

    for a = 1:length(t_id)
<<<<<<< Updated upstream
       tree_file_address = ['C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\files_for_reference\tree_behave' num2str(tau) '.txt' ];
=======
       tree_file_address = ['C:\Users\vinivius valent\Documents\GitHub\main\files_for_reference\tree_behave' num2str(tau) '.txt' ];
>>>>>>> Stashed changes
       % Creating table with the tree structure
       [contexts, PM, responses, rnds] = build_treePM (tree_file_address);
       colnames = {'0', '1', '2'}; rownames = {};
       for tt = 1:length(contexts)
           rownames{1,tt} = ['w=' num2str(contexts{1,tt})];
       end
       ctstruct = uitable(f,'Data',PM,'ColumnName', colnames, 'RowName', rownames,'Position', [975 400 310 175]); 
       %
       [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx(data, t_id(a), from, till, tree_file_address, 0, tau);
       [chain,responses, times] = get_seqandresp(data,tau, t_id(p), from, till);
       h = findobj('Tag','position');
       fpos = str2num(h.String);
       if fpos >= 1
          [ctx_fer,ct_poscell] = lastwas_error(ct_pos, ctx_er, contexts, chain, responses,fpos); 
       end       
       for b = 1:treesizes(find(trees == tau))
          h = findobj('Tag','filter');
          if h.Value == 0 % Considering all responses
          aux = [1:length(ctx_er{b,1})];
          else
              h = findobj('Tag','condition'); % Considering Successes or failures
              if fpos == 0
                  if isequal(h.String{h.Value},'SUCCESSES')
                      aux = find(ctx_er{b,1} == 0); 
                  elseif isequal(h.String{h.Value},'FAILURES')
                      aux = find(ctx_er{b,1} == 1); 
                  else
                      aux = [1:length(ctx_er{b,1})]; % redundancy
                  end
              else
                  if isequal(h.String{h.Value},'SUCCESSES')
                      aux = find(ctx_fer{b,1} == 0); 
                  elseif isequal(h.String{h.Value},'FAILURES')
                      aux = find(ctx_fer{b,1} == 1); 
                  else
                      aux = [1:length(ctx_fer{b,1})]; % redundancy
                  end                  
              end
          end
          tau_repo{a,b} = ctx_rtime{b,1}(aux,1);
          tau_repo{a,b} = tau_repo{a,b}(find( (tau_repo{a,b} <= limitingr)&(tau_repo{a,b} >= limitingl) ),1);
          counts_total(a,b) = length(ctx_rtime{b,1});
       end
    end
    
    [chain,responses, times] = get_seqandresp(data,tau, t_id(p), from, till);
    srate = sum(chain == responses)/length(chain);
    
    % Identifying the context
    wstr = findobj('Tag','context');
    w = wstr.String; auxw = [];
    for wi = 1:length(w)
       auxw = [auxw str2num(w(1,wi))];
    end
    
    for wj = 1:length(contexts)
       if isequal(auxw,contexts{1,wj})
          posw = wj;
          break; 
       end
    end
    
    % Setting the total
    h = findobj('Tag','total');
    h.String = ['Total: ' num2str(counts_total(p,posw)) ' sr = (' num2str(srate) ')'];
 
    % Plotting Data
    ax1 = axes(f,'Position', [ 0.05 0.55 0.375 0.4]); ax1.Tag = 'axes1';
    xlabel('Time (sec)'); ylabel('Frequency')
    X = tau_repo{p,posw}; assignin('base','sample',X)
    sses = findobj('Tag','axes1');
    axes(sses)
    h = histogram(X,'BinWidth',bwid);
    xlabel('Time (sec)'); ylabel('Frequency')
    legend(['N =' num2str(length(X))])
    axis([lak rak 0 max(h.Values)])    
    
    % Exponential Modelling
    h = findobj('Tag','exponential'); 
    if h.Value == 1
    sses = findobj('Tag','axes1');
    axes(sses)
    yyaxis right
    [lambda, x, fest] = expmodel(X, [lak rak], bwid , 0);   
    plot(x,fest,'r','LineWidth',1.5)
    h = gca; h.Legend.String{1,2} =  ['\lambda =' num2str(lambda,'%.3f') ];
    axis([lak rak 0 max(fest)])
    h.YAxis(1).Color = 'k';h.YAxis(2).Color = 'k';
    xlabel('Time (sec)'); 
    yyaxis left
    
    % QQ plot for the exponential
    ax2 = axes(f,'Position', [0.05 0.075 0.25 0.40]); ax2.Tag = 'axes2';
    xlabel('Observed'); ylabel('Expected')
    sses = findobj('Tag','axes2');
    axes(sses)
    q = 10;
    nX = exprnd(1/lambda,length(X),1);
    axes(sses)
    qxqplot(X,nX,q)
    end

    % Normal Modelling
    h = findobj('Tag','normal'); 
    if h.Value == 1
    sses = findobj('Tag','axes1');
    axes(sses)
    yyaxis right
    [mu, sigma, x, fest] = normal_model(X, [lak,rak], bwid, 0); 
    plot(x,fest,'r','LineWidth',1.5)
    h = gca; h.Legend.String{1,2} =  ['mu =' num2str(mu,'%.3f') ' sigma = ' num2str(sigma,'%.3f') ];
    axis([lak rak 0 max(fest)])
    h.YAxis(1).Color = 'k';h.YAxis(2).Color = 'k';
    xlabel('Time (sec)');
    yyaxis left
    % QQ plot for the exponential
    ax2 = axes(f,'Position', [0.05 0.075 0.25 0.40]); ax2.Tag = 'axes2';
    xlabel('Observed'); ylabel('Expected')
    sses = findobj('Tag','axes2');
    axes(sses)
    q = 10;
    nX = normrnd(mu,sigma, [length(X),1]);
    qxqplot(X,nX,q)
    end
    
    % Gamma Modelling
    h = findobj('Tag','gamma'); 
    if h.Value == 1
    sses = findobj('Tag','axes1');
    axes(sses)
    yyaxis right
    [khat, thetahat, x, fest] = gamma_model(X, [lak,rak], bwid, 0);
    plot(x,fest,'r','LineWidth',1.5)
    h = gca; h.Legend.String{1,2} =  ['k =' num2str(khat,'%.3f') ' theta = ' num2str(thetahat,'%.3f') ];
    axis([lak rak 0 max(fest)])
    h.YAxis(1).Color = 'k';h.YAxis(2).Color = 'k';
    xlabel('Time (sec)');
    yyaxis left
    % QQ plot for the exponential
    ax2 = axes(f,'Position', [0.05 0.075 0.25 0.40]); ax2.Tag = 'axes2';
    xlabel('Observed'); ylabel('Expected')
    sses = findobj('Tag','axes2');
    axes(sses)
    q = 10;
    nX = gamrnd(khat,thetahat,length(X),1);
    qxqplot(X,nX,q)
    end
    
    % Log-Normal Modelling
    h = findobj('Tag','lognormal'); 
    if h.Value == 1
    sses = findobj('Tag','axes1');
    axes(sses)
    yyaxis right
    [uhat, sigmahat, x, fest] = lognormal_model(X, [lak,rak], bwid, 0);
    plot(x,fest,'r','LineWidth',1.5)
    h = gca; h.Legend.String{1,2} =  ['\mu =' num2str(uhat,'%.3f') ' \sigma = ' num2str(sigmahat,'%.3f') ];
    axis([lak rak 0 max(fest)])
    h.YAxis(1).Color = 'k';h.YAxis(2).Color = 'k';
    xlabel('Time (sec)');
    yyaxis left
    % QQ plot for the exponential
    ax2 = axes(f,'Position', [0.05 0.075 0.25 0.40]); ax2.Tag = 'axes2';
    xlabel('Observed'); ylabel('Expected')
    sses = findobj('Tag','axes2');
    axes(sses)
    q = 10;
    nX = lognrnd(uhat,sigmahat,length(X),1);
    qxqplot(X,nX,q)
    end

    end
end
 % Ao carregar, indicar os indices de cada indivíduo em referência à árvore
 % Verificar se o código vai rodar perfeitamente para todas as árvores.