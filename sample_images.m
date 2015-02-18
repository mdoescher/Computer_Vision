function[red,green,blue]=sample_images(aligned_images)
% this function selects sample points from the image to use for the camera
% response function determination



% This number of sample pixels will result in an overdetermined system for
% the least squares fitting step
numpics=length(aligned_images)
numsamplepixels=ceil(255/(numpics-1))*2*5;

% Total pixels in the image
height=size(aligned_images{1},1);
width=size(aligned_images{2},2);
totalpixels=height*width;

% Sample the images at regular intervals to grab enough samples
interval = floor(totalpixels/numsamplepixels);
smplindices = int32((interval:interval:totalpixels)');
smplindices=smplindices(1:numsamplepixels);

% Initializing some matrices to hold the samples
red=zeros(numsamplepixels,numpics);
blue=zeros(numsamplepixels,numpics);
green=zeros(numsamplepixels,numpics);

for i = 1:numpics
    image=aligned_images{i};
    rtmp=image(:,:,1);
    red(:,i)=rtmp(smplindices);
    gtmp=image(:,:,2);
    green(:,i)=gtmp(smplindices);
    btmp=image(:,:,3);
    blue(:,i)=btmp(smplindices);
end
