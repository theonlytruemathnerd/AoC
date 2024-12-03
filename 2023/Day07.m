clear;clc

txt = fileread('Day07.txt');

% txt = ['32T3K 765' newline ...
% 'T55J5 684' newline ...
% 'KK677 28' newline ...
% 'KTJJT 220' newline ...
% 'QQQJA 483'];

part1(txt)
part2(txt)

function part1(txt)
lines = splitlines(txt)';
words = split(lines);
hands = words(:,:,1);
bids = str2double(words(:,:,2));
nums = zeros(length(hands),6);
map = dictionary(["A" "K" "Q" "J" "T" "9" "8" "7" "6" "5" "4" "3" "2"],14:-1:2);
for i = 1:length(hands)
    hand = hands{i};
    for j = 1:5
        nums(i,j+1) = map(hand(j));
    end
    hand = sort(groupcounts(nums(i,2:end)'))';
    if isequal(hand, 5)
        nums(i,1) = 7;
    elseif isequal(hand, [1 4])
        nums(i,1) = 6;
    elseif isequal(hand, [2 3])
        nums(i,1) = 5;
    elseif isequal(hand, [1 1 3])
        nums(i,1) = 4;
    elseif isequal(hand, [1 2 2])
        nums(i,1) = 3;
    elseif isequal(hand, [1 1 1 2])
        nums(i,1) = 2;
    elseif isequal(hand, [1 1 1 1 1])
        nums(i,1) = 1;
    else
        error('wtf')
    end
end
[~,i] = sortrows(nums,'ascend');
bids = bids(i);
disp(sum(bids.*(1:length(bids))))
end

function part2(txt)
lines = splitlines(txt)';
words = split(lines);
hands = words(:,:,1);
bids = str2double(words(:,:,2));
nums = zeros(length(hands),6);
map = dictionary(["A" "K" "Q" "J" "T" "9" "8" "7" "6" "5" "4" "3" "2"],14:-1:2);
map("J") = 1;
for i = 1:length(hands)
    hand = hands{i};
    for j = 1:5
        nums(i,j+1) = map(hand(j));
    end
    hand = nums(i,2:end)';
    hand(hand==1) = mode(hand(hand~=1));
    hand = sort(groupcounts(hand))';
    if isequal(hand, 5)
        nums(i,1) = 7;
    elseif isequal(hand, [1 4])
        nums(i,1) = 6;
    elseif isequal(hand, [2 3])
        nums(i,1) = 5;
    elseif isequal(hand, [1 1 3])
        nums(i,1) = 4;
    elseif isequal(hand, [1 2 2])
        nums(i,1) = 3;
    elseif isequal(hand, [1 1 1 2])
        nums(i,1) = 2;
    elseif isequal(hand, [1 1 1 1 1])
        nums(i,1) = 1;
    else
        error('wtf')
    end
end
[~,i] = sortrows(nums,'ascend');
bids = bids(i);
disp(sum(bids.*(1:length(bids))))
end