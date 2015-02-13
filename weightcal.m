function[weight] = weightcal(pixelval)

if pixelval <= (0.5*(256+1))
weight = pixelval;
else
weight = 257 - pixelval;
end
