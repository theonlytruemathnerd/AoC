clear;clc

txt = 'To continue, please consult the code grid in the manual.  Enter the code at row 2978, column 3083.';
nums = mat2cell(str2double(extract(txt,digitsPattern)),[1 1]);
[row,col] = deal(nums{:});

part1(row,col)

function part1(row,col)
n = row+col-2;
pos = (n*(n+1))/2 + col;
num = 20151125;
for i = 2:pos
    num = mod(num*252533,33554393);
end
disp(num)
end