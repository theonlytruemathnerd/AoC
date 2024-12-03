clear;clc

txt = fileread('Day19.txt');

% txt = ['H => HO' newline ...
% 'H => OH' newline ...
% 'O => HH' newline newline ...
% 'HOHOHO'];

part1(txt);

% txt = ['H => HO' newline ...
% 'H => OH' newline ...
% 'O => HH' newline ...
% 'e => O' newline ...
% 'e => H' newline newline...
% 'HOH'];

% part2memo(txt);
% part2CYK(txt);
part2(txt)

function part1(txt)
lines = splitlines(txt);
n = length(lines)-2;
start = lines{end};
molecules = strings(1,0);
for i = 1:n
    words = split(lines{i});
    catalyst = words{1};
    products = words{3};
    numMatches = length(regexp(start,catalyst));
    for j = 1:numMatches
        molecules = [molecules,regexprep(start,catalyst,products,j)]; %#ok<AGROW>
    end
end
disp(length(unique(molecules)))
end

function part2memo(txt)
lines = splitlines(txt);
n = length(lines)-2;
final = lines{end};
backmap = configureDictionary('string','string');
for i = 1:n
    words = split(lines{i});
    backmap(words{3}) = words{1};
end
keys = backmap.keys';
[~,i] = sort(strlength(keys),'descend');
keys = keys(i);
% disp(keys(1:20)')
% memomap = configureDictionary('string','cell');
% memomap = searchcell(memomap,final,cell(1,0));
% disp(memomap('e'))
memomap = configureDictionary('string','double');
memomap = search(memomap,final,0);
disp(memomap('e'))
    function memomap = searchcell(memomap,enter,path)
        if isKey(memomap,'e')
            return
        end
        for key = keys
            numMatches = count(enter,key);
            for j = 1:numMatches
                exit = regexprep(enter,key,backmap(key),j);
                if strcmp(exit,'e')
                    memomap(exit) = {[path{:},key]};
                    disp('done')
                    return
                end
                if (isKey(memomap,exit) && length(memomap{exit})>length(path{:})+1) || ...
                        ~isKey(memomap,exit)
                    memomap(exit) = {[path{:},key]};
                    memomap = searchcell(memomap,exit,{[path{:},key]});
                end
            end
        end
    end
    function memomap = search(memomap,enter,len)
        if isKey(memomap,'e') || (contains(enter,'e') && strlength(enter)>1)
            return
        end
        for key = keys
            % exit = regexprep(enter,key,backmap(key));
            % if strcmp(exit,'e')
            %     memomap(exit) = len+1;
            %     disp('done')
            %     return
            % end
            % if (isKey(memomap,exit) && memomap(exit)>len+1) || ...
            %         ~isKey(memomap,exit)
            %     % disp([length(exit),len+1])
            %     memomap(exit) = len+1;
            %     memomap = search(memomap,exit,len+1);
            %     if isKey(memomap,'e')
            %         return
            %     end
            % end
            numMatches = count(enter,key);
            for j = 1:numMatches
                exit = regexprep(enter,key,backmap(key),j);
                if strcmp(exit,'e')
                    memomap(exit) = len+1;
                    disp('done')
                    return
                end
                if (isKey(memomap,exit) && memomap(exit)>len+1) || ...
                        ~isKey(memomap,exit)
                    % disp([length(exit),len+1])
                    memomap(exit) = len+1;
                    memomap = search(memomap,exit,len+1);
                    if isKey(memomap,'e')
                        return
                    end
                end
            end
        end
    end
end

function part2CYK(txt)
lines = splitlines(txt);
n = length(lines)-2;
start = lines{end};
foremap = configureDictionary('string','cell');
% backmap = configureDictionary('string','string');
for i = 1:n
    words = split(lines{i});
    if isKey(foremap,words{1})
        % foremap(words{1}) = [foremap(words{1}),words(3)];
        foremap{words{1}} = [foremap{words{1}},string(words{3})];
    else
        foremap(words{1}) = {string(words(3))};
    end
    % backmap(words{3}) = words{1};
end
% disp(foremap)
% disp(backmap)
keys = foremap.keys';
TERMS = ["Rn","Y","Ar"]; % since they cannot be transformed into anything else
% Convert to Chomsky normal form
% START - done since "e" does not appear on RHS
% TERM
counter = 0;
for key = keys
    % disp(key)
    prods = foremap{key};
    for i = 1:length(prods)
        product = prods(i);
        % disp(product)
        elems = regexp(product,'[A-Z][a-z]?','match');
        % disp(elems)
        [~,terms] = ismember(elems,TERMS);
        % terms = find(ismember(elems,TERMS))
        if nnz(terms) > 1 || (nnz(terms) == 1 && length(elems) > 1)
            counter = counter + 1;
            prods(i) = regexprep(product,'(Rn|Y|Ar)',['$1',num2str(counter)]);
            for term = TERMS(unique(terms(terms~=0)))
                foremap(term+counter) = {term};
            end
        end
    end
    foremap{key} = prods;
    % break
end
% disp(foremap)
% BIN
keys = foremap.keys';
counter = 0;
for key = keys
    % disp(key)
    newcell = foremap{key};
    for product = foremap{key}
        % disp(product)
        elems = regexp(product,'[A-Z][a-z]?\d*','match');
        % disp(elems) % all elems are nonterminals
        if length(elems) > 2 % more than 2 nonterminals
            % disp(product)
            % disp(elems)
            newcell = setdiff(newcell,product);
            counter = counter + 1;
            newcell = [newcell,elems(1)+"A"+counter]; %#ok<AGROW>
            foremap{key} = newcell;
            for i = 2:length(elems)-2
                counter = counter + 1;
                foremap("A"+(counter-1)) = {elems(i)+"A"+counter};
            end
            foremap("A"+counter) = {join(elems(end-1:end),"")};
            % for i = 2:length(nonterms)-1
            %     nonterm = nonterms(i)
            %     counter = counter + 1;
            %     newprod = join([elems(nonterms(i-1):nonterms(i)-1),"A"+counter],"");
            %     newcell = [newcell,newprod];
            %     % foremap("A"+counter) = {}
            % end
        end
    end
    % break
end

foremap = dictionary("e",{["HH" "HO" "OH"]} ...
    )
disp(foremap)

% DEL - done since there are no epsilons
% UNIT - done since there are no unit rules
disp(start)

chars = regexp(start,'[A-Z][a-z]?','match');
n = length(chars);
keys = foremap.keys';
values = foremap.values';
r = length(keys);
P = false(n,n,r);
% back = 
% disp(chars(1:10))
disp(chars)
for s = 1:n
    if ismember(chars{s},TERMS)
        P(1,s,startsWith(keys,chars{s})) = true;
    end
end
% disp(P)

% for l = 2:n
%     for s = 1:n-l+1
%         for p = 1:l-1



end

function part2(txt)
lines = splitlines(txt);
start = lines{end};
start = replace(start,{'Rn','Y','Ar'},{'(',',',')'});
start = regexprep(start,'[a-z]','');
start = regexprep(start,'[A-Z]','A');
steps = 0;

while ~strcmp(start,'A')
    % A -> AA
    [starts,ends] = regexp(start,'A{2,}','start','end');
    steps = steps + sum(ends-starts);
    start = regexprep(start,'A{2,}','A');
    
    % A -> A(A)
    starts = regexp(start,'A\(A\)');
    steps = steps + length(starts);
    start = regexprep(start,'A\(A\)','A');

    % A -> A(A,A)
    starts = regexp(start,'A\(A,A\)');
    steps = steps + length(starts);
    start = regexprep(start,'A\(A,A\)','A');

    % A -> A(A,A,A)
    starts = regexp(start,'A\(A,A,A\)');
    steps = steps + length(starts);
    start = regexprep(start,'A\(A,A,A\)','A');
end
disp(steps)
end