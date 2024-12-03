clear;clc

txt = fileread('Day03.txt');

part1(txt)
part2(txt)

function part1(txt)
lines = splitlines(txt)';
total = 0;
for line = lines
    sides = sort(str2double(extract(line,digitsPattern)'));
    if sides(1)+sides(2) > sides(3)
        total = total + 1;
    end
end
disp(total)
end

function part2(txt)
lines = splitlines(txt)';
n = length(lines);
nums = zeros(n,3);
for i = 1:n
    nums(i,:) = str2double(extract(lines{i},digitsPattern)');
end
nums = reshape(nums,3,n)';
total = 0;
for i = 1:n
    nums(i,:) = sort(nums(i,:));
    if nums(i,1)+nums(i,2) > nums(i,3)
        total = total + 1;
    end
end
disp(total)
end