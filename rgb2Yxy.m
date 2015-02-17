function [ hdr, min, max, average ] = rgb2Yxy(hdr)
%RGB2XYY Summary of this function goes here
%   Detailed explanation goes here
rgb2Yxy = [0.5141364 0.3238786 0.16036376; ...
    0.265068 0.67023428 0.06409157; 0.0241188 0.1228178 0.84442666 ];
tmp = zeros(3,1);
max = 0;
min = 1000000;
sum = 0;
for i=1:size(hdr,1)
    for j=1:size(hdr,2)
        tmp(1) = 0; tmp(2)=0; tmp(3)=0;
        for k=1:3
            tmp(k) = tmp(k) + rgb2Yxy(k,1)*hdr(i,j,1);
            tmp(k) = tmp(k) + rgb2Yxy(k,2)*hdr(i,j,2);
            tmp(k) = tmp(k) + rgb2Yxy(k,3)*hdr(i,j,3);
        end
        W = tmp(1) + tmp(2) + tmp(3);
        if (W > 0)
            hdr(i,j,1) = tmp(2);
            hdr(i,j,2) = tmp(1)/W;
            hdr(i,j,3) = tmp(2)/W;
        else
            hdr(i,j,1) = 0;
            hdr(i,j,2) = 0;
            hdr(i,j,3) = 0;
        end
        if (max < hdr(i,j,1))
            max = hdr(i,j,1);
        end
        if (min > hdr(i,j,1))
            min = hdr(i,j,1);
        end
        sum = sum + log(eps(0) + hdr(i,j,1));
    end
end
average = sum/(size(hdr,1)*size(hdr,2));


