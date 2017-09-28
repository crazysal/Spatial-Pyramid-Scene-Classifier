% %Driver file to Run All other files
% % 

% % %Initial var for running files 
img = imread('../data/testy/3.jpg');
filterBank = createFilterBank(); 
%% Run Q 1.1
computeDictionary();
load('dictionary.mat');
%% Run Q1.3
[wordMap] = getVisualWords(img, filterBank, dictionary);
imagesc(wordMap)
 
%% Run Q2.1  
[dictionarySize,~] = size(dictionary);
[histo1] = getImageFeatures(wordMap, dictionarySize);
histogram(histo1);
        
%% Run Q2.2  
L = 3; 
[h] = getImageFeaturesSPM(L+1, wordMap, dictionarySize);