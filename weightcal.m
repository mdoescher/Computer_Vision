function[weight] = weightcal(pixelval)

if pixelval <= (0.5*(256+1))
weight = pixelval - 1;
else
weight = 256 - pixelval;
end
