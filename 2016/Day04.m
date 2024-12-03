clear;clc

txt = fileread('Day04.txt');

% txt = ['qzmt-zixmtkozy-ivhz-343[zimth]' newline ...
% 'aaaaa-bbb-z-y-x-123[abxyz]' newline ...
% 'a-b-c-d-e-f-g-h-987[abcde]' newline ...
% 'not-a-real-room-404[oarel]' newline ...
% 'totally-real-room-200[decoy]'];

part1(txt);
part2(txt);

function part1(txt)
total = 0;
lines = splitlines(txt)';
for line = lines
    letters = extract(line,lettersPattern);
    checksum = letters{end};
    letters = join(letters(1:end-1),'');
    [B,BG] = groupcounts(letters{:}');
    F = sortrows(double([B BG]),{'descend','ascend'});
    if strcmp(char(F(1:5,2)'),checksum)
        total = total + str2double(extract(line,digitsPattern));
    end
end
disp(total)
end

function part2(txt)
lines = splitlines(txt)';
for line = lines
    letters = extract(line,lettersPattern);
    checksum = letters{end};
    letters = join(letters(1:end-1),'');
    [B,BG] = groupcounts(letters{:}');
    F = sortrows(double([B BG]),{'descend','ascend'});
    if strcmp(char(F(1:5,2)'),checksum)
        nums = double(letters{:})-double('a');
        sector = str2double(extract(line,digitsPattern));
        nums = mod(nums + sector,26);
        word = char(nums+double('a'));
        if ~contains(word,"bunny") && ~contains(word,"egg") && ~contains(word,"fuzzy") && ...
                ~contains(word,"basket") && ~contains(word,"candy") && ~contains(word,'grass') && ...
                ~contains(word,"dye") && ~contains(word,"hunt") && ~contains(word,"jelly") && ...
                ~contains(word,"rabbit") && ~contains(word,"flower") && ~contains(word,"chocolate")
            fprintf('%d: %s\n',sector,word)
        end
    end
end
end