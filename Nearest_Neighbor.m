% Read an image
inputImage = imread('liftingbody.png');
[r,c] = size(inputImage);

% Choose how much you wish to scale the image
scale = [4 4];

% Number of rows and columns in the new image
rn = scale(1)*r;
rc = scale(2)*c;

outputImage = zeros(x,y, class(inputImage));


for i=1:x
    % If you round the current row times the ratio between number of 
    % old and new rows you get the correct row in the original image
    newI = round( (i-1)*(r-1)/(rn-1)+1 );
    
    for j=1:y
        % Do the same for the colums
        newJ = round( (j-1)*(c-1)/(rc-1)+1 );
        % Assign the new values to the new image
        outputImage(i,j) = inputImage(newI,newJ);
    end
end

figure(1), imshow(inputImage)
title('Original image')

figure(2), imshow(outputImage)
title('Image after nearest neighbor interpolation')

imwrite(outputImage, "OutputImageNearestNeighbor.png")