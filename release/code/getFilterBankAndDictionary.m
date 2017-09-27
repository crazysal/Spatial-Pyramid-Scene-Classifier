function [filterBank, dictionary] = getFilterBankAndDictionary(impath)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

filterBank  = createFilterBank();
K=100;%number of clusters
alpha=70; %for sampling apha pixels from image    
    for ii=1:length(impath)    
        img = imread(impath{ii});        
        [h,w,z] = size(img(:,:,:));
        if z == 1
            img = cat(3, img, img, img);
        end 
        img = RGB2Lab(img);
        %creating row vector of size (alpha) filled with random values from h -> w
        index = randperm(h*w,alpha);
        % get the subscript value from the indices of the above random pixel values sampled at alpha
        [P,Q] = ind2sub([h w], index); 
        % storing the random pixels 
        patch_of_img(:,:,:) = img(P, Q, :);
        %running our image filters on the matrix of random pixels & saving
        [filtered_patch(:,:,:,ii)] = extractFilterResponses(patch_of_img,filterBank); 
    end
    
%Resizing filter responses from a 4d matrix to (h*w)X3f matrix 
patch = reshape(filtered_patch, size(filtered_patch,1)* size(filtered_patch,2) * size(filtered_patch,4), size(filtered_patch,3));
[~,dictionary]=kmeans(patch,K,'EmptyAction','drop');
end


 