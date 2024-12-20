clear;clc

data = '125 17';
data = '30 71441 3784 580926 2 8122942 0 291';

parts(data, 25)
parts(data, 75)

function parts(data, numBlinks)
nums = str2double(split(data));
[B,BG] = groupcounts(nums);
freqDict = dictionary(BG,B);
splitDict = dictionary(0,{1});

for blink = 1:numBlinks
    nums = freqDict.keys';
    newFreqDict = configureDictionary('double','double');
    for num = nums
        if splitDict.isKey(num)
            vals = splitDict{num};
        else
            vals = splitNum(num);
            splitDict(num) = {vals};
        end

        for val = vals
            if newFreqDict.isKey(val)
                newFreqDict(val) = newFreqDict(val) + freqDict(num);
            else
                newFreqDict(val) = freqDict(num);
            end
        end
    end
    freqDict = newFreqDict;
end
fprintf('%d\n',sum(freqDict.values))
end

function vals = splitNum(num)
numDigits = floor(log10(num))+1;
if ~mod(numDigits,2) % even number of digits
    vals = [floor(num/10^(numDigits/2)) mod(num,10^(numDigits/2))];
else
    vals = num*2024;
end
end