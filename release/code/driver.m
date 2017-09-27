% %Driver file to Run All other files
% % 
% % %Initial var for running files 
img = imread('../data/testy/1.jpg');
filterBank = createFilterBank();
% % %imshow(img_1); 
% % 
% % %% Run Q 1.1
% % filtered_img_montage = extractFilterResponses(img, filterBank); 
% % 
% % %% Run Q 1.2
% % %trainTestData = load('../data/traintest.mat');
% % % 
% % % t=trainTestData.test_imagenames;
% % %     for ii = 1:size(t)
% % %         img_name_char{ii} = char(strcat('../data/',t(ii)));
% % %     end 
% % % % dictionary_ans = getFilterBankAndDictionary(img_name_char);      
% % % [filterBank, dictionary] = getFilterBankAndDictionary(img_name_char);
computeDictionary();
load("dictionary.mat");
%% Run Q1.3
[wordMap] = getVisualWords(img, filterBank, dictionary);
imagesc(wordMap)
 
%% Run Q2.1  
dictionarySize = size(dictionary);
[histo1] = getImageFeatures(wordMap, dictionarySize);
        