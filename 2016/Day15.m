clear;clc

% Disc #1 has 17 positions; at time=0, it is at position 5.
% Disc #2 has 19 positions; at time=0, it is at position 8.
% Disc #3 has 7 positions; at time=0, it is at position 1.
% Disc #4 has 13 positions; at time=0, it is at position 7.
% Disc #5 has 5 positions; at time=0, it is at position 1.
% Disc #6 has 3 positions; at time=0, it is at position 0.

% Disc #1 has 5 positions; at time=0, it is at position 4.
% Disc #2 has 2 positions; at time=0, it is at position 1.

part1
part2

function part1
% Chinese remainder theorem
% t = a1 mod n1
% t = a2 mod n2
% m1n1 + m2n2 = 1 (m1,m2 from extended Euclidean algorithm)
% t = a1m2n2 + a2m1n1

% t1 = mod(4+1,5) % drop at 0 mod 5
% t2 = mod(1+2,2) % drop at 1 mod 2
% a1 = 0; n1 = 5;
% a2 = 1; n2 = 2;
% [m1,m2] = EEA(n1,n2);
% t = a1*m2*n2 + a2*m1*n1;
% disp(t)

% t1 = mod(-5-1,17) % drop at 11 mod 17
% t2 = mod(-8-2,19) % drop at  9 mod 19
% t3 = mod(-1-3,7)  % drop at  3 mod 7
% t4 = mod(-7-4,13) % drop at  2 mod 13
% t5 = mod(-1-5,5)  % drop at  4 mod 5
% t6 = mod(-0-6,3)  % drop at  0 mod 3
a = [ 5  8 1  7 1 0];
n = [17 19 7 13 5 3];
a = mod(-a-(1:length(a)),n);
m = zeros(1,length(a));
y = zeros(1,length(a));
N = prod(n);
for i = 1:length(a)
    m(i) = N/n(i);
    y(i) = mod(EEA(m(i),n(i)),n(i));
end
t = mod(sum(a.*m.*y),N);
disp(t)
end

function part2
a = [ 5  8 1  7 1 0  0];
n = [17 19 7 13 5 3 11];
a = mod(-a-(1:length(a)),n);
m = zeros(1,length(a));
y = zeros(1,length(a));
N = prod(n);
for i = 1:length(a)
    m(i) = N/n(i);
    y(i) = mod(EEA(m(i),n(i)),n(i));
end
t = mod(sum(a.*m.*y),N);
disp(t)
end

function [m1,m2] = EEA(n1,n2)
q = [0;0];
r = [n1;n2];
s = [1;0];
t = [0;1];
while r(end)~=0
    q(end+1) = floor(r(end-1)/r(end)); %#ok<AGROW>
    r(end+1) = r(end-1)-q(end)*r(end); %#ok<AGROW>
    s(end+1) = s(end-1)-q(end)*s(end); %#ok<AGROW>
    t(end+1) = t(end-1)-q(end)*t(end); %#ok<AGROW>
end
m1 = s(end-1);
m2 = t(end-1);
end