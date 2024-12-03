clear;clc

file = fopen('AOC2017Day12.txt', 'r');
raw_input = splitlines(fscanf(file, '%c'));

% raw_input = {
%     '0 <-> 2'
%     '1 <-> 1'
%     '2 <-> 0, 3, 4'
%     '3 <-> 2, 4'
%     '4 <-> 2, 3, 6'
%     '5 <-> 6'
%     '6 <-> 4, 5'};

% Part 1

G = graph;
for i = 0:length(raw_input)-1
    G = addnode(G, num2str(i));
end

for i = 1:length(raw_input)
    pipe = raw_input{i};
    nodes = string(split(pipe, " "));
    for j = 3:length(nodes)
        node = strip(nodes(j), ",");
        if findedge(G, num2str(i-1), node) == 0
            G = G.addedge(num2str(i-1), node);
        end
    end
end

disp(length(bfsearch(G, "0")))

% Part 2

disp(max(conncomp(G)))