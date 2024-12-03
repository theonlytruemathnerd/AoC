clear;clc

txt = fileread('Day10.txt');

% txt = ['value 5 goes to bot 2' newline ...
% 'bot 2 gives low to bot 1 and high to bot 0' newline ...
% 'value 3 goes to bot 1' newline ...
% 'bot 1 gives low to output 1 and high to bot 0' newline ...
% 'bot 0 gives low to output 2 and high to output 0' newline ...
% 'value 2 goes to bot 2'];

part1(txt)

function part1(txt)
% since bot/output 0 exists, all bots/outputs get bumped up 1
mx = max(str2double(extract(txt,digitsPattern)),[],'all') + 1;
lines = splitlines(txt)';
instructs = configureDictionary('double','string');
bots = zeros(mx,2); % [val1, val2]
outs = zeros(mx,1);
for line = lines
    nums = str2double(extract(line{:},digitsPattern));
    if startsWith(line{:},'value')
        if bots(nums(2)+1,1) == 0
            bots(nums(2)+1,1) = nums(1);
        else
            bots(nums(2)+1,2) = nums(1);
        end
    elseif startsWith(line{:},'bot')
        instructs(nums(1)) = line{:};
    end
end
% bots
while any(bots(:,2) ~= 0)
    bot = find(bots(:,2) ~= 0,1); % shifted by 1
    line = instructs(bot-1);
    nums = str2double(extract(line,digitsPattern));
    words = split(line);
    if startsWith(words{1},'bot')
        if prod(bots(nums(1)+1,:)) == 61*17
            disp(nums(1))
        end
        if strcmp(words{6},'bot')
            if bots(nums(2)+1,1) == 0
                bots(nums(2)+1,1) = min(bots(nums(1)+1,:));
            else
                bots(nums(2)+1,2) = min(bots(nums(1)+1,:));
            end
        else
            outs(nums(2)+1) = min(bots(nums(1)+1,:));
        end
        if strcmp(words{11},'bot')
            if bots(nums(3)+1,1) == 0
                bots(nums(3)+1,1) = max(bots(nums(1)+1,:));
            else
                bots(nums(3)+1,2) = max(bots(nums(1)+1,:));
            end
        else
            outs(nums(3)+1) = max(bots(nums(1)+1,:));
        end
        bots(nums(1)+1,:) = 0;
    end
end
disp(prod(outs(1:3)))
end
