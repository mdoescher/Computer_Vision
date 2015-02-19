function[images]=align_images(input_images, depth)
% Align images using Ward's Medium Threshold bitmap (MTB) technique
% input_images is a cell array containing the images to be aligned

% grab the middle image and use this as the reference image to which the
% other images will be aligned.
n=length(input_images);
reference_image_number = int32(n / 2)
reference_image = input_images{reference_image_number};

% keep track of maximum offsets applied - for cropping
max_x=0;min_x=0;max_y=0;min_y=0;
gray_reference=rgb2gray(reference_image);

% recursive ward_MTB algorithm
for i=1:n
    i
    if (i~= reference_image_number)
    [x,y]=ward_MTB(gray_reference, rgb2gray(input_images{i}), depth);
    max_x=max(max_x,x);min_x=min(min_x,x);max_y=max(max_y,y);min_y=min(min_y,y);
   
    %translate images
    input_images{i}=imtranslate(input_images{i},[x,y],'FillValues',255);
    end
end

%crop images
width=size(reference_image,1)-abs(max_x)-abs(min_x)
height=size(reference_image,2)-abs(max_y)-abs(min_y)
for i=1:n
    input_images{i}=imcrop(input_images{i},[max_x max_y width height]);
end

%return images
images=input_images;
end % end of function

%#####################################################################

function [x,y]=ward_MTB(reference_image, image, depth)

if (depth == 0) 
    x=0;y=0;return;
end

% Gaussian filter from http://stackoverflow.com/questions/8204645/implementing-
% gaussian-blur-how-to-calculate-convolution-matrix-kernel
filter=[    0.0030    0.0133    0.0219    0.0133    0.0030
    0.0133    0.0596    0.0983    0.0596    0.0133
    0.0219    0.0983    0.1621    0.0983    0.0219
    0.0133    0.0596    0.0983    0.0596    0.0133
    0.0030    0.0133    0.0219    0.0133    0.0030];

% shrink_reference
reference_blurred=imfilter(reference_image, filter);
reference_small=imresize(reference_blurred, 0.5);

% shrink_image
image_blurred=imfilter(image, filter);
image_small=imresize(image_blurred, 0.5);

% call function with depth-1
[x,y]=ward_MTB(reference_small, image_small, depth-1);
% offsets returned are for the smaller size image
x=2*x; y=2*y;

% convert reference and image to median threshold bitmap (MTB)
height=size(image,1);
width=size(image,2);

reference_MTB=zeros(height,width);
image_MTB=zeros(height,width);

reference_median = median(reshape(reference_image, 1, []));
image_median = median(reshape(image, 1, []));
for i=1:height
    for j=1:width
        if (reference_image(i,j)>reference_median)
            reference_MTB(i,j) = 1;
        else
            reference_MTB(i,j) = 0;
        end
        if (image(i,j) > image_median)
            image_MTB(i,j) = 1;
        else
            image_MTB(i,j)=0;
        end
    end
end

% translate and determine best matching translation
min_error = height*width;
new_x=x;
new_y=y;
image_MTB=imtranslate(image_MTB,[x,y],'FillValues',255);

for i=-1:1
    for j=-1:1;
        image_MTB_test=imtranslate(image_MTB,[i,j],'FillValues',255);
        error = sum(sum(xor(reference_MTB(abs(x)+2:height-abs(x)-1,abs(y)+2:width-abs(y)-1), image_MTB_test(abs(x)+2:height-abs(x)-1,abs(y)+2:width-abs(y)-1))));
        if (error < min_error) 
            min_error=error; 
            new_x=x+i;
            new_y=y+j;
        end
    end
end

% return x and y
x=new_x; y=new_y;
end % of function


