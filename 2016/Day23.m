clear;clc

txt = ['cpy 2 a' newline ...
'tgl a' newline ...
'tgl a' newline ...
'tgl a' newline ...
'cpy 1 a' newline ...
'dec a' newline ...
'dec a'];

txt = fileread('Day23.txt');

% factorial(a)+81*93

part1(txt)

function part1(txt)
regs = [7 0 0 0];
lines = splitlines(txt)';
N = length(lines);
i = 1;
while i<=N
    words = split(lines{i})';
    switch words{1}
        case 'cpy'
            if ~isstrprop(words{3},'alpha'); i=i+1; continue; end
            regs(double(words{3})-double('a')+1) = getVal(words{2},regs);
            i = i + 1;
        case 'inc'
            if ~isstrprop(words{2},'alpha'); i=i+1; continue; end
            regs(double(words{2})-double('a')+1) = regs(double(words{2})-double('a')+1) + 1;
            i = i + 1;
        case 'dec'
            if ~isstrprop(words{2},'alpha'); i=i+1; continue; end
            regs(double(words{2})-double('a')+1) = regs(double(words{2})-double('a')+1) - 1;
            i = i + 1;
        case 'jnz'
            if getVal(words{2},regs) ~= 0
                i = i + getVal(words{3},regs);
            else
                i = i + 1;
            end
        case 'tgl'
            val = getVal(words{2},regs);
            if i+val>N; i=i+1; continue; end
            line = lines{i+val};
            switch line(1:3)
                case 'inc'
                    lines{i+val} = ['dec' line(4:end)];
                case 'dec'
                    lines{i+val} = ['inc' line(4:end)];
                case 'jnz'
                    lines{i+val} = ['cpy' line(4:end)];
                case 'cpy'
                    lines{i+val} = ['jnz' line(4:end)];
                case 'tgl'
                    lines{i+val} = ['inc' line(4:end)];
            end
            i = i + 1;
        otherwise
            error('oopsies')
    end
    % disp(regs)
end
disp(regs)
end

function val = getVal(word,regs)
if isstrprop(word,'alpha')
    val = regs(double(word)-double('a')+1);
else
    val = str2double(word);
end
end