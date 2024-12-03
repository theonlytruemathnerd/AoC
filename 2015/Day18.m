clear;clc

txt = fileread('Day18.txt');

% txt = ['.#.#.#' newline ...
% '...##.' newline ...
% '#....#' newline ...
% '..#...' newline ...
% '#.#..#' newline ...
% '####..'];

part1(txt,100)
part2(txt,100)

function part1(txt,steps)
lines = splitlines(txt);
n = length(lines);
grid = false(n); % grid(i,j)
for i = 1:n
    grid(i,:) = lines{i}=='#';
end
for step = 1:steps
    % n, ne, e, se, s, sw, w, nw
    neigrid = [zeros(1,n);grid(1:end-1,:)] + ...
              [zeros(1,n);[grid(1:end-1,2:end),zeros(n-1,1)]] + ...
              [grid(:,2:end),zeros(n,1)] + ...
              [[grid(2:end,2:end),zeros(n-1,1)];zeros(1,n)] + ...
              [grid(2:end,:);zeros(1,n)] + ...
              [[zeros(n-1,1),grid(2:end,1:end-1)];zeros(1,n)] + ...
              [zeros(n,1),grid(:,1:end-1)] + ...
              [zeros(1,n);[zeros(n-1,1),grid(1:end-1,1:end-1)]];
    grid = (grid & neigrid==2) | neigrid==3;
end
disp(nnz(grid))
end

function part2(txt,steps)
lines = splitlines(txt);
n = length(lines);
grid = false(n); % grid(i,j)
for i = 1:n
    grid(i,:) = lines{i}=='#';
end
grid(1,1) = true;
grid(1,n) = true;
grid(n,1) = true;
grid(n,n) = true;
for step = 1:steps
    % n, ne, e, se, s, sw, w, nw
    neigrid = [zeros(1,n);grid(1:end-1,:)] + ...
              [zeros(1,n);[grid(1:end-1,2:end),zeros(n-1,1)]] + ...
              [grid(:,2:end),zeros(n,1)] + ...
              [[grid(2:end,2:end),zeros(n-1,1)];zeros(1,n)] + ...
              [grid(2:end,:);zeros(1,n)] + ...
              [[zeros(n-1,1),grid(2:end,1:end-1)];zeros(1,n)] + ...
              [zeros(n,1),grid(:,1:end-1)] + ...
              [zeros(1,n);[zeros(n-1,1),grid(1:end-1,1:end-1)]];
    grid = (grid & neigrid==2) | neigrid==3;
    grid(1,1) = true;
    grid(1,n) = true;
    grid(n,1) = true;
    grid(n,n) = true;
end
disp(nnz(grid))
end