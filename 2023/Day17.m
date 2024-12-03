clear;clc

txt = ['2413432311323' newline ...
'3215453535623' newline ...
'3255245654254' newline ...
'3446585845452' newline ...
'4546657867536' newline ...
'1438598798454' newline ...
'4457876987766' newline ...
'3637877979653' newline ...
'4654967986887' newline ...
'4564679986453' newline ...
'1224686865563' newline ...
'2546548887735' newline ...
'4322674655533'];

txt = fileread('Day17.txt');

part1(txt,1,3)
part1(txt,4,10)

function part1(txt,mn,mx)
lines = splitlines(txt);
grid = char(lines{:});
grid = double(grid)-48;

[ny,nx] = size(grid);
pos = 1+1i;
goal = nx+ny*1i;

queue = [pos, 1, 1, 0;
         pos, 1i, 1, 0];
% pos, dir, stepNum, heat
% add three steps to left and right at a time. no going straight

minHeat = Inf;
seen = false(nx,ny,4,mx);
dirs = [-1i 1 1i -1];
while ~isempty(queue)
    testHeat = min(queue(:,4));
    if ~mod(testHeat,100)
        fprintf('%d \t%d\n',testHeat,size(queue,1))
    end
    active = queue(:,4)==testHeat;
    newQueue = zeros(0,4);
    for i = find(active)'
        pos = queue(i,1);
        dir = queue(i,2);
        dst = queue(i,3);
        heat = testHeat;
        if any(seen(imag(pos),real(pos),dirs==dir,1:dst)); continue; end
        seen(imag(pos),real(pos),dirs==dir,dst) = true;

        for turn = [1i -1i]
            newheat = heat;
            for dist = 1:mx
                newpos = pos + dir*turn*dist;
                row = imag(newpos); col = real(newpos);
                if col<=0 || nx<col || row<=0 || ny<row; break; end
                newheat = newheat + grid(row,col);
    
                if newpos==goal && newheat<minHeat
                    minHeat = min(minHeat,newheat);
                    % queue(queue(:,4)>=minHeat,:) = [];
                    fprintf('%d \t%d\n',minHeat,size(queue,1))
                elseif dist>=mn
                    newQueue(end+1,:) = [newpos, dir*turn, dist, newheat];
                end
            end
        end
    end
    queue(active,:) = [];
    queue = [queue;newQueue];
end
disp(minHeat)
end

% function part1(txt)
% lines = splitlines(txt);
% grid = char(lines{:});
% grid = double(grid)-48;
% 
% [ny,nx] = size(grid);
% disp(nx*ny)
% pos = 1+1i;
% goal = nx+ny*1i;
% % estHeatRem = @(pos) (abs(real(pos-goal)) + abs(imag(pos-goal)))*mean(grid(imag(pos):end,real(pos):end),'all');
% estHeatRem = @(pos) (abs(real(pos-goal)) + abs(imag(pos-goal)));
% 
% queue = [pos, 1, 1, 0, estHeatRem(pos);
%          pos, 1i, 1, 0, estHeatRem(pos)];
% % pos, dir, Heat, estTotalHeat
% % add three steps to left and right at a time. no going straight
% 
% % while pos~=goal
% minHeat = Inf;
% seen = false(nx,ny,4,3);
% heatmap = inf(nx,ny,4,3);
% dirs = [-1i 1 1i -1];
% cunt = 0;
% while ~isempty(queue)
%     pos = queue(1,1);
%     dir = queue(1,2);
%     dst = queue(1,3);
%     heat = queue(1,4);
%     queue(1,:) = [];
%     if any(seen(imag(pos),real(pos),dirs==dir,1:dst)); continue; end
%     seen(imag(pos),real(pos),dirs==dir,dst) = true;
% 
%     % if heatmap(imag(pos),real(pos),dirs==dir,dst)<heat; continue; end
%     % heatmap(imag(pos),real(pos),dirs==dir,dst) = heat;
% 
%     for turn = [1i -1i]
%         newheat = heat;
%         for dist = 1:3
%             newpos = pos + dir*turn*dist;
%             row = imag(newpos); col = real(newpos);
%             if col<=0 || nx<col || row<=0 || ny<row; break; end
%             newheat = newheat + grid(row,col);
% 
%             if newpos==goal
%                 minHeat = min(minHeat,newheat);
%                 queue(queue(:,4)>=minHeat,:) = [];
%                 fprintf('%d, %d\n',minHeat,size(queue,1))
%             else
%                 queue(end+1,:) = [newpos, dir*turn, dist, newheat, newheat+estHeatRem(newpos)];
%             end
%         end
%     end
% 
%     cunt = cunt + 1;
%     if ~mod(cunt,100)
%         fprintf('%d\t%d\t%d\n',size(queue,1),min(real(queue(:,1))+imag(queue(:,1))),max(real(queue(:,1))+imag(queue(:,1))))
%         queue = sortrows(queue,4);
%     end
%     % dispqueue(queue)
%     % if size(queue,1) > 10
%     %     break
%     % end
%     % break
% end
% disp(minHeat)
% % disp(queue)
% end

% function part1(txt)
% lines = splitlines(txt);
% grid = char(lines{:});
% grid = double(grid)-48;
% 
% [ny,nx] = size(grid);
% pos = 1+1i;
% goal = nx+ny*1i;
% estHeatRem = @(pos) (abs(real(pos-goal)) + abs(imag(pos-goal)))*mean(grid(imag(pos):end,real(pos):end),'all');
% % estHeatRem = @(pos) (abs(real(pos-goal)) + abs(imag(pos-goal)))*9;
% 
% queue = [pos, 0, estHeatRem(pos), 0, 0, 0];
% % pos, Heat, estTotalHeat, lastDir, 2ndLastDir, 3rdLastDir
% % while pos~=goal
% minHeat = Inf;
% while ~isempty(queue)
%     pos = queue(1,1);
%     heat = queue(1,2);
%     lastDirs = queue(1,4:6);
%     queue(1,:) = [];
% 
%     for neigh = [-1i -1 1i 1]
%         newpos = pos+neigh;
%         row = imag(newpos);
%         col = real(newpos);
%         if all(lastDirs==neigh) || neigh==-lastDirs(1); continue; end
%         if col==0 || nx<col || row==0 || ny<row; continue; end
% 
%         if newpos==goal
%             minHeat = min(minHeat,heat+grid(row,col));
%             % disp(queue(:,1:3))
%             % fprintf('%d, %d\n',minHeat,size(queue,1))
%             queue(queue(:,2)>=minHeat,:) = []; % prune
%             % fprintf('%d, %d\n',minHeat,size(queue,1))
%             % disp(queue(:,1:3))
%             % queue = [];
%             % break
%             fprintf('%d, %d, %d\n',minHeat,size(queue,1),max(queue(:,2)))
%         else
%             queue(end+1,:) = [newpos, heat+grid(row,col), heat+estHeatRem(newpos), neigh, lastDirs(1:2)];
%         end
%     end
%     queue = sortrows(queue,3);
%     dispqueue(queue)
%     if size(queue,1) > 10
%         break
%     end
%     % break
% end
% disp(heat)
% disp(queue)
% end
