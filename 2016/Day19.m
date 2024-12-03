clear;clc

% num = 3001330;

% part 1
% 5: 3
% 6: 5
% 10: 5
% 30: 29
% 100: 73
% 1000: 977
% 10000: 3617
% 100000: 68929
% 1000000: 951425
% 3001330: 1808357
% part1(3001330)

% part 2
% 5: 2
% 6: 3
% 10: 1
% 30: 3
% 100: 19
% 1000: 271
% 10000: 3439
% 100000: 40951

% 5: 2      % 3,5,1,4
% 1,2,3,4,5
% 1,2,  4,5
% 1,2,  4
%   2,  4
%   2

% 10: 1     % 6,7,9,0,2,3,5,8,4
% 1,2,3,4,5,6,7,8,9,0
% 1,2,3,4,5,  7,8,9,0   1:6 5
% 1,2,3,4,5,    8,9,0   2:7 4.5-
% 1,2,3,4,5,    8,  0   3:9 4
% 1,2,3,4,5,    8       4:0 3.5-
% 1,  3,4,5,    8       5:2 3       8,1,3,4,5
% 1,    4,5,    8       8:3 2.5-
% 1,    4,      8       1:5 2       4,8,1
% 1,    4               4:8 1.5-    1,4
% 1                     1:4 1       1

num = 100000;
part1(num)
node1(num)
tic
% node2(num)
toc
tic
part2(num)
toc

function node1(num)
list = [2:num 1]; % pseudo-linked list
ind = 1;
while ind~=list(ind)
    list(ind) = list(list(ind));
    ind = list(ind);
end
disp(ind)
end

function node2(num)
list = [2:num 1]; % pseudo-linked list
acr = floor(num/2); % steps to across
bit = mod(num,2);
ind = 1;
while ind~=list(ind)
    % old = mod(findacr(list,ind,acr)-2,num)+1;
    old = findacr(list,ind,acr-1);
    % fprintf('%d\t%d\t%d\t%d\t%d\n',ind,acr,old,list(old),list(list(old)))
    % new = mod(old,num)+1;
    list(old) = list(list(old));
    ind = list(ind);
    bit = ~bit;
    if bit
        acr = acr-1;
    end
    % break
end

disp(ind)
end

function ind = findacr(list,ind,acr)
if acr~=0
    ind = findacr(list,list(ind),acr-1);
end
end

function part1(num)
circ = 1:num;
dist = 2;
ind = 2;
for i = 1:num-1
    circ(ind) = 0;
    if ind+dist > num
        dist = dist*2;
        fnd = find(circ([ind+1:end 1:ind-1]),2);
        ind = mod(ind+fnd(end)-1,num)+1;
    else
        ind = ind + dist;
    end
end
disp(find(circ))
end

function part2(num)
% circ = 1:num;
list = [2:num 1];
% in = true(1,2*num);
acr = floor(num/2); % steps to across
bit = mod(num,2);
ind = 1;
cunt = 0;
while ind~=list(ind)
    cunt = cunt + 1;
    if ~mod(cunt,num/10)
        fprintf('%d\n',cunt)
    end
    % find old = acr-1 steps ahead
    % set list(old) = list(list(old));
    % disp(list)
    old = ind;
    for i = 1:acr-1
        old = list(old);
    end
    % old = mod(ind+acr-2,num)+1; % first guess
    % while nnz(in(ind+1:old)) ~= acr-1
        % old = mod(old,num) + 1;
        % old = old + 1;
        % old = list(mod(old-1,num)+1);
        % if old<ind; old=old+num; end
        % old = old + find(in(old+1:end),1);
    % end
    % old = mod(old-1,num)+1;
    % while in(old)
    %     old = mod(old,num) + 1;
    % end
    % in([list(old) list(old)+num]) = false;
    % fprintf('%d: %d -> %d\n',old,list(old),list(list(old)))
    list(old) = list(list(old));
    ind = list(ind);
    bit = ~bit;
    acr = acr-bit;
    % break
end
disp(ind)
end








