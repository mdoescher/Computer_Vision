clc;

%directory = strcat('/Users/eyoong/Downloads/exposures/');

%directory='Test/';
%directory='Car/';
directory='Construction/';


[r,b,g,le,files,s]=imagereader(directory);
%[aligned_images]=align_images(files);

lambda = 100;
weights=zeros(1,256);
for i=1:256
    weights(i)=weightcal(i);
end

[redres] = solveSVD(r,le,lambda,weights);
[blueres] = solveSVD(b,le,lambda,weights);
[greenres] = solveSVD(g,le,lambda,weights);

[hdrmap]=radiancemap(redres,blueres,greenres,weights,le,files,directory);


%imshow(hdrmap);
figure
imshow(tonemap(hdrmap));

%imshow(simplerein(hdrmap,1,1.5))
%imshow(drago(hdrmap,0.5,2,1.5)) %bias=(good values =0.5-0.95 | not to exceed 0.0-1.0)
