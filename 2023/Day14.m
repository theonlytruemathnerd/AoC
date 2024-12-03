clear;clc

txt = ['O....#....' newline ...
'O.OO#....#' newline ...
'.....##...' newline ...
'OO.#O....O' newline ...
'.O.....O#.' newline ...
'O.#..O.#.#' newline ...
'..O..#O..O' newline ...
'.......O..' newline ...
'#....###..' newline ...
'#OO..#....'];

txt = fileread('Day14.txt');

part1(txt)
part2(txt)

function part1(txt)
% lines = splitlines(txt);
% dish = char(lines{:});
% load = 0;
% for j = 1:size(dish,2) % cols
%     rocks = find(dish(:,j)=='O');
%     cubes = [0;find(dish(:,j)=='#');size(dish,1)+1];
%     for i = 1:length(cubes)-1
%         nRocks = nnz(cubes(i)<rocks & rocks<cubes(i+1)); % <= cubes(i+1)-cubes(i)-1
%         newPos = cubes(i)+1:cubes(i)+nRocks;
%         load = load + sum(size(dish,1)+1-newPos);
%     end
% end
% disp(load)
lines = splitlines(txt);
dish = char(lines{:});
rocks = dish=='O';
cubes = dish=='#';
rocks = tilt(rocks,cubes,0);
dispLoad(rocks)
end

function part2(txt)
lines = splitlines(txt);
dish = char(lines{:});
rocks = dish=='O';
cubeN = dish=='#';
cubeW = rot90(cubeN,3);
cubeS = rot90(cubeN,2);
cubeE = rot90(cubeN,1);
r2cmap = configureDictionary('cell','double');
c2rmap = configureDictionary('double','cell');
for cycle = 1:1000
    rocks = rot90(tilt(rocks,cubeN,0),0); % north
    rocks = rot90(tilt(rocks,cubeW,3),1); % west
    rocks = rot90(tilt(rocks,cubeS,2),2); % south
    rocks = rot90(tilt(rocks,cubeE,1),3); % east
    if isKey(r2cmap,{rocks})
        disp([r2cmap({rocks}),cycle])
        break
    else
        r2cmap({rocks}) = cycle;
        c2rmap(cycle) = {rocks};
    end
end
% dish = repmat('.',size(dish));
% dish(rocks) = 'O';
% dish(cubeN) = '#'
c0 = r2cmap({rocks}); % start of cycle
cN = cycle-c0;        % cycle length
finalRocks = c2rmap(mod(1e9-c0,cN)+c0);
dispLoad(finalRocks{1})
end

function rocks = tilt(rocks,cubes,rot)
rocks = rot90(rocks,rot);
% tilts to the north, rotate inputs and outputs outside of function
ni = size(rocks,1);
nj = size(rocks,2);
for j = 1:nj
    rs = find(rocks(:,j));
    cs = [0;find(cubes(:,j));ni+1];
    nRocks = sum(cs(1:end-1)<rs' & rs'<cs(2:end),2); % number of rocks in each region
    rocks(:,j) = any(cs(1:end-1)<(1:ni) & (1:ni)<=cs(1:end-1)+nRocks,1)'; % where the rocks end up
end
end

function dispLoad(rocks)
nj = size(rocks,1);
disp(sum((nj:-1:1).*sum(rocks,2)'))
end