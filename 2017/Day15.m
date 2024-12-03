clear; clc

A = 873;
B = 583;

% A = 65;
% B = 8921;

part1(A,B)
part2(A,B)

function part1(A,B)
Amult = 16807;
Bmult = 48271;
modval = 2147483647;
total = 0;
for i = 1:4e7
    A = mod(A*Amult,modval);
    B = mod(B*Bmult,modval);
    if mod(A,2^16) == mod(B,2^16)
        total = total + 1;
    end
end
disp(total)
end

function part2(A,B)
Amult = 16807;
Bmult = 48271;
modval = 2147483647;
nPairs = 5e6;
As = zeros(1,nPairs); Ai = 1;
while Ai <= nPairs
    A = mod(A*Amult,modval);
    if mod(A,4)==0
        As(Ai) = A;
        Ai = Ai + 1;
    end
end
Bs = zeros(1,nPairs); Bi = 1;
while Bi <= nPairs
    B = mod(B*Bmult,modval);
    if mod(B,8)==0
        Bs(Bi) = B;
        Bi = Bi + 1;
    end
end
total = 0;
for i = 1:nPairs
    if mod(As(i),2^16) == mod(Bs(i),2^16)
        total = total + 1;
    end
end
disp(total)
end