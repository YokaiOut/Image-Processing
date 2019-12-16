function [a] = DarkPixelToLight(x)
% this will read an image for you 
% Please enter a file path like:
% this = 'E:\3rd year\Image Pro\extended tasks\extended task
% wk2\Images\SampleImages\chestxray.jpg'
% or this = 'Images\SampleImages\chestxray.jpg' 
% if not the program will not work
a = imread(x);

% this uses a built in function to conver the image into a greyscale image 
b = rgb2gray(a);

for i = 1:534
    for j = 1:800
        if b(i, j) < 50
        b(i,j) = 255;
        end 
    end
end

%this then shows the image after it has been convertedclea
imshow(b);
