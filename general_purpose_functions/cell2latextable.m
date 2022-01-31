% [table_latex] = cell2latextable(tab)
%
% This function turns a cell into a latex table.
% 
% tab = table in cell format;

function [table_latex] = cell2latextable(tab)

table_latex = '~\begin{tabular}{~|';

for a = 1:size(tab,2)
   table_latex = strcat(table_latex, 'c|');
end
table_latex = strcat(table_latex, '~}~\hline~');

for a = 1:size(tab,1)
    for b = 1:size(tab,2)
        table_latex = strcat(table_latex, tab{a,b});
        if b == size(tab,2)
        else
        table_latex = strcat(table_latex, '~&~');
        end
    end
    table_latex = strcat(table_latex, '~\\~');
    if a == 1
    table_latex = strcat(table_latex, '~\hline~');    
    end
end

table_latex = strcat(table_latex, '~\hline~\end{tabular}');

table_latex = strrep(table_latex,'~',' ');


end