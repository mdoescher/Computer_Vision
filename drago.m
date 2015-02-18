function [ hdrmap ] = drago(hdr, bias, expo, cont)
% Drago tonemapping
% http://pages.cs.wisc.edu/~lizhang/courses/cs766-2012f/projects/hdr/Drago2003ALM.pdf

[hdr, max, average] = rgb2Yxy(hdr);

adapt = (1+bias-0.85)^5;
lumav = exp(average)/adapt;
lwmax = max/lumav;

for i = 1:size(hdr,1)
    for j = 1:size(hdr,2)
        hdr(i,j,1) = hdr(i,j,1)^(cont);
   	    hdr(i,j,1) = hdr(i,j,1) * expo;
        hdr(i,j,1) = hdr(i,j,1)/lumav;
        denom = log(2+((hdr(i,j,1)/lwmax)^(log(bias)/log(0.5)))*8);
        hdr(i,j,1) = (log(hdr(i,j,1)+1)/denom)/log10(lwmax+1);
    end
end

hdrmap=Yxy2rgb(hdr);

% gamma correction - from paper - uncomment to use
% hdrmap(:,:,1) = hdrmap(:,:,1).^(1/2.2);
% hdrmap(:,:,2) = hdrmap(:,:,2).^(1/2.2);
% hdrmap(:,:,3) = hdrmap(:,:,3).^(1/2.2);

