function [ hdr ] = Yxy2rgb( hdr )
%YXY2RGB Summary of this function goes here
%   Detailed explanation goes here
Yxy2RGB = [2.5651 -1.1665 -0.3986; ...
    -1.0217 1.9777 0.0439; 0.0753 -0.2543 1.1892];
result = zeros(3,1);

for i=1:size(hdr,1)
    for j=1:size(hdr,2)
        Y = hdr(i,j,1);
        result(2)=hdr(i,j,2);
        result(3)=hdr(i,j,3);
        if (Y > eps(0) && result(2) > eps(0) && result(3) > eps(0))
            X = (result(2)*Y)/result(3);
            Z = (X/result(2)) - X - Y;
        else
            X = eps(0);
            Z = eps(0);
        end
        hdr(i,j,1) = X;
        hdr(i,j,2) = Y;
        hdr(i,j,3) = Z;
        result(1) = 0; result(2)=0; result(3)=0;
        for k=1:3
            result(k) = result(k) + Yxy2RGB(k,1)*hdr(i,j,1);
            result(k) = result(k) + Yxy2RGB(k,2)*hdr(i,j,2);
            result(k) = result(k) + Yxy2RGB(k,3)*hdr(i,j,3);
        end
        hdr(i,j,1) = result(1);
        hdr(i,j,2) = result(2);
        hdr(i,j,3) = result(3);
    end
end


