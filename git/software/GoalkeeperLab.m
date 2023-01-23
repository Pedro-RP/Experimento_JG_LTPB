function GoalkeeperLab(data,pathtogit,ntrials,EEGsignals,fs,channels)
%% Managing other windows
other_win = findobj('Name','Goalkeeper Lab');
    if ~isempty(other_win)
        close(other_win)
    end
%% Defining renderer and getting paths
set(0,'defaultfigurecolor',[1 1 1]); %set(0, 'DefaultFigureRenderer', 'painters');
addpath(genpath(pathtogit))

%% Defining figure spects
strfig.data = data; % data to be associated to the GUI
strfig.EEGsignals = EEGsignals; % eeg data to be associated to the GUI
strfig.fs = fs;
strfig.FontChoice = 10;
strfig.channels = channels;
strfig.edit_tags = {'vol'; 'tree'; 'mintime'; 'maxtime'; 'context'; 'fromtrial'; 'totrial'; 'position'; 'laksis'; 'raksis'; 'bwid'; 'low'; 'high'; 'ch'; 'filter'};

assignin('base','aux',0); % assing value for workspace variable
f = figure('Name','Goalkeeper Lab','NumberTitle','off');
f.Tag = 'goalkeeperlab';
guidata(f,strfig) % associating GUI and data
set(f,'Resize','on')
scrsize = get(0,'ScreenSize');
f.Position = [0 0 scrsize(3) scrsize(4)];


%% Defining the fields and fields labels
numfilds1 = 15;
column1 = 0.92:-0.06:(0.92-numfilds1*(0.06));

% LABEL VOLUNTEER
lvolfield = uicontrol(f,'Style','text','String', 'VOLUNTEER:', 'FontWeight','bold','FontName','Palatino','FontSize',12);
lvolfield.Units = 'normalized'; lvolfield.Position = [0.5 column1(1) 0.07 0.05];
lvolfield.BackgroundColor = [1 1 1]; uicontrol(lvolfield); lvolfield.Tag = 'text_field1';
% FIELD VOLUNTEER
volfield = uicontrol(f,'Style','edit','Units','normalized'); 
volfield.Position = [0.50625 column1(1) 0.06 0.02]; uicontrol(volfield); volfield.Tag = 'vol';

% LABEL TREE
ltreefield = uicontrol(f,'Style','text','String', 'TREE: ','FontWeight','bold','FontName','Palatino','FontSize',12);
ltreefield.Units = 'normalized'; ltreefield.Position = [0.485 column1(2) 0.07 0.05];
ltreefield.BackgroundColor = [1 1 1];uicontrol(ltreefield); ltreefield.Tag = 'text_field2';

% FILED TREE
taufield = uicontrol(f,'Style','edit','Units','normalized'); 
taufield.Position = [0.50625 column1(2) 0.06 0.02]; uicontrol(taufield); taufield.Tag = 'tree';

% LABEL MINIMAL VALUE OF THE RESPONSE TIME
lleftl = uicontrol(f,'Style','text','String', 'MIN TIME: ','FontWeight','bold','FontName','Palatino','FontSize',12);
lleftl.Units = 'normalized'; lleftl.Position = [0.4975 column1(3) 0.07 0.05];
lleftl.BackgroundColor = [1 1 1]; uicontrol(lleftl); lleftl.Tag = 'text_field3';

% FIELD MINIMAL VALUE OF THE RESPONSE TIME
leftl = uicontrol(f,'Style','edit','Units','normalized'); leftl.Position = [0.50625 column1(3) 0.06 0.02]; uicontrol(leftl); leftl.Tag = 'mintime';

% LABEL MAXIMUM VALUE OF THE RESPONSE TIME
lrightl = uicontrol(f,'Style','text','String', 'MAX TIME: ','FontWeight','bold','FontName','Palatino','FontSize',12);
lrightl.Units = 'normalized'; lrightl.Position = [(lleftl.Position(1)+0.0825) column1(3) 0.07 0.05];
lrightl.BackgroundColor = [1 1 1]; uicontrol(lrightl); lrightl.Tag = 'text_field4';

% FIELD MAXIMUM VALUE OF THE RESPONSE TIME
rightl = uicontrol(f,'Style','edit','Units','normalized'); rightl.Position = [(lleftl.Position(1)+0.09) column1(3) 0.06 0.02]; uicontrol(leftl); rightl.Tag = 'maxtime';

% LABEL CONTEXT
lwctx = uicontrol(f,'Style','text','String', 'CONTEXT(W): ','FontWeight','bold','FontName','Palatino','FontSize',12);
lwctx.Units = 'normalized'; lwctx.Position = [0.505 column1(4) 0.07 0.05];
lwctx.BackgroundColor = [1 1 1]; uicontrol(lwctx); lwctx.Tag = 'text_field5';

% FIELD CONTEXT
wctx = uicontrol(f,'Style','edit','Units','normalized'); wctx.Position = [0.50625 column1(4) 0.06 0.02]; uicontrol(wctx); wctx.Tag = 'context';

% LABEL FROM TRIAL
lfromtrial = uicontrol(f,'Style','text','String', 'FROM TRIAL: ','FontWeight','bold','FontName','Palatino','FontSize',12);
lfromtrial.Units = 'normalized'; lfromtrial.Position = [0.505 column1(5) 0.07 0.05];
lfromtrial.BackgroundColor = [1 1 1]; lfromtrial.BackgroundColor = [1 1 1]; uicontrol(lfromtrial);
lfromtrial.Tag = 'text_field6';

% FIELD FROM TRIAL
fromtrial = uicontrol(f,'Style','edit','Units','normalized'); fromtrial.Position = [0.50625 column1(5) 0.06 0.02]; uicontrol(fromtrial); fromtrial.Tag = 'fromtrial';

% LABEL TO TRIAL
ltotrial = uicontrol(f,'Style','text','String', 'TO TRIAL: ','FontWeight','bold','FontName','Palatino','FontSize',12);
ltotrial.Units = 'normalized'; ltotrial.Position = [(lleftl.Position(1)+0.0825) column1(5) 0.07 0.05];
ltotrial.BackgroundColor = [1 1 1]; uicontrol(ltotrial);
ltotrial.Tag = 'text_field7';

% FIELD TO TRIAL
totrial = uicontrol(f,'Style','edit','Units','normalized'); totrial.Position = [(lleftl.Position(1)+0.09) column1(5) 0.06 0.02]; uicontrol(totrial);totrial.Tag = 'totrial';

% LABEL APPLY MODEL
lexpomodel = uicontrol(f,'Style','text','String', ' APPLY MODEL: ','FontWeight','bold','FontName','Palatino','FontSize',12);
lexpomodel.Units = 'normalized'; lexpomodel.Position = [0.495 column1(6) 0.09 0.05]; lexpomodel.BackgroundColor = [1 1 1]; uicontrol(lexpomodel);
lexpomodel.Tag = 'text_field8';

% FIELD MODEL
model = uicontrol(f,'Style','popupmenu','Units','normalized');model.Position = [0.50625 column1(6) 0.06 0.02];
model.String = {'None','Exponential','Normal','Gamma','Lognormal'}; model.Value = 1; model.Tag = 'misc2';

% LABEL ADVANCED OPTIONS
lfilterrate = uicontrol(f,'Style','text','String', 'ADV. OPTIONS: ','FontWeight','bold','FontName','Palatino','FontSize',12); 
lfilterrate.Units = 'normalized'; lfilterrate.Position = [0.4975 column1(7) 0.09 0.05]; lfilterrate.BackgroundColor = [1 1 1]; uicontrol(lfilterrate);
lfilterrate.Tag = 'text_field9';

%FIELD ADVANCED OPTIONS
filterrate = uicontrol(f,'Style','radiobutton','String','Option 1','String', 'APPLY','FontWeight','bold','FontName','Palatino','FontSize',12); 
filterrate.Units = 'normalized'; filterrate.Position = [0.50625 (column1(7)+0.005) 0.06 0.02]; filterrate.BackgroundColor = [1 1 1]; filterrate.Tag = 'filter';

% LABEL PREVIOUS GUESS
lposit = uicontrol(f,'Style','text','String', 'PREVIOUS GUESS: ','FontWeight','bold','FontName','Palatino','FontSize',12); 
lposit.Units = 'normalized'; lposit.Position = [0.505 column1(8) 0.09 0.05]; lposit.BackgroundColor = [1 1 1];uicontrol(lposit);
lposit.Tag = 'text_field10';

% FIELD PREVIOUS GUESS
posit = uicontrol(f,'Style','edit'); posit.Units = 'normalized'; posit.Position = [0.50625 column1(8) 0.06 0.02]; posit.Tag = 'position';

% FIELD CORRECT/INCORRECT
conditioning = uicontrol(f,'Style','popupmenu','String',{'NONE','CORRECT','INCORRECT'});
conditioning.Units = 'normalized'; conditioning.Position = [(0.50625+0.075) column1(8) 0.06 0.02]; conditioning.Tag = 'condition';
conditioning.Tag = 'misc3';

% LABEL FREQUENCY PLOT
lfplot = uicontrol(f,'Style','text','FontWeight','bold','FontName','Palatino','FontSize',12); 
lfplot.String = 'FREQUENCY PLOT'; lfplot.Units = 'normalized'; lfplot.Position = [0.49 column1(9) 0.12 0.02]; lfplot.BackgroundColor = [1 1 1]; uicontrol(lfplot);
lfplot.Tag = 'text_field11';

% LABEL L.AXIS
llaksis = uicontrol(f,'Style','text','String', 'L.AXIS: ','FontWeight','bold','FontName','Palatino','FontSize',12); 
llaksis.Units = 'normalized'; llaksis.Position = [0.48 column1(10) 0.09 0.05]; llaksis.BackgroundColor = [1 1 1]; uicontrol(llaksis);
llaksis.Tag = 'text_field12';

% FIELD L.AXIS
laksis = uicontrol(f,'Style','edit'); laksis.Units = 'normalized'; laksis.Position = [0.55 (column1(9)-0.03) 0.06 0.02]; uicontrol(laksis); laksis.Tag = 'laksis';

% LABEL R.AXIS
lraksis = uicontrol(f,'Style','text','String', 'R.AXIS: ','FontWeight','bold','FontName','Palatino','FontSize',12);
lraksis.Units = 'normalized'; lraksis.Position = [0.48 (column1(11)+0.03) 0.09 0.05]; lraksis.BackgroundColor = [1 1 1]; uicontrol(lraksis);
lraksis.Tag = 'text_field13';

% FIELD R.AXIS
raksis = uicontrol(f,'Style','edit'); raksis.Units = 'normal'; raksis.Position = [0.55 column1(10) 0.06 0.02]; uicontrol(raksis); raksis.Tag = 'raksis';

% LABEL BIN WIDTH
lbwidfield = uicontrol(f,'Style','text','String', 'BIN WIDTH: ','FontWeight','bold','FontName','Palatino','FontSize',12);
lbwidfield.Units = 'normalized'; lbwidfield.Position = [0.49 (column1(12)+0.05) 0.09 0.05]; lbwidfield.BackgroundColor = [1 1 1]; uicontrol(lbwidfield);
lbwidfield.Tag = 'text_field14';

% FIELD BIN WIDTH
bwidfield = uicontrol(f,'Style','edit'); bwidfield.Units = 'normalized'; bwidfield.Position = [0.505 column1(11) 0.06 0.02]; uicontrol(bwidfield); bwidfield.Tag = 'bwid';

% LABEL EEG FILTERING:
leegfilt = uicontrol(f,'Style','text','String', 'EEG FILTERING:','FontWeight','bold','FontName','Palatino','FontSize',12);
leegfilt.Units = 'normalized'; leegfilt.Position = [0.448 0.075 0.108 0.027]; leegfilt.BackgroundColor = [1 1 1]; uicontrol(leegfilt);
leegfilt.Tag = 'text_field15';

% LABEL LOW:
llow = uicontrol(f,'Style','text','String', 'LOW:','FontWeight','bold','FontName','Palatino','FontSize',12);
llow.Units = 'normalized'; llow.Position = [0.463 0.031 0.03 0.026]; llow.BackgroundColor = [1 1 1]; uicontrol(llow);
llow.Tag = 'text_field16';

% FIELD LOW:
lowfield = uicontrol(f,'Style','edit'); lowfield.Units = 'normalized'; lowfield.Position = [0.505 0.038 0.06 0.02]; uicontrol(lowfield); lowfield.Tag = 'low';

% LABEL HIGH:
lhigh = uicontrol(f,'Style','text','String', 'HIGH:','FontWeight','bold','FontName','Palatino','FontSize',12);
lhigh.Units = 'normalized'; lhigh.Position = [0.575 0.029 0.03 0.026]; lhigh.BackgroundColor = [1 1 1]; uicontrol(lhigh);
lhigh.Tag = 'text_field17';

% FIELD HIGH:
highfield = uicontrol(f,'Style','edit'); highfield.Units = 'normalized'; highfield.Position = [0.609 0.036 0.06 0.02]; uicontrol(highfield); highfield.Tag = 'high';

% LABEL CHANNEL:
lch = uicontrol(f,'Style','text','String', 'CH:','FontWeight','bold','FontName','Palatino','FontSize',12);
lch.Units = 'normalized'; lch.Position = [0.58 0.075 0.022 0.027]; lch.BackgroundColor = [1 1 1]; uicontrol(lch);
lch.Tag = 'text_field18';

% FIELD CHANNEL:
chfield = uicontrol(f,'Style','edit'); chfield.Units = 'normalized'; chfield.Position = [0.608 0.084 0.06 0.02]; uicontrol(chfield); chfield.Tag = 'ch';

% PUSH UP BUTTONS
savecurrentd = uicontrol(f,'Style','pushbutton');
savecurrentd.Units = 'normalized'; savecurrentd.Position = [0.505 (column1(12)+0.02) 0.08 0.02]; 
savecurrentd.String = 'SAVE DISTRIBUTION'; uicontrol(savecurrentd);
savecurrentd.Callback = @savingdata; savecurrentd.Tag = 'button1';

cleard = uicontrol(f,'Style','pushbutton'); 
cleard.Units = 'normalized'; cleard.Position = [0.505 (column1(12)-0.01) 0.10 0.02]; 
cleard.String = 'CLEAR DISTRIBUTION(S)'; uicontrol(cleard);
cleard.Callback = @cleardists; cleard.Tag = 'button2';

testd = uicontrol(f,'Style','pushbutton');
testd.Units = 'normalized'; testd.Position = [0.505 (column1(13)+0.02) 0.08 0.02]; 
testd.String = 'TEST DISTRIBUTIONS'; uicontrol(testd);
testd.Callback = @TestDist; testd.Tag = 'button3';

updateb = uicontrol(f,'Style','pushbutton');
updateb.Units = 'normalized'; updateb.Position = [0.58 column1(1) 0.08 0.02]; 
updateb.String = 'UPDATE'; uicontrol(updateb);
updateb.Callback = @upthedata; updateb.Tag = 'button4';

clresul = uicontrol(f,'Style','pushbutton');
clresul.Units = 'normalized'; clresul.Position = [0.505 (column1(13)+-0.01) 0.08 0.02]; 
clresul.String = 'CLEAR RESULTS'; uicontrol(clresul);
clresul.Callback = @clresults; clresul.Tag = 'button5';

upeegdata = uicontrol(f,'Style','pushbutton');
upeegdata.Units = 'normalized'; upeegdata.Position = [0.506 0.135 0.07 0.032]; 
upeegdata.String = 'upload EEG data'; uicontrol(upeegdata);
upeegdata.Callback = @upeeg; upeegdata.Tag = 'button6';

% SLIDERS
fslid = uicontrol(f, 'Style', 'slider', 'Units', 'normalized','Position', [0.002 0 0.0400 0.02]);
fslid.SliderStep = [1/2 1];
fslid.Value = 0; fslid.Callback = @changefsize;

% FIELD REFERENCE
timereference = uicontrol(f,'Style','popupmenu','Units','normalized');timereference.Position = [0.6088 0.1249 0.0584 0.0375];
timereference.String = {'Pre-response','Post-response'}; timereference.Value = 2; timereference.Tag = 'misc1';

%% CALL-OUT FUNCTIONS

% MAIN CALL
    function upthedata(updateb, ~)
    strfig = guidata(updateb); % loading the data
    data = strfig.data;
    channels = strfig.channels;
    denpos = [0.262 0.072 0.158 0.216];
    qqpos = [0.049 0.165 0.1580 0.291];
    
    % removing previous axes
    grafiks = findobj('Type','axes'); auxdel = [];
    if ~isempty(grafiks)
        for a = 1:length(grafiks)       
             if (length(grafiks(a).Tag) ==5 )&&(strcmp(grafiks(a).Tag(1:4),'axes'))
               if grafiks(a).Tag(5) ~= '4'
                  delete(grafiks(a))
               end
             end
        end
    end
    delete(findobj('Tag','prev')); delete(findobj('Tag','freqdom'));delete(findobj('Tag','gathereeg')); delete(findobj('Tag','next'));
    delete(findobj('Tag','trialshown'));
    
    % Removing heavy data
    evalin( 'base', 'clear EEGprocessed sigselection' )
    
    % removing previous tree table
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
    [~, ~, tauofid, ~, trees, treesizes] = data_setaspects(data, ntrials, pathtogit);
    t_id = find(tauofid == tau);
    tau_repo = cell(length(t_id),treesizes(find(trees == tau))); %#ok<FNDSB>
    counts_total = zeros(length(t_id),treesizes(find(trees == tau))); %#ok<FNDSB>
    
    % Loading EEG channels
    if ~isempty(channels)
    auxobj = findobj('Tag','EEGchannels');
        if ~isempty(auxobj)
           delete(auxobj); 
        end
       info = [1:length(channels)]';
       cinfo = {'n.'};
       chanref = uitable(findobj('Tag','goalkeeperlab'),'Data',info,'ColumnName', cinfo, 'RowName',channels,'Units', 'normalized','Position', [0.431 0.224 0.071 0.721], 'Tag', 'EEGchannels');
       chanref.FontSize = strfig.FontChoice;
    end

    for a = 1:length(t_id)
       tree_file_address = [pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt' ];
       % Creating table with the tree structure
       [contexts, PM,~ , ~] = build_treePM (tree_file_address);
       colnames = {'0', '1', '2'}; rownames = cell(1,length(contexts));
       for tt = 1:length(contexts)
           rownames{1,tt} = ['w=' num2str(contexts{1,tt})];
       end
       ctstruct = uitable(findobj('Tag','goalkeeperlab'),'Data',PM,'ColumnName', colnames, 'RowName',rownames,'Units', 'normalized','Position', [0.257 0.313 0.163 0.125], 'Tag', 'table');
       %
       [ctx_rtime, ctx_er, ~, contexts, ~, ct_pos] = rtanderperctx(data, t_id(a), from, till, tree_file_address, 0, tau);
       assignin('base','position_lists', ct_pos)
       [chain,responses, ~] = get_seqandresp(data,tau, t_id(p), from, till);
       h = findobj('Tag','position');
       fpos = str2num(h.String); 
       if fpos >= 1
          [ctx_fer,~] = lastwas_error(ct_pos, ctx_er, contexts, chain, responses,fpos); 
       end
       aux_list = cell(treesizes(find(trees == tau)),1);
       for b = 1:treesizes(find(trees == tau)) %#ok<FNDSB>
          h = findobj('Tag','filter');
          if h.Value == 0 % Considering all responses
          aux = [1:length(ctx_er{b,1})];
          else
              h = findobj('Tag','condition'); % Considering CORRECT or INCORRECT
              if fpos == 0
                  if isequal(h.String{h.Value},'CORRECT')
                      aux = find(ctx_er{b,1} == 0); 
                  elseif isequal(h.String{h.Value},'INCORRECT')
                      aux = find(ctx_er{b,1} == 1); 
                  else
                      aux = [1:length(ctx_er{b,1})]; % redundancy
                  end
              else
                  if isequal(h.String{h.Value},'CORRECT')
                      aux = find(ctx_fer{b,1} == 0); 
                  elseif isequal(h.String{h.Value},'INCORRECT')
                      aux = find(ctx_fer{b,1} == 1); 
                  else
                      aux = [1:length(ctx_fer{b,1})]; % redundancy
                  end                  
              end
          end
          % for the selection of the functionals
          auxb = find((ctx_rtime{b,1} <= limitingr)&(ctx_rtime{b,1} >= limitingl)~= 0);
          aux = intersect(aux,auxb); aux_list{b,1} = aux;
          tau_repo{a,b} = ctx_rtime{b,1}(aux,1);
          counts_total(a,b) = length(ctx_rtime{b,1});
       end
    end
    
    [chain,responses, ~] = get_seqandresp(data,tau, t_id(p), from, till);
    srate = sum(chain == responses)/length(chain);
    
    % Identifying the context
    wstr = findobj('Tag','context');
    w = wstr.String; auxw = zeros(1,length(w));
    for wi = 1:length(w)
       auxw(wi) = str2num(w(1,wi)); %#ok<ST2NM>
    end
    
    for wj = 1:length(contexts)
       if isequal(auxw,contexts{1,wj})
          posw = wj;
          break; 
       end
    end
    assignin('base','positions',aux_list{posw,1})
    % Setting the total
    h = findobj('Tag','total');
    h.String = ['TOTAL: ' num2str(counts_total(p,posw)) ' SRATE = (' num2str(srate) ')'];
 
    % Plotting data
    ax1 = axes('Position', [ 0.05 0.55 0.36 0.4]); ax1.Tag = 'axes1'; ax1.NextPlot = 'add'; % SUBSTITUTES THE LINE ABOVE IN MATLAB2015
    axes(ax1)
    xlabel('time (sec.)'); ylabel('frequency')
    X = tau_repo{p,posw};
    X = X(find(X~=0),1); %#ok<FNDSB>
    assignin('base','sample',X)
    assignin('base', 'datacut', X)     % cenoura
    h = histogram(X,'BinWidth',bwid);
    box(ax1,'on')
    xlabel('Time (sec)'); ylabel('Frequency')
    legend(['N =' num2str(length(X))])
    axis([lak rak 0 max(h.Values)])
    
    % Exponential modelling
    if model.Value == 2
    [lambda, x, fest] = expmodel(X, [lak rak], bwid , 0);   
    ax2 = axes('Position', denpos); ax2.NextPlot = 'add'; ax2.Tag = 'axes2';
    axes(ax2)
    plot(x,fest,'r','LineWidth',1.5)
    box(ax2,'on')
    legend(['\lambda =' num2str(lambda,'%.3f') ]);
    axis([lak rak 0 max(fest)])
    xlabel('time (sec)'); ylabel('P(Z = z)')    
    % quantile-quantile plot
    ax3 = axes('Position', qqpos); ax3.NextPlot = 'add'; ax3.Tag = 'axes3'; % SUBSTITUTE THE LINE ABOVE IN MATLAB2015
    xlabel('Observed'); ylabel('Expected')
    axes(ax3)
    q = 10;
    nX = exprnd(1/lambda,length(X),1);
    qxqplot(X,nX,q)
    box(ax3,'on')
    end

    % Normal modelling 
    if model.Value == 3
    ax2 = axes('Position', denpos); ax2.NextPlot = 'add'; ax2.Tag = 'axes2';
    axes(ax2)
    [mu, sigma, x, fest] = normal_model(X, [lak,rak], bwid, 0); 
    plot(x,fest,'r','LineWidth',1.5)
    box(ax2,'on')
    legend(['mu =' num2str(mu,'%.3f') ' sigma = ' num2str(sigma,'%.3f') ]);
    axis([lak rak 0 max(fest)])
    xlabel('time (sec)'); ylabel('P(Z = z)')
    % quantile-quantile plot
    ax3 = axes('Position', qqpos); ax3.NextPlot = 'add'; ax3.Tag = 'axes3'; 
    xlabel('Observed'); ylabel('Expected')
    axes(ax3)
    q = 10;
    nX = normrnd(mu,sigma, [length(X),1]);
    qxqplot(X,nX,q)
    box(ax3,'on')
    end
    
    % Gamma modelling 
    if model.Value == 4
    ax2 = axes('Position', denpos); ax2.NextPlot = 'add'; ax2.Tag = 'axes2';
    axes(ax2)
    [khat, thetahat, x, fest] = gamma_model(X, [lak,rak], bwid, 0);
    plot(x,fest,'r','LineWidth',1.5)
    box(ax2,'on')
    legend(['\mu =' num2str(khat*thetahat,'%.3f') ' \sigma^{2} = ' num2str(khat*thetahat^2,'%.3f') ]);
    axis([lak rak 0 max(fest)]) 
    xlabel('time (sec)'); ylabel('P(Z = z)')
    % quantile-quantile plot
    ax3 = axes('Position', qqpos); ax3.NextPlot = 'add'; ax3.Tag = 'axes3'; 
    xlabel('Observed'); ylabel('Expected')
    axes(ax3)
    q = 10;
    nX = gamrnd(khat,thetahat,length(X),1);
    qxqplot(X,nX,q)
    box(ax3,'on')
    end
    
    % Log-Normal Modelling
    if model.Value == 5
    ax2 = axes('Position', denpos); ax2.NextPlot = 'add'; ax2.Tag = 'axes2';
    axes(ax2)
    [uhat, sigmahat, x, fest] = lognormal_model(X, [lak,rak], bwid, 0);
    plot(x,fest,'r','LineWidth',1.5)
    box(ax2,'on')
    legend(['\mu =' num2str(uhat,'%.3f') ' \sigma = ' num2str(sigmahat,'%.3f') ]);
    axis([lak rak 0 max(fest)])
    xlabel('time (sec)'); ylabel('P(Z = z)')
    % quantile-quantile plot
    ax3 = axes('Position', qqpos); ax3.NextPlot = 'add'; ax3.Tag = 'axes3'; 
    xlabel('Observed'); ylabel('Expected')
    axes(ax3)
    q = 10;
    nX = lognrnd(uhat,sigmahat,length(X),1);
    qxqplot(X,nX,q)
    box(ax3,'on')
    end

    end

% SECUNDARY CALL (1)   

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
    % Plotting the boxplot
    grafiks = findobj('Type','axes');
    if ~isempty(grafiks) 
        for a = 1:length(grafiks)
             if (length(grafiks(a).Tag) ==5 )&&(strcmp(grafiks(a).Tag(1:5),'axes4'))
               delete(grafiks(a))
             end
        end
    end 
    ax4 = axes('Position', [0.8068 0.0573 0.1843 0.1706]); ax4.NextPlot = 'add'; ax4.Tag = 'axes4'; % SUBSTITUTES THE LINE ABOVE IN MATLAB2015
    axes(ax4);
    dnames = setdiff(groupsws,[]); dnamescell = cell(length(dnames),1);
    for a = 1:length(dnames)
       dnamescell{1} = 'a';
    end
    sbox_varsize(groupsws, distws,  'distributions', 'time', '', '', 1, 0, [])
    box(ax4,'on')
    ylabel('time(sec.)')
    end

% SECUNDARY CALL (2)

    function cleardists(cleard,~)
        assignin('base','aux',0);
        assignin('base','dist',[]);
        assignin('base','groups',[]);
    % removing saved distributions    
    grafiks = findobj('Type','axes'); 
    if ~isempty(grafiks)
        for a = 1:length(grafiks)
             if (length(grafiks(a).Tag) ==5 )&&(strcmp(grafiks(a).Tag(1:5),'axes4'))
               delete(grafiks(a))
             end
        end
    end

    end

% SECUNDARY CALL (3)

    function TestDist(testd,~)
    distws = evalin('base','dist');
    groupsws = evalin('base','groups');
    x1 = distws(find(groupsws == 1),1); x1 = x1(find(isoutlier(x1) == 0),1);
    x2 = distws(find(groupsws == 2),1); x2 = x2(find(isoutlier(x2) == 0),1);
    [~,p] = kstest2(x1,x2);
    ks = findobj('Tag','ksresult');
    ks.String = ['RESULT: ' num2str(p,'%2f')];
    end

    function clresults(clresul,~) %#ok<INUSD>
        auxobj = findobj('Tag','ksresult');
        if ~isempty(auxobj)
            auxobj.String = '';
        end
    end
% secundary call (4)
    function upeeg(upeegdata, ~)
    strfig = guidata(upeegdata);
    data = strfig.data;
    fs = strfig.fs;
    eegdata = strfig.EEGsignals; % loading eeg signals
    
    % getting the low-cut frequency of the filter
    auxobj = findobj('Tag','low');
    low_cut = str2num(auxobj.String);
    % getting the high-cut frequency of the filter
    auxobj = findobj('Tag','high');
    upper_cut = str2num(auxobj.String);
    % filtering the EEg data
    assignin('base','EEGprocessed', filtEEGdata(eegdata,fs,low_cut,upper_cut));
    
    % getting the parameters for the function of EEG selection
    % getting the volunteer
    auxobj = findobj('Tag','vol');
    id = str2num(auxobj.String);
    % getting the context
    auxobj = findobj('Tag','context');
    ctx = auxobj.String;
    auxobj = findobj('Tag','table');
    contexts = auxobj.RowName;
    for c = 1:length(contexts)
       if strcmp(replace(replace(contexts{c},'w=',''),' ',''),ctx)
          ctx_num = c;
          break; 
       end
    end
    % getting the from trial
    auxobj = findobj('Tag','fromtrial');
    from = str2num(auxobj.String);
    
    % getting till trial
    auxobj = findobj('Tag','totrial');
    till = str2num(auxobj.String);
    
    % getting minimum response time
    auxobj = findobj('Tag','mintime');
    minrt = str2num(auxobj.String);
    
    % getting maximum response time
    auxobj = findobj('Tag','maxtime');
    maxrt = str2num(auxobj.String);
    
    % getting the channel
    auxobj = findobj('Tag','ch');
    channel = str2num(auxobj.String);
    
    % getting the tree
    auxobj = findobj('Tag','tree');
    tree = str2num(auxobj.String);
    
    % plotting the signal

    [sigselection, interval] = get_EEGselection(data, id, ctx_num, evalin('base','position_lists'), evalin('base','positions'), evalin('base','EEGprocessed'), channel, from, till, evalin('base','ntrials'), tree, timereference.Value);
    assignin('base','sigselection',sigselection)
    auxobj = findobj('Tag','axes5');
    if ~isempty(auxobj)
       delete(auxobj) 
    end
    ax5 = axes('Position', [0.693 0.719 0.287 0.219]); ax5.Tag = 'axes5'; ax5.NextPlot = 'add'; 
    axes(ax5)
    
    xlabel('time (sec.)'); ylabel('\mu V')
    if timereference.Value == 1
    time = [0:interval]*1/(fs); %#ok<NBRAK> % time = [1:size(sigselection,2)]*1/(fs);
    time = -flip(time);
    else
    time = [0:interval]*1/(fs); %#ok<NBRAK>    
    end
    assignin('base','time',time)
    
    plot(time,sigselection(1,:))
    xlim([min(time),max(time)])
    box(ax5,'on')
    legend(['N =' num2str(size(sigselection,1))])
    
    % Plotting the ERP
    auxobj = findobj('Tag','axes6');
    if ~isempty(auxobj)
       delete(auxobj) 
    end    
    ax6 = axes('Position', [0.693 0.45 0.287 0.219]); ax6.Tag = 'axes6'; ax6.NextPlot = 'add'; 
    axes(ax6)
    shadedplot(time',sigselection', 'r', [0.95 0.95 0.95],'','time (sec.)', '\mu V', []);
    xlim([min(time) max(time)])
    box(ax6,'on')
    % Plotting the frequency domain
    auxobj = findobj('Tag','axes7');
    if ~isempty(auxobj)
       delete(auxobj) 
    end
    [FM,freq] = sig_fdomain(sigselection,fs);
    assignin('base','f',freq)
    assignin('base','FM',FM)
    
    % Button for visualizing the spectra
    uicontrol(findobj('Tag','goalkeeperlab'),'Style','pushbutton','Tag','freqdom','Units','normalized','Position',...
        [0.9249 0.9448 0.0558 0.0343], 'String', 'Freq. Domain', 'Tag', 'freqdom');
    freqdom = findobj('Tag','freqdom'); freqdom.FontSize = strfig.FontChoice;
    freqdom.Callback = @showspec;
    
    % Button for gathering data of all EEG channels
    uicontrol(findobj('Tag','goalkeeperlab'),'Style','pushbutton','Tag','gathereeg','Units','normalized','Position',...
        [0.9417 0.0040 0.0558 0.0343], 'String', 'Gather EEG');
    gathereeg = findobj('Tag','gathereeg'); gathereeg.FontSize = strfig.FontChoice;
    uicontrol(gathereeg);
    gathereeg.Callback = @callgathereeg;
        
    % Button indicating the occurance
    uicontrol(findobj('Tag','goalkeeperlab'),'Style','edit','Units','normalized','Tag','trialshown','Position', [0.7967 0.9526 0.0600 0.0200],...
        'String', num2str(1), 'Enable', 'off');
    trialshown = findobj('Tag','trialshown'); trialshown.FontSize = strfig.FontChoice;
    uicontrol(trialshown); 
    
    % Buttons for changing the ocurrance
    uicontrol(findobj('Tag','goalkeeperlab'),'Style','pushbutton','Units','normalized','Tag','prev','Position', [0.7546 0.9523 0.0351 0.0200],...
        'String', 'Prev.');
    prev = findobj('Tag','prev'); prev.FontSize = strfig.FontChoice;
    uicontrol(prev); prev.Callback = @change2prev;
    
    uicontrol(findobj('Tag','goalkeeperlab'),'Style','pushbutton','Units','normalized','Tag','next','Position', [0.8628 0.9512 0.0351 0.0200],...
        'String', 'Next');
    next = findobj('Tag','next'); next.FontSize = strfig.FontChoice;
    uicontrol(next); next.Callback = @change2next;
   
    end

 % SECONDARY CALL (5)
    function showspec(freqdom , ~) %#ok<INUSD>
        auxfig = figure('Name','Freq. Inspection','NumberTitle','off');
        auxfig.Tag = 'FreqInsp';
        time = evalin('base','time');
        sigselection = evalin('base','sigselection');
        tshow = findobj('Tag','trialshown');
        % ATTENTION: lw of spec_throughtime must be changed according to the length of the signal, now is set to 250 %
        spec_throughtime(sigselection, time, 250,50,fs, str2num(tshow.String), auxfig)
        set(0, 'CurrentFigure', findobj('Tag','goalkeeperlab'))    
    end

 % SECONDARY CALL (6)
    function change2prev(prev , ~) %#ok<INUSD>
        aux = findobj('Tag','trialshown');
        cur_trial = str2num(aux.String);
        if (cur_trial - 1) >= 0
        aux.String = num2str(cur_trial-1);
        %
        sigselection = evalin('base','sigselection');
        auxobj = findobj('Tag','axes5');
        if ~isempty(auxobj)
           delete(auxobj) 
        end
        ax5 = axes('Position', [0.693 0.719 0.287 0.219]); ax5.Tag = 'axes5'; ax5.NextPlot = 'add'; 
        axes(ax5)

        xlabel('time (sec.)'); ylabel('\mu V')
        time = evalin('base', 'time');

        plot(time,sigselection( str2num(aux.String),:) )
        xlim([min(time),max(time)])
        box(ax5,'on')
        legend(['N =' num2str(size(sigselection,1))])
        %
        else
        end
    end
 % SECONDARY CALL (7)
    function change2next(next , ~) %#ok<INUSD>
        aux = findobj('Tag','trialshown');
        N = size(evalin('base','sigselection'),1);
        cur_trial = str2num(aux.String);
        if (cur_trial +1) <= N
        aux.String = num2str(cur_trial+1);
        %
        sigselection = evalin('base','sigselection');
        auxobj = findobj('Tag','axes5');
        if ~isempty(auxobj)
           delete(auxobj) 
        end
        ax5 = axes('Position', [0.693 0.719 0.287 0.219]); ax5.Tag = 'axes5'; ax5.NextPlot = 'add'; 
        axes(ax5)

        xlabel('time (sec.)'); ylabel('\mu V')
        time = evalin('base', 'time');

        plot(time,sigselection( str2num(aux.String),:) )
        xlim([min(time),max(time)])
        box(ax5,'on')
        legend(['N =' num2str(size(sigselection,1))])
        %
        else
        end
    end
 % SECONDARY CALL (8)
    function callgathereeg(gathereeg, ~)    
    strfig = guidata(gathereeg);
    data = strfig.data;
    fs = strfig.fs;
    eegdata = strfig.EEGsignals; % loading eeg signals
    
    % getting the low-cut frequency of the filter
    auxobj = findobj('Tag','low');
    low_cut = str2num(auxobj.String);
    % getting the high-cut frequency of the filter
    auxobj = findobj('Tag','high');
    upper_cut = str2num(auxobj.String);
    
    % getting the volunteer
    auxobj = findobj('Tag','vol');
    id = str2num(auxobj.String);
    % getting the context
    auxobj = findobj('Tag','context');
    ctx = auxobj.String;
    auxobj = findobj('Tag','table');
    contexts = auxobj.RowName;
    for c = 1:length(contexts)
        if strcmp(replace(replace(contexts{c},'w=',''),' ',''),ctx)
           ctx_num = c;
           break; 
        end
     end
     % getting the from trial
     auxobj = findobj('Tag','fromtrial');
     from = str2num(auxobj.String);
     
     % getting till trial
     auxobj = findobj('Tag','totrial');
     till = str2num(auxobj.String);
     
     % getting minimum response time
     auxobj = findobj('Tag','mintime');
     minrt = str2num(auxobj.String);
     
     % getting maximum response time
     auxobj = findobj('Tag','maxtime');
     maxrt = str2num(auxobj.String);
     
     % getting the tree
     auxobj = findobj('Tag','tree');
     tree = str2num(auxobj.String);
     C = size(eegdata,1);  
     if evalin('base','exist(''EEGincond'')')
         new = evalin('base','size(EEGincond,1)')+1;
     else
         assignin('base','EEGincond',cell(1,C));
         new = 1;
     end
     
         for channel = 1:C
             [sigs, ~] = get_EEGselection(data, id, ctx_num, evalin('base','position_lists'), evalin('base','positions'), evalin('base','EEGprocessed'), channel, from, till, evalin('base','ntrials'), tree, timereference.Value);
             assignin('base','sigs',sigs)
             evalin('base',['EEGincond{' num2str(new)  ',' num2str(channel) '} = sigs;'])
             disp(['gathering...channel ' num2str(channel) '.'])
         end
    disp('Done gathering.');
    end
 % SECONDARY CALL (9)
    function changefsize(fslid,~)
    strfig = guidata(updateb);
    edit_taglist = strfig.edit_tags;
            choice = fslid.Value;
        if abs(choice-0)< 10^(-5)
            strfig.FontChoice = 8;
        elseif abs(choice-1/2)< 10^(-5)
            strfig.FontChoice = 10;
        elseif abs(choice-1)< 10^(-5)
            strfig.FontChoice = 12;
        else
        end    
    taglabel = 'text_field';
        for a = 1:18
            obj = findobj('Tag',[taglabel num2str(a)]);
            obj.FontSize = strfig.FontChoice;
        end
    taglabel = 'button';
        for a = 1:6
            obj = findobj('Tag',[taglabel num2str(a)]);
            obj.FontSize = strfig.FontChoice;
        end
        taglabel = 'misc';
        for a = 1:3
            obj = findobj('Tag',[taglabel num2str(a)]);
            obj.FontSize = strfig.FontChoice;
        end
        for a = 1:size(edit_taglist,1)
            obj = findobj('Tag',edit_taglist{a,1});
            obj.FontSize = strfig.FontChoice;
        end        
    end
ltotal = uicontrol(f,'Style','text','String', ''); ltotal.Units = 'normalized'; ltotal.Position = [0.236 0.448 0.15 0.025]; ltotal.BackgroundColor = [1 1 1]; uicontrol(ltotal);ltotal.Tag = 'total';
ksresult = uicontrol(f,'Style','text','String', ''); ksresult.Units = 'normalized'; ksresult.Tag = 'ksresult'; ksresult.Position = [0.8101 0.2461 0.15 0.025]; ksresult.BackgroundColor = [1 1 1]; uicontrol(ksresult);
end