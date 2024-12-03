clear;clc

txt = ['Hit Points: 58' newline ...
'Damage: 9'];

% player = Player(10,250,13,8);
% player = player.PlayerTurn(4); %poison
% player = player.BossTurn;
% player = player.PlayerTurn(1); %magicmissile
% player = player.BossTurn;
% disp(player.ManaSpent)

% player = Player(10,250,14,8);
% player = player.PlayerTurn(5); %recharge
% player = player.BossTurn;
% player = player.PlayerTurn(3); %shield
% player = player.BossTurn;
% player = player.PlayerTurn(2); %drain
% player = player.BossTurn;
% player = player.PlayerTurn(4); %poison
% player = player.BossTurn;
% player = player.PlayerTurn(1); %magicmissile
% player = player.BossTurn;
% disp(player.ManaSpent)

player = Player(50,500,58,9);

part1(player,false)
part1(player,true)

function part1(player,hard)
matrix = 0;
states = player;
minMana = Inf;
costs = [53 73 113 173 229];
while true
    matrix = [repmat(matrix,5,1),repelem(1:5,length(states))'];
    states = repmat(states,5,1);
    % disregard states that would go above minMana
    tooExpensive = ([states.ManaSpent] + costs(matrix(:,end))) > minMana;
    matrix(tooExpensive,:) = [];
    states(tooExpensive) = [];

    nStates = length(states);
    died = false(1,nStates);
    won = false(1,nStates);
    for i = 1:nStates
        [states(i),died(i),won(i)] = ...
            playRound(states(i),matrix(i,end),hard);
    end
    matrix(died,:) = [];
    states(died) = [];
    won(died) = [];
    if isempty(states)
        break
    end
    if nnz(won)
        [m,~] = min([states(won).ManaSpent]);
        % winners = find(won);
        % disp(matrix(winners(i),:))
        minMana = min(minMana,m);
    end
    if minMana <= states(1).ManaSpent
        % impossible to get a lower mana cost
        disp('done')
        break
    end
    matrix(won,:) = [];
    states(won) = [];
    if isfinite(minMana)
        tooExpensive = [states.ManaSpent] > minMana;
        matrix(tooExpensive,:) = [];
        states(tooExpensive) = [];
    end
    % disp(matrix)
    disp([size(matrix),minMana,states(1).ManaSpent])
end
disp(minMana)
end

function [state,died,won] = playRound(state,spell,hard)
state = state.PlayerTurn(spell,hard);
died = state.HP <= 0;
state = state.BossTurn;
won = state.BossHP <= 0;
end