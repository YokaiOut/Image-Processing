function [a] = GreyScale(x)
% this uses a built in function to conver the image into a greyscale image 
a = rgb2gray(x);
%this then shows the image after it has been converted
imshow(a);