clear;clc

txt = 'hijkl';
txt = 'ihgpwlah';
txt = 'kglvqrro';
txt = 'ulqzkmiv';

txt = 'qzthpkfp';

part1(txt)
part2(txt)

function part1(txt)
Engine = java.security.MessageDigest.getInstance('MD5');

goal = 4+4i;

hash2pos = @(hash) 1+count(hash,'R')-count(hash,'L') + 1i*(1+count(hash,'D')-count(hash,'U'));
estDist =  @(pos)  abs(real(pos)-real(goal)) + abs(imag(pos)-imag(goal));
hashdist = @(hash) estDist(hash2pos(hash));

dirs = 'UDLR';
hash = txt;
stepMap = dictionary(hash,0);    % hash -> numSteps
queue = {hash hashdist(hash)}; % hash, estStepsToGoal

while ~isequal(hash2pos(hash),goal)
    % pop top of queue
    hash = queue{1,1};
    numSteps = stepMap(hash);
    queue(1,:) = [];

    for neigh = dirs(openDirs(hash,Engine))
        newhash = [hash,neigh];
        newpos = hash2pos(newhash);
        if 1<=real(newpos) && real(newpos)<=4 && ...
                1<=imag(newpos) && imag(newpos)<=4
            if ~isKey(stepMap,newhash) || numSteps+1<stepMap(newhash)
                stepMap(newhash) = numSteps+1;
                queue(end+1,:) = {newhash numSteps+estDist(newpos)}; %#ok<AGROW>
            end
        end
    end
    queue = sortrows(queue,2); % lowest estDistToGoal, lowest numSteps
end
disp(hash(isstrprop(hash,'upper')))
end

function part2(txt)
Engine = java.security.MessageDigest.getInstance('MD5');
% hash = uint8(hash);
% hash = typecast(Engine.digest(hash), 'uint8');
% hash = sprintf('%.2x',hash);

goal = 4+4i;

hash2pos = @(hash) 1+count(hash,'R')-count(hash,'L') + 1i*(1+count(hash,'D')-count(hash,'U'));
estDist =  @(pos)  abs(real(pos)-real(goal)) + abs(imag(pos)-imag(goal));
hashdist = @(hash) estDist(hash2pos(hash));

dirs = 'UDLR';
hash = txt;
stepMap = dictionary(hash,0);    % hash -> numSteps
queue = {hash hashdist(hash)}; % hash, estStepsToGoal
maxdist = 0;

while ~isempty(queue)
    % pop top of queue
    hash = queue{1,1};
    numSteps = stepMap(hash);
    queue(1,:) = [];

    for neigh = dirs(openDirs(hash,Engine))
        newhash = [hash,neigh];
        newpos = hash2pos(newhash);
        if 1<=real(newpos) && real(newpos)<=4 && 1<=imag(newpos) && imag(newpos)<=4 % in bounds
            if ~isKey(stepMap,newhash)
                stepMap(newhash) = numSteps+1;
                if hash2pos(newhash)==goal && numSteps+1>maxdist
                    maxdist = numSteps+1; % at goal, record dist
                elseif ~(hash2pos(newhash)==goal) % not at goal, add to queue
                    queue(end+1,:) = {newhash numSteps+estDist(newpos)}; %#ok<AGROW>
                end
            end
        end
    end
end
disp(maxdist)
end

function dirs = openDirs(hash,Engine)
% hash = uint8(hash);
hash = typecast(Engine.digest(uint8(hash)), 'uint8');
hash = sprintf('%.2x',hash);
dirs = ismember(hash(1:4),'bcdef');
end