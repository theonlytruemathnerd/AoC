% clear;clc

data = readlines("Day07ex.txt");
data = readlines("Day07.txt");

parts(data)

function parts(data)
total = 0;
for row = 1:numel(data)
    nums = double(extract(data(row),digitsPattern))';
    goal = nums(1);
    running = nums(2);
    nums = nums(3:end);

    if recurse(goal, running, nums, @plus) || ...
        recurse(goal, running, nums, @times) || recurse(goal, running, nums, @concat)
        total = total + goal;
    end
end
fprintf('%d\n',total)
end

function [bool, running, nums] = recurse(goal, running, nums, op)
% takes in a
running = op(running, nums(1));
nums = nums(2:end);
if isempty(nums) || running > goal
    bool = goal==running;
    return
end

bool = recurse(goal, running, nums, @plus) || ...
    recurse(goal, running, nums, @times) || recurse(goal, running, nums, @concat);
end

function out = concat(A, B)
out = A*10^floor(log10(B)+1) + B;
end