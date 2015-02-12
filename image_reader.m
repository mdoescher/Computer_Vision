function [red,blue,green,exposures,files] = image_reader(directory, filetype)
% This reads in a sequence of images from a directory and returns selected
% sample pixel values from the red, blue and green channels.  It also
% returns a matrix of exposure times for the images and a list of the files

files=dir([directory,'*.', filetype]);
number_of_pictures=length(files);

% This number of sample pixels will result in an overdetermined system for
% the least squares fitting
number_of_sample_pixels=ceil(255/(number_of_pictures-1))*2;

% Total pixels in an image
r=size(imread([directory,files(1).name]),1);
c=size(imread([directory,files(1).name]),2);
total_pixels = r*c;

% Determine which pixels to sample 
% currently by just taking samples at equal intervals
interval = floor(total_pixels/number_of_sample_pixels);
sample_indices = (1:interval:total_pixels)';
sample_indices = int32(sample_indices(1:number_of_sample_pixels));

% Eugene, I couldn't get this next section to work - you didn't include the test
% images that you were using when you pushed your work to GitHub.  I downloaded 
% some of the test images from the assignment description to play
% with, but I'm not sure we're using the same set.  I just entered the
% exposure values manually.

%expoinfo = dir([directory,'/*.txt'])
%txtname = strcat(directory,expoinfo(1).name)
%fid=fopen(txtname)
%exposures=zeros(numpics,1)

%for i = 1:numpics
%    tmp=fgets(fid);
%    if tmp(2) == '/'
%        exposures(i)=1/str2double(tmp(3:1:length(tmp)));
%    else
%        exposures(i)=str2double(tmp);
%    end
%end

% exposure time (maybe in seconds)
exposures=[13, 10, 4, 3.2, 1, 0.8, 0.3, 1/4, 1/60, 1/80, 1/320, 1/400, 1/1000]';

red   = zeros(number_of_sample_pixels, number_of_pictures);
blue  = zeros(number_of_sample_pixels, number_of_pictures);
green = zeros(number_of_sample_pixels, number_of_pictures);

%read in the images and grab the sample pixels
for i = 1:number_of_pictures
    image=imread([directory,files(i).name]);
    tmp=image(:,:,1);
    red(:,i)=tmp(sample_indices);
    tmp=image(:,:,2);
    green(:,i)=tmp(sample_indices);
    tmp=image(:,:,3);
    blue(:,i)=tmp(sample_indices);
end







