function [hdrmap] = simplerein(hdr,a,saturation)
% Reinhard's global tonmapping algorithm from 
% Photographic Tone Reproduction for Digital Images by Reinhard, Stark,
% Shirley, and Ferwerda

% luminance map
lum = 0.2125*hdr(:,:,1)+ 0.7154*hdr(:,:,2) + 0.0721*hdr(:,:,3);
totalpix = size(hdr,1)*size(hdr,2);

% compute average luminance as in equation 1 from the paper
lav = exp((1/totalpix)*sum(sum(log(lum+eps(0)))));

% scaling so values will be between 0 and 1
scalelum = (a/lav)* lum;
oper = scalelum ./ (scalelum+1);

% copy to hdr map
%hdrmap = zeros(size(hdr));
hdrmap = oper;

% Fattal's gradient based operator from cybertron.cg.tu-berlin.de
for i=1:3   
     hdrmap(:,:,i) = ((hdr(:,:,i) ./ lum) .^ saturation) .* oper;
end
end

