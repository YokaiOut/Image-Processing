function [a] = LightPixelToDark2(x)
% this will read an image for you 
% Please enter a file path like:
% this = 'E:\3rd year\Image Pro\extended tasks\extended task
% wk2\Images\SampleImages\chestxray.jpg'
% or this = 'Images\SampleImages\chestxray.jpg' 
% if not the program will not work
a = imread(x);

% this uses a built in function to conver the image into a greyscale image 
b = rgb2gray(a);

X = 255;

while (X >= 0)  
    for i = 1:534
        for j = 1:800
            if b(i, j) > X
            b(i,j) = 0;
            end 
        end
    end

    X = X - 1;

%this then shows the image after it has been convertedclea
    imshow(b);
end