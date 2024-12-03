clear;clc

txt = fileread('Day02.txt');

% txt = ['Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green' newline ...
% 'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue' newline ...
% 'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red' newline ...
% 'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red' newline ...
% 'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'];

part1(txt)
part2(txt)

function part1(txt)
total = 0;
lines = splitlines(txt)';
n = length(lines);
red = 12;
green = 13;
blue = 14;
for i = 1:n
    words = split(lines{i});
    good = true;
    for j = 3:2:length(words)
        if startsWith(words{j+1},'red') && str2double(words{j}) > red
            good = false;
            break
        elseif startsWith(words{j+1},'green') && str2double(words{j}) > green
            good = false;
            break
        elseif startsWith(words{j+1},'blue') && str2double(words{j}) > blue
            good = false;
            break
        end
    end
    if good
        num = words{2};
        total = total + str2double(num(1:end-1));
    end
end
disp(total)
end

function part2(txt)
total = 0;
lines = splitlines(txt)';
n = length(lines);
for i = 1:n
    words = split(lines{i});
    red = 0;
    green = 0;
    blue = 0;
    for j = 3:2:length(words)
        if startsWith(words{j+1},'red')
            red = max(red,str2double(words{j}));
        elseif startsWith(words{j+1},'green')
            green = max(green,str2double(words{j}));
        elseif startsWith(words{j+1},'blue')
            blue = max(blue,str2double(words{j}));
        end
    end
    num = prod([red,green,blue]);
    total = total + num;
end
disp(total)
end