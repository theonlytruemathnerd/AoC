clear;clc

data = char(splitlines(fileread("Day10ex.txt")));
data = char(splitlines(fileread("Day10.txt")));

part1(data)
part2(data)

function part1(data)
data = paddata(data,size(data)+2,FillValue='.',Side='both');
nineInds = find(data=='9')';
numNines = numel(nineInds);
accNines = false([size(data) numNines]);
offset = (0:numNines-1)*numel(data);
offset3 = reshape(offset,1,1,[]);
accNines(nineInds+offset) = true;
nums = '8':-1:'0';
for num = nums
    % find the number of 9s for each number, iterating downward
    [rows,cols] = find(data==num);
    lookRows = [rows-1, rows, rows, rows+1]; % up, left, right, down
    lookCols = [cols, cols-1, cols+1, cols];
    lookInds = sub2ind(size(data),lookRows,lookCols);
    lookReach9 = accNines(lookInds+offset3); % can the lookInds reach each 9?
    lookNextNum = data(lookInds)==char(num+1); % are the lookInds the next number?
    lookNextReach9 = lookReach9 & lookNextNum; % do the lookInds obey both?
    nextReach9 = any(lookNextReach9,2); % do the 
    numInds = sub2ind(size(data),rows,cols);
    accNines(numInds+offset3) = nextReach9;
end
disp(nnz(nextReach9))
end

function part2(data)
data = paddata(data,size(data)+2,FillValue='.',Side='both');
paths = zeros(size(data));
paths(data=='9') = 1;
nums = '8':-1:'0';
for num = nums
    % find the number of paths to 9 for each number, iterating downward
    [rows,cols] = find(data==num);
    lookRows = [rows-1, rows, rows, rows+1]; % up, left, right, down
    lookCols = [cols, cols-1, cols+1, cols];
    lookInds = sub2ind(size(data),lookRows,lookCols);
    lookNumPaths = paths(lookInds);
    lookNextNum = data(lookInds)==char(num+1);
    lookNextNumPaths = lookNumPaths.*lookNextNum;
    nextNumPaths = sum(lookNextNumPaths,2);
    numInds = sub2ind(size(data),rows,cols);
    paths(numInds) = nextNumPaths;
end
disp(sum(nextNumPaths))
end