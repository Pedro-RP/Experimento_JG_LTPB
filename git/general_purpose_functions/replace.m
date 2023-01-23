% new_string = replace(text_string,old,new)
%
% This function replaces a pattern (old) by a pattern (new) in the
% textstring.
% INPUT:
% text_string = string containing the text in which the pattern will be
% searched.
% old = old pattern that will be substituted.
% new = new pattern.
%
% date: 08/04/2022  author: Paulo Roberto Cabral Passos


function new_string = replace(text_string,old,new)


l = length(old);

if isempty(text_string)
   return 
end

a = 1;
while count(text_string,old)>=1
    if (a+l-1 <= length(text_string)) && (strcmp(text_string(a:a+l-1),old))
          if ((a-1)== 0)
          text_string = [new text_string(a+l:end)]; a = 0;
          elseif (a+l > length(text_string))
          text_string = [text_string(1:a-1) new]; a = 0;
          else
          text_string = [text_string(1:a-1) new new text_string(a+l:end)]; a = 0;
          end          
    end
   a = a+1;
end


new_string = text_string;
end