clear;clc

txt = ['###########' newline ...
'#0.1.....2#' newline ...
'#.#######.#' newline ...
'#4.......3#' newline ...
'###########'];

txt = fileread('Day24.txt');

part1(txt)

function part1(txt)
% find the shortest dist between each pair of numbers
% path find on that weighted graph

lines = splitlines(txt);
grid = char(lines{:})~='#';
nums = str2double(extract(txt,digitsPattern))';
distA = zeros(length(nums));
poss = zeros(length(nums),2);
for num = nums
    [i,j] = find(char(lines{:})==num2str(num));
    poss(num+1,:) = [i,j];
end

for num1 = 1:length(nums)-1
    for num2 = num1+1:length(nums)
        dist = findDist(grid,poss(num1,:),poss(num2,:));
        distA(num1,num2) = dist;
    end
end
disp('half')
distA = distA + distA';
% distG = graph(distA,'upper','omitselfloops');

dist = findPath(distA,length(nums));
disp(dist)

end

function dist = findDist(grid,start,final)
dists = inf(size(grid));
dists(start(1),start(2)) = 0;
queue = [start 0 sum(abs(start-final))]; % pos, steps, estDist
while true
    pos = queue(1,1:2);
    dst = queue(1,3);
    queue(1,:) = [];
    for neigh = [-1 0 0 1;0 -1 1 0]
        newpos = pos + neigh';
        dist = dst + 1;
        if isequal(newpos,final); return; end
        if grid(newpos(1),newpos(2)) && dists(newpos(1),newpos(2))>dist
            dists(newpos(1),newpos(2)) = dist;
            queue(end+1,:) = [newpos dist dist+sum(abs(newpos-final))];
        end
    end
    queue = sortrows(queue,4);
end
end

% function dist = findDist(grid,start,final)
% seen = false(size(grid));
% queue = start; % pos
% dist = 0;
% while true
%     newQ = zeros(0,2);
%     dist = dist + 1;
%     for i = 1:size(queue,1)
%         pos = queue(i,:);
%         seen(pos(1),pos(2)) = true;
%         for neigh = [-1 0 0 1;0 -1 1 0]
%             newpos = pos + neigh';
%             if isequal(newpos,final); return; end
%             if grid(newpos(1),newpos(2)) && ~seen(newpos(1),newpos(2))
%                 newQ(end+1,:) = newpos;
%             end
%         end
%     end
%     queue = newQ;
% end
% end

function dist = findPath(A,final)
paths = perms(2:final);
dists = A(1,paths(:,1))';
for j = 1:final-2
    dists = dists + diag(A(paths(:,j),paths(:,j+1)));
end
dists = dists + A(1,paths(:,end))';
dist = min(dists);
end