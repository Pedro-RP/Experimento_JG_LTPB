url = "https://game.numec.prp.usp.br/study/times/dados/";
trials = 1000;
pagecontent = webread(url);
% Extracting Table
browmarker = strfind(pagecontent, '<tr><td ');
ecolumnmarker = strfind(pagecontent,'</tr>');
pagecontent = pagecontent(browmarker(1):ecolumnmarker(end));
% Extracting Rows
browmarker = strfind(pagecontent, '<tr>');
ecolumnmarker = strfind(pagecontent,'</tr>');
filelist = cell(1,1);
datatables = cell(1,1);
aux = 0;

for k = 1:length(ecolumnmarker)
    rowcontent = pagecontent(browmarker(k):ecolumnmarker(k));
    if contains(rowcontent,'.csv')
        aux = aux+1;
        b = strfind(rowcontent,'</td>');
        fileline = rowcontent( b(1):b(2) );
        hyperfile = fileline(10: end-1); hyperaux = strfind(hyperfile, '"');
        datatables{aux,1} = webread(  url + hyperfile( hyperaux(1)+1: hyperaux(2)-1 )  );
        filelist{aux,1} = hyperfile( hyperaux(1)+1: hyperaux(2)-1 );
    end
end

data = [];
aux = 0;
for k = 1:size(datatables,1) 
    auxdata = datatables{k,1}{:,:};
    if size(auxdata,1) == trials
        aux = aux +1;
        minidata = zeros(trials,10);
        minidata(:,1) = ones(trials,1); % group info
        minidata(:,2) = ones(trials,1); % day info
        minidata(:,3) = [1:trials]'; %#ok<NBRAK> % play info
        minidata(:,4) = ones(trials,1); % step info
        minidata(:,5) = 7*ones(trials,1); % tree info !!ATTENTION: Choose the same number as in the configuration file!!
        minidata(:,6) = aux*ones(trials,1); % alternative ID info
        minidata(:,7) = auxdata(:,4); % response time info
        minidata(:,8) = auxdata(:,3); % response info
        minidata(:,9) = auxdata(:,2); % stochastic chain info
        minidata(:,10) = auxdata(:,6); % elapsed time info
    end
    data = [data; minidata];
end


clearvars -except data filelist