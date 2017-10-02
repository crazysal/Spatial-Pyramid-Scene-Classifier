function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (height, width)
%   dictionarySize: the number of visual words, dictionary size
% Output:

%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    height = size(wordMap, 1);
    width = size(wordMap, 2);
    his = cell(1, layerNum);
    h = [];
    
    % for layer 1 to N
    weight = zeros(3, 1);
    L = layerNum - 1;    
    weight(1) = 2^(-L);
    for i = 0:L-1
        weight(i+2) = 2^(i - L);
    end
    for i = layerNum:-1:1 
        his{i} = zeros(2^(i-1), 2^(i-1), dictionarySize);
        % finest layer histograms first
        if i == layerNum
            for j = 1:2^(i-1)
                for k = 1:2^(i-1)
                    window = wordMap(ceil((j-1)*height/(2^(i-1))+1) : ceil(j*height/(2^(i-1))), ceil((k-1)*width/(2^(i-1))+1) : ceil(k*width/(2^(i-1))));
                    his{i}(j, k, :) = histcounts(window(:), 1:(dictionarySize+1));
                end
            end
        % previous layer histo aggregates           
        else
            for j = 1:2^(i-1)
                for k = 1:2^(i-1)
                    his{i}(j, k, :) = his{i+1}(2*j-1, 2*k-1, :) + his{i+1}(2*j-1, 2*k, :) + his{i+1}(2*j, 2*k-1, :) + his{i+1}(2*j, 2*k, :);
                    his{i}(j, k, :) = his{i}(j, k, :) ./ 4;
                end        
            end
        end
    end
    
    % weighting scheme
    for i = 1:layerNum
        his{i} = his{i} .* weight(i);
    end
    
    % concatenate the vector
    for i = 1:layerNum
        for j = 1:2^(i-1)
            for k = 1:2^(i-1)
                h = [h; squeeze(his{i}(j, k, :))];
            end
        end
    end
    
    h = h / sum(h);
    assert((sum(h(:)) - 1) < 0.0001, 'h is not l1 normalized');
end