%% Part 1

clear;clc
txt = fileread('Day02.txt');
disp(part1(txt))
disp(part2(txt))

function A = area(l,w,h)
A = 2*l*w + 2*w*h + 2*h*l;
A = A + min([l*w,w*h,h*l]);
end

function total = part1(txt)
total = 0;
for line = split(txt)'
    lwh = regexp(line{1},'\d+','match');
    lwh = num2cell(cellfun(@str2num,lwh));
    [l,w,h] = deal(lwh{:});
    total = total + area(l,w,h);
end
end

function total = part2(txt)
total = 0;
for line = split(txt)'
    lwh = regexp(line{1},'\d+','match');
    lwh = cellfun(@str2num,lwh);
    total = total + 2*sum(mink(lwh,2));
    total = total + prod(lwh);
end
end
