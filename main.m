clc;

%directory = strcat('/Users/eyoong/Downloads/exposures/');
directory='Test_Image/';
[r,b,g,le,files,s]=imagereader(directory);

lambda = 100;
weights=zeros(1,256);
for i=1:256
    weights(i)=weightcal(i);
end

[redres,lred] = solveSVD(r,le,lambda,weights);
[blueres,lred] = solveSVD(b,le,lambda,weights);
[greenres,lred] = solveSVD(g,le,lambda,weights);

[hdrmap]=radiancemap(redres,blueres,greenres,weights,le,files,directory);

%imshow(hdrmap);
imshow(tonemap(hdrmap));
