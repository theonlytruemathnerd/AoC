clear;clc

txt = fileread('Day04.txt');

% txt = ['Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53' newline ...
% 'Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19' newline ...
% 'Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1' newline ...
% 'Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83' newline ...
% 'Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36' newline ...
% 'Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11'];

part1(txt)
part2(txt)

function part1(txt)
total = 0;
lines = splitlines(txt)';
for i = 1:length(lines)
    line = lines{i};
    words = split(line)';
    bar = find(ismember(words,'|'));
    wins = str2double(words(3:bar-1));
    mine = str2double(words(bar+1:end));
    hits = nnz(ismember(mine,wins));
    if hits
        total = total + 2^(hits-1);
    end
end
disp(total)
end

function part2(txt)
lines = splitlines(txt)';
copies = ones(1,length(lines));
for i = 1:length(lines)
    line = lines{i};
    words = split(line)';
    bar = find(ismember(words,'|'));
    wins = str2double(words(3:bar-1));
    mine = str2double(words(bar+1:end));
    hits = nnz(ismember(mine,wins));
    copies(i+1:i+hits) = copies(i+1:i+hits) + copies(i);
end
disp(sum(copies))
end