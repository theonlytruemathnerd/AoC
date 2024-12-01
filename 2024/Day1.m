clear;clc

data = readmatrix("example.txt");
data = readmatrix("real.txt");

% Part 1
sorted = [sort(data(:,1)),sort(data(:,2))];
disp(sum(abs(diff(sorted,1,2))))


% Part 2
[L,LG] = groupcounts(data(:,1));
[R,RG] = groupcounts(data(:,2));

similarities = zeros(size(LG));
for ind = 1:numel(LG)
    if ismember(LG(ind),RG)
        similarities(ind) = L(ind) * LG(ind) * R(RG==LG(ind));
    end
end
disp(sum(similarities))