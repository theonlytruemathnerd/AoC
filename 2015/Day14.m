clear;clc

txt = ['Rudolph can fly 22 km/s for 8 seconds, but then must rest for 165 seconds.' newline ...
'Cupid can fly 8 km/s for 17 seconds, but then must rest for 114 seconds.' newline ...
'Prancer can fly 18 km/s for 6 seconds, but then must rest for 103 seconds.' newline ...
'Donner can fly 25 km/s for 6 seconds, but then must rest for 145 seconds.' newline ...
'Dasher can fly 11 km/s for 12 seconds, but then must rest for 125 seconds.' newline ...
'Comet can fly 21 km/s for 6 seconds, but then must rest for 121 seconds.' newline ...
'Blitzen can fly 18 km/s for 3 seconds, but then must rest for 50 seconds.' newline ...
'Vixen can fly 20 km/s for 4 seconds, but then must rest for 75 seconds.' newline ...
'Dancer can fly 7 km/s for 20 seconds, but then must rest for 119 seconds.'];

% txt = ['Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.' newline ...
% 'Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.'];

time = 2503;
part1(txt,time)
part2(txt,time)

function part1(txt,time)
best = 0;
for line = splitlines(txt)'
    matches = regexp(line,'\d+','match');
    matches = matches{:};
    speed = str2double(matches{1});
    dur = str2double(matches{2});
    rest = str2double(matches{3});
    dist = fly(speed,dur,rest,time);
    best = max(best,dist);
end
disp(best)
end

function dist = fly(speed,dur,rest,time)
dist = (speed*dur)*floor(time/(dur+rest));
dist = dist + speed*min(rem(time,dur+rest),dur);
end

function part2(txt,time)
lines = splitlines(txt)';
n = length(lines);
dists = zeros(n,time);
for i = 1:n
    line = lines(i);
    matches = regexp(line,'\d+','match');
    matches = matches{:};
    speed = str2double(matches{1});
    dur = str2double(matches{2});
    rest = str2double(matches{3});
    dists(i,:) = flysecond(speed,dur,rest,time);
end
scores = sum(dists==max(dists),2);
disp(max(scores))
end

function dists = flysecond(speed,dur,rest,time)
loop = dur+rest;
bursts = ceil(time/loop);
dists = zeros(1,bursts*loop);
for burst = 0:bursts-1
    dists(loop*burst+1 : loop*burst+dur) = speed*(dur*burst+1 : dur*burst+dur);
    dists(loop*burst+dur+1 : loop*(burst+1)) = dists(loop*burst+dur);
end
dists = dists(1:time);
end