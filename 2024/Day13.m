clear;clc

data = reshape(double(string(extract(fileread('Day13ex.txt'),digitsPattern))),6,[])';
data = reshape(double(string(extract(fileread('Day13.txt'),digitsPattern))),6,[])';

parts(data,false)
parts(data,true)

function parts(data,part2)
totalTokens = 0;

for ii = 1:size(data,1)
    A = reshape(data(ii,1:4),2,2);
    b = data(ii,5:6)';
    if part2
        b = b + 10000000000000;
    end
    X = A\b;
    if all(abs(round(X)-X)<.01)
        totalTokens = totalTokens + 3*X(1) + X(2);
    end
end
fprintf('%d\n',totalTokens)
end