clear;clc

data = split(fileread("Day05ex.txt"),char([10 10]));
data = split(fileread("Day05.txt"),char([10 10]));

part1(data)
part2(data)

function part1(data)
rules = double(split(string(splitlines(data{1})),'|'));
pages = unique(rules)';
locs = zeros(1,max(pages));
ruleRows = false(size(rules,1),numel(pages));
for i = 1:numel(pages)
    locs(pages(i)) = i;
    ruleRows(:,i) = ismember(rules(:,1),pages(i)) | ismember(rules(:,2),pages(i));
end

updates = string(splitlines(data{2}));
total = 0;
for update = updates(:)'
    updateNums = double(split(update,','))';
    indPages = locs(updateNums);
    relRules = rules(sum(ruleRows(:,indPages),2)==2,:);
    [~,Locb] = ismember(relRules,updateNums);
    if all(Locb(:,1)<Locb(:,2))
        total = total + updateNums((numel(updateNums)+1)/2);
    end
end
disp(total)
end

function part2(data)
rules = double(split(string(splitlines(data{1})),'|'));
pages = unique(rules)';
locs = zeros(1,max(pages));
ruleRows = false(size(rules,1),numel(pages));
for i = 1:numel(pages)
    locs(pages(i)) = i;
    ruleRows(:,i) = ismember(rules(:,1),pages(i)) | ismember(rules(:,2),pages(i));
end

updates = string(splitlines(data{2}));
total = 0;
for update = updates(:)'
    updateNums = double(split(update,','))';
    indPages = locs(updateNums);
    relRules = rules(sum(ruleRows(:,indPages),2)==2,:);
    [~,Locb] = ismember(relRules,updateNums);
    if ~all(Locb(:,1)<Locb(:,2))
        [B,BG] = groupcounts(relRules(:,2));
        total = total + BG(B==numel(B)/2);
    end
end
disp(total)
end