clear;clc

txt = '..^^.';
txt = '.^^.^.^^^^';

txt = '......^.^^.....^^^^^^^^^...^.^..^^.^^^..^.^..^.^^^.^^^^..^^.^.^.....^^^^^..^..^^^..^^.^.^..^^..^^^..';

part1(txt,40)
tic
part1(txt,400000) % fuck you I can brute force it 7 seconds
toc

function part1(txt,num)
row = txt=='.'; % safe = true
total = nnz(row);
for i = 1:num-1
    % find newrow
    left = [1 row(1:end-1)];
    righ = [row(2:end) 1];
    row = ~((~left&~row&righ) | (left&~row&~righ) | (~left&row&righ) | (left&row&~righ));
    % add to total
    total = total + nnz(row);
end
disp(total)
end
