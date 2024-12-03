clear;clc

txt = fileread('Day13.txt');
% txt = ['Alice would gain 54 happiness units by sitting next to Bob.' newline ...
% 'Alice would lose 79 happiness units by sitting next to Carol.' newline ...
% 'Alice would lose 2 happiness units by sitting next to David.' newline ...
% 'Bob would gain 83 happiness units by sitting next to Alice.' newline ...
% 'Bob would lose 7 happiness units by sitting next to Carol.' newline ...
% 'Bob would lose 63 happiness units by sitting next to David.' newline ...
% 'Carol would lose 62 happiness units by sitting next to Alice.' newline ...
% 'Carol would gain 60 happiness units by sitting next to Bob.' newline ...
% 'Carol would gain 55 happiness units by sitting next to David.' newline ...
% 'David would gain 46 happiness units by sitting next to Alice.' newline ...
% 'David would lose 7 happiness units by sitting next to Bob.' newline ...
% 'David would gain 41 happiness units by sitting next to Carol.'];

disp(part(txt))
disp(part(txt,'me'))

function total = part(txt,~)
G = graph;
names = unique(regexp(txt,'(?<=^|\n)\w+','match'));
for line = splitlines(txt)'
    parts = split(line);
    mult = 2*strcmp(parts{3},'gain') - 1;
    % G = addedge(G,parts{1},strip(parts{11},'.'),mult*str2double(parts{4}));
    name1 = find(strncmp(names,parts{1},1),1);
    name2 = find(strncmp(names,parts{11},1),1);
    G = addedge(G,name1,name2,mult*str2double(parts{4}));
end
G = simplify(G,'sum');
n = numnodes(G);
if nargin==2
    for node = 1:n
        G = addedge(G,node,n+1,0);
    end
    n = n+1;
end
Gadj = full(adjacency(G,'weighted'));
cycles = allcycles(G,'MinCycleLength',n);
scores = zeros(size(cycles));
for i = 1:length(cycles)
    cycle = cycles{i};
    for j = 1:length(cycle)
        scores(i) = scores(i) + Gadj(cycle(j),cycle(mod(j,length(cycle))+1));
    end
end
total = max(scores);
end