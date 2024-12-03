% clear;clc

txt = fileread('Day23.txt');

% txt = ['inc a' newline ...
% 'jio a, +2' newline ...
% 'tpl a' newline ...
% 'inc a'];

part1(txt)
% COLLATZ CONJECTURE BABY

function part1(txt)
% ab = uint64([0 0]); % part1
ab = uint64([1 0]); % part2
i = 1;
lines = splitlines(txt)';
while i <= length(lines)
    line = lines{i};
    % disp([num2str(i) ',' line])
    switch line(1)
        case 'h' % hlf
            ab(strcmp(line(end),'b')+1) = ab(strcmp(line(end),'b')+1)/2;
            i = i + 1;
        case 't' % trp
            ab(strcmp(line(end),'b')+1) = ab(strcmp(line(end),'b')+1)*3;
            i = i + 1;
        case 'i' % inc
            ab(strcmp(line(end),'b')+1) = ab(strcmp(line(end),'b')+1)+1;
            i = i + 1;
        case 'j' % jmp, jie, jio
            inc = str2double(extract(line,digitsPattern));
            inc = inc*(2*contains(line,'+')-1);
            if strcmp(line(1:3),'jie')
                jmp = ~mod(ab(strcmp(line(5),'b')+1),2);
            elseif strcmp(line(1:3),'jio')
                jmp = ab(strcmp(line(5),'b')+1)==1;
            else
                jmp = true;
            end
            if jmp
                i = i + inc;
            else
                i = i + 1;
            end
    end
end
disp(ab)
end
