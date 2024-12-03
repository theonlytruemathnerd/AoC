clear;clc

txt = ['abba[mnop]qrst[]' newline ...
    'abcd[bddb]xyyx' newline ...
    'aaaa[qwer]tyui' newline ...
    'ioxxoj[asdfgh]zxcvbn'];

txt = fileread('Day07.txt');

part1(txt);

% txt = ['aba[bab]xyz[]' newline ...
%     'xyx[xyx]xyx' newline ...
%     'aaa[kek]eke' newline ...
%     'zazbz[bzb]cdb'];

part2(txt)

function part1(txt)
total = 0;
lines = splitlines(txt)';
for line = lines
    % disp(line{:})
    % keep = false;
    % extents = regexp(line,'(\[\w*\])','tokenExtents');
    % extents = extents{1};
    % nums = double(line{:});
    % dnums = diff(nums);
    % pairs = find(dnums==0);
    % ddnums = diff(dnums);
    % for pair = pairs
    %     if pair==1 || pair==length(dnums); continue; end
    %     if ddnums(pair-1)==ddnums(pair) && ddnums(pair-1)~=0 % ABBA
    %         keep = true;
    %         for j = 1:length(extents)
    %             expair = extents{j};
    %             if expair(1)<pair && pair<expair(2)
    %                 keep = false;
    %                 break
    %             end
    %         end
    %         if ~keep; break; end
    %     end
    % end
    % if keep
    %     % disp(line{:})
    %     total = total + 1;
    % end

    extents = regexp(line,'(\[\w*\])','tokenExtents');
    [starts,tokens] = regexp(line,'(\w)(\w)\2\1','start','tokens');
    extents = extents{1}; starts = starts{1}; tokens = tokens{1};
    regkeep = false;
    if length(starts)<1; continue; end % no ABBAs
    for i = 1:length(starts)
        start = starts(i);
        lets = tokens{i};
        if ~strcmp(lets{1},lets{2}); regkeep=true; end
        for j = 1:length(extents)
            pair = extents{j};
            if pair(1)<start && start<pair(2)
                regkeep = false;
                break
            end
        end
        if ~regkeep; break; end
    end
    if regkeep
        % disp(line{:})
        total = total + 1;
    end
end
disp(total)
end

function part2(txt)
total = 0;
lines = splitlines(txt)';
N = length(lines);
for i = 1:N
    line = lines{i};
    n = length(line);
    brakets = [find(line=='[');find(line==']')];
    ABAinds = [];
    BABinds = [];
    for j = 1:n-2
        if line(j)~=line(j+1) && line(j)==line(j+2) && ~ismember(j+1,brakets)
            bab = false;
            for pair = brakets
                if pair(1)<j && j<pair(2)
                    bab = true;
                    BABinds(end+1) = j; %#ok<AGROW>
                    break
                end
            end
            if ~bab
                ABAinds(end+1) = j; %#ok<AGROW>
            end
        end
    end

    ssl = false;
    for abai = ABAinds
        for babi = BABinds
            if line(abai)==line(babi+1) && line(abai+1)==line(babi)
                ssl = true;
                break
            end
        end
        if ssl; break; end
    end
    total = total + ssl;
end
disp(total)
end