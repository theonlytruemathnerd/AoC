clear;clc

txt = 'hepxcrrq';
nextpass(txt) % hepxxyzz
txt = 'hepxxyzz';
nextpass(txt) % heqaabcc

function nextpass(txt)
place = 8;
% counter = 0;
while true
    txt = increment(txt,place);
    % counter = counter + 1;
    % if ~mod(counter,1000)
    %     disp([num2str(counter) string(txt)])
    % end
    if nnz(ismember(diff(double(txt)),1)) < 2
        place = 7; % increment 7th letter, set 8th letter to 'a'
        continue
    end
    % conseqs = find(diff(double(txt)==1)); % at least one conseq
    
    if ~ismember(diff(find(diff(double(txt))==1)),1)
        place = 8;
        continue
    end
    doubles = regexp(txt,'(\w)\1{1}','match');
    if length(unique(doubles)) < 2
        place = 8;
        continue
    end
    break
end
disp(txt)
end

function txt = increment(txt,place)
let2let = dictionary(["a" "b" "c" "d" "e" "f" "g" "h" "j" "k" "m" "n" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"], ...
                     ["b" "c" "d" "e" "f" "g" "h" "j" "k" "m" "n" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "a"]);
% let2num = dictionary(["a" "b" "c" "d" "e" "f" "g" "h" "j" "k" "m" "n" ...
%     "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"],0:22);
% num2let = dictionary(0:22,["a" "b" "c" "d" "e" "f" "g" "h" "j" "k" "m" ...
%     "n" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"]);
% if strcmp(old(end),"z")
% txt(end) = let2let(end);
for i = place:-1:1
    txt(i) = let2let(txt(i));
    if ~strcmp(txt(i),"a")
        break
    end
end
txt(place+1:8) = 'a';
end