clear;clc

txt = fileread('Day12.txt');
% txt = '[1,"red",5]';

disp(part1(txt))
disp(part2(txt))

timeit(@() parse_json(txt), 2) % about .33s for full input

function total = part1(txt)
total = 0;
for match = regexp(txt,'(-?\d+)','match')
    total = total + str2double(match);
end
end

function total = part2(txt)
data = parse_json(txt);
total = recurse(data);
end

function total = recurse(data)
total = 0;
if isstruct(data)
    for field = fieldnames(data)'
        if ischar(data.(field{1})) && strcmp(data.(field{1}),'red')
            total = 0;
            return
        end
        total = total + recurse(data.(field{1}));
    end
elseif iscell(data)
    for elem = data
        total = total + recurse(elem{:});
    end
elseif isnumeric(data)
    total = data;
end
end

function [data,json] = parse_json(json)
% [DATA JSON] = PARSE_JSON(json)
% This function parses a JSON string and returns a cell array with the
% parsed data. JSON objects are converted to structures and JSON arrays are
% converted to cell arrays.
% Simplified from:
% https://www.mathworks.com/matlabcentral/fileexchange/20565-json-parser
data = cell(0,1);
while ~isempty(json)
    [value, json] = parse_value(json);
    data{end+1} = value; %#ok<AGROW>
end
end

function [value, json] = parse_value(json)
value = [];
if ~isempty(json)
    switch json(1)
        case '"'
            [value, json] = parse_string(json(2:end));
        case '{'
            [value, json] = parse_object(json(2:end));
        case '['
            [value, json] = parse_array(json(2:end));
        otherwise
            [value, json] = parse_number(json);
    end
end
end

function [data, json] = parse_array(json)
data = cell(0,1);
while ~isempty(json)
    if strcmp(json(1),']') % array is closed
        json(1) = [];
        return
    end
    [value, json] = parse_value(json);
    data{end+1} = value; %#ok<AGROW>
    if strcmp(json(1),',') % another element coming up
        json(1) = [];
    end
end
end

function [data, json] = parse_object(json)
data = [];
while ~isempty(json)
    id = json(1);
    json(1) = [];
    switch id
        case '"' % Start a name/value pair
            [name, value, json] = parse_name_value(json);
            data.(name) = value;
        case '}' % End of object, so exit the function
            return
    end
end
end

function [name, value, json] = parse_name_value(json)
name = [];
value = [];
if ~isempty(json)
    [name, json] = parse_string(json);
    json(1) = []; % :
    [value, json] = parse_value(json);
end
end

function [string, json] = parse_string(json)
quote = find(json=='"', 1);
string = json(1:quote-1);
json(1:quote) = [];
end

function [num, json] = parse_number(json)
% nonnum = find(~ismember(json,'-0123456789'),1);
nonnum = regexp(json,'[^0-9-]','once');
num = str2double(json(1:nonnum-1));
json(1:nonnum-1) = [];
end