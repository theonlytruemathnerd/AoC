clear;clc

txt = ['...#......' newline ...
'.......#..' newline ...
'#.........' newline ...
'..........' newline ...
'......#...' newline ...
'.#........' newline ...
'.........#' newline ...
'..........' newline ...
'.......#..' newline ...
'#...#.....'];

txt = fileread('Day11.txt');

part1(txt)
part2(txt,1e6)

function part1(txt)
lines = splitlines(txt);
n = length(lines);
grid = char(lines{:});
space = grid;
rowcount = 0;
colcount = 0;
for i = 1:n
    if ~contains(grid(i,:),'#') % no galaxy in row
        space(i+1+rowcount:end+1,:) = space(i+rowcount:end,:);
        rowcount = rowcount + 1;
    end
    if ~contains(grid(:,i)','#') % no galaxy in col
        space(:,i+1+colcount:end+1) = space(:,i+colcount:end);
        colcount = colcount + 1;
    end
end
[rows,cols] = find(space=='#');
total = 0;
for i = 1:length(rows)-1
    for j = i+1:length(rows)
        total = total + abs(diff(rows([i,j]))) + abs(diff(cols([i,j])));
    end
end
disp(total)
end

function part2(txt,gap)
lines = splitlines(txt);
n = length(lines);
grid = char(lines{:});
rowjumps = [];
coljumps = [];
for i = 1:n
    if ~contains(grid(i,:),'#') % no galaxy in row
        rowjumps(end+1) = i; %#ok<AGROW>
    end
    if ~contains(grid(:,i)','#') % no galaxy in col
        coljumps(end+1) = i; %#ok<AGROW>
    end
end
[rows,cols] = find(grid=='#');
total = 0;
for i = 1:length(rows)-1
    for j = i+1:length(rows)
        total = total + abs(diff(rows([i,j]))) + abs(diff(cols([i,j])));
        total = total + (gap-1)*nnz(min(rows([i,j]))<rowjumps & rowjumps<max(rows([i,j])));
        total = total + (gap-1)*nnz(min(cols([i,j]))<coljumps & coljumps<max(cols([i,j])));
    end
end
fprintf('%d\n',total)
end