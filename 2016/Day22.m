clear;clc

txt = ['Filesystem            Size  Used  Avail  Use%' newline ...
'/dev/grid/node-x0-y0   10T    8T     2T   80%' newline ...
'/dev/grid/node-x0-y1   11T    6T     5T   54%' newline ...
'/dev/grid/node-x0-y2   32T   28T     4T   87%' newline ...
'/dev/grid/node-x1-y0    9T    7T     2T   77%' newline ...
'/dev/grid/node-x1-y1    8T    0T     8T    0%' newline ...
'/dev/grid/node-x1-y2   11T    7T     4T   63%' newline ...
'/dev/grid/node-x2-y0   10T    6T     4T   60%' newline ...
'/dev/grid/node-x2-y1    9T    8T     1T   88%' newline ...
'/dev/grid/node-x2-y2    9T    6T     3T   66%'];

txt = fileread('Day22.txt');

part1(txt)
part2(txt)

function part1(txt)
nums = reshape(str2double(extract(txt,digitsPattern)),6,[])';
total = 0;
for i = 1:size(nums,1)
    for j = 1:size(nums,1)
        if i==j; continue; end
        if nums(i,4)<=nums(j,5) && nums(i,4)~=0
            total = total + 1;
        end
    end
end
disp(total)
end

function part2(txt)
nums = reshape(str2double(extract(txt,digitsPattern)),6,[])';

nx = max(nums(:,1))+1;
ny = max(nums(:,2))+1;
grid = ceil(log10(reshape(nums(:,4),ny,nx)+1));
grid(grid==max(grid,[],'all')) = inf;
disp(34+32+5*36)

end