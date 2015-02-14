function [ hdrMap ] = drago(hdr, b, ldmax)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
hdr = rgb2xyz(hdr);
lwmax = max(max(hdr(:,:,2)));
scal = (ldmax*0.01)/(log10(lwmax+1));
hdr(:,:,1) = scal.*(log(hdr(:,:,1) + 1)./log(2 + 8*((hdr(:,:,1)./lwmax).^(log(b)/log(0.5)))));
hdr(:,:,2) = scal.*(log(hdr(:,:,2) + 1)./log(2 + 8*((hdr(:,:,2)./lwmax).^(log(b)/log(0.5)))));
hdr(:,:,3) = scal.*(log(hdr(:,:,3) + 1)./log(2 + 8*((hdr(:,:,3)./lwmax).^(log(b)/log(0.5)))));

hdrMap=xyz2rgb(hdr);
hdrMap=hdrMap.^(1/2.2);
end

