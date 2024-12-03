clear;clc

txt = fileread('Day06.txt');
% txt = ['turn on 0,0 through 999,999' newline 'toggle 0,0 through 999,0' ...
%     newline 'turn off 499,499 through 500,500'];

disp(part1(txt))
disp(part2(txt))

function lights = part1(txt)
lights = false(1000,1000);
for line = splitlines(txt)'
    tokes = regexp(line,'(\d+)','match');
    tokes = cellfun(@str2num,tokes{1},'UniformOutput',false);
    [x1,y1,x2,y2] = deal(tokes{:});
    if contains(line,'on')
        lights(x1+1:x2+1,y1+1:y2+1) = true;
    elseif contains(line,'off')
        lights(x1+1:x2+1,y1+1:y2+1) = false;
    else
        lights(x1+1:x2+1,y1+1:y2+1) = ~lights(x1+1:x2+1,y1+1:y2+1);
    end
end
lights = nnz(lights);
end

function lights = part2(txt)
lights = zeros(1000,1000);
for line = splitlines(txt)'
    tokes = regexp(line,'(\d+)','match');
    tokes = cellfun(@str2num,tokes{1},'UniformOutput',false);
    [x1,y1,x2,y2] = deal(tokes{:});
    if contains(line,'on')
        lights(x1+1:x2+1,y1+1:y2+1) = lights(x1+1:x2+1,y1+1:y2+1) + 1;
    elseif contains(line,'off')
        lights(x1+1:x2+1,y1+1:y2+1) = max(lights(x1+1:x2+1,y1+1:y2+1) - 1, 0);
    else
        lights(x1+1:x2+1,y1+1:y2+1) = lights(x1+1:x2+1,y1+1:y2+1) + 2;
    end
end
lights = sum(lights,'all');
end