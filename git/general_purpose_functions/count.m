% score = count(text_string,pattern)
%
% The function counts the number of times a pattern is seen in the text
% string.
% INPUT:
% text_string = string containing the text in which the pattern will be
% searched.
% pattern = pattern that will be searched.
%
% date: 08/04/2022  author: Paulo Roberto Cabral Passos


function score = count(text_string,pattern)

l = length(pattern);
score = 0;

for a = 1:length(text_string)
    if (a+l-1) <= length(text_string)
        if strcmp(text_string(a:a+l-1),pattern)
        score = score+1;   
        end
    end
end

end

