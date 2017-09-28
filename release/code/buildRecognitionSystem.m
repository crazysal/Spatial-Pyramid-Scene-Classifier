function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	
    L = 3;
    train_features = zeros(size(dictionary, 2) * (4^L - 1) / 3, length(train_imagenames));
	% create train_features
    for i = 1:length(train_imagenames)
        imgPath = sprintf('../data/%s', train_imagenames{i});
        img = im2double(imread(imgPath));
    	wordMap = getVisualWords(img, filterBank, dictionary);
        train_features(:, i) = getImageFeaturesSPM(L, wordMap, size(dictionary, 2));
        fprintf('image completed %d/%d %s\n', i, length(train_imagenames), imgPath);
    end
    train_labels = train_labels';
    save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end