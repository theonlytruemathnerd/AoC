clear;clc

% containers = [20 15 10 5 5];
% part1(containers,25)
% part2(containers,25)

containers = [50 44 11 49 42 46 18 32 26 40 21 7 18 43 10 47 36 24 22 40];
part1(containers,150)
part2(containers,150)

function part1(containers,liters)
ascend = sort(containers);
descend = fliplr(ascend);
kmin = find(cumsum(descend)>=liters,1);
kmax = find(cumsum(ascend)>liters,1)-1;
total = 0;
for k = kmin:kmax
    combos = nchoosek(ascend,k);
    sums = sum(combos,2);
    total = total + nnz(sums==liters);
end
disp(total)
end

function part2(containers,liters)
ascend = sort(containers);
descend = fliplr(ascend);
kmin = find(cumsum(descend)>=liters,1);
combos = nchoosek(ascend,kmin);
sums = sum(combos,2);
total = nnz(sums==liters);
disp(total)
end