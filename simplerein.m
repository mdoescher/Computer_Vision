function [hdrmap] = simplerein(hdr,a,saturation)
%SIMPLEREIN Summary of this function goes here
%   Detailed explanation goes here
lum = 0.2125*hdr(:,:,1)+ 0.7154*hdr(:,:,2) + 0.0721*hdr(:,:,3);
totalpix = size(hdr,1)*size(hdr,2);
lav = exp((1/totalpix)*sum(sum(log(lum+eps(0)))));
scalelum = (a/lav)* lum;
oper = scalelum ./ (scalelum+1);
hdrmap = zeros(size(hdr));
hdrmap = oper;

 for i=1:3   
     hdrmap(:,:,i) = ((hdr(:,:,i) ./ lum) .^ saturation) .* oper;
 end
end

