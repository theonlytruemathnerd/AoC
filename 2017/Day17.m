clear;clc

skip = 3;
skip = 349;

% part1node(skip);
part1(skip)
part2(skip)
% for i = 1:10
% fprintf('%d\n',node.value)
% node = node.next;
% end

function part1node(skip)
node = LinkedList2017Day17(0);
node.next = node;
for val = 1:1000
    for i = 1:mod(skip,val)
        node = node.next;
    end
    node.insertAfter(val);
    node = node.next;
end
disp(node.next.value)
end

function part1(skip)
list = zeros(1,2018);
list(1) = 1;
active = 1;
for val = 2:2018
    for i = 1:mod(skip,val-1)
        active = list(active);
    end
    list(val) = list(active);
    list(active) = val;
    active = val;
end
disp(list(active)-1)
end

% [1,0,0,0,0,0,0,0,0,0] 1 1
% [2,1,0,0,0,0,0,0,0,0] 2 1
% [3,1,2,0,0,0,0,0,0,0] 3 3
% [3,1,4,2,0,0,0,0,0,0] 4 3
% [3,1,5,2,4,0,0,0,0,0] 5 1
% [6,1,5,2,4,3,0,0,0,0] 6 4
% [6,1,5,7,4,3,2,0,0,0] 7 6
% [6,1,5,7,4,8,2,3,0,0] 8 4
% [6,1,5,9,4,8,2,3,7,0] 9 1
% [T,1,5,9,4,8,2,3,7,6] 10->6-1 = 5
%  0,9,5,7,2,4,3,8,6,1

function part2(skip)
pos = 0;
for val = 1:50000000
    pos = mod(pos+skip,val)+1;
    % fprintf('%d\n',pos)
    if pos==1
        fprintf('%d\n',val)
    end
end
end

% 0,1,1,2,2,1,5,2,6,1
% 1,2,2,3,3,2,6,3,7,2

% 1,2,4,5,8,19,41,58,416,422,3706