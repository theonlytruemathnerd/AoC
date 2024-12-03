clear;clc

% part1(10,[7,4])
part1(1350,[31,39])

% part2(10)
part2(1350)

function part1(num,goal) % DFS
% pos = (x,y) = x + y*1i = (col,row)

goal = goal(1) + goal(2)*1i;
isOpen = @(pos) ~mod(nnz(dec2bin(real(pos)^2 + 3*real(pos) + 2*real(pos)*imag(pos) + imag(pos) + imag(pos)^2 + num)=='1'),2);
estDist = @(pos) abs(real(pos)-real(goal)) + abs(imag(pos)-imag(goal));
pos = 1+1i;

stepMap = dictionary(pos,0);  % pos -> numSteps
queue = [pos 0 estDist(pos)]; % pos, numSteps, estDistToGoal
while ~isequal(pos,goal)
    % pop top of queue
    pos = queue(1,1);
    numSteps = queue(1,2);
    queue(1,:) = [];

    for neigh = [1,-1,1i,-1i]
        newpos = pos + neigh;
        if 0<=angle(newpos) && angle(newpos)<=pi/2 && isOpen(newpos) % in bounds and not a wall
            if ~isKey(stepMap,newpos) || numSteps+1<stepMap(newpos)
                stepMap(newpos) = numSteps+1;
                queue(end+1,:) = [newpos numSteps+1 estDist(newpos)]; %#ok<AGROW>
            end
        end
    end
    queue = sortrows(queue,[3 2]); % lowest estDistToGoal, lowest numSteps
end
disp(numSteps)
end

function part2(num) % BFS
isOpen = @(pos) ~mod(nnz(dec2bin(real(pos)^2 + 3*real(pos) + 2*real(pos)*imag(pos) + imag(pos) + imag(pos)^2 + num)=='1'),2);
pos = 1+1i;

stepMap = dictionary(pos,0);  % pos -> numSteps
queue = [pos 0]; % pos, numSteps
while ~isempty(queue)
    % pop top of queue
    pos = queue(1,1);
    numSteps = queue(1,2);
    queue(1,:) = [];

    for neigh = [1,-1,1i,-1i]
        newpos = pos + neigh;
        if 0<=angle(newpos) && angle(newpos)<=pi/2 && isOpen(newpos) % in bounds and not a wall
            if (~isKey(stepMap,newpos) || numSteps+1<stepMap(newpos)) && numSteps<50
                stepMap(newpos) = numSteps+1;
                queue(end+1,:) = [newpos numSteps+1]; %#ok<AGROW>
            end
        end
    end
    queue = sortrows(queue,2); % lowest numSteps
end
disp(numEntries(stepMap))
end