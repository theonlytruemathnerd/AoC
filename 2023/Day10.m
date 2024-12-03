clear;clc

txt = ['7-F7-' newline ...
'.FJ|7' newline ...
'FSLL7' newline ...
'|F--J' newline ...
'LJ.LJ'];

txt = ['.F----7F7F7F7F-7....' newline ...
'.|F--7||||||||FJ....' newline ...
'.||.FJ||||||||L7....' newline ...
'FJL7L7LJLJ||LJ.L-7..' newline ...
'L--J.L7...LJS7F-7L7.' newline ...
'....F-J..F7FJ|L7L7L7' newline ...
'....L7.F7||L7|.L7L7|' newline ...
'.....|FJLJ|FJ|F7|.LJ' newline ...
'....FJL-7.||.||||...' newline ...
'....L---J.LJ.LJLJ...'];

txt = ['FF7F7F7F7F7F7F7F---7' newline ...
'L|LJS|||||||||||F--J' newline ...
'FL-7LJLJ||||||LJL-77' newline ...
'F--JF--7||LJLJ7F7FJ-' newline ...
'L---JF-JLJ.||-FJLJJ7' newline ...
'|F|F-JF---7F7-L7L|7|' newline ...
'|FFJF7L7F-JF7|JL---7' newline ...
'7-L-JL7||F7|L7F-7F7|' newline ...
'L.L7LFJ|||||FJL7||LJ' newline ...
'L7JLJL-JLJLJL--JLJ.L'];

txt = fileread('Day10.txt');

[grid,dists] = part1(txt);
part2(grid,dists)

function [grid,dists] = part1(txt)
lines = splitlines(txt)';
grid = char(lines{:});
mapL = dictionary([-1,1i],[-1i,1]);
mapJ = dictionary([1,1i],[-1i,-1]);
map7 = dictionary([1,-1i],[1i,-1]);
mapF = dictionary([-1,-1i],[1i,1]);
[i,j] = find(grid=='S');
prev = j + i*1i; % top left is 1+1i, increase down and right
dists = inf(size(grid));
dists(i,j) = 0;
dirs = [-1i,1,1i,-1]; % up, right, down, left
queue = []; % [col+row*1i, dir]
outs = dirs;
for dir = dirs
    next = prev+dir;
    dists(imag(next),real(next)) = 1;
    chr = grid(imag(next),real(next));
    if chr=='L' && isKey(mapL,dir)
        queue(end+1,:) = [next mapL(dir)];
    elseif chr=='J' && isKey(mapJ,dir)
        queue(end+1,:) = [next mapJ(dir)];
    elseif chr=='7' && isKey(map7,dir)
        queue(end+1,:) = [next map7(dir)];
    elseif chr=='F' && isKey(mapF,dir)
        queue(end+1,:) = [next mapF(dir)];
    elseif (chr=='|' && real(dir)==0) || (chr=='-' && imag(dir)==0)
        queue(end+1,:) = [next dir];
    else
        dists(imag(next),real(next)) = inf;
        outs = setdiff(outs,dir);
    end
end
switch sum(outs)
    case 1-1i
        grid(i,j) = 'L';
    case -1-1i
        grid(i,j) = 'J';
    case -1+1i
        grid(i,j) = '7';
    case 1+1i
        grid(i,j) = 'F';
end
while ~isempty(queue)
    prev = queue(1,1);
    dir = queue(1,2);
    queue(1,:) = [];
    dist = dists(imag(prev),real(prev));
    next = prev+dir;
    if dists(imag(next),real(next)) <= dist % reached halfway point
        continue
    end
    dists(imag(next),real(next)) = dist + 1;
    switch grid(imag(next),real(next))
        case 'L'
            queue(end+1,:) = [next mapL(dir)];
        case 'J'
            queue(end+1,:) = [next mapJ(dir)];
        case '7'
            queue(end+1,:) = [next map7(dir)];
        case 'F'
            queue(end+1,:) = [next mapF(dir)];
        case {'|','-'}
            queue(end+1,:) = [next dir];
    end
end
disp(max(dists(isfinite(dists))))
grid(isinf(dists)) = '.';
end

function part2(grid,dists)
total = 0;
[rows,cols] = find(isinf(dists));
for i = 1:length(rows)
    in = false;
    rowstart = max(1,rows(i)-cols(i)+1);
    colstart = max(1,cols(i)-rows(i)+1);
    for j = 0:rows(i)-rowstart
        if ismember(grid(rowstart+j,colstart+j),{'|','-','J','F'})
            in = ~in;
        end
    end
    total = total + in;
end
disp(total)
end