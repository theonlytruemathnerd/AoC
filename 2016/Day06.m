clear;clc

txt = fileread('Day06.txt');

part1(txt)
part2(txt)

function part1(txt)
lines = splitlines(txt);
txt = char(lines{:});
disp(mode(txt))
end

function part2(txt)
lines = splitlines(txt);
txt = char(lines{:});
for i = 1:size(txt,2)
    col = txt(:,i);
    while length(unique(col))>1
        col(col==mode(col)) = '';
    end
    fprintf('%c',col(1))
end
fprintf('\n')
end