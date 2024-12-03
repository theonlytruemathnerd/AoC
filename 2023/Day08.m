clear;clc

txt = fileread('Day08.txt');

% txt = ['RL' newline newline ...
% 'AAA = (BBB, CCC)' newline ...
% 'BBB = (DDD, EEE)' newline ...
% 'CCC = (ZZZ, GGG)' newline ...
% 'DDD = (DDD, DDD)' newline ...
% 'EEE = (EEE, EEE)' newline ...
% 'GGG = (GGG, GGG)' newline ...
% 'ZZZ = (ZZZ, ZZZ)'];

part1(txt)

% txt = ['LR' newline newline ...
% 'AAA = (AAB, XXX)' newline ...
% 'AAB = (XXX, AAZ)' newline ...
% 'AAZ = (AAB, XXX)' newline ...
% 'BBA = (BBB, XXX)' newline ...
% 'BBB = (BBC, BBC)' newline ...
% 'BBC = (BBZ, BBZ)' newline ...
% 'BBZ = (BBB, BBB)' newline ...
% 'XXX = (XXX, XXX)'];

part2(txt)

function part1(txt)
leftmap = configureDictionary('string','string');
rightmap = configureDictionary('string','string');
lines = splitlines(txt)';
path = lines{1};
for line = lines(3:end)
    words = extract(line,lettersPattern);
    leftmap(words{1}) = words{2};
    rightmap(words{1}) = words{3};
end
node = "AAA";
steps = 0;
while ~strcmp(node,"ZZZ")
    dir = path(mod(steps,length(path))+1);
    if strcmp(dir,"L")
        node = leftmap(node);
    else
        node = rightmap(node);
    end
    steps = steps + 1;
end
disp(steps)
end

function part2(txt)
leftmap = configureDictionary('string','string');
rightmap = configureDictionary('string','string');
lines = splitlines(txt)';
path = lines{1};
for line = lines(3:end)
    words = extract(line,lettersPattern);
    leftmap(words{1}) = words{2};
    rightmap(words{1}) = words{3};
end
nodes = unique([keys(leftmap);keys(rightmap)]);
nodes = nodes(endsWith(nodes,"A"))';
zees = zeros(size(nodes),'uint64');
for i = 1:length(nodes)
    node = nodes(i);
    steps = 0;
    while true
        dind = mod(steps,length(path))+1;
        dir = path(dind);
        if strcmp(dir,"L")
            node = leftmap(node);
        else
            node = rightmap(node);
        end
        steps = steps+1;
        if endsWith(node,"Z")
            zees(i) = steps;
            break
        end
    end
end
steps = 1;
for zee = zees
    steps = lcm(steps,zee);
end
disp(steps)
end