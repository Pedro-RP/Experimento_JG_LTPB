

x = [1:10000000];
y = 20*exp(-(1/250)*x).*sin(x*(1/1000)*10*2*pi);
plot(x,y)
for k = 1:size(data,1)
   e = data(k,14)-data(k,10)+1;   
   for kk = 1:size(EEGsignals,1)
   EEGsignals(kk, data(k,10):data(k,14)) =  y(1,1:e); 
   end
end