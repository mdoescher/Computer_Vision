function [ hdr ] = Yxy2rgb( hdr )
% Convert Yxy colorspace to rgb
% http://www.easyrgb.com/?X=MATH
%http://www.cs.rit.edu/~ncs/color/t_convert.html

Yxy2rgb = [2.5651 -1.1665 -0.3986; ...
    -1.0217 1.9777 0.0439; 0.0753 -0.2543 1.1892];
tmp = zeros(3,1);

for i=1:size(hdr,1)
    for j=1:size(hdr,2)
        Y = hdr(i,j,1);
        tmp(2)=hdr(i,j,2);
        tmp(3)=hdr(i,j,3);
        if (Y > eps(0) && tmp(2) > eps(0) && tmp(3) > eps(0))
            X = (tmp(2)*Y)/tmp(3);
            Z = (X/tmp(2)) - X - Y;
        else
            X = eps(0);
            Z = eps(0);
        end
        hdr(i,j,1) = X;
        hdr(i,j,2) = Y;
        hdr(i,j,3) = Z;
        tmp(1) = 0; tmp(2)=0; tmp(3)=0;
        for k=1:3
            tmp(k) = tmp(k) + Yxy2rgb(k,1)*hdr(i,j,1);
            tmp(k) = tmp(k) + Yxy2rgb(k,2)*hdr(i,j,2);
            tmp(k) = tmp(k) + Yxy2rgb(k,3)*hdr(i,j,3);
        end
        hdr(i,j,1) = tmp(1);
        hdr(i,j,2) = tmp(2);
        hdr(i,j,3) = tmp(3);
    end
end


