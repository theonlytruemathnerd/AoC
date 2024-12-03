clear;clc

txt = fileread('Day24.txt');
nums = str2double(extract(txt,digitsPattern))';

% nums = [1:5 7:11];

part(nums,3)
part(nums,4)

function part(nums,comparts)
nums = fliplr(nums);
weight = sum(nums)/comparts;
for nnums = 1:length(nums)
    tests = nchoosek(nums,nnums)';
    valid = sum(tests,1)==weight;
    if nnz(valid)
        fprintf('%d\n',min(prod(tests(:,valid),1)))
        break
    end
end
end