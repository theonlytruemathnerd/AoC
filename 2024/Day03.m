clear;clc

data = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';
data = 'xmul(2,4)&mul[3,7]!^don''t()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))';
data = fileread("Day03.txt");

part1(data)
part2(data)

function part1(data)
matches = regexp(data,'mul\(\d+,\d+\)','match');
total = 0;
for match = matches
    nums = str2double(extract(match{1},digitsPattern));
    total = total + prod(nums);
end
disp(total)
end

function part2(data)
matches = regexp(data,'mul\(\d+,\d+\)|do\(\)|don''t\(\)','match');
total = 0;
enabled = true;
for ii = 1:numel(matches)
    match = matches{ii};
    if contains(match,'do()')
        enabled = true;
    elseif contains(match,'don''t()')
        enabled = false;
    elseif enabled
        nums = str2double(extract(match,digitsPattern));
        total = total + prod(nums);
    end
end
disp(total)
end