clear;clc

txt = ['p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>' newline ...
'p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>'];

txt = fileread('Day20.txt');

part1(txt)

txt = ['p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>' newline ...
'p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>' newline ...
'p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>' newline ...
'p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>'];

part2(txt)

function part1(txt)
nums = reshape(str2double(extract(txt,optionalPattern('-')+digitsPattern)),9,[])';
pva = [sum(abs(nums(:,1:3)),2),sum(abs(nums(:,4:6)),2),sum(abs(nums(:,7:9)),2)];
[~,I] = sortrows(pva,[3 2 1]);
disp(I(1)-1)
end

function xt = part2(txt)
nums = reshape(str2double(extract(txt,optionalPattern('-')+digitsPattern)),9,[])';
N = size(nums,1);
xt = inf(N);
for p1 = 1:N-1
    for p2 = p1+1:N
        x1 = [nums(p1,7)/2, nums(p1,7)/2+nums(p1,4), nums(p1,1)]; % [a0/2, a0/2+v0, p0]
        x2 = [nums(p2,7)/2, nums(p2,7)/2+nums(p2,4), nums(p2,1)]; % [a0/2, a0/2+v0, p0]
        xd = x1-x2;
        if xd(1)==0
            if xd(2)==0
                continue
            end
            xt(p1,p2) = -xd(3)/xd(2);
            xt(p2,p1) = -xd(3)/xd(2);
            continue
        end
        d = xd(2)^2 - 4*xd(1)*xd(3);
        % disp([p1,p2,d;xd])
        if d<0
            continue
        elseif d==0
            xt(p1,p2) = -xd(2)/(2*xd(1));
            xt(p2,p1) = xt(p1,p2);
        elseif d>0
            xt(p1,p2) = (-xd(2)+sqrt(d))/(2*xd(1));
            xt(p2,p1) = (-xd(2)-sqrt(d))/(2*xd(1));
        end
    end
end
xt

end