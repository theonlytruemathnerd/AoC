clear;clc

data = char(splitlines(fileread("Day04ex.txt")));
data = char(splitlines(fileread("Day04.txt")));

part1(data)
part2(data)

function part1(data)
xmas = "XMAS";
n = size(data,1);

% row left right
leftright = count(string(data),xmas);

% row right left
rightleft = count(string(flip(data,2)),xmas);

% col top down
topdown = count(string(data'),xmas);

% col bottomup
bottomup = count(string(flip(data',2)),xmas);

diags = 0;
for k = -n+1 : n-1
    diags = diags + count(string(diag(data,k)'),xmas);
    diags = diags + count(string(diag(rot90(data),k)'),xmas);
    diags = diags + count(string(diag(rot90(data,2),k)'),xmas);
    diags = diags + count(string(diag(rot90(data,3),k)'),xmas);
end

disp(sum(leftright+rightleft+topdown+bottomup)+diags)
end

function part2(data)
mas = "MAS";
sam = "SAM";
n = size(data,1);

startInd = @(x)(1-x).*(x<=0) + (n*x+1).*(x>0);

% disp(data)
Ainds = [];
for k = -n+1 : n-1
    % fprintf('%d: %s\n',k,diag(data,k)')
    inds = startInd(k) + (n+1)*strfind(diag(data,k)',mas|sam);
    Ainds = [Ainds inds];
end
total = 0;
for Aind = Ainds
    if isequal(sort(data([Aind-n+1 Aind+n-1])),'MS')
        total = total + 1;
    end
end
disp(total)
end