clear;clc

txt = ['#.##..##.' newline ...
'..#.##.#.' newline ...
'##......#' newline ...
'##......#' newline ...
'..#.##.#.' newline ...
'..##..##.' newline ...
'#.#.##.#.' newline newline ...
'#...##..#' newline ...
'#....#..#' newline ...
'..##..###' newline ...
'#####.##.' newline ...
'#####.##.' newline ...
'..##..###' newline ...
'#....#..#'];

txt = fileread('Day13.txt');

part1(txt)
part2(txt)

function part1(txt)
total = 0;
blocks = split(txt,compose('\n\n'));
N = length(blocks);
for ii = 1:N
    lines = splitlines(blocks{ii});
    block = char(lines{:});
    % look for vertical mirrors
    nj = size(block,2);
    for j = 1:nj-1
        st = max(1,2*j-nj+1);
        en = min(nj,2*j);
        if strcmp(block(:,st:j),fliplr(block(:,j+1:en)))
            total = total + j;
            break
        end
    end
    % look for horizontal mirrors
    ni = size(block,1);
    for i = 1:ni-1
        st = max(1,2*i-ni+1);
        en = min(ni,2*i);
        if strcmp(block(st:i,:),flipud(block(i+1:en,:)))
            total = total + 100*i;
            break
        end
    end
end
disp(total)
end

function part2(txt)
total = 0;
blocks = split(txt,compose('\n\n'));
N = length(blocks);
for ii = 1:N
    lines = splitlines(blocks{ii});
    block = char(lines{:});
    % look for vertical mirrors
    nj = size(block,2);
    for j = 1:nj-1
        st = max(1,2*j-nj+1);
        en = min(nj,2*j);
        if nnz(block(:,st:j)~=fliplr(block(:,j+1:en)))==1
            total = total + j;
            break
        end
    end
    % look for horizontal mirrors
    ni = size(block,1);
    for i = 1:ni-1
        st = max(1,2*i-ni+1);
        en = min(ni,2*i);
        if nnz(block(st:i,:)~=flipud(block(i+1:en,:)))==1
            total = total + 100*i;
            break
        end
    end
end
disp(total)
end