function[files, images, log_exposure] = load_images(directory, extension)
% This function reads in a directory containing a series of images for HDR
% processing.  It returns the filenames as a dir structure and the images 
% as a cell arrayIt also collects information from a .txt file regarding
% exposure time and returns the log exposure time

% read the filenames
files = dir([directory, '*.', extension]);

% read the images into a cell array
number_of_pictures = length(files);
for i=1:number_of_pictures
    images{i}=imread([directory, files(i).name]);
end

% Get the total number of pixels
total_pixels = size(imread([directory,files(1).name]),1)*size(imread([directory,files(1).name]),2);

% Get log_exposure information from the .txt file
% log_exposure is a matrix with the exposure time for every pixel in each
% image -- each column of this array represents one image
exposure_info = dir([directory,'*.txt']);
file_name = strcat(directory,exposure_info(1).name);
fid=fopen(file_name);
log_exposure = zeros(total_pixels,number_of_pictures);
for i = 1:number_of_pictures
    tmp=fgets(fid);
    log_exposure(:,i)=log(str2double(tmp));
end
