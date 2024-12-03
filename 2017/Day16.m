clear;clc

% txt = 's1,x3/4,pe/b';
% part1(txt,5)

txt = fileread('Day16.txt');
part1(txt,16)
part2(txt,16)

function part1(txt,N)
instructs = split(txt,',')';
loop = 1:N;
nums = str2double(extract(txt,digitsPattern));
numi = 1;
for i = 1:length(instructs)
    instruct = instructs{i};
    switch instruct(1)
        case 's'
            loop = circshift(loop,nums(numi));
            numi = numi + 1;
        case 'x'
            loop([nums(numi)+1,nums(numi+1)+1]) = loop([nums(numi+1)+1,nums(numi)+1]);
            numi = numi + 2;
        case 'p'
            a = find(loop==double(instruct(2))-96);
            b = find(loop==double(instruct(4))-96);
            loop([a b]) = loop([b a]);
    end
end
% disp(loop)
disp(char(loop+96))
end

function part2(txt,N)
instructs = split(txt,',')';
loop = 1:N;
nums = str2double(extract(txt,digitsPattern));
nReps = 43;
loops = zeros(nReps,N);
for rep = 1:nReps
    numi = 1;
    for i = 1:length(instructs)
        instruct = instructs{i};
        switch instruct(1)
            case 's'
                loop = circshift(loop,nums(numi));
                numi = numi + 1;
            case 'x'
                loop([nums(numi)+1,nums(numi+1)+1]) = loop([nums(numi+1)+1,nums(numi)+1]);
                numi = numi + 2;
            case 'p'
                a = find(loop==double(instruct(2))-96);
                b = find(loop==double(instruct(4))-96);
                loop([a b]) = loop([b a]);
        end
    end
    % [lia,locb] = ismember(loop,loops,'rows');
    % if lia
        % fprintf('%d\t%d\n',locb,rep)
    % end
    loops(rep,:) = loop;
end
disp(char(loops(mod(1e9,42),:)+96))
% disp(loop)
% disp(char(loop+96))
% disp(char(loops+96))
end