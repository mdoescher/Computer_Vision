function [ hdrmap ] = reinhard(hdr,f,m,a,c)
% Reinhard's tonemapping algorithm from: 
%http://pages.cs.wisc.edu/~lizhang/courses/cs766-2012f/projects/hdr/Reinhard2005DRR.pdf

totalpix = size(hdr,1)*size(hdr,2);
% luminance, maximum luminance, minimum luminance, and average luminance
luminance = 0.2125*hdr(:,:,1)+ 0.7154*hdr(:,:,2) + 0.0721*hdr(:,:,3);
lmax=log(max(max(luminance)));
lmin=log(min(min(luminance)));
lav = (1/totalpix)*sum(sum(log(luminance+eps(0))));

% channel average
cred = (1/totalpix)*log(sum(sum(hdr(:,:,1))));
cgreen = (1/totalpix)*log(sum(sum(hdr(:,:,2))));
cblue = (1/totalpix)*log(sum(sum(hdr(:,:,3))));
cav = [cred cgreen cblue];

% key
k = (lmax-lav)/(lmax-lmin);

% m adjusts contrast. if contrast is set to at most zero, contrast defaults to this value.
if m <= 0
    m = 0.3 + 0.7*k^(1.4);
end
f = exp(-f); % equation 5 - f is intensity
for i = 1:size(hdr,1)
    for j = 1:size(hdr,2)
        for k = 1:3
            % color is color correction :  0<=c<=1
            local = c*hdr(i,j,k) + (1-c)*luminance(i,j);
            globe = c*cav(k) + (1-c)*lav;
            % a is light adaptation
            la = a*local + (1-a) * globe;
            hdr(i,j,k) = hdr(i,j,k) / (hdr(i,j,k) + (f*la)^m);
        end
    end
end
hdrmap = hdr;
        
