inputImage = imread('liftingbody.png');

ratio = [4, 4];
[h, w] = size(inputImage);
H = (ratio(1) * h);
W = (ratio(2) * w);
Y = zeros(H,W, class(inputImage));
hs = (h/H);
ws = (w/W);
    for i=1:H
      y = (hs * i) + (0.5 * (1 - 1/ratio(1)));
        for j=1:W
          x = (ws * j) + (0.5 * (1 - 1/ratio(2)));
      %// Any values out of acceptable range
          x(x < 1) = 1;
          x(x > h - 0.001) = h - 0.001;
          x1 = floor(x);
          x2 = x1 + 1;
          y(y < 1) = 1;
          y(y > w - 0.001) = w - 0.001;
          y1 = floor(y);
          y2 = y1 + 1;
      %// 4 Neighboring Pixels
          NP1 = inputImage(y1,x1);
          NP2 = inputImage(y1,x2);
          NP3 = inputImage(y2,x1); 
          NP4 = inputImage(y2,x2);
      %// 4 Pixels Weights
          PW1 = (y2-y)*(x2-x);
          PW2 = (y2-y)*(x-x1);
          PW3 = (x2-x)*(y-y1);
          PW4 = (y-y1)*(x-x1);
          Y(i,j) = PW1 * NP1 + PW2 * NP2 + PW3 * NP3 + PW4 * NP4;
        end
    end

figure(1), imshow(I)
title('Original Image')

figure(2), imshow(Y)
title('Image after bilinear interpolation')

imwrite(Y, "OutputImageBilinear.png")