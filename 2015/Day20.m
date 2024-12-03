clear;clc

num = 34000000;

part1(num)
part2(num)

function part1(num)
tic
pres = zeros(1,num/10);
for n = 1:num/10
    if ~mod(n,100000)
        toc
        disp(n)
        [m,i] = max(pres(1:n));
        if m > num
            disp(i)
            break
        end
        tic
    end
    pres(n:n:end) = pres(n:n:end) + 10*n;
end
end

function part2(num)
tic
pres = zeros(1,num);
for n = 1:num/10
    if ~mod(n,100000)
        toc
        disp(n)
        bigs = pres(1:n)>=num;
        if nnz(bigs)
            disp(find(bigs,1))
            break
        end
        tic
    end
    pres(n:n:min(50*n,num)) = pres(n:n:min(50*n,num)) + 11*n;
end
end
