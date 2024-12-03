clear;clc

txt = 'wtnhxymk';
% txt = 'abc';

MD5('abc3231929');

% part1(txt)
part2(txt)

function part1(txt)
sz = 1e7;
nums = spalloc(1,sz,sz/1e5);
parfor num = 1:sz
    hash = MD5([txt,num2str(num)]);
    if strcmp(hash(1:5),'00000')
        nums(num) = double(hash(6));
        disp([num2str(num) ',' hash(6)])
    end
end
chars = char(full(nums(find(nums)))); %#ok<FNDSB>
password = chars(1:8);
disp(password)
end

function part2(txt)
sz = 5e7;
sixs = spalloc(1,sz,sz/1e5);
svns = spalloc(1,sz,sz/1e5);
parfor num = 1:sz
    hash = MD5([txt,num2str(num)]);
    if strcmp(hash(1:5),'00000')
        sixs(num) = double(hash(6));
        svns(num) = double(hash(7));
        disp([num2str(num) ',' hash(6) ',' hash(7)])
    end
end
inds = full(sixs(find(sixs))); %#ok<FNDSB>
svns = full(svns(find(svns))); %#ok<FNDSB>
for i = 1:8
    password(i) = svns(find(inds==i+47,1)); %#ok<AGROW>
end
disp(char(password))
end

function hash = MD5(data)
data = uint8(data);
Engine = java.security.MessageDigest.getInstance('MD5');
Engine.update(typecast(data(:), 'uint8'));
hash = typecast(Engine.digest, 'uint8');
hash = sprintf('%.2x', hash);
end