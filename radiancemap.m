function[hdr] = radiancemap(redresponse, greenresponse, blueresponse, weightfunc, expo, files, directory)
numfiles = length(files);
tmp1 = imread(strcat(directory,files(1).name));
weightsum = zeros(size(tmp1));
hdr = zeros(size(tmp1));
for i = 1:numfiles
image = double(imread(strcat(directory,files(i).name)));
weightedimage = weightfunc(image+1);
weightsum = weightsum + weightedimage;

pixelmap(:,:,1) = redresponse(image(:,:,1)+1) - expo(1,i);
pixelmap(:,:,2) = greenresponse(image(:,:,2)+1) - expo(1,i);
pixelmap(:,:,3) = blueresponse(image(:,:,3)+1) - expo(1,i);

hdr = hdr + (weightsum .* pixelmap);
end
               
hdr = hdr ./ weightsum;
hdr = exp(hdr);