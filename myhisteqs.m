function [im_new,cdfnorm, im_new_reshaped] = myhisteqs(im)
%MYHISTEQ Your own computation of histogram equalization
%   im_new - is the output image with equalized histogram
%   cdfnorm - is the normalized cumulative distribution function that is the
%   mapping from input to output image
%   im_new_reshaped = is the same as im_new, with difference in computation
%   (saves one loop).

%first compute the histogram of the image
h = imhist(im);

for i=1:size(h)
    cdf(i) = sum(h(1:i));
end
%normalize cdf
cdfnorm = round(((cdf -min(cdf))/(size(im, 1)*size(im, 2) - min(cdf)))*255);


im_new = im;
for i=1:size(im,1)
    for j=1:size(im,2)
        im_new(i,j) = cdfnorm(im(i, j) + 1);
    end
end

end

