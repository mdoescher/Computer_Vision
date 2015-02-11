directory = '/Users/eyoong/Downloads/exposures/'

function[red,blue,green,exposures,files] = imageio(directory)

files = dir([directory,'*.jpg']);
numpics = length(files);
numsamplepixels=ceil(255/(numpics-1))*2;
totalpixels = size(imread([directory,files(1).name]),1)*size(imread([directory,files(1).name]),2);
interval = floor(totalpixels/numsamplepixels);
smplindices = (1:interval:totalpixels)';

expoinfo = dir([directory,'*.txt']);
txtname = strcat(directory,expoinfo(1).name);
fid=fopen(txtname);
exposures=zeros(numpics,1);

for i = 1:numpics
tmp=fgets(fid);
if tmp(2) == '/'
exposures(i)=1/str2double(tmp(3:1:length(tmp)));
else
exposures(i)=str2double(tmp);
end
end


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
