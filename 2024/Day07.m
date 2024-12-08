clear;clc

data = readlines("Day07ex.txt");
data = readlines("Day07.txt");

tic
parts(data, false)
toc

tic
parts(data, true)
toc

function parts(data, doConcat)
total = 0;
for row = 1:numel(data)
    nums = double(extract(data(row),digitsPattern))';
    running = nums(1);
    nums = nums(end:-1:2);

    bool = peel(running, nums, "minus", doConcat) || peel(running, nums, "rdivide", doConcat);
    if bool || (doConcat && peel(running, nums, "deconcat", doConcat))
        total = total + running;
    end
end
fprintf('%d\n',total)
end

function bool = peel(running, nums, op, doConcat)
relNum = nums(1);
nums = nums(2:end);
pow10 = 10^floor(log10(relNum)+1);
if op == "deconcat" && relNum == mod(running,pow10)
    running = floor(running/pow10);
elseif op == "rdivide" && ~mod(running,relNum)
    running = running/relNum;
elseif op == "minus" && running > relNum
    running = running - relNum;
else
    bool = false;
    return
end
if isscalar(nums)
    bool = running==nums;
    return
end

bool = peel(running, nums, "minus", doConcat) || peel(running, nums, "rdivide", doConcat) || ...
    (doConcat && peel(running, nums, "deconcat", doConcat));
end