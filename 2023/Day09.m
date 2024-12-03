clear;clc

txt = fileread('Day09.txt');

% txt = ['0 3 6 9 12 15' newline ...
% '1 3 6 10 15 21' newline ...
% '10 13 16 21 30 45'];

part(txt,true)
part(txt,false)

function part(txt,forward)
total = 0;
lines = splitlines(txt)';
for line = lines
    nums = regexp(line,'-?\d+','match');
    nums = str2double(nums{:});
    cpy = nums;
    deg = -1;
    while any(cpy)
        cpy = diff(cpy);
        deg = deg + 1;
    end
    [p,~,mu] = polyfit(1:length(nums),nums,deg);
    if forward
        total = total + round(polyval(p,length(nums)+1,[],mu));
    else
        total = total + round(polyval(p,0,[],mu));
    end
end
fprintf('%d\n',total)
end
