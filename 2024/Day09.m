clear;clc

data = '12345';
data = '2333133121414131402';
data = fileread("Day09.txt");

part1(data)
part2(data)

function part1(data)
data = double(data)-48;
disk = NaN(1,sum(data));

pointer = 0;
for ii = 1:numel(data)
    if mod(ii,2) % file
        disk(pointer+1:pointer+data(ii)) = (ii-1)/2;
    end
    pointer = pointer + data(ii);
end

freeSpace = isnan(disk);
cumFreeSpace = cumsum(freeSpace);
remFileSpace = cumsum(~freeSpace,"reverse");
equilibrium = find(remFileSpace==cumFreeSpace,1);
numFilesToMove = nnz(freeSpace(1:equilibrium));
onlyFiles = disk(~freeSpace);
disk(freeSpace(1:equilibrium)) = onlyFiles(end:-1:end-numFilesToMove+1);
checksum = sum(disk(1:remFileSpace(1)).*(0:remFileSpace(1)-1));
fprintf('%d\n',checksum)
end

function part2(data)
data = double(data)-48;
disk = NaN(1,sum(data));

pointer = 0;
for ii = 1:numel(data)
    if mod(ii,2) % file
        disk(pointer+1:pointer+data(ii)) = (ii-1)/2;
    end
    pointer = pointer + data(ii);
end

fileSizes = data(1:2:end);
freeSpaces = data(2:2:end);
freeSpaces(freeSpaces==0) = [];
freeSpace = isnan(disk);
freeSpaceStarts = find(freeSpace(1:end-1)<freeSpace(2:end))+1;

for file = numel(fileSizes):-1:1
    space = find(freeSpaces>=fileSizes(file),1);
    if ~isempty(space) && freeSpaceStarts(space) < find(disk==file-1,1)
        disk(disk==file-1) = NaN;
        disk(freeSpaceStarts(space):freeSpaceStarts(space)+fileSizes(file)-1) = file-1;
        if freeSpaces(space) == fileSizes(file) % file completely fills space
            freeSpaces(space) = [];
            freeSpaceStarts(space) = [];
        else % file partially fills space
            freeSpaces(space) = freeSpaces(space) - fileSizes(file);
            freeSpaceStarts(space) = freeSpaceStarts(space) + fileSizes(file);
        end
    end
end
checksum = sum(disk.*(0:numel(disk)-1),"omitmissing");
fprintf('%d\n',checksum)
end