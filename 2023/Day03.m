clear;clc

txt = fileread('Day03.txt');

% txt = ['467..114..' newline ...
% '...*......' newline ...
% '..35..633.' newline ...
% '......#...' newline ...
% '617*......' newline ...
% '.....+.58.' newline ...
% '..592.....' newline ...
% '......755.' newline ...
% '...$.*....' newline ...
% '.664.598..'];

part1(txt)
part2(txt)

function part1(txt)
total = 0;
symbols = [];
lines = splitlines(txt)';
for i = 1:length(lines)
    line = lines{i};
    digits = isstrprop(line,'digit');
    for j = 1:length(line)
        if (~strcmp(line(j),'.') && ~digits(j))
            % disp([line(j) num2str(i) num2str(j)])
            symbols = [symbols;[i j]]; %#ok<AGROW>
        end
    end
end
for i = 1:length(lines)
    [starts,ends,matches] = regexp(lines{i},'\d+','start','end','match');
    for j = 1:length(matches)
        rows = [(i-1)*ones(1,ends(j)-starts(j)+3), i, i, (i+1)*ones(1,ends(j)-starts(j)+3)]';
        cols = [starts(j)-1:ends(j)+1, starts(j)-1, ends(j)+1, starts(j)-1:ends(j)+1]';
        neis = [rows,cols];
        if any(ismember(symbols,neis,'rows'))
            total = total + str2double(matches{j});
        end
    end
end
disp(total)
end

function part2(txt)
gears = [];
lines = splitlines(txt)';
for i = 1:length(lines)
    line = lines{i};
    for j = 1:length(line)
        if strcmp(line(j),'*')
            % disp([line(j) num2str(i) num2str(j)])
            gears = [gears;[i j]]; %#ok<AGROW>
        end
    end
end
% disp(gears)
gearnums = zeros(size(gears));
for i = 1:length(lines)
    [starts,ends,matches] = regexp(lines{i},'\d+','start','end','match');
    for j = 1:length(matches)
        rows = [(i-1)*ones(1,ends(j)-starts(j)+3), i, i, (i+1)*ones(1,ends(j)-starts(j)+3)]';
        cols = [starts(j)-1:ends(j)+1, starts(j)-1, ends(j)+1, starts(j)-1:ends(j)+1]';
        neis = [rows,cols];
        ginds = find(ismember(gears,neis,'rows'));
        for gind = ginds'
            if gearnums(gind,1)==0 % first num
                gearnums(gind,1) = str2double(matches{j});
            elseif gearnums(gind,2)==0 % second num
                gearnums(gind,2) = str2double(matches{j});
            else
                gearnums(gind,:) = NaN;
            end
        end
    end
end
% disp(gearnums)
disp(sum(prod(gearnums,2),'omitmissing'))
end