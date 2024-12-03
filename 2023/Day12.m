clear;clc

txt = ['???.### 1,1,3' newline ...
    '.??..??...?##. 1,1,3' newline ...
    '?#?#?#?#?#?#?#? 1,3,1,6' newline ...
    '????.#...#... 4,1,1' newline ...
    '????.######..#####. 1,6,5' newline ...
    '?###???????? 3,2,1'];

txt = fileread('Day12.txt');

part1(txt)
part2(txt)

function part1(txt)
total = 0;
lines = splitlines(txt)';
N = length(lines);
for ii = 1:N
    line = lines{ii};
    str = strip(extractBefore(line,whitespaceBoundary),'.');
    nums = str2double(extract(line,digitsPattern))';
    nNums = length(nums);
    nCols = sum(nums)+nNums;
    state = zeros(1,nCols);
    state(1) = 1; % copies
    numCols = false(1,nCols);
    for i = 1:nNums
        numCols((sum(nums(1:i-1))+i):(sum(nums(1:i))+i-1)) = true;
    end
    for c = str
        % cols are responsible for pushing
        newState = zeros(1,nCols);
        % first col
        if state(1)~=0 && (c=='?' || c=='.')
            newState(1) = 1; % A -> A
            % newState{1} = [1,1]; % A -> A
        end

        for col = 1:nCols-1
            if numCols(col) && (c=='#' || c=='?')
                newState(col+1) = newState(col+1) + state(col);
            elseif ~numCols(col) && (c=='.' || c=='?')
                newState(col) = newState(col) + state(col);
                newState(col+1) = newState(col+1) + state(col);
            end
        end

        % move last col
        if state(end)~=0 && (c=='?' || c=='.')
            newState(end) = newState(end) + state(end);
        end

        state = newState;
    end
    total = total + state(end);
end
disp(total)
end

function part2(txt)
total = 0;
lines = splitlines(txt)';
n = length(lines);
for ii = 1:n
    line = lines{ii};
    str = extractBefore(line,whitespaceBoundary);
    str = repmat([str '?'],1,5);
    str = strip(str(1:end-1),'.');
    nums = str2double(extract(line,digitsPattern))';
    nums = repmat(nums,1,5);
    nNums = length(nums);
    nCols = sum(nums)+nNums;
    state = zeros(1,nCols);
    state(1) = 1; % copies
    numCols = false(1,nCols);
    for i = 1:nNums
        numCols((sum(nums(1:i-1))+i):(sum(nums(1:i))+i-1)) = true;
    end
    for c = str
        % cols are responsible for pushing
        newState = zeros(1,nCols);
        % first col
        if state(1)~=0 && (c=='?' || c=='.')
            newState(1) = 1; % A -> A
            % newState{1} = [1,1]; % A -> A
        end

        for col = 1:nCols-1
            if numCols(col) && (c=='#' || c=='?')
                newState(col+1) = newState(col+1) + state(col);
            elseif ~numCols(col) && (c=='.' || c=='?')
                newState(col) = newState(col) + state(col);
                newState(col+1) = newState(col+1) + state(col);
            end
        end

        % move last col
        if state(end)~=0 && (c=='?' || c=='.')
            newState(end) = newState(end) + state(end);
        end

        state = newState;
    end
    total = total + state(end);
end
fprintf('%d\n',total)
end
