clear;clc

txt = fileread('Day08.txt');

% txt = ['rect 3x2' newline ...
%     'rotate column x=1 by 1' newline ...
%     'rotate row y=0 by 4' newline ...
%     'rotate column x=1 by 1'];

part1(txt)

function part1(txt)
screen = false(6,50);
lines = splitlines(txt)';
N = length(lines);
for ii = 1:N
    line = lines{ii};
    nums = str2double(extract(line,digitsPattern));
    if startsWith(line,'rect')
        screen(1:nums(2),1:nums(1)) = true;
    elseif startsWith(line,'rotate column')
        screen(:,nums(1)+1) = circshift(screen(:,nums(1)+1),nums(2));
    elseif startsWith(line,'rotate row')
        screen(nums(1)+1,:) = circshift(screen(nums(1)+1,:),nums(2));
    end
end
disp(nnz(screen))
spy(screen)
end
