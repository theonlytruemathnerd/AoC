clear;clc

txt = fileread('Day08.txt');
% txt = {'""';'"abc"';'"aaa\"aaa"';'"\x27"'};
disp(part1(txt))
disp(part2(txt))

function total = part1(txt)
total = 0;
for lit = splitlines(txt)'
    newlit = lit{1};
    newlit = newlit(2:end-1);
    total = total + 2; % starting/ending quotes
    total = total + length(regexp(newlit,'\\\\'));
    total = total + length(regexp(newlit,'\\\"'));
    total = total + 3*length(regexp(newlit,'\\x[a-f0-9]'));
    % disp(length(regexp(newlit,'\\\\')) + length(regexp(newlit,'\\\"')) + 3*length(regexp(newlit,'\\x[a-f0-9]')))
end
end

function total = part2(txt)
total = 0;
for lit = splitlines(txt)'
    newlit = lit{1};
    newlit = newlit(2:end-1);
    total = total + 4; % starting/ending quotes
    total = total + 2*length(regexp(newlit,'\\\\')); % \\ to \\\\
    total = total + 2*length(regexp(newlit,'\\\"')); % \" to \\\"
    total = total + length(regexp(newlit,'\\x[a-f0-9]')); % \xNN to \\xNN
    % disp(length(regexp(newlit,'\\\\')) + length(regexp(newlit,'\\\"')) + 3*length(regexp(newlit,'\\x[a-f0-9]')))
end
end