% strcut = split(text_string,delimiter)
%
% This function splits a text in substring marked by a delimiter. The
% delimiter is not included in the substrings.
%
% INPUT:
% text_string = The string to be splitted
% delimiter = the delimiter
%
% OUTPUT:
% strcut = cell containing the substrings
% 
% date: 08/04/2022  author: Paulo Roberto Cabral Passos

function strcut = split(text_string,delimiter)


if isempty(text_string)
   return; 
end

l = length(delimiter);

strcut = {}; places = 0; %#ok<NASGU>

a = 1; strcut = {}; place = 0;
while count(text_string,delimiter)>=1
    L = length(text_string);
    if (a+l-1) <= L
       if strcmp(text_string(a:a+l-1),delimiter)
       place = place+1;
       
       if (a-1 > 0)
          strcut{place} = text_string(1:a-1);  %#ok<AGROW>
          if a+l <= length(text_string)
          text_string = text_string(a+l:end); a = 0;
          else
              break
          end
       else
          text_string = text_string(a+l:end); a = 0;
       end
       
       end
    end
    a = a+1;
end
if length(text_string) >= 1
   place = place +1;
   strcut{place} = text_string;
end
    
    

end
