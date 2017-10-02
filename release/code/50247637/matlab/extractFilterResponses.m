function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses
[x,y,z] = size(img);
desired_z_len = length(filterBank)*3;
%add code to handle greyscale images  
filterR = zeros(x,y,desired_z_len );

    if (size(img, 3) == 1)
        img = cat(3, img, img, img);
    end
img = im2double(img);    
img = RGB2Lab(img);
    for i = 1 : size(filterBank)
        filterR = cat(3, filterR, imfilter(img, filterBank{i}, 'replicate', 'same', 'conv'));
    end
filterResponses = filterR(:,:,61:120);
end

 
 