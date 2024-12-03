clear;clc

txt = fileread('Day01.txt');

% txt = ['1abc2' newline ...
% 'pqr3stu8vwx' newline ...
% 'a1b2c3d4e5f' newline ...
% 'treb7uchet'];

part1(txt)

% txt = ['two1nine' newline ...
% 'eightwothree' newline ...
% 'abcone2threexyz' newline ...
% 'xtwone3four' newline ...
% '4nineeightseven2' newline ...
% 'zoneight234' newline ...
% '7pqrstsixteen'];

part2(txt)

function part1(txt)
lines = splitlines(txt)';
total = 0;
for line = lines
    matches = regexp(line,'\d','match');
    matches = matches{1};
    total = total + str2double([matches{1},matches{end}]);
end
disp(total)
end

function part2(txt)
lines = splitlines(txt)';
total = 0;
words = ["one" "two" "three" "four" "five" "six" "seven" "eight" "nine"];
map = dictionary(["one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "1" "2" "3" "4" "5" "6" "7" "8" "9"],["1" "2" "3" "4" "5" "6" "7" "8" "9" "1" "2" "3" "4" "5" "6" "7" "8" "9"]);
for line = lines
    [indices,matches] = regexp(line,'\d','start','match');
    indices = indices{1};
    matches = matches{1};
    for word = words
        [winds,watches] = regexp(line,word,'start','match');
        indices = [indices,winds{1}];
        matches = [matches,watches{1}];
    end
    % matches = regexp(line,'(\d|one|two|three|four|five|six|seven|eight|nine)','tokens');
    % matches = map(matches{1});
    [~,mind] = min(indices);
    [~,maxd] = max(indices);
    % disp([line{1} ',' map(matches{mind}) ',' map(matches{maxd})])
    % disp([line{1} ',' matches{1} ',' matches{end} ',' [matches{1},matches{end}]])
    % total = total + str2double([matches{1},matches{end}]);
    total = total + double(join([map(matches{mind}) map(matches{maxd})],""));
end
disp(total)
end