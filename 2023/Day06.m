clear;clc

txt = ['Time:        60     94     78     82' newline ...
'Distance:   475   2138   1015   1650'];

% txt = ['Time:      7  15   30' newline ...
% 'Distance:  9  40  200'];

part1(txt)
part2(txt)

function part1(txt)
lines = splitlines(txt);
times = str2double(extract(lines{1},digitsPattern))';
dists = str2double(extract(lines{2},digitsPattern))';
total = 1;
for i = 1:length(times)
    time = times(i);
    dist = dists(i);
    medist = (0:time).*(time:-1:0);
    total = total*nnz(medist>dist);
end
disp(total)
end

function part2(txt)
lines = splitlines(txt);
times = str2double(join(extract(lines{1},digitsPattern),''));
dist = str2double(join(extract(lines{2},digitsPattern),''));
for i = 1:times
    if i*(times-i) > dist
        disp(times-2*i+1)
        break
    end
end
end
