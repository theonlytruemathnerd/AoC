clear;clc

data = char(splitlines(fileread("Day06ex.txt")));
data = char(splitlines(fileread("Day06.txt")));

visited = part1(data);
part2(data,visited)

function visited = part1(data)
visited = false(size(data));
obstructions = data == '#';
[posr,posc] = find(data == '^');
pos = [posr posc];
steps = 0;
heading = 0; % 0:N, 1:E, 2:S, 3:W
while ~isempty(steps)
    switch heading
        case 0
            steps = find(obstructions(pos(1)-1:-1:1,pos(2)),1)-1;
            if isempty(steps), visited(pos(1):-1:1,pos(2)) = true; end
            indices = [pos(1),-1,pos(1)-steps,pos(2),1,pos(2)];
            dPos = [-steps 0];
        case 1
            steps = find(obstructions(pos(1),pos(2)+1:end),1)-1;
            if isempty(steps), visited(pos(1),pos(2):end) = true; end
            indices = [pos(1),1,pos(1),pos(2),1,pos(2)+steps];
            dPos = [0 steps];
        case 2
            steps = find(obstructions(pos(1)+1:end,pos(2)),1)-1;
            if isempty(steps), visited(pos(1):end,pos(2)) = true; end
            indices = [pos(1),1,pos(1)+steps,pos(2),1,pos(2)];
            dPos = [steps 0];
        case 3
            steps = find(obstructions(pos(1),pos(2)-1:-1:1),1)-1;
            if isempty(steps), visited(pos(1),pos(2):-1:1) = true; end
            indices = [pos(1),1,pos(1),pos(2),-1,pos(2)-steps];
            dPos = [0 -steps];
    end
    if isempty(steps)
        break
    end
    visited(indices(1):indices(2):indices(3), indices(4):indices(5):indices(6)) = true;
    pos = pos + dPos;
    heading = mod(heading+1,4);
end
disp(nnz(visited))
end

function part2(data, visited)
[visr,visc] = find(visited);
[posr,posc] = find(data == '^');

numLoops = 0;
for ii = 1:numel(visr)
    pos = [posr posc];
    if isequal(pos,[visr(ii) visc(ii)])
        continue
    end
    visited = zeros(size(data));
    obstructions = data == '#';
    obstructions(visr(ii),visc(ii)) = true;
    steps = 0;
    heading = 0; % 0:N, 1:E, 2:S, 3:W
    while ~isempty(steps)
        switch heading
            case 0
                steps = find(obstructions(pos(1)-1:-1:1,pos(2)),1)-1;
                if isempty(steps), visited(pos(1):-1:1,pos(2)) = true; end
                indices = [pos(1),-1,pos(1)-steps,pos(2),1,pos(2)];
                dPos = [-steps 0];
            case 1
                steps = find(obstructions(pos(1),pos(2)+1:end),1)-1;
                if isempty(steps), visited(pos(1),pos(2):end) = true; end
                indices = [pos(1),1,pos(1),pos(2),1,pos(2)+steps];
                dPos = [0 steps];
            case 2
                steps = find(obstructions(pos(1)+1:end,pos(2)),1)-1;
                if isempty(steps), visited(pos(1):end,pos(2)) = true; end
                indices = [pos(1),1,pos(1)+steps,pos(2),1,pos(2)];
                dPos = [steps 0];
            case 3
                steps = find(obstructions(pos(1),pos(2)-1:-1:1),1)-1;
                if isempty(steps), visited(pos(1),pos(2):-1:1) = true; end
                indices = [pos(1),1,pos(1),pos(2),-1,pos(2)-steps];
                dPos = [0 -steps];
        end
        if isempty(steps) % left the board, no loop
            break
        end
        visited(indices(1):indices(2):indices(3), indices(4):indices(5):indices(6)) = ...
            visited(indices(1):indices(2):indices(3), indices(4):indices(5):indices(6)) + 1;
        if max(visited,[],'all')>4
            numLoops = numLoops + 1;
            break
        end
        pos = pos + dPos;
        heading = mod(heading+1,4);
    end
end
disp(numLoops)
end

