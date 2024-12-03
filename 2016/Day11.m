clear;clc
 
% # of steps to bring i objects up one floor: 2*i-3
% estimated number of steps to end:
% [sum(n=1..3)(4-n)*(2*i-3)], i = # of objs on nth floor
 
% state = [1,2,1,3,1]; % E,G1,M1,G2,M2
% state = [1,1,1,1,2,1,2,3,3,3,3]; % E,G1,M1,G2,M2,G3,M3,G4,M4,G5,M5
state = [1,1,1,1,1,1,1,1,2,1,2,3,3,3,3];
 
expSteps = @(state) sum(max(1,2*sum(state(2:end)<=(1:3)',2)-3)) + max(state(1)-min(state(2:end)),0);
state = [state,0,expSteps(state),1,0]; % add steps, expSteps, identifier, and previous
 
states = state;
queue = state;
 
tic
n = length(state)-5;
best = inf;
counter = 0;
while ~isempty(queue)
    counter = counter + 1;
    [queue,states] = updateState(queue,states);
    queue(sum(queue(:,n+2:n+3),2)>=best,:) = [];
    done = all(states(:,1:n+1)==4,2);
    if states(done,n+2)<best
        best = min(states(done,n+2));
    end
end
toc
disp(best)
 
findpath(states)
 
function [queue,states] = updateState(queue,states)
n = size(queue,2)-5; % number of objects
map = dictionary(0:n,[0 1 2*(2:n)-3]);
expSteps = @(state) sum(map(sum(state(2:n+1)<=(1:3)',2))) + max(state(1)-min(state(2:n+1)),0);
state = queue(1,:); % take first state in queue
queue(1,:) = [];
currObjs = state(2:n+1)==state(1); % objs on same floor as elevator
% try to move two objects up
added = false;
if state(1)~=4 && nnz(currObjs)>=2
    % if not on top floor and at least two objs
    combos = nchoosek(find(currObjs),2)';
    for combo = combos
        newState = state;
        newState([1,combo'+1,n+2]) = newState([1,combo'+1,n+2])+1;
        newState(2:n+1) = reshape(sortrows(reshape(newState(2:n+1),2,[])')',1,[]);
        newState(n+3) = expSteps(newState);
        newState(n+5) = newState(n+4); % set previous to state(identifier)
        newState(n+4) = max(states(:,n+4)) + 1;
        if isValidState(newState)
            [queue,states,added] = addStates(queue,states,newState,added);
        end
    end
end
 
% try to move one object up
if state(1)~=4 && nnz(currObjs)>=1 && ~added
    % if not on top floor, at least one obj, and can't move 2 items up
    for obj = find(currObjs)
        newState = state;
        newState([1,obj+1,n+2]) = newState([1,obj+1,n+2])+1;
        newState(2:n+1) = reshape(sortrows(reshape(newState(2:n+1),2,[])')',1,[]);
        newState(n+3) = expSteps(newState);
        newState(n+5) = newState(n+4); % set previous to state(identifier)
        newState(n+4) = max(states(:,n+4)) + 1;
        if isValidState(newState)
            [queue,states] = addStates(queue,states,newState);
        end
    end
end
% try to move one object down
botItemFloor = min(state(2:n+1));
added = false;
if state(1)>botItemFloor && nnz(currObjs)>=1
    % if not on bottom floor with items and at least one obj
    for obj = find(currObjs)
        newState = state;
        newState([1,obj+1]) = newState([1,obj+1])-1;
        newState(n+2) = newState(n+2)+1;
        newState(2:n+1) = reshape(sortrows(reshape(newState(2:n+1),2,[])')',1,[]);
        newState(n+3) = expSteps(newState);
        newState(n+5) = newState(n+4); % set previous to state(identifier)
        newState(n+4) = max(states(:,n+4)) + 1;
        if isValidState(newState)
            [queue,states] = addStates(queue,states,newState);
        end
    end
end
% try to move two objects down
if state(1)>botItemFloor && nnz(currObjs)>=2 && ~added
    % if not on bottom floor with items, at least two objs, and can't only move 1 item down
    combos = nchoosek(find(currObjs),2)';
    for combo = combos
        newState = state;
        newState([1,combo'+1]) = newState([1,combo'+1])-1;
        newState(n+2) = newState(n+2)+1;
        newState(2:n+1) = reshape(sortrows(reshape(newState(2:n+1),2,[])')',1,[]);
        newState(n+3) = expSteps(newState);
        newState(n+5) = newState(n+4); % set previous to state(identifier)
        newState(n+4) = max(states(:,n+4)) + 1;
        if isValidState(newState)
            [queue,states] = addStates(queue,states,newState);
        end
    end
end
queue = sortrows(queue,[n+3,n+2,1]); % expSteps, steps taken, elevator floor
end
 
function TF = isValidState(state)
% whole state
n = length(state)-5; % number of objects
for M = 3:2:n+1
    if any(state(M)==state(2:2:n)) && state(M)~=state(M-1)
        % microchip on same floor as a generator without its own generator
        TF = false;
        return
    end
end
TF = true;
end
 
function [queue,states,added] = addStates(queue,states,newState,added)
n = length(newState)-5; % number of objects
% pos = ismember(states(:,1:n+1),newState(1:n+1),'rows');
pos = isExistingState(states,newState); % takes 60% the time of ismember
if ~any(pos) % new config
    states(end+1,:) = newState;
    queue(end+1,:) = newState;
    added = true;
elseif newState(n+2) < states(pos,n+2) % existing config, fewer steps
    states(pos,[n+2,n+3,n+5]) = newState([n+2,n+3,n+5]);
    % states that had their previous as the old config get their
    %   * steps updated to newState steps + 1
    %   * states that point to them need their steps updated as well
    ids = states(pos,n+4); % ids that need to be updated
    while ~isempty(ids)
        id = ids(1);
        ids(1) = [];
        pos = states(:,n+5)==id; % states whose previous is id
        states(pos,n+2) = states(states(:,n+4)==id,n+2)+1; % update steps
        ids = [ids;states(pos,n+4)]; %#ok<AGROW>
    end
end
end
 
function pos = isExistingState(states,newState)
% whole states, true where newState(1:n+1) is in states
n = length(newState)-5; % number of objects
pos = false(size(states,1),1);
for i = find(states(:,1)==newState(1))'
    pos(i) = isequal(states(i,2:n+1),newState(2:n+1));
end
end
 
function findpath(states)
n = size(states,2)-5; % number of objects
state = states(states(:,n+3)==0,:);
id = state(n+4);
while id~=0
    if n==4
        fprintf('%d | %d %d | %d %d | %d\n',state(1),state(2),state(3),state(4),state(5),state(6))
    elseif n==10
        fprintf('%d | %d %d | %d %d | %d %d | %d %d | %d %d | %d\n',state(1),state(2),state(3),...
            state(4),state(5),state(6),state(7),state(8),state(9),state(10),state(11),state(12))
    elseif n==14
        fprintf('%d | %d %d | %d %d | %d %d | %d %d | %d %d | %d %d | %d %d | %d\n',state(1),...
            state(2),state(3),state(4),state(5),state(6),state(7),state(8),state(9),state(10),...
            state(11),state(12),state(13),state(14),state(15),state(16))
    end
    id = state(n+5);
    state = states(states(:,n+4)==id,:);
end
end