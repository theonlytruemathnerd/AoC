clear;clc

data = reshape(double(string(regexp(fileread('Day14ex.txt'),'-?\d+','match'))),4,[])';
data = reshape(double(string(regexp(fileread('Day14.txt'),'-?\d+','match'))),4,[])';

part1(data)

function part1(data)
sz = [7 11];
sz = [103 101];

data(:,1:2) = data(:,1:2) + 1; % matlab is fun
data = data(:,[2 1 4 3]); % [y x dy dx]

for second = 1:prod(sz)
    data(:,1:2) = mod(data(:,1:2)+data(:,3:4)-1,sz)+1;
    N = histcounts2(data(:,1),data(:,2),10);
    if max(N,[],'all') > 40
        disp(second)
        disp(N)
        A = false(sz);
        inds = sub2ind(sz,data(:,1),data(:,2));
        A(inds) = true;
        spy(A)
    end
    if second == 100
        mid = (sz+1)/2;
        data(any(data(:,1:2)==mid,2),:) = [];
        quads = data(:,1:2) < (sz+1)/2;
        quads = sum(quads.*[1 2],2);
        product = prod(groupcounts(quads));
        disp(product)
    end
end
end
