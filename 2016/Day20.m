clear;clc

txt = ['5-8' newline ...
'0-2' newline ...
'4-7'];

txt = fileread('Day20.txt');

part1(txt)
part2(txt)

function part1(txt)
nums = sortrows(reshape(str2double(extract(txt,digitsPattern)),2,[])');
mn = 0;
while true
    pass = true;
    for i = 1:size(nums,1)
        if nums(i,1)<=mn && mn<=nums(i,2)
            pass = false;
            mn = nums(i,2)+1;
        end
    end
    if pass
        break
    end
end
disp(mn)
end

function part2(txt)
nums = sortrows(reshape(str2double(extract(txt,digitsPattern)),2,[])');
valid = 0;
mn = nums(1,2);
for i = 2:size(nums,1)
    if mn<nums(i,1)
        valid = valid + nums(i,1)-mn-1;
    end
    mn = max(mn,nums(i,2));
end
imax = 4294967295;
valid = valid + imax-max(nums(:,2));
disp(valid)
end
