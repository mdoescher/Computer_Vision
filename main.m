directory = strcat('/Users/eyoong/Downloads/exposures/');

[r,b,g,le,files]=imagereader(directory);

lambda = 1;
weights=[];
for i=1:256
weights(i)=weightcal(i);
end

[redres,lred] = solveSVD(r,le,lambda,weights);
[greenres,lred] = solveSVD(g,le,lambda,weights);
[blueres,lred] = solveSVD(b,le,lambda,weights);

[hdrmap]=radiancemap(redres,greenres,blueres,weights,le,files,directory);

imshow(tonemap(hdrmap));
