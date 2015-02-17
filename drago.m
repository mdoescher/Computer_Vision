function [ hdrmap ] = drago(hdr, bias, expo,cont)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[hdr, min, max, average] = rgb2Yxy(hdr);

adapt = 1;
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

%hdr(:,:,1) = scal.*(log(hdr(:,:,1) + 1)./log(2 + 8*((hdr(:,:,1)./lwmax).^(log(bias)/log(0.5)))));


hdrmap=Yxy2rgb(hdr);
% hdrmap(:,:,1) = hdrmap(:,:,1).^(1/2.2);
% hdrmap(:,:,2) = hdrmap(:,:,2).^(1/2.2);
% hdrmap(:,:,3) = hdrmap(:,:,3).^(1/2.2);

