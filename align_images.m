%function[]=align_images(files)
% Align images using Ward's Medium Threshold bitmap (MTB) technique

%files is a data structure containing the filenames of a sequence of
%images

directory='Test_Image/';
files = dir([directory,'*.jpg']);

n = length(files);
image=imread([directory,files(1).name]);

%gray =image;
gray=rgb2gray(image);

filter=[    0.0030    0.0133    0.0219    0.0133    0.0030
    0.0133    0.0596    0.0983    0.0596    0.0133
    0.0219    0.0983    0.1621    0.0983    0.0219
    0.0133    0.0596    0.0983    0.0596    0.0133
    0.0030    0.0133    0.0219    0.0133    0.0030];
%filter is from http://stackoverflow.com/questions/8204645/implementing-
%gaussian-blur-how-to-calculate-convolution-matrix-kernel

gray_blurred=imfilter(gray,filter);
image_half_size=imresize(gray_blurred,0.5);

imshow(image_half_size)

m=median(reshape(image_half_size, 1,[]))

height=size(image_half_size,1);
width=size(image_half_size,2);
X=zeros(height,width);

for i=1:height
    for j=1:width
        if image_half_size(i,j)>m
            X(i,j)=1;
        else
            X(i,j)=0;
        end
    end
end


image2=imread([directory,files(2).name]);
gray2=rgb2gray(image2);
gray_blurred2=imfilter(gray2,filter);
image_half_size2=imresize(gray_blurred2,0.5);
m=median(reshape(image_half_size2, 1,[]))

Y=zeros(height,width);
for i=1:height
    for j=1:width
        if image_half_size2(i,j)>m
            Y(i,j)=1;
        else
            Y(i,j)=0;
        end
    end
end

Z=xor(X,Y);
sum(sum(Z))
Y=imtranslate(Y,[1, 0]);
Z=xor(X,Y);
sum(sum(Z))



