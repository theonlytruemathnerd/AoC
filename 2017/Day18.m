clear;clc

% txt = ['set a 1' newline ...
% 'add a 2' newline ...
% 'mul a a' newline ...
% 'mod a 5' newline ...
% 'snd a' newline ...
% 'set a 0' newline ...
% 'rcv a' newline ...
% 'jgz a -1' newline ...
% 'set a 1' newline ...
% 'jgz a -2'];

% txt = fileread('Day18.txt');

part1
part2

function part1
a = 2^31-1;
p = 464;
for i = 1:127
    p = mod(mod(p*8505,a)*129749+12345,a);
    b = mod(p,10000);
end
fprintf('%d\t%d\n',p,b)
%                   a       b       f       i       p
% set i 31          0       0       0       31      0
% set a 1           1       0       0       31      0
% mul p 17          1       0       0       31      0
% jgz p p           1       0       0       31      0
% mul a 2           2       0       0       31      0
% add i -1          2       0       0       30      0
% jgz i -2          2^31    0       0       0       0
% add a -1          2^31-1  0       0       0       0
% set i 127         2^31-1  0       0       127     0
% set p 464         2^31-1  0       0       127     464
% mul p 8505        2^31-1  0       0       127     3946320
% mod p a           2^31-1  0       0       127     3946320
% mul p 129749      2^31-1  0       0       127     512031073680
% add p 12345       2^31-1  0       0       127     512031086025
% mod p a           2^31-1  0       0       127     929978039
% set b p           
% mod b 10000       2^31-1  8039    0       127     929978039
% snd b                     8039
% add i -1          2^31-1  8039    0       126     929978039
% jgz i -9          2^31-1  1187    0       0       1041971187
% jgz a 3
% rcv b
% jgz b -1
% set f 0           2^31-1  1187    0       0       1041971187
% set i 126         2^31-1  1187    0       126     1041971187
% rcv a                     1187
% rcv b
% set p a
% mul p -1
% add p b
% jgz p 4
% snd a
% set a b
% jgz 1 3
% snd b
% set f 1
% add i -1
% jgz i -11
% snd a
% jgz f -16
% jgz a -19
end

function part2
a = 2^31-1;
p = 464;
queue = [];
for i = 1:127
    p = mod(mod(p*8505,a)*129749+12345,a);
    b = mod(p,10000);
    queue(end+1) = b;
end

f = 1;
sent = 127;
sender = 0;
while f==1
    sender = ~sender;
    if ~sender
        sent = sent + 127;
    end
    newqueue = [];
    a = queue(1);
    f = 0;
    for i = 1:126
        b = queue(i+1);
        if b<=a % p=b-a<=0
            newqueue(end+1) = a;
            a = b;
        else    % p=b-a>0
            newqueue(end+1) = b;
            f = 1;
        end
    end
    newqueue(end+1) = a;
    queue = newqueue;
end
disp(sent)

%                   a       b       f       i       p                       a       b       f       i       p
% set i 31          0       0       0       31      0                       0       0       0       31      1
% set a 1           1       0       0       31      0                       1       0       0       31      1
% mul p 17          1       0       0       31      0                       1       0       0       31      17
% jgz p p           1       0       0       31      0                       1       0       0       31      17
% mul a 2           2       0       0       31      0                       
% add i -1          2       0       0       30      0                       
% jgz i -2          2^31    0       0       0       0                       
% add a -1          2^31-1  0       0       0       0
% set i 127         2^31-1  0       0       127     0
% set p 464         2^31-1  0       0       127     464
% mul p 8505        2^31-1  0       0       127     3946320
% mod p a           2^31-1  0       0       127     3946320
% mul p 129749      2^31-1  0       0       127     512031073680
% add p 12345       2^31-1  0       0       127     512031086025
% mod p a           2^31-1  0       0       127     929978039
% set b p           
% mod b 10000       2^31-1  8039    0       127     929978039
% snd b                     8039
% add i -1          2^31-1  8039    0       126     929978039
% jgz i -9          2^31-1  1187    0       0       1041971187
% jgz a 3                                                                   1       0       0       31      17
% rcv b
% jgz b -1
% set f 0                                                                   1       0       0       31      17
% set i 126                                                                 1       0       0       126     17
% rcv a                                                                     8039    0       0       126     17
% rcv b                                                                     349     3308    0       124     -7690
% set p a                                                                   349     3308    0       124     349
% mul p -1                                                                  349     3308    0       124     -349
% add p b                                                                   349     3308    0       124     2959
% jgz p 4                                                                   349     3308    0       124     2959
% snd a                                                                     8039    349     0       125     -7690
% set a b                                                                   349     349     0       125     -7690
% jgz 1 3
% snd b                                                                     349     3308    0       124     2959
% set f 1                                                                   8039    9873    1       126     1834
% add i -1                                                                  349     349     0       124     -7690
% jgz i -11                                                                 349     349     0       124     -7690
% snd a
% jgz f -16
% jgz a -19
end