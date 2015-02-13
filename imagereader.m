function[red,blue,green,logexpo,files, smplindices] = imagereader(directory)

% read the filenames
files = dir([directory,'*.jpg']);
numpics = length(files);

%filenames=[];
%for i=1:numpics
%    filenames{1}=strcat(directory,files(i).name);
%end

% This number of sample pixels will result in an overdetermined system for the least squares fitting
numsamplepixels=ceil(255/(numpics-1))*2*5;

% Total pixels in the image
totalpixels = size(imread([directory,files(1).name]),1)*size(imread([directory,files(1).name]),2);

% Sample the images at regular intervals to grab enough samples
interval = floor(totalpixels/numsamplepixels);
smplindices = int32((interval:interval:totalpixels)');
smplindices=smplindices(1:numsamplepixels);

% Get exposure information from the .txt file
expoinfo = dir([directory,'*.txt']);
txtname = strcat(directory,expoinfo(1).name);
fid=fopen(txtname);
logexpo = zeros(totalpixels,numpics);
for i = 1:numpics
    tmp=fgets(fid);
    logexpo(:,i)=log(str2double(tmp));
end

% Initializing some matrices to hold the samples
red=zeros(numsamplepixels,numpics);
blue=zeros(numsamplepixels,numpics);
green=zeros(numsamplepixels,numpics);

for i = 1:numpics
image=imread([directory,files(i).name]);
rtmp=image(:,:,1);
red(:,i)=rtmp(smplindices);
gtmp=image(:,:,2);
green(:,i)=gtmp(smplindices);
btmp=image(:,:,3);
blue(:,i)=btmp(smplindices);
end
