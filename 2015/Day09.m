clear;clc

txt = fileread('Day09.txt');
% txt = {'London to Dublin = 464'
% 'London to Belfast = 518'
% 'Dublin to Belfast = 141'};

disp(part(txt,'short'))
disp(part(txt,'long'))

function total = part(txt,dist)
G = graph;
for line = splitlines(txt)'
    parts = split(line);
    G = addedge(G,parts{1},parts{3},str2double(parts{5}));
end
best = Inf;
if strcmp(dist,'long')
    G.Edges.Weight = -G.Edges.Weight;
end
n = numnodes(G);
Gadj = full(adjacency(G,'weighted'));
% G = graph(ones(n)-eye(n));
sts = nchoosek(1:n,2);
for i = 1:size(sts,1)
    paths = allpaths(G,sts(i,1),sts(i,2),'MinPathLength',n-1,'MaxPathLength',n-1);
    for j = 1:length(paths)
        cost = 0;
        route = paths{j};
        for k = 1:n-1
            cost = cost + Gadj(route(k),route(k+1));
        end
        best = min(best,cost);
    end
end
total = abs(best);
end