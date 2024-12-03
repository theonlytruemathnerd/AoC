clear;clc

txt = compose('cpy 41 a\ninc a\ninc a\ndec a\njnz a 2\ndec a');

txt = compose('cpy 1 a\ncpy 1 b\ncpy 26 d\njnz c 2\njnz 1 5\ncpy 7 c\ninc d\ndec c\njnz c -2\ncpy a c\ninc a\ndec b\njnz b -2\ncpy c b\ndec d\njnz d -6\ncpy 16 c\ncpy 17 d\ninc a\ndec d\njnz d -2\ndec c\njnz c -5');

partfib(1)
partfib(2)

function part1(txt)
regs = [0 0 0 0];
lines = splitlines(txt)';
N = length(lines);
i = 1;
while i<=N
    if i==10; disp(regs); end
    if i==17; disp(regs); end
    words = split(lines{i})';
    switch words{1}
        case 'cpy'
            regs(double(words{3})-double('a')+1) = getVal(words{2},regs);
            i = i + 1;
        case 'inc'
            regs(double(words{2})-double('a')+1) = regs(double(words{2})-double('a')+1) + 1;
            i = i + 1;
        case 'dec'
            regs(double(words{2})-double('a')+1) = regs(double(words{2})-double('a')+1) - 1;
            i = i + 1;
        case 'jnz'
            if getVal(words{2},regs) ~= 0
                i = i + getVal(words{3},regs);
            else
                i = i + 1;
            end
    end
    % disp(regs)
end
disp(regs)
end

function partfib(part)
% after running line 10 'cpy a c' the first time, regs read
% part 1: [1 1 1 26]
% part 2: [1 1 1 33]
% after running line 18 'cpy 17 d' the first time, regs read
% part 1: [ 317811  196418 16 17]   % [fib(28) fib(27) 16 17]
% part 2: [9227465 5802887 16 17]   % [fib(35) fib(34) 16 17]
% after finishing, regs read
% part 1: [ 318083  196418 0 0]     % [fib(28)+16*17 fib(27) 0 0]
% part 2: [9227737 5802887 0 0]     % [fib(35)+16*17 fib(34) 0 0]
if part==1
    disp(fibonacci(28)+16*17)
elseif part==2
    disp(fibonacci(35)+16*17)
end
end

function val = getVal(word,regs)
if isstrprop(word,'alpha')
    val = regs(double(word)-double('a')+1);
else
    val = str2double(word);
end
end