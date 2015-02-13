function[red,blue,green,logexpo,files] = imagereader(directory)

files = dir([directory,'*.jpg']);
numpics = length(files);
filenames=[];
for i=1:numpics
filenames{1}=strcat(directory,files(i).name);
end
numsamplepixels=ceil(255/(numpics-1))*2;
totalpixels = size(imread([directory,files(1).name]),1)*size(imread([directory,files(1).name]),2);
interval = floor(totalpixels/numsamplepixels);
smplindices = (interval:interval:totalpixels)';

expoinfo = dir([directory,'*.txt']);
txtname = strcat(directory,expoinfo(1).name);
fid=fopen(txtname);
logexpo = zeros(totalpixels,numpics);

for i = 1:numpics
tmp=fgets(fid);
if tmp(2) == '/'
exposures=1/str2double(tmp(3:1:length(tmp)));
else
exposures=str2double(tmp);
end
logexpo(:,i)=log(exposures);
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
