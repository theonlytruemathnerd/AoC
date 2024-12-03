clear;clc

txt = ['.|...\....' newline ...
'|.-.\.....' newline ...
'.....|-...' newline ...
'........|.' newline ...
'..........' newline ...
'.........\' newline ...
'..../.\\..' newline ...
'.-.-/..|..' newline ...
'.|....-|.\' newline ...
'..//.|....'];

txt = fileread('Day16.txt');

disp(part1(txt,1+1i,1))

part2(txt)

function tiles = part1(txt,pos,dir)
lines = splitlines(txt);
grid = char(lines{:});
[nr,ni] = size(grid);

backslashdirmap = dictionary([1 1i -1 -1i],[1i 1 -1i -1]);
foreslashdirmap = dictionary([1 1i -1 -1i],[-1i -1 1i 1]);

% pos = 1+1i; % down right is positive
% dir = 1;

visited = false(nr,ni,4);
visited(imag(pos),real(pos),2*angle(dir)/pi+2) = true;
queue = [pos dir]; % pos dir

while ~isempty(queue)
    pos = queue(1,1);
    dir = queue(1,2);
    queue(1,:) = [];
    % disp([pos dir])

    chr = grid(imag(pos),real(pos));
    switch chr
        case '.'
            posdir = [pos+dir dir];
            [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
        case '\'
            posdir = [pos+backslashdirmap(dir) backslashdirmap(dir)];
            [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
        case '/'
            posdir = [pos+foreslashdirmap(dir) foreslashdirmap(dir)];
            [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
        case '|'
            if imag(dir)~=0 % dir is vert
                posdir = [pos+dir dir];
                [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
            else % dir is horiz
                posdir = [pos-1i -1i];
                [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
                posdir = [pos+1i 1i];
                [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
            end
        case '-'
            if real(dir)~=0 % dir is horiz
                posdir = [pos+dir dir];
                [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
            else % dir is vert
                posdir = [pos-1 -1];
                [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
                posdir = [pos+1 1];
                [queue,visited] = addposdir(posdir,queue,visited,nr,ni);
            end
    end
end
tiles = nnz(any(visited,3));
end

function part2(txt)
lines = splitlines(txt);
grid = char(lines{:});
[nr,ni] = size(grid);
maxen = 0;
for i = 1:nr
    tiles = part1(txt,i+1i,1i); % down from top
    maxen = max(maxen,tiles);
    tiles = part1(txt,i+ni*1i,-1i); % up from bottom
    maxen = max(maxen,tiles);
end
disp('halfway done')
for j = 1:ni
    tiles = part1(txt,1+j*1i,1); % right from left
    maxen = max(maxen,tiles);
    tiles = part1(txt,nr+j*1i,-1); % left from right
    maxen = max(maxen,tiles);
end
disp(maxen)
end

function [queue,visited] = addposdir(posdir,queue,visited,nr,ni)
diri = 2*angle(posdir(2))/pi+2;
% if in range and not in visited, add to queue and visited
if min(real(posdir(1)),imag(posdir(1)))==0 || real(posdir(1))>nr || imag(posdir(1))>ni
    return
elseif visited(imag(posdir(1)),real(posdir(1)),diri)
% elseif any(all(visited==posdir,2)) % posdir in visited
    return
else
    queue(end+1,:) = posdir;
    visited(imag(posdir(1)),real(posdir(1)),diri) = true;
end
end