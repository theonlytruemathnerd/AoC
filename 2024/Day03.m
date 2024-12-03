clear;clc

data = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';
data = 'xmul(2,4)&mul[3,7]!^don''t()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))';
data = fileread("Day03.txt");

nums = part1(data);
part2(data,nums)

function nums = part1(data)
tokens = regexp(data,'mul\((\d+),(\d+)\)','tokens');
tokens = string([tokens{:}]);
nums = reshape(double(tokens),2,[]);
total = sum(prod(nums));
disp(total)
end

function part2(data,nums)
matches = regexp(data,'mul\(\d+,\d+\)|do\(\)|don''t\(\)','match');
total = 0;
enabled = true;
numInd = 1;
for ii = 1:numel(matches)
    match = matches{ii};
    if contains(match,'do()')
        enabled = true;
    elseif contains(match,'don''t()')
        enabled = false;
    else
        if enabled
            total = total + prod(nums(:,numInd));
        end
        numInd = numInd + 1;
    end
end
disp(total)
end