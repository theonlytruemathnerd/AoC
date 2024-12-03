clear;clc

data = readmatrix("Day01ex.txt");
data = readmatrix("Day01.txt");

part1(data)
part2(data)

function part1(data)
sorted = [sort(data(:,1)),sort(data(:,2))];
disp(sum(abs(diff(sorted,1,2))))
end

function part2(data)
[L,LG] = groupcounts(data(:,1));
[R,RG] = groupcounts(data(:,2));

similarities = zeros(size(LG));
for ind = 1:numel(LG)
    if ismember(LG(ind),RG)
        similarities(ind) = L(ind) * LG(ind) * R(RG==LG(ind));
    end
end
disp(sum(similarities))
end