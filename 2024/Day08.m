clear;clc

data = char(splitlines(fileread("Day08ex.txt")));
data = char(splitlines(fileread("Day08.txt")));

parts(data,true)
parts(data,false)

function parts(data,part1)
[symbolCounts,uniqueSymbols] = groupcounts(data(:));
numPairs = sum(arrayfun(@(x)nchoosek(x,2),symbolCounts(2:end)));
if part1
    coeffs = [2 -1;-1 2];
    nodesPerPair = 2;
else
    coeffs = [50:-1:-49;-49:50]';
    nodesPerPair = 100;
end
antinodes = zeros(nodesPerPair*numPairs,2);
rowInd = 1;
for symbolInd = 2:numel(uniqueSymbols) % uniqueSymbols starts with '.'
    symbol = uniqueSymbols(symbolInd);
    [rows,cols] = find(data==symbol);
    for ind1 = 1:symbolCounts(symbolInd)-1
        for ind2 = ind1+1:symbolCounts(symbolInd)
            antinodes(rowInd:rowInd+nodesPerPair-1,:) = ...
                coeffs * [rows(ind1) cols(ind1);rows(ind2) cols(ind2)];
            rowInd = rowInd + nodesPerPair;
        end
    end
end
uniqueLocs = unique(antinodes,"rows");
disp(nnz(all(isbetween(uniqueLocs,1,size(data)),2)))
end