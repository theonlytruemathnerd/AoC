clear;clc

txt = fileread('Day05.txt');
% txt = ['ugknbfddgicrmopn' newline 'aaa' newline 'jchzalrnumimnmhp' ...
%     newline 'haegwjzuvuyypxyu' newline 'dvszwmarrgswjxmb'];
% txt = ['qjhvhtzxzqqjkmpb' newline 'xxyxx' newline 'uurcxstgmygtbstg' ...
%     newline 'ieodomkazucvgmuy'];

disp(part1(txt))
disp(part2(txt))

function total = part1(txt)
total = 0;
for str = splitlines(txt)'
    str = str{1};
    if length(regexp(str,'[aeiou]{1}')) < 3
        continue
    end
    if length(regexp(str,'(\w)\1')) < 1
        continue
    end
    if ~isempty(regexp(str,'(ab|cd|pq|xy)', 'once'))
        continue
    end
    total = total + 1;
end
end

function total = part2(txt)
total = 0;
for str = splitlines(txt)'
    str = str{1};
    if isempty(regexp(str,'(\w{2})\w*\1', 'once'))
        continue
    end
    if isempty(regexp(str,'(\w)\w\1','once'))
        continue
    end
    total = total + 1;
end
end
