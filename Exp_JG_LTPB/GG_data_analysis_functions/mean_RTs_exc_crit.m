% [exclude] = mean_RTs_exc_crit (data) 
%
% This function checks the mean RTs exclusion criteria. It returns which participant(s), if any, have a mean response
% time in the third or second blocks higher then the mean response time of
% the first block. 
%
% INPUT:
% data = data matrix.
%
% OUTPUT:
% exclude = list of the Goalkeeper Game IDs of the participants that had a mean response
% time in the third or second blocks higher then the mean response time of
% the first block. An empty list means that there isn't any participant that
% matches this description. 
% Example: if the output variable "exclude" is the list "1,2", that means
% participants T001 and T002 had a mean response time in the third or second blocks higher then the mean response time of
% the first block.
%
%03/10/2022 by Pedro R. Pinheiro

function [exclude] = mean_RTs_exc_crit(data)
for i = 1:size(data,1)
   
    RT(i)= data(i,7);
   
   
end

a=1;

for par = 1:(size(data,1)/1000) 
P{par}=RT(a:a+999); 

a=a+1000;

end

%Block 1

RF1 = 0;
for par = 1:(size(data,1)/1000);
    for k = drange(1:334); %the second input is the number of trials in the block.
        
        RF1 = RF1 + P{par}(k); %RF1 (RTs full block 1) -> Response times of block 1. It is the sum of all the terms inside the interval k for A{par}.
    end
    
    MRF1(par) = RF1/334;  %MRF1 (Mean RTs Full block 1) is a vector in which each term corresponds to the mean response time of a participant in the first block.
    RF1=0;

end

%Block 2

RF2 = 0;
for par = 1:(size(data,1)/1000);
    for k = drange(335:668); 
        
        RF2 = RF2 + P{par}(k); 
    end
    
    MRF2(par) = RF2/334;  
    RF2=0;
end

%Block 3

RF3 = 0;
for par = 1:(size(data,1)/1000);
    for k = drange(669:1000); 
        
        RF3 = RF3 + P{par}(k); 
    end
    
    MRF3(par) = RF3/332;  
    RF3=0;
end
exclude=[];
ex=1;
for par = 1:(size(data,1)/1000)
    if MRF2(par) > MRF1(par) || MRF3(par) > MRF1(par)
        exclude(ex) = data((par*1000),11); %list of participants in the style "T0__" that needs to be excluded for not having learned the sequence.
        ex=ex+1;
    end
end

end

