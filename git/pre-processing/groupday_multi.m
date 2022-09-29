% data = groupday_multi(data, ppg,spp,cells)
%
% "This function is part of the routine for analyzing Goalkeeper's game
% data"
%
% The function receives the following arguments:
% data = data variable described in analisesquest.m
%
% ppg = a column vector in which each odd and even column corresponds
% to day one and two, respectively. The vector contain twice the number of
% groups, since each row itens the group changes. This way each item
% corresponds to the number of participants in a group and day.
%
% spp = going from day to the in each group, tells the number of steps
% each participant played.
%
% cells = this tells how many cells each step contains.
%
% The function returns a matrix in which the first column tells the group
% from which the information comes and the second column from which day.
%
% author: Paulo Roberto Cabral Passos.
% Last Modification: 19/07/2019


function data = groupday_multi(data, ppg,spp,cells)

d = 0;
p = 1; type = 0;
nc = 0; c = 1; l = 1;
    for a = 1:size(ppg,2)
        nc = sum(  spp(1, p:p+ppg(1,a)-1 )  );
        lc = sum( cells(1, l:l+nc-1));
        d = 2;
        if rem(a,2) ~= 0 % evolves the day
            type = type+1; %evolves the group
            d = 1;
        end
        data(c:c+lc-1,1)= type*ones(lc,1); 
        data(c:c+lc-1,2)= d*ones(lc,1);
        p = p+ppg(1,a); 
        l = l+nc;
        c = c+lc;
    end

end