clear;clc

txt = fileread('Day05.txt');
% txt = fileread('Day05ex.txt');

tic
part1(txt)
toc
tic
part2(txt)
toc

function part1(txt)
blocks = split(txt,compose('\r\n\r\n'))';
blocknums = cell(1,length(blocks));
for j = 2:length(blocks)
    blocknums{j} = reshape(str2double(extract(blocks{j},digitsPattern)),[],length(splitlines(blocks{j}))-1)';
end
seeds = str2double(extract(blocks{1},digitsPattern))';
locs = zeros(size(seeds));
for i = 1:length(seeds)
    seed = seeds(i);
    for j = 2:length(blocks)
        nums = blocknums{j};
        for k = 1:size(nums,1)
            if nums(k,2)<=seed && seed<nums(k,2)+nums(k,3)
                seed = nums(k,1)+seed-nums(k,2);
                break
            end
        end
    end
    locs(i) = seed;
end
disp(min(locs))
end

function part2(txt)
blocks = split(txt,compose('\r\n\r\n'))';
blocknums = cell(1,length(blocks));
for j = 2:length(blocks)
    blocknums{j} = reshape(str2double(extract(blocks{j},digitsPattern)),[],length(splitlines(blocks{j}))-1)';
end
seeds = str2double(extract(blocks{1},digitsPattern))';
endnums = sortrows(blocknums{end});

% pass-through numbers for last block
for seed = 0:endnums(1,1)-1
    if moveback(blocknums,seeds,seed)
        return
    end
end

% iterate over arrays in last block from lowest to highest
for row = 1:size(endnums,1)
    for seed = endnums(row,1):endnums(row,1)+endnums(row,3)-1
        if moveback(blocknums,seeds,seed)
            return
        end
    end
    % cover in-betweens
    for seed = endnums(row,1)+endnums(row,3):endnums(row+1,1)-1
        if moveback(blocknums,seeds,seed)
            return
        end
    end
end

end

function worked = moveback(blocknums,seeds,seed)
newseed = seed;
worked = false;
for j = length(blocknums):-1:1
    nums = blocknums{j};
    for k = 1:size(nums,1)
        if nums(k,1)<=newseed && newseed<nums(k,1)+nums(k,3)
            newseed = nums(k,2)+newseed-nums(k,1);
            break
        end
    end
end
for i = 1:2:length(seeds)
    if seeds(i)<=newseed && newseed<seeds(i)+seeds(i+1)
        disp(seed)
        worked = true;
        return
    end
end
end