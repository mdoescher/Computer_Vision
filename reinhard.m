function [ hdrmap ] = reinhard(hdr,f,a,c)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
totalpix = size(hdr,1)*size(hdr,2);
luminance = 0.2125*hdr(:,:,1)+ 0.7154*hdr(:,:,2) + 0.0721*hdr(:,:,3);
lmax=log(max(max(luminance)));
lmin=log(min(min(luminance)));
lav = (1/totalpix)*sum(sum(log(luminance+eps(0))));
cred = (1/totalpix)*log(sum(sum(hdr(:,:,1))));
cgreen = (1/totalpix)*log(sum(sum(hdr(:,:,2))));
cblue = (1/totalpix)*log(sum(sum(hdr(:,:,3))));
cav = [cred cgreen cblue];
k = (lmax-lav)/(lmax-lmin);
m = 0.3 + 0.7*k^(1.4);
f = exp(-f);
for i = 1:size(hdr,1)
    for j = 1:size(hdr,2)
        for k = 1:3
            local = c*hdr(i,j,k) + (1-c)*luminance(i,j);
            globe = c*cav(k) + (1-c)*lav;
            la = a*local + (1-a) * globe;
            hdr(i,j,k) = hdr(i,j,k) / (hdr(i,j,k) + (f*la)^m);
        end
    end
end
hdrmap = hdr;
        
