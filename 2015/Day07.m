clear;clc

txt = fileread('Day07.txt');
% txt = ['123 -> x' newline ...
% 'x AND y -> d' newline ...
% 'y RSHIFT 2 -> g' newline ...
% 'NOT x -> h' newline ...
% 'x LSHIFT 2 -> f' newline ...
% '456 -> y' newline ...
% 'x OR y -> e' newline ...
% 'NOT y -> i'];

part1(txt)

function part1(txt)
map = dictionary('1',uint16(1));
lines = splitlines(txt);
while ~isempty(lines)
    unused = [];
    for i = 1:length(lines)
        line = lines{i};
        tokes = split(line);
        % disp(line)
        if contains(line,'AND') && map.isKey(tokes{1}) && map.isKey(tokes{3})
            map(tokes{5}) = bitand(map(tokes{1}),map(tokes{3}));
        elseif contains(line,'OR') && map.isKey(tokes{1}) && map.isKey(tokes{3})
            map(tokes{5}) = bitor(map(tokes{1}),map(tokes{3}));
        elseif contains(line,'NOT') && map.isKey(tokes{2})
            map(tokes{4}) = bitcmp(map(tokes{2}));
        elseif contains(line,'LSHIFT') && map.isKey(tokes{1})
            map(tokes{5}) = bitshift(map(tokes{1}),str2double(tokes{3}));
        elseif contains(line,'RSHIFT') && map.isKey(tokes{1})
            map(tokes{5}) = bitshift(map(tokes{1}),-str2double(tokes{3}));
        elseif length(tokes) == 3 && ~isempty(sscanf(tokes{1},'%d'))
            map(tokes{3}) = uint16(str2double(tokes{1}));
        elseif length(tokes) == 3 && map.isKey(tokes{1})
            map(tokes{3}) = map(tokes{1});
        else
            unused = [unused i]; %#ok<AGROW>
        end
        if strcmp(tokes{3},'b')
            map('b') = uint16(3176);
        end
    end
    lines = lines(unused);
end
disp(map("a"))
% disp(map)
end