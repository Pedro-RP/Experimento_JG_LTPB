%sbox_conection(group_id, data,  x_name, y_name, tit, box_names, sig_dif, test, acsis)

group_id = [zeros(1,4), ones(1,4), 2* ones(1,4),3* ones(1,4), 4*ones(1,4)];

data = [4 2 3 5 7 5 2 3 7 9 7 8 5 8 6 9 1 4 7 6 ];
  
  x_name = 'x';
  
  y_name = 'yt';
  
  tit = 'tit';
  
  box_names = { '1';
                '2';
                '3'; 
                '4';
                '5'};
 sig_dif = 1;
 
 test = 0;
 
 acsis = [];
 
 figure
 sbox_comp(group_id', data',  x_name, y_name, tit, box_names, sig_dif, test, acsis)