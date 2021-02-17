image = imread('liftingbody.png');
zoom = 4;
[r c d] = size(image);
rn = floor(zoom*r);
cn = floor(zoom*c);
s = zoom;
im_zoom = cast(zeros(rn,cn,d),'uint8');
im_pad = zeros(r+4,c+4,d);
im_pad(2:r+1,2:c+1,:) = image;
im_pad = cast(im_pad,'double');
for m = 1:rn
    x1 = ceil(m/s); x2 = x1+1; x3 = x2+1;
    p = cast(x1,'uint16');
    if(s>1)
       m1 = ceil(s*(x1-1));
       m2 = ceil(s*(x1));
       m3 = ceil(s*(x2));
       m4 = ceil(s*(x3));
    else
       m1 = (s*(x1-1));
       m2 = (s*(x1));
       m3 = (s*(x2));
       m4 = (s*(x3));
    end
    X = [ (m-m2)*(m-m3)*(m-m4)/((m1-m2)*(m1-m3)*(m1-m4)) ...
          (m-m1)*(m-m3)*(m-m4)/((m2-m1)*(m2-m3)*(m2-m4)) ...
          (m-m1)*(m-m2)*(m-m4)/((m3-m1)*(m3-m2)*(m3-m4)) ...
          (m-m1)*(m-m2)*(m-m3)/((m4-m1)*(m4-m2)*(m4-m3))];
    for n = 1:cn
        y1 = ceil(n/s); y2 = y1+1; y3 = y2+1;
        if (s>1)
           n1 = ceil(s*(y1-1));
           n2 = ceil(s*(y1));
           n3 = ceil(s*(y2));
           n4 = ceil(s*(y3));
        else
           n1 = (s*(y1-1));
           n2 = (s*(y1));
           n3 = (s*(y2));
           n4 = (s*(y3));
        end
        Y = [ (n-n2)*(n-n3)*(n-n4)/((n1-n2)*(n1-n3)*(n1-n4));...
              (n-n1)*(n-n3)*(n-n4)/((n2-n1)*(n2-n3)*(n2-n4));...
              (n-n1)*(n-n2)*(n-n4)/((n3-n1)*(n3-n2)*(n3-n4));...
              (n-n1)*(n-n2)*(n-n3)/((n4-n1)*(n4-n2)*(n4-n3))];
        q = cast(y1,'uint16');
        sample = im_pad(p:p+3,q:q+3,:);
        im_zoom(m,n,1) = X*sample(:,:,1)*Y;
        if(d~=1)
              im_zoom(m,n,2) = X*sample(:,:,2)*Y;
              im_zoom(m,n,3) = X*sample(:,:,3)*Y;
        end
    end
end
im_zoom = cast(im_zoom,'uint8');

figure(1), imshow(image)
title('Original Image')

figure(2), imshow(im_zoom)
title('Image after bicubic interpolation')

imwrite(im_zoom, "OutputImageBicubic.png")

