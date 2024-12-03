clear;clc

data = readmatrix("Day02ex.txt");
data = readmatrix("Day02.txt",NumHeaderLines=0);

% Part 1
numSafe = 0;
for ii = 1:size(data,1)
    row = data(ii,~isnan(data(ii,:)));
    if isValid(row)
        numSafe = numSafe + 1;
    end
end
disp(numSafe)

% Part 2
numSafe = 0;
for ii = 1:size(data,1)
    row = data(ii,~isnan(data(ii,:)));
    safe = false;
    for jj = 1:numel(row)
        newRow = row([1:jj-1 jj+1:end]);
        if isValid(newRow)
            numSafe = numSafe + 1;
            break
        end
    end
end
disp(numSafe)

function bool = isValid(row)
diffs = diff(row);
bool = (all(diffs<0) || all(diffs>0)) && all(abs(diffs)<=3);
end