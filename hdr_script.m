directory='Test_Image/';
filetype='jpg';
%directory = '/Users/eyoong/Downloads/exposures/'

% perhaps we should move the exposure part out of the imagereader function
%exposures=[13, 10, 4, 3.2, 1, 0.8, 0.3, 1/4, 1/60, 1/80, 1/320, 1/400, 1/1000]';

[red,blue,green,exposures,files] = image_reader(directory, filetype);

Z=red;
B=log(exposures)
l=1;

[g,lE]=solveSVD(Z,B,l,@weightcal);