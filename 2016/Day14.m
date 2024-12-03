clear;clc

txt = 'qzyelonm';
% txt = 'abc';

assert(contains(MD5('abc18'),'cc38887a5'))

part1(txt)

function part1(txt)
threes = cell(1,16);
% fives = cell(1,16);
chars = string(split('123456789abcdef0','')');
charmap = dictionary(chars(2:end-1),1:16);
Engine = java.security.MessageDigest.getInstance('MD5');
tic
N = 42e3;
nums = cellstr(string(0:N));
numKeys = 0;
kys = zeros(1,100);
for i = 0:N
    if ~mod(i,1000)
        fprintf('%d\n',i)
    end
    hash = [txt,nums{i+1}];
    for j = 1:2017
        hash = uint8(hash);
        hash = typecast(Engine.digest(hash), 'uint8');
        hash = sprintf('%.2x',hash);
    end
    
    three = hash(1:end-2)==hash(2:end-1) & hash(2:end-1)==hash(3:end);
    five = hash(1:end-4)==hash(2:end-3) & hash(2:end-3)==hash(3:end-2) & ...
        hash(3:end-2)==hash(4:end-1) & hash(4:end-1)==hash(5:end);
    
    for thr = find(three,1)
        threes{charmap(hash(thr))} = [threes{charmap(hash(thr))},i];
    end
    for fiv = hash(five)
        num = charmap(fiv);
        thrs = unique(threes{num});
        for thr = thrs
            if i-1000<=thr && thr<i
                numKeys = numKeys + 1;
                kys(numKeys) = thr;
                fprintf('key %d: %d (matched with %d)\n',numKeys,thr,i)
            end
        end
        threes{num} = [thrs(i-1000<thr),i];
    end
    if numKeys>=64 && i>kys(64)+1000
        break
    end
end
toc
end

function hash = MD5(data)
data = uint8(data);
Engine = java.security.MessageDigest.getInstance('MD5');
hash = typecast(Engine.digest(data), 'uint8');
hash = sprintf('%.2x', hash);
end