function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix
% close all;
% clear;
% clc;

load('vision.mat');
load('../data/traintest.mat');

layerNum = 3;
confusion_matrix = zeros(length(mapping), length(mapping));

for i = 1:size(test_imagenames, 1)
    imgPath = sprintf('../data/%s', test_imagenames{i});
    image = im2double(imread(imgPath));
    
    wordMap = getVisualWords(image, filterBank, dictionary);
    test_features = getImageFeaturesSPM(layerNum, wordMap, size(dictionary,2));
    distances{i} = distanceToSet(test_features, train_features);
    
    fprintf('image completed %d/%d %s\n', i, length(test_imagenames), test_imagenames{i});
end

% nearest neighbor
K = 1;
accuracy = zeros(K, 1);

for k = 1:K
    for i = 1:size(test_imagenames, 1)
        [~, index] = sort(distances{i}, 'descend');
        count_class = zeros(size(mapping));
        
        for j = 1:k
            count_class(train_labels(index(j))) = count_class(train_labels(index(j))) + 1;
        end
        [~, max_index] = max(count_class);
        confusion_matrix(test_labels(i), max_index) = confusion_matrix(test_labels(i), max_index) + 1;
    end
    accuracy(k) = trace(confusion_matrix) / sum(confusion_matrix(:));
    fprintf('The accuracy is %f \n', trace(confusion_matrix) / sum(confusion_matrix(:)));
end

end