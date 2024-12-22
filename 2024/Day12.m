clear;clc

data = char(splitlines(fileread("Day12ex.txt")));
data = char(splitlines(fileread("Day12.txt")));

parts(data,false)
parts(data,true)

function parts(data,part2)
[nr,~] = size(data);
vertSame = diff(data,1,1) == 0;
[vr,vc] = find(vertSame);
vs = vr + (vc-1)*nr;
vt = vs + 1;

horzSame = diff(data,1,2) == 0;
[hr,hc] = find(horzSame);
hs = hr + (hc-1)*nr;
ht = hs + nr;

G = graph([vs;hs],[vt;ht]);
[bins,binsizes] = conncomp(G,OutputForm='cell');

warning('off','MATLAB:polyshape:repairedBySimplify');
totalPrice = 0;
for bind = 1:numel(binsizes)
    area = binsizes(bind);
    if part2
        perimeter = findNumSides(bins{bind},nr);
    else
        perimeter = findPerimeter(subgraph(G,bins{bind}));
    end
    totalPrice = totalPrice + area*perimeter;
end
warning('on','MATLAB:polyshape:repairedBySimplify');

disp(totalPrice)
end

function perimeter = findPerimeter(G)
deg = degree(G);
perimeter = 4*numnodes(G)-sum(deg);
end

function numSides = findNumSides(inds,nr)
x = ceil(inds/nr);
y = mod(inds-1,nr)+1;

X = [x;x;x+1;x+1;NaN(1,numel(inds))];
X = reshape(X,[],1);
Y = [y;y+1;y+1;y;NaN(1,numel(inds))];
Y = reshape(Y,[],1);
pgon = polyshape(X,Y);
numSides = numsides(pgon);
end