% Read an image
inputImage = imread('liftingbody.png');

% Choose how much you wish to scale the image
scale = [4, 4];

% Number of rows and columns in the old image
[r, c] = size(inputImage);

% Number of rows and columns in the new image
rn = (scale(1) * r);
cn = (scale(2) * c);

% Create the new image as a matrix filled with zeroes.
newImage = zeros(rn,cn, class(inputImage));

for i=1:rn
    % Finds the row of the current pixel in the old image.
    y = ((i-1)*(r-1)/(rn-1)+1);
    for j=1:cn
        % Finds the column of the current pixel in the old image.
        x = ((j-1)*(c-1)/(cn-1)+1);
        % Check for values out of range
        x(x < 1) = 1;
        x(x > r - 0.001) = r - 0.001;
        % x1 is the column to the left of the current pixel
        x1 = floor(x);
        % x2 is the column to the right of the current pixel 
        x2 = x1 + 1;
         
        y(y < 1) = 1;
        y(y > c - 0.001) = c - 0.001;
        % y1 is the row to the top of the current pixel
        y1 = floor(y);
        % y2 is the row to the bottom the current pixel
        y2 = y1 + 1;
        % Finds the 4 neighbouring pixels in the original image
        NP1 = inputImage(y1,x1);
        NP2 = inputImage(y1,x2);
        NP3 = inputImage(y2,x1); 
        NP4 = inputImage(y2,x2);
        % Finds the different pixel weights for the neighboring pixels
        PW1 = (y2-y)*(x2-x);
        PW2 = (y2-y)*(x-x1);
        PW3 = (x2-x)*(y-y1);
        PW4 = (y-y1)*(x-x1);
        % Sets the pixel value for the pixel in the new image
        newImage(i,j) = PW1 * NP1 + PW2 * NP2 + PW3 * NP3 + PW4 * NP4;
    end
end

figure(1), imshow(inputImage)
title('Original Image')

figure(2), imshow(newImage)
title('Image after bilinear interpolation')

imwrite(Y, "OutputImageBilinear.png")