function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)
% 
img = imread('../data/testy/4.jpg');
% filterBank = createFilterBank();s
  
%Applying filter on image 
[filtsRes]= extractFilterResponses(img, filterBank);
[h,w,~] = size(filtsRes);
%Resizing filter responses from a 4d matrix to (h*w)X3f matrix 
filtsResponse = reshape(filtsRes, size(filtsRes,1)*size(filtsRes,2), size(filtsRes,3));

the_pdist_2 = pdist2(dictionary,filtsResponse);
min_pdist = min(the_pdist_2);
%get the value of dictionary
for i = 1:length(min_pdist)
    wordMap(i) = find(the_pdist_2(:,i) == min_pdist(i));
end
%reshape wordMap to shape if initial image
wordMap = reshape(wordMap, h, w);
end
