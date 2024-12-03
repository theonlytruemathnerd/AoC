clear;clc

txt = ['Hit Points: 100' newline ...
'Damage: 8' newline ...
'Armor: 2'];

shop = fileread('Day21.txt');

part1(txt,shop)
part2(txt,shop)

function part1(txt,shop)
boss = str2double(extract(txt,digitsPattern))';
[weapons,armor,rings] = processShop(shop);
T = combinations(1:5,1:6,1:7,1:7);
T(T.Var3<T.Var4,:) = [];
T((T.Var3==T.Var4)&T.Var3>1,:) = [];
cheapest = Inf;
for row = 1:height(T)
    dmg = weapons(T{row,1},2) + rings(T{row,3},2) + rings(T{row,4},2);
    arm = armor(T{row,2},3) + rings(T{row,3},3) + rings(T{row,4},3);
    if play([100,dmg,arm],boss)
        cheapest = min(cheapest,weapons(T{row,1},1) + armor(T{row,2},1) + ...
            rings(T{row,3},1) + rings(T{row,4},1));
    end
end
disp(cheapest)
end

function part2(txt,shop)
boss = str2double(extract(txt,digitsPattern))';
[weapons,armor,rings] = processShop(shop);
T = combinations(1:5,1:6,1:7,1:7);
T(T.Var3<T.Var4,:) = [];
T((T.Var3==T.Var4)&T.Var3>1,:) = [];
most = 0;
for row = 1:height(T)
    dmg = weapons(T{row,1},2) + rings(T{row,3},2) + rings(T{row,4},2);
    arm = armor(T{row,2},3) + rings(T{row,3},3) + rings(T{row,4},3);
    if ~play([100,dmg,arm],boss)
        most = max(most,weapons(T{row,1},1) + armor(T{row,2},1) + ...
            rings(T{row,3},1) + rings(T{row,4},1));
    end
end
disp(most)
end

function win = play(player, boss)
while player(1)>0 && boss(1)>0
    boss(1) = boss(1) - max(player(2)-boss(3),1);
    player(1) = player(1) - max(boss(2)-player(3),1);
end
if boss(1)<=0
    win = true;
elseif player(1)<=0
    win = false;
else
    error('wtf?')
end
end

function [weapons,armor,rings] = processShop(shop)
blocks = split(shop,compose('\r\n\r\n'))';
weapons = reshape(str2double(extract(blocks{1},digitsPattern)),3,[])';
armor = [0,0,0;reshape(str2double(extract(blocks{2},digitsPattern)),3,[])'];
rings = [0,0,0,0;reshape(str2double(extract(blocks{3},digitsPattern)),4,[])'];
rings = rings(:,2:4);
end