clear;clc

data = split(fileread("Day05ex.txt"),char([10 10]));
data = split(fileread("Day05.txt"),char([10 10]));

parts(data)

function parts(data)
rules = double(split(string(splitlines(data{1})),'|'));
updates = string(splitlines(data{2}));

part1 = 0;
part2 = 0;
for update = updates(:)'
    updateNums = double(split(update,','))';
    [~,Locb] = ismember(rules,updateNums);
    Locb(Locb(:,1)==0,1) = -Inf;
    Locb(Locb(:,2)==0,2) = Inf;
    if all(Locb(:,1)<Locb(:,2))
        part1 = part1 + updateNums((numel(updateNums)+1)/2);
    else
        relRules = rules(all(isfinite(Locb),2),:);
        [B,BG] = groupcounts(relRules(:,2));
        part2 = part2 + BG(B==numel(B)/2);

        % Faster, but not as elegant
        % sorted = unique(relRules(:,1));
        % N = histcounts(relRules(:,1),[sorted;inf]);
        % part2 = part2 + sorted(N==(numel(sorted)/2));
    end
end
disp(part1)
disp(part2)
end