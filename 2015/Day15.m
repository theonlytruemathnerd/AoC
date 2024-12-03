clear;clc

txt = ['Sugar: capacity 3, durability 0, flavor 0, texture -3, calories 2' newline ...
'Sprinkles: capacity -3, durability 3, flavor 0, texture 0, calories 9' newline ...
'Candy: capacity -1, durability 0, flavor 4, texture 0, calories 1' newline ...
'Chocolate: capacity 0, durability 0, flavor -2, texture 2, calories 8'];

% txt = ['Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8' newline ...
% 'Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3'];

part1(txt)
part2(txt)

% (5-by-n) * (n-by-1) = (5-by-1)

function part1ga(txt)
lines = splitlines(txt)';
n = length(lines);
A = zeros(5,n); % columns = ingredients
for i = 1:n
    line = lines(i);
    matches = regexp(line,'-?\d+','match');
    A(:,i) = cellfun(@str2double,matches{:})';
end
fun = @(x) -prod(A(1:4,:)*x' * (min(A(1:4,:)*x')>0));
% x0 = (100/n)*ones(1,n);
Aeq = ones(1,n); % 1 of each amount
beq = 100;       % 100 total
lb = zeros(1,n);
ub = 100*ones(1,n);
% [x,~] = fmincon(fun,x0,[],[],Aeq,beq,lb,ub,@intx);
[x,fval] = gamultiobj(fun,n,[],[],Aeq,beq,lb,ub,[],1:n);
disp(x)
disp(A)
disp(-fval)
% fprintf('%.f\n',prod(A(1:4,:)*round(x)'))
end

function part2ga(txt)
lines = splitlines(txt)';
n = length(lines);
A = zeros(5,n); % columns = ingredients
for i = 1:n
    line = lines(i);
    matches = regexp(line,'-?\d+','match');
    A(:,i) = cellfun(@str2double,matches{:})';
end
fun = @(x) -prod(A(1:4,:)*x' * (min(A(1:4,:)*x')>0));
% x0 = (100/n)*ones(1,n);
Aeq = [ones(1,n);A(5,:)]; % 1 of each amount
beq = [100;500];       % 100 tsp, 500 cals
lb = zeros(1,n);
ub = 100*ones(1,n);
% [x,~] = fmincon(fun,x0,[],[],Aeq,beq,lb,ub,@intx);
[x,fval] = gamultiobj(fun,n,[],[],Aeq,beq,lb,ub,[],1:n);
disp(x)
disp(A)
disp(-fval)
% fprintf('%.f\n',prod(A(1:4,:)*round(x)'))
end

function part1(txt)
lines = splitlines(txt)';
n = length(lines);
A = zeros(5,n); % columns = ingredients
for i = 1:n
    line = lines(i);
    matches = regexp(line,'-?\d+','match');
    A(:,i) = cellfun(@str2double,matches{:})';
end
best = 0;
for n1 = 0:100
    for n2 = 0:100-n1
        for n3 = 0:100-n1-n2
            n4 = 100-n1-n2-n3;
            x = [n1;n2;n3;n4];
            score = prod(A(1:4,:)*x) * (min(A(1:4,:)*x)>0);
            best = max(best,score);
        end
    end
end
disp(best)
end

function part2(txt)
lines = splitlines(txt)';
n = length(lines);
A = zeros(5,n); % columns = ingredients
for i = 1:n
    line = lines(i);
    matches = regexp(line,'-?\d+','match');
    A(:,i) = cellfun(@str2double,matches{:})';
end
best = 0;
for n1 = 0:100
    for n2 = 0:100-n1
        for n3 = 0:100-n1-n2
            n4 = 100-n1-n2-n3;
            x = [n1;n2;n3;n4];
            score = prod(A(1:4,:)*x) * (min(A(1:4,:)*x)>0) * (A(5,:)*x==500);
            best = max(best,score);
        end
    end
end
disp(best)
end