clc;
%clearvars;

%directory = strcat('/Users/eyoong/Downloads/exposures/'); extension='jpg';
%directory='Test/'; extension='jpg';
%directory='Car/'; extension='JPG';
directory='Construction/'; extension='JPG';

% recursive depth for image alignment - maximum of 2^depth pixel shift
depth = 5;

[files, images, log_exposure] = load_images(directory, extension);

% use small images for testing
%for i=1:length(images)
%    images{i}=imresize(images{i},0.2);
%end

aligned_images = align_images(images, depth); 
[red,green,blue]=sample_images(aligned_images);

lambda = 100;
weights=zeros(1,256);
for i=1:256
    weights(i)=weightcal(i);
end

[red_response] = solveSVD(red,log_exposure,lambda,weights);
[green_response] = solveSVD(green,log_exposure,lambda,weights);
[blue_response] = solveSVD(blue,log_exposure,lambda,weights);

[hdr]=radiancemap_with_aligned_images(red_response,green_response,blue_response,weights,log_exposure,images);

figure
% matlab native tonemapping
imshow(tonemap(hdr));


% figure
% %imshow(simplerein(hdrmap,1,1.5))
% imshow(drago(hdrmap,0.85,2,1.5))
