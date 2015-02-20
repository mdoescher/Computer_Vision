clc;
clearvars;

%specify directory and extension type
directory='CS_Hallway/'; extension='JPG';

% recursive depth for image alignment - maximum of 2^(depth-1) pixel shift
depth = 0;

%load images
[files, images, log_exposure] = load_images(directory, extension);

%align the images
aligned_images = align_images(images, depth); 

% generate HDR image
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

% tonemapping and output
figure
% matlab native tonemapping
imshow(tonemap(hdr, 'AdjustLightness', [0.1 1], 'AdjustSaturation', 2.5));
title(['Native Matlab Tonemapping']);
%imwrite(tonemap(hdr, 'AdjustSaturation', 1),'matlab_tonemap.png');

figure;
imshow(simplerein(hdr,1,1));
title('Simple Reinhard Tonemapping');
%imwrite(simplerein(hdr,1.2,1.5),'simple_reinhard.png');

figure;
imshow(reinhard(hdr, -15, 0.1, 3, 0)); %f brightness; m contrast 0-1; adaptation close to 1? ; color c=0.
title('Reinhard Tonemapping');
%imwrite(reinhard(hdr, 0.6, 0.1, 1.2, 0),'reinhard.png'); % f m a c

figure
imshow(drago(hdr, 0.85, 1.5, 1.5, 1.2)); % hdr, bias, expo, cont, gamma
title('Drago Tonemapping')
%imwrite(drago(hdr, 0.85, 1.5, 1.5, 1.2),'dragon.png');