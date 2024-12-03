clear;clc

txt = ['swap position 4 with position 0' newline ...
    'swap letter d with letter b' newline ...
    'reverse positions 0 through 4' newline ...
    'rotate left 1 step' newline ...
    'move position 1 to position 4' newline ...
    'move position 3 to position 0' newline ...
    'rotate based on position of letter b' newline ...
    'rotate based on position of letter d'];
part1(txt,'abcde')
% part2(txt,'decab')

txt = fileread('Day21.txt');
% part1(txt,'abcdefgh')
part2(txt,'fbgdceah')

function part1(txt,pass)
for line = splitlines(txt)'
    % disp(pass)
    fprintf('%s\t%s\n',pass,line{1})
    words = split(line)';
    switch words{1}
        case 'swap'
            if strcmp(words{2},'position')
                ind1 = str2double(words{3})+1;
                ind2 = str2double(words{6})+1;
                pass([ind1 ind2]) = pass(([ind2 ind1]));
            else
                ind1 = find(pass==words{3});
                ind2 = find(pass==words{6});
                pass([ind1 ind2]) = pass(([ind2 ind1]));
            end
        case 'rotate'
            if strcmp(words{2},'right')
                pass = circshift(pass,str2double(words{3}));
            elseif strcmp(words{2},'left')
                pass = circshift(pass,-str2double(words{3}));
            else
                ind = find(pass==words{end});
                if ind>=5
                    pass = circshift(pass,ind+1);
                else
                    pass = circshift(pass,ind);
                end
            end
        case 'reverse'
            ind1 = str2double(words{3})+1;
            ind2 = str2double(words{5})+1;
            pass(ind1:ind2) = pass(ind2:-1:ind1);
        case 'move'
            ind1 = str2double(words{3})+1;
            % let = pass(ind1);
            pass = pass([1:ind1-1,ind1+1:end ind1]);
            ind2 = str2double(words{6})+1;
            pass = pass([1:ind2-1 end ind2:end-1]);
            % pass = [pass(1:ind2),let,pass(ind2+1:end)];
        otherwise
            error('wtf')
    end
end
disp(pass)
end

function part2(txt,pass)
rot = [-1 -1 2 -2 1 -3 0 4];
for line = fliplr(splitlines(txt)')
    % disp(pass)
    fprintf('%s\t%s\n',pass,line{1})
    words = split(line)';
    switch words{1}
        case 'swap'
            if strcmp(words{2},'position')
                ind1 = str2double(words{3})+1;
                ind2 = str2double(words{6})+1;
                pass([ind1 ind2]) = pass(([ind2 ind1]));
            else
                ind1 = find(pass==words{3});
                ind2 = find(pass==words{6});
                pass([ind1 ind2]) = pass(([ind2 ind1]));
            end
        case 'rotate'
            if strcmp(words{2},'right')
                pass = circshift(pass,-str2double(words{3}));
            elseif strcmp(words{2},'left')
                pass = circshift(pass,str2double(words{3}));
            else
                ind = pass==words{end};
                pass = circshift(pass,rot(ind));
            end
        case 'reverse'
            ind1 = str2double(words{3})+1;
            ind2 = str2double(words{5})+1;
            pass(ind1:ind2) = pass(ind2:-1:ind1);
        case 'move'
            ind1 = str2double(words{6})+1;
            % let = pass(ind1);
            pass = pass([1:ind1-1,ind1+1:end ind1]);
            ind2 = str2double(words{3})+1;
            pass = pass([1:ind2-1 end ind2:end-1]);
            % pass = [pass(1:ind2),let,pass(ind2+1:end)];
        otherwise
            error('wtf')
    end
end
disp(pass)
end
