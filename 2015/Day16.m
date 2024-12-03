clear;clc

txt = fileread('Day16.txt');
goal = ['children: 3' newline ...
'cats: 7' newline ...
'samoyeds: 2' newline ...
'pomeranians: 3' newline ...
'akitas: 0' newline ...
'vizslas: 0' newline ...
'goldfish: 5' newline ...
'trees: 3' newline ...
'cars: 2' newline ...
'perfumes: 1'];

part1(txt,goal)
part2(txt,goal)

function part1(txt,goal)
goalmap = configureDictionary('string','double');
for line = splitlines(goal)'
    words = split(line);
    [compound,number] = deal(words{:});
    goalmap(compound(1:end-1)) = str2double(number);
end
lines = splitlines(txt)';
for sue = 1:length(lines)
    matches = regexp(lines(sue),'(\w+|\d+)','match');
    matches = matches{:};
    if (goalmap(matches{3}) ~= str2double(matches{4})) || ...
            (goalmap(matches{5}) ~= str2double(matches{6})) || ...
            (goalmap(matches{7}) ~= str2double(matches{8}))
        continue
    end
    disp(sue)
end
end

function part2(txt,goal)
goalmap = configureDictionary('string','double');
for line = splitlines(goal)'
    words = split(line);
    [compound,number] = deal(words{:});
    goalmap(compound(1:end-1)) = str2double(number);
end
lines = splitlines(txt)';
for sue = 1:length(lines)
    matches = regexp(lines(sue),'(\w+|\d+)','match');
    matches = matches{:};
    compounds = matches([3,5,7]);
    numbers = matches([4,6,8]);
    good = true;
    for j = 1:3
        if ismember(compounds{j},["cats","trees"]) && ...
                goalmap(compounds{j}) >= str2double(numbers{j})
            good = false;
        elseif ismember(compounds{j},["pomeranians","goldfish"]) && ...
                goalmap(compounds{j}) <= str2double(numbers{j})
            good = false;
        elseif ismember(compounds{j},["children","samoyeds","akitas","vizslas","cars","perfumes"]) && ...
                goalmap(compounds{j}) ~= str2double(numbers{j})
            good = false;
        end
        if ~good; break; end
    end
    if ~good; continue; end
    disp(sue)
end
end