%RTs
for i = 1:size(data_LTPB,1)

    T2(i)= data_LTPB(i,7);
end     
a=1;

for par = 1:(size(data_LTPB,1)/1000) 
    RT2{par}=T2(a:a+999); 

    a=a+1000;

end

for par = 1:(size(data_LTPB,1)/1000)
     GTML(par) = mean(RT2{par}); %global temporal means LTPB
end

Pain_Intensity = [7.25, 4.25, 5.33, 3.5, 2.25, 6, 6, 4.75, 0.25];


RTxI = [Pain_Intensity.' GTML .'];

figure 

[R,PValue] = corrplot(RTxI)

%Accuracy

for i = 1:size(data_LTPB,1)
  
   if data_LTPB(i,8) == data_LTPB(i,9)
       WL(i)= 1;    
   else 
       WL(i)= 0;
   end
   
end

wl=1;

for par = 1:(size(data_LTPB,1)/1000) 
    
    AL{par} = WL(wl:wl+999);
    wl=wl+1000;

end


for par = 1:(size(data_LTPB,1)/1000)
     GAL(par) = mean(AL{par}); 
end

figure

RTxA = [Pain_Intensity.' GAL.'];

[R,PValue] = corrplot(RTxA)

%Local Variance

Lv_scL = 0;

for par = 1:(size(data_LTPB,1)/1000)
    for i = 1 : 999  % i goes from 1 to n-1
        Lv_scL = Lv_scL + ((RT2{par}(i) - RT2{par}(i+1))/(RT2{par}(i) + RT2{par}(i+1))).^2;
    end
    Lv_LG(par) = (3/999) * Lv_scL;
    Lv_scL = 0;
end

RTxL = [Pain_Intensity.' Lv_LG.'];

figure
[R,PValue] = corrplot(RTxL)