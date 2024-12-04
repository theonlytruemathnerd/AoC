clear;clc

data = char(splitlines(fileread("Day04ex.txt")));
data = char(splitlines(fileread("Day04.txt")));

part1(data)
part2(data)

function part1(data)
xmas = "XMAS";
samx = "SAMX";
n = size(data,1);

rows = sum(count(string(data),xmas) + count(string(data),samx));
cols = sum(count(string(data'),xmas) + count(string(data'),samx));

diags = 0;
dataRot = rot90(data);
for k = -n+1 : n-1
    diags = diags + count(string(diag(data,k)'),xmas) + count(string(diag(data,k)'),samx);
    diags = diags + count(string(diag(dataRot,k)'),xmas) + count(string(diag(dataRot,k)'),samx);
end

disp(rows+cols+diags)
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
    Ainds = [Ainds startInd(k) + (n+1)*strfind(diag(data,k)',mas)];
    Ainds = [Ainds startInd(k) + (n+1)*strfind(diag(data,k)',sam)];
end
total = 0;
for Aind = Ainds
    if isequal(data([Aind-n+1 Aind+n-1]),'MS') || isequal(data([Aind-n+1 Aind+n-1]),'SM')
        total = total + 1;
    end
end
disp(total)
end