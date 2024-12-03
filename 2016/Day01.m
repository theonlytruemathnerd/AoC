clear;clc

txt = 'L1, L3, L5, L3, R1, L4, L5, R1, R3, L5, R1, L3, L2, L3, R2, R2, L3, L3, R1, L2, R1, L3, L2, R4, R2, L5, R4, L5, R4, L2, R3, L2, R4, R1, L5, L4, R1, L2, R3, R1, R2, L4, R1, L2, R3, L2, L3, R5, L192, R4, L5, R4, L1, R4, L4, R2, L5, R45, L2, L5, R4, R5, L3, R5, R77, R2, R5, L5, R1, R4, L4, L4, R2, L4, L1, R191, R1, L1, L2, L2, L4, L3, R1, L3, R1, R5, R3, L1, L4, L2, L3, L1, L1, R5, L4, R1, L3, R1, L2, R1, R4, R5, L4, L2, R4, R5, L1, L2, R3, L4, R2, R2, R3, L2, L3, L5, R3, R1, L4, L3, R4, R2, R2, R2, R1, L4, R4, R1, R2, R1, L2, L2, R4, L1, L2, R3, L3, L5, L4, R4, L3, L1, L5, L3, L5, R5, L5, L4, L2, R1, L2, L4, L2, L4, L1, R4, R4, R5, R1, L4, R2, L4, L2, L4, R2, L4, L1, L2, R1, R4, R3, R2, R2, R5, L1, L2';
% txt = 'R5, L5, R5, R3';
% txt = 'R2, R2, R2';
% txt = 'R2, L3';

part1(txt)

% txt = 'R8, R4, R4, R8';

part2(txt)

function part1(txt)
pos = 0;
dir = 1i;
steps = string(split(txt,', ')');
for step = steps
    if startsWith(step,"R")
        dir = dir * -1i;
    else
        dir = dir * 1i;
    end
    pos = pos + dir*str2double(extract(step,digitsPattern));
end
disp(abs(real(pos) + imag(pos)))
end

function part2(txt)
pos = 0;
dir = 1i;
steps = string(split(txt,', ')');
poss = pos;
for step = steps
    if startsWith(step,"R")
        dir = dir * -1i;
    else
        dir = dir * 1i;
    end
    num = str2double(extract(step,digitsPattern));
    newpos = pos + dir*str2double(extract(step,digitsPattern));
    if isreal(dir)
        poss(end+1:end+num) = (min(real([pos+dir newpos])):max(real([pos+dir newpos])))+1i*imag(pos);
    else
        poss(end+1:end+num) = real(pos)+1i*(min(imag([pos+dir newpos])):max(imag([pos+dir newpos])));
    end
    pos = pos + dir*str2double(extract(step,digitsPattern));
    [m,f] = mode(poss);
    if f > 1
        break
    end
end
disp(abs(real(m) + imag(m)))
end