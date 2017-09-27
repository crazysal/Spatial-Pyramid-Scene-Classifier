function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

   %montage(cat(4,x234{:}),'Size', [4 5 ]);

% TODO Implement your code here

%final = "final_filtered_";
[x,y,z] = size(img);
desired_z_len = length(filterBank)*3;
%add code to handle greyscale images  
final_filter = zeros(x,y,desired_z_len );
img = im2double(img);
[l,a,b] = RGB2Lab(img); 
    for ii = 1: numel(filterBank)-2
        convolutedl = imfilter(l, filterBank{ii}, 'replicate');
        final_filter(:,:,ii*3) = reshape(convolutedl,x,y,[]);          
        convoluteda = imfilter(a, filterBank{ii}, 'replicate');
        final_filter(:,:,ii*3+1) = reshape(convoluteda,x,y,[]);          
        convolutedb = imfilter(b, filterBank{ii}, 'replicate');
        final_filter(:,:,ii*3+2) = reshape(convolutedb,x,y, []);          
    end    
filterResponses  = final_filter; 
end
 
 