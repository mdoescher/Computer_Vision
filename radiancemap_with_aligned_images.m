function[hdr] = radiancemap_with_aligned_images(red_response, green_response, blue_response, weight_function, log_exposure, images)

hdr=zeros(size(images{1}));
n=length(images);
weight_sum=zeros(size(images{1}));


% numfiles = length(files);
% tmp1 = imread(strcat(directory,files(1).name));
% weightsum = zeros(size(tmp1));
% hdr = zeros(size(tmp1));

for i = 1:n
    image = double(images{i});
    weighted_image = weight_function(image+1);
    weight_sum = weight_sum + weighted_image;

    pixelmap(:,:,1) = red_response(image(:,:,1)+1) - log_exposure(1,i);
    pixelmap(:,:,2) = green_response(image(:,:,2)+1) - log_exposure(1,i);
    pixelmap(:,:,3) = blue_response(image(:,:,3)+1) - log_exposure(1,i);

    hdr = hdr + (weighted_image .* pixelmap);
end
               
hdr = hdr ./ weight_sum;
hdr = exp(hdr);


